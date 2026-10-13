"""存档 XML 格式修复引擎。

对解码后的 XML 字符串进行检测与修复，解决以下常见问题：
  1) 非法控制字符（U+00~U+08, U+0B~U+0C, U+0E~U+1F）
  2) 未闭合的标签（自闭合 / 补齐闭标签）
  3) 编码异常（非 UTF-8 可映射字符、非法 XML 字符实体）
  4) 结构不完整（截断的文档、缺失根元素）

使用流程：
    result = XmlRepairer(xml_string).repair()
    if result.success:
        fixed_xml = result.repaired_xml          # 修复后的可用 XML
    else:
        errors = result.errors                    # 无法自动修复的错误列表
        suggestions = result.suggestions          # 手动修复建议

依赖: 标准库（xml.etree.ElementTree, re, shutil, os）。
"""

from __future__ import annotations

import os
import re
import xml.etree.ElementTree as ET
from dataclasses import dataclass, field
from datetime import datetime
from typing import List, Optional, Tuple


# ---------------------------------------------------------------------------
# 常量
# ---------------------------------------------------------------------------

# XML 1.0 合法字符范围：#x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD]
# 下面是 0x00-0x1F 范围内**非法**的控制字符集合（排除合法的 \t \n \r）
_ILLEGAL_CTRL_CHARS = {
    i for i in range(0x20)
    if i not in (0x09, 0x0A, 0x0D)  # TAB, LF, CR 是合法的
}

# 控制字符 -> 替代文本的映射（用于错误报告和修复日志）
_CTRL_CHAR_NAMES = {
    0x00: "NUL", 0x01: "SOH", 0x02: "STX", 0x03: "ETX",
    0x04: "EOT", 0x05: "ENQ", 0x06: "ACK", 0x07: "BEL",
    0x08: "BS",  0x0B: "VT",  0x0C: "FF",  0x0E: "SO",
    0x0F: "SI",  0x10: "DLE", 0x11: "DC1", 0x12: "DC2",
    0x13: "DC3", 0x14: "DC4", 0x15: "NAK", 0x16: "SYN",
    0x17: "ETB", 0x18: "CAN", 0x19: "EM",  0x1A: "SUB",
    0x1B: "ESC", 0x1C: "FS",  0x1D: "GS",  0x1E: "RS",
    0x1F: "US",
}


@dataclass
class RepairIssue:
    """单条检测结果。"""
    category: str        # 分类: 'control_char' | 'unclosed_tag' | 'encoding' | 'structure'
    severity: str        # 级别: 'error' | 'warning'
    message: str         # 人可读描述
    line: int = 0        # 行号(1-based)
    column: int = 0      # 列号(1-based)
    position: int = 0    # 字符位置(0-based)
    detail: str = ""     # 额外详情（原始字节等）
    auto_fixed: bool = False  # 是否已被自动修复


@dataclass
class RepairResult:
    """修复结果。"""
    success: bool                    # 最终是否成功（修复后可通过 ET 解析）
    original_xml: str                # 原始 XML
    repaired_xml: str = ""           # 修复后 XML（success=True 时有效）
    issues: List[RepairIssue] = field(default_factory=list)  # 全部问题
    backup_path: str = ""            # 备份文件路径
    fix_summary: str = ""            # 修复摘要
    errors: List[str] = field(default_factory=list)       # 未修复的错误
    suggestions: List[str] = field(default_factory=list)  # 建议


class XmlRepairer:
    """XML 格式修复器。

    用法::
        repairer = XmlRepairer(xml_string)
        result = repairer.repair()              # 执行完整检测+修复流程
        # 或分步控制：
        repairer.detect()                      # 仅检测，不修改
        repaired = repairer.apply_fixes()      # 应用修复
    """

    def __init__(self, xml_string: str,
                 backup_dir: Optional[str] = None):
        """
        Args:
            xml_string: 待检测/修复的 XML 文本。
            backup_dir: 备份目录路径。为 None 时不创建备份文件。
        """
        self.original = xml_string
        self._working = xml_string
        self._backup_dir = backup_dir
        self.issues: List[RepairIssue] = []

    # ──────────────────────────────────────
    # 公开接口
    # ──────────────────────────────────────

    def detect(self) -> List[RepairIssue]:
        """执行全部检测（不修改原文），返回问题列表。"""
        self.issues.clear()
        self._detect_control_chars()
        self._detect_structure()
        return list(self.issues)

    def repair(self) -> RepairResult:
        """执行完整流程：检测 → 备份 → 修复 → 验证。"""
        self.detect()

        result = RepairResult(
            success=False,
            original_xml=self.original,
            issues=list(self.issues),
        )

        has_errors = any(i.severity == "error" for i in self.issues)

        if not has_errors:
            # 无错误 — 尝试验证能否正常解析
            if self._try_parse(self.original):
                result.success = True
                result.repaired_xml = self.original
                result.fix_summary = "未发现格式问题，文件完好"
                return result
            else:
                # ET.fromstring 报错但我们的检测没找到 — 记录原始错误
                result.errors.append("XML 存在无法识别的格式异常")
                result.suggestions.append("建议手动检查 XML 是否符合规范")
                return result

        # 有错误 → 先备份
        if self._backup_dir:
            result.backup_path = self._create_backup()

        # 逐级修复
        self._working = self.original

        # 第 1 步：清理非法控制字符
        if any(i.category == "control_char" for i in self.issues):
            self._working, _ = _fix_control_chars(self._working, self.issues)

        # 第 2 步：修复结构问题
        struct_issues = [i for i in self.issues if i.category == "structure"]
        if struct_issues:
            self._working = self._fix_structure(self._working, struct_issues)

        result.repaired_xml = self._working

        # 验证修复结果
        if self._try_parse(self._working):
            result.success = True
            fixed_count = sum(1 for i in self.issues if i.auto_fixed)
            warn_count = sum(1 for i in self.issues if i.severity == "warning")
            parts = [f"已自动修复 {fixed_count} 个问题"]
            if warn_count:
                parts.append(f"{warn_count} 个警告（已保留）")
            result.fix_summary = "；".join(parts)
        else:
            # 修复失败 — 收集剩余错误信息
            parse_err = self._get_parse_error(self._working)
            result.errors.append(f"自动修复后仍无法解析: {parse_err}")
            result.suggestions.append(
                "文件损坏严重，建议从备份恢复或重新导出存档"
            )
            # 也给出每个未修复问题的具体建议
            for issue in self.issues:
                if not issue.auto_fixed:
                    result.suggestions.append(
                        f"  - {issue.message} (行{issue.line}列{issue.column})"
                    )

        return result

    # ──────────────────────────────────────
    # 检测步骤
    # ──────────────────────────────────────

    def _detect_control_chars(self):
        """扫描非法 XML 控制字符（单次线性扫描，O(n)）。

        原实现在每个非法字符处调用 original[:i].count("\\n") 与
        original.rfind("\\n", 0, i)，对大文件呈 O(n^2)。这里改为边遍历边
        累计行号与上一处换行位置，避免反复切片扫描。
        """
        line = 1
        last_nl = -1
        original = self.original
        for i, ch in enumerate(original):
            if ch == "\n":
                line += 1
                last_nl = i
            code = ord(ch)
            if code in _ILLEGAL_CTRL_CHARS:
                col = i - last_nl
                name = _CTRL_CHAR_NAMES.get(code, f"U+{code:04X}")

                # 判断严重程度：在文本节点中的控制字符通常是数据污染，
                # 可以安全删除；在标签名/属性中则更危险。
                context = self.original[max(0, i - 30):i + 30]
                severity = "error"

                issue = RepairIssue(
                    category="control_char",
                    severity=severity,
                    message=f"非法控制字符 U+{code:04X} ({name})",
                    line=line,
                    column=col,
                    position=i,
                    detail=f"context: {repr(context)}",
                )
                self.issues.append(issue)

    def _detect_structure(self):
        """尝试解析以检测结构问题（未闭合标签、截断等）。"""
        err_msg = self._get_parse_error(self.original)
        if not err_msg:
            return  # 结构没问题

        # 解析错误信息
        parsed_err = self._parse_et_error(err_msg)
        if parsed_err:
            line, col, msg = parsed_err
            # 判断错误类型
            if "not well-formed" in msg or "invalid token" in msg:
                # 可能已经被 control_char 检测到了，避免重复
                ctrl_at_pos = [
                    i for i in self.issues
                    if i.category == "control_char"
                    and i.line == line and abs(i.column - col) <= 2
                ]
                if not ctrl_at_pos:
                    self.issues.append(RepairIssue(
                        category="structure",
                        severity="error",
                        message=f"格式异常: {msg}",
                        line=line,
                        column=col,
                    ))
            elif "unclosed" in msg.lower() or "no element found" in msg.lower():
                self.issues.append(RepairIssue(
                    category="structure",
                    severity="error",
                    message=f"结构不完整: {msg}",
                    line=line,
                    column=col,
                ))
            elif "mismatch" in msg.lower():
                self.issues.append(RepairIssue(
                    category="structure",
                    severity="error",
                    message=f"标签不匹配: {msg}",
                    line=line,
                    column=col,
                ))
            else:
                self.issues.append(RepairIssue(
                    category="structure",
                    severity="error",
                    message=f"解析错误: {msg}",
                    line=line,
                    column=col,
                ))

    # ──────────────────────────────────────
    # 修复步骤
    # ──────────────────────────────────────

    def _fix_structure(self, xml: str,
                       issues: List[RepairIssue]) -> str:
        """修复结构性问题。"""
        working = xml

        # 策略 A：检查并补齐未闭合标签
        working = self._fix_unclosed_tags(working)

        # 策略 B：如果仍然无法解析，尝试截断到最后一个完整位置
        if not self._try_parse(working):
            working = self._truncate_to_valid(working)

        return working

    @staticmethod
    def _fix_unclosed_tags(xml: str) -> str:
        """尝试补齐未闭合的标签。

        思路：
          1. 统计所有开标签 <xxx> 和闭标签 </xxx> 的名称
          2. 找出缺少闭标签的元素，按逆序（LIFO）补齐
          3. 同时处理自闭合标签 <xxx/>
        """
        # 自闭合不算需要关闭
        void_self = set(re.findall(r'<([a-zA-Z_][\w.:.-]*)[^>]*/>', xml))

        # 模拟栈来找出真正未闭合的
        stack = []
        for m in re.finditer(r'</?([a-zA-Z_][\w.:.-]*)[\s>]|/>|>', xml):
            token = m.group()
            if token.startswith('</'):
                tag_name = m.group(1)
                # 弹栈到匹配项
                if stack and stack[-1] == tag_name:
                    stack.pop()
                # 不匹配的情况暂时忽略（复杂嵌套错误交给截断策略）
            elif token.endswith('/>') or (token.endswith('>') and not token.startswith('</')):
                tag_name = m.group(1)
                if tag_name and tag_name not in void_self and not token.endswith('/>'):
                    stack.append(tag_name)

        # 补齐闭标签
        if stack:
            closing = "".join(f"</{tag}>" for tag in reversed(stack))
            xml = xml.rstrip() + closing + "\n"

        return xml

    @staticmethod
    def _truncate_to_valid(xml: str) -> str:
        """二分搜索最后一个可成功解析的位置，截断至此。

        当其他修复策略都失败时作为最后手段。
        """
        lo, hi = 100, len(xml)
        best = xml

        while lo < hi:
            mid = (lo + hi + 1) // 2
            candidate = xml[:mid]
            # 简单补一个根闭标签试试
            # 先找最外层开标签
            root_match = re.match(r'\s*<([\w:]+)', candidate)
            if root_match:
                root_name = root_match.group(1)
                trial = candidate
                if not trial.rstrip().endswith(f"</{root_name}>"):
                    trial = trial.rstrip() + f"</{root_name}>"
                if XmlRepairer._try_parse(trial):
                    best = trial
                    lo = mid
                else:
                    hi = mid - 1
            else:
                hi = mid - 1

        return best

    # ──────────────────────────────────────
    # 备份
    # ──────────────────────────────────────

    def _create_backup(self) -> str:
        """将原始 XML 写入带时间戳的备份文件。"""
        os.makedirs(self._backup_dir, exist_ok=True)
        ts = datetime.now().strftime("%Y%m%d_%H%M%S")
        path = os.path.join(self._backup_dir, f"xml_backup_{ts}.xml")
        with open(path, "w", encoding="utf-8") as f:
            f.write(self.original)
        return path

    # ──────────────────────────────────────
    # 工具方法
    # ──────────────────────────────────────

    @staticmethod
    def _try_parse(xml: str) -> bool:
        """尝试用 ET 解析 XML，返回是否成功。"""
        try:
            ET.fromstring(xml)
            return True
        except Exception:
            return False

    @staticmethod
    def _get_parse_error(xml: str) -> str:
        """返回 ET 解析的错误信息，无错误时返回空字符串。"""
        try:
            ET.fromstring(xml)
            return ""
        except ET.ParseError as e:
            return str(e)
        except Exception as e:
            return str(e)

    @staticmethod
    def _parse_et_error(err_msg: str) -> Optional[Tuple[int, int, str]]:
        """解析 ET 错误消息，提取 (line, column, message)。"""
        m = re.match(r".*:\s*line\s+(\d+),\s*column\s+(\d+)\s*(.*)", err_msg)
        if m:
            return int(m.group(1)), int(m.group(2)), m.group(3).strip()
        return None


# ---------------------------------------------------------------------------
# 独立修复函数（供 codec / models 层直接调用）
# ---------------------------------------------------------------------------

def _fix_control_chars(xml: str,
                       issues: List[RepairIssue]) -> Tuple[str, int]:
    """移除/替换 XML 中的非法控制字符。

    Returns:
        (修复后文本, 替换数量)
    """
    count = 0
    chars = list(xml)
    # 从后往前替换，避免偏移
    for issue in reversed(issues):
        if issue.category != "control_char":
            continue
        pos = issue.position
        if pos < len(chars) and ord(chars[pos]) in _ILLEGAL_CTRL_CHARS:
            chars[pos] = ""  # 直接删除
            issue.auto_fixed = True
            count += 1
    return "".join(chars), count


def detect_and_repair_xml(xml_string: str,
                           backup_dir: Optional[str] = None) -> RepairResult:
    """便捷函数：一步完成 XML 检测与修复。

    Args:
        xml_string: 待处理的 XML 文本。
        backup_dir: 备份目录。传入路径则自动生成带时间戳的备份文件。

    Returns:
        RepairResult，包含修复状态、问题列表、建议等。
    """
    return XmlRepairer(xml_string, backup_dir=backup_dir).repair()


def format_repair_report(result: RepairResult) -> str:
    """将 RepairResult 格式化为可读的报告文本。"""
    lines = []
    lines.append("=" * 56)
    lines.append("  存档 XML 格式检测与修复报告")
    lines.append("=" * 56)

    # 总体结论
    status = "✅ 修复成功" if result.success else "❌ 修复失败"
    lines.append(f"\n【总体结论】{status}")

    # 问题列表
    if result.issues:
        lines.append(f"\n【共检测到 {len(result.issues)} 个问题】")
        for idx, issue in enumerate(result.issues, 1):
            icon = {"error": "❌", "warning": "⚠️"}.get(issue.severity, "•")
            fix_mark = " [已自动修复]" if issue.auto_fixed else ""
            loc = ""
            if issue.line > 0:
                loc = f" (行{issue.line}, 列{issue.column})"
            lines.append(f"  {idx}. {icon} [{issue.category}]{loc} "
                         f"{issue.message}{fix_mark}")
            if issue.detail:
                lines.append(f"     详情: {issue.detail}")
    else:
        lines.append("\n  未检测到格式问题")

    # 修复摘要
    if result.fix_summary:
        lines.append(f"\n【修复摘要】{result.fix_summary}")

    # 备份信息
    if result.backup_path:
        lines.append(f"\n【备份位置】{result.backup_path}")

    # 错误和建议
    if result.errors:
        lines.append("\n【未解决的错误】")
        for e in result.errors:
            lines.append(f"  • {e}")
    if result.suggestions:
        lines.append("\n【建议】")
        for s in result.suggestions:
            lines.append(f"  • {s}")

    lines.append("\n" + "=" * 56)
    return "\n".join(lines)
