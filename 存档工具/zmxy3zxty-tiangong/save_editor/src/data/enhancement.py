"""强化系统：解析「强化后增加属性」文本并计算强化后属性。

依赖: core.constants (ATTR_FIELD_MAP), data.common (_parse_attr_val)。
"""
import re

from core.constants import ATTR_FIELD_MAP, ENHANCE_ATTR_ALIASES

# 匹配模式： "防御+4" / "攻击+3" / "生命+5 防御+2" / "无"
_ENHANCE_RE = re.compile(r'([\u4e00-\u9fa5]+)\s*\+(\d+(?:\.\d+)?)')


def _normalize_attr_name(name: str) -> str:
    """将强化加成文本中的属性别名归一化为规范名。

    例："蓝量" → "魔法", "血量" → "生命", "回蓝" → "回魔"
    已是规范名则原样返回。
    """
    return ENHANCE_ATTR_ALIASES.get(name, name)


def parse_enhancement_bonus(enh_str):
    """解析「强化后增加属性」文本为 dict。

    例：
      "防御+4"          -> {"防御": 4}
      "攻击+3"           -> {"攻击": 3}
      "生命+5 防御+2"   -> {"生命": 5, "防御": 2}
      "无" / ""         -> {}
    """
    if not enh_str or str(enh_str).strip() in ("无", "", "-"):
        return {}
    result = {}
    for m in _ENHANCE_RE.finditer(str(enh_str)):
        attr_name = _normalize_attr_name(m.group(1))
        try:
            bonus = float(m.group(2))
            result[attr_name] = int(bonus) if bonus == int(bonus) else bonus
        except (ValueError, TypeError):
            pass
    return result


def apply_enhancement(base_attrs, enhance_bonus, level):
    """根据强化等级和每级加成，计算强化后的属性字典。

    参数：
      base_attrs    : dict {属性名: 基础值(str)} — 来自 _parse_attr_val 的结果
      enhance_bonus : dict {属性名: 每级加成(float)} — 来自 parse_enhancement_bonus
      level         : int, 1~10

    返回：
      dict {ATTR_FIELD_MAP序号: 强化后值(str)}，仅含有效数值字段
    """
    result = {}
    for field_idx, attr_name in ATTR_FIELD_MAP.items():
        base_str = base_attrs.get(attr_name)  # 可能是 None 或 "0"
        per_level = enhance_bonus.get(attr_name, 0)
        try:
            base_val = float(base_str) if base_str else 0.0
        except (TypeError, ValueError):
            base_val = 0.0
        enhanced = base_val + per_level * level
        # 整数化
        if enhanced == int(enhanced):
            result[field_idx] = str(int(enhanced))
        else:
            result[field_idx] = str(enhanced)
    return result
