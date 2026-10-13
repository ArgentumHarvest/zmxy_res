"""装备强化（Mixin）。

职责：提供「装备强化」能力，作为背包装备/已装备页签中「右键菜单」或「强化按钮」
的触发目标。强化只写入物品的「强化」字段(索引23)，基础属性(7~13)始终保持原始
值（或在有权威参考时重置为权威基础值），由游戏在读取时按 强化等级×每级加成 计算
最终属性——绝不直接把强化加成并入基础属性。

依赖: core.constants, data.enhancement, data.common, ui.theme。
"""
import traceback
import tkinter as tk
import customtkinter as ctk

from core.constants import (ATTR_DISPLAY_NAMES, ENHANCE_MIN_LEVEL,
                            ENHANCE_MAX_LEVEL, SLOT_CODES, ATTR_FIELD_MAP)
from data.enhancement import parse_enhancement_bonus, apply_enhancement
from data.common import _parse_attr_val
from ui.theme import (C_PANEL, C_BG, C_FRAME, C_ACCENT, C_ACCENT2, C_WARN,
                     C_ERR, C_FG, C_SUB, FONT_FAMILY, CORNER,
                     HOVER_ACCENT,
                     C_BTN_SUB, HOVER_BTN_SUB)


class EnhancePageMixin:
    """装备强化相关方法。"""

    # ────────────────────────────────────
    # 装备强化（由背包装备/已装备页签触发）
    # ────────────────────────────────────
    # 装备类页签才允许强化
    ENHANCE_BAGS = ("背包装备", "已装备")

    def _get_enhance_target(self):
        """返回 (行号, 物品) 当前应被强化的目标；无有效目标返回 (None, None)。"""
        if not hasattr(self, "items") or not self.items:
            return None, None
        row = None
        # 多重策略获取选中行：行选择 > 单元格选择 > 上次选中
        try:
            if self.sheet is not None:
                # 1) 行选择（整行选中）
                sel_rows = self.sheet.get_selected_rows()
                if sel_rows:
                    row = max(sel_rows.keys() if isinstance(sel_rows, dict)
                              else list(sel_rows))
                # 2) 单元格选择（取单元格所在行）
                if row is None:
                    sel_cells = self.sheet.get_selected_cells()
                    if sel_cells:
                        cells = list(sel_cells) if isinstance(sel_cells, set) else sel_cells
                        if cells and isinstance(cells[0], (list, tuple)):
                            row = cells[0][0]
        except Exception:
            pass
        # 3) 回退到上次选中行
        if row is None:
            row = getattr(self, "_last_selected_row", None)
        if row is None or not (0 <= row < len(self.items)):
            return None, None
        return row, self.items[row]

    def _rc_enhance(self) -> None:
        """右键菜单「强化」回调：对当前选中物品打开强化弹窗。"""
        # 先关闭任何已存在的强化弹窗
        self._close_enh_dlg()
        row, item = self._get_enhance_target()
        if item is None:
            self._set_status("请先选中一件物品再强化", C_WARN)
            return
        # 仅武器/防具/饰品/法宝可强化；头衔(zbtx)与头像(zbch)等非装备槽位不可强化，给出提示
        slot = item[3].strip() if len(item) > 3 else ""
        if slot not in ("zbwq", "zbfj", "zbsp", "zbfb"):
            self._set_status(f"当前物品槽位 [{SLOT_CODES.get(slot, slot)}] 可能不支持强化",
                             C_WARN)
        self._open_enhance_dialog()

    def _close_enh_dlg(self) -> None:
        dlg = getattr(self, "_enh_dlg", None)
        if dlg is not None:
            try:
                dlg.destroy()
            except Exception:
                pass
        self._enh_dlg = None

    def _open_enhance_dialog(self) -> None:
        """打开装备强化弹窗，针对当前选中物品设置强化等级。"""
        row, item = self._get_enhance_target()
        if item is None:
            self._set_status("请先选中一件物品再强化", C_WARN)
            tk.messagebox.showwarning(
                "未选中装备",
                "请先在『背包装备』或『已装备』页的表格中点击选中一件装备，"
                "再执行强化。")
            return

        name = item[1].strip() or "(无名)"
        code = item[2].strip()
        slot = item[3].strip() if len(item) > 3 else ""
        slot_nm = SLOT_CODES.get(slot, slot)
        color = item[6].strip() if len(item) > 6 else ""
        try:
            cur_lv = int(item[23]) if (len(item) > 14
                                       and item[23].strip().isdigit()) else 0
        except (ValueError, TypeError):
            cur_lv = 0

        dlg = ctk.CTkToplevel(self.app)
        dlg.title(f"装备强化 — {name}")
        self._place_toplevel(dlg, 460, 560)
        dlg.grab_set()
        dlg.resizable(False, False)
        self._enh_dlg = dlg
        self._enh_target_row = row

        ctk.CTkLabel(dlg, text="⚔ 装备强化", text_color=C_ACCENT,
                     font=ctk.CTkFont(family=FONT_FAMILY, size=16,
                                     weight="bold")
                     ).pack(padx=14, pady=(12, 6), anchor="w")

        # 选中物品信息
        info = ctk.CTkFrame(dlg, fg_color=C_FRAME, corner_radius=CORNER)
        info.pack(fill=tk.X, padx=14, pady=4)
        self._enh_item_lbl = ctk.CTkLabel(
            info,
            text=f"【{name}】\n代码: {code}   槽位: {slot_nm}   颜色: {color}",
            text_color=C_FG, font=ctk.CTkFont(family=FONT_FAMILY, size=11),
            justify="left", anchor="w")
        self._enh_item_lbl.pack(fill=tk.X, padx=10, pady=8)

        # 等级控制
        ctrl = ctk.CTkFrame(dlg, fg_color="transparent", corner_radius=CORNER)
        ctrl.pack(fill=tk.X, padx=14, pady=4)
        ctk.CTkLabel(ctrl, text="目标强化等级:", text_color=C_FG,
                     font=ctk.CTkFont(family=FONT_FAMILY, size=12,
                                     weight="bold")
                     ).pack(side=tk.LEFT)
        level_choices = [str(v) for v in range(ENHANCE_MIN_LEVEL,
                                              ENHANCE_MAX_LEVEL + 1)]
        self._enh_level_menu = ctk.CTkOptionMenu(
            ctrl, values=level_choices, width=90,
            fg_color=C_PANEL, button_color=C_ACCENT,
            button_hover_color=HOVER_ACCENT, text_color=C_FG,
            font=ctk.CTkFont(family=FONT_FAMILY, size=13, weight="bold"),
            corner_radius=CORNER, command=self._on_enh_level_changed)
        self._enh_level_menu.pack(side=tk.LEFT, padx=8)
        self._enh_level_menu.set(str(cur_lv))

        # 快捷按钮
        qrow = ctk.CTkFrame(dlg, fg_color="transparent")
        qrow.pack(fill=tk.X, padx=14, pady=(2, 4))
        for lv_text in ("+1", "+5", "MAX"):
            ctk.CTkButton(
                qrow, text=lv_text, width=55,
                command=(lambda l=lv_text: self._enh_quick_level(l)),
                fg_color=C_BTN_SUB, hover_color=HOVER_BTN_SUB, text_color=C_FG,
                font=ctk.CTkFont(family=FONT_FAMILY, size=11),
                corner_radius=CORNER).pack(side=tk.LEFT, padx=3)

        # 属性预览
        prev = ctk.CTkFrame(dlg, fg_color=C_FRAME, corner_radius=CORNER)
        prev.pack(fill=tk.BOTH, expand=True, padx=14, pady=4)
        ctk.CTkLabel(prev, text="强化后属性预览", text_color=C_ACCENT,
                     font=ctk.CTkFont(family=FONT_FAMILY, size=12,
                                     weight="bold")
                     ).pack(anchor="w", padx=10, pady=(6, 4))
        self._enh_preview_tb = ctk.CTkTextbox(
            prev, fg_color=C_BG, text_color=C_FG,
            font=ctk.CTkFont(family=FONT_FAMILY, size=11),
            wrap="none", corner_radius=CORNER)
        self._enh_preview_tb.pack(fill=tk.BOTH, expand=True,
                                  padx=8, pady=(0, 8))

        # 底部操作栏
        bar = ctk.CTkFrame(dlg, fg_color="transparent", corner_radius=CORNER)
        bar.pack(fill=tk.X, padx=14, pady=8)
        ctk.CTkButton(bar, text="✓ 应用强化", width=140,
                      corner_radius=CORNER,
                      command=lambda: self._cmd_apply_enhance(),
                      fg_color=C_ACCENT, hover_color=HOVER_ACCENT,
                      text_color="#ffffff",
                      font=ctk.CTkFont(family=FONT_FAMILY, size=13,
                                      weight="bold")
                      ).pack(side=tk.LEFT, padx=4)
        ctk.CTkButton(bar, text="取消", width=80, corner_radius=CORNER,
                      command=self._close_enh_dlg,
                      fg_color=C_BTN_SUB, hover_color=HOVER_BTN_SUB,
                      text_color=C_FG,
                      font=ctk.CTkFont(family=FONT_FAMILY, size=13)
                      ).pack(side=tk.LEFT, padx=4)
        self._enh_status_lbl = ctk.CTkLabel(
            bar, text="", text_color=C_SUB,
            font=ctk.CTkFont(family=FONT_FAMILY, size=11))
        self._enh_status_lbl.pack(side=tk.RIGHT, padx=8)

        self._refresh_enhance_preview()

    # -- 回调与逻辑 --
    def _on_enh_level_changed(self, _choice: str) -> None:
        self._refresh_enhance_preview()

    def _enh_quick_level(self, action: str) -> None:
        try:
            cur = int(self._enh_level_menu.get())
        except (ValueError, AttributeError):
            cur = 0
        if action == "+1":
            new_lv = min(cur + 1, ENHANCE_MAX_LEVEL)
        elif action == "+5":
            new_lv = min(cur + 5, ENHANCE_MAX_LEVEL)
        else:  # MAX
            new_lv = ENHANCE_MAX_LEVEL
        self._enh_level_menu.set(str(new_lv))
        self._refresh_enhance_preview()

    def _refresh_enhance_preview(self) -> None:
        """根据当前选中物品和选择的目标等级，计算并展示强化后属性预览。

        显示格式：基础值（+N）——先显示来自参考库的基础数值，
        再在括号中以 +加成值 形式展示目标等级带来的增量部分。
        """
        tb = getattr(self, "_enh_preview_tb", None)
        if tb is None:
            return
        tb.delete("0.0", tk.END)

        row, item = self._get_enhance_target()
        if item is None or len(item) < 7:
            tb.insert("0.0", "请先在背包表格中点击选中一件装备，"
                       "再设置强化等级。\n\n"
                       "(提示：在「背包装备」或「已装备」页中单击一行)")
            return

        name = item[1].strip() or "(无名)"
        code = item[2].strip() or "?"
        slot_nm = SLOT_CODES.get(item[3], item[3])
        color = item[6].strip() if len(item) > 6 else ""

        try:
            cur_lv = int(item[23]) if (len(item) > 14
                                     and str(item[23]).isdigit()) else 0
        except (ValueError, TypeError):
            cur_lv = 0
        try:
            target_lv = int(self._enh_level_menu.get())
        except (ValueError, AttributeError, IndexError):
            target_lv = 0

        self._enh_item_lbl.configure(
            text=f"【{name}】\n代码: {code}   槽位: {slot_nm}   颜色: {color}"
                 f"\n当前等级: {cur_lv}  →  目标等级: {target_lv}")

        ea = self.refdata.get("equip_attrs", {}).get(name)
        lines = [f"═══ 【{name}】强化属性预览 ═══\n"]

        if not ea:
            lines.append("  ⚠ 参考库中未找到该装备的权威属性数据\n")
            lines.append("  将仅写入「强化」字段(索引23)，基础属性保持不变\n")
            self._enh_preview_tb.insert("0.0", "".join(lines))
            return

        enh_bonus = parse_enhancement_bonus(ea.get("强化后增加属性", ""))
        if not enh_bonus:
            lines.append("  该装备无强化加成数据（强化等级仍会写入）\n")
            self._enh_preview_tb.insert("0.0", "".join(lines))
            return

        # 每级加成摘要（归一化后的标准名）
        per_lv_str = ", ".join(f"{k}+{v}" for k, v in enh_bonus.items())
        lines.append(f"  每级加成: {per_lv_str}\n")

        # ── 基础属性（来自参考库） ──
        lines.append("  基础属性 (来自参考库):\n")

        base_attrs = {}
        for field_idx, attr_name in ATTR_FIELD_MAP.items():
            base_val = ea.get(attr_name, "")
            if base_val and str(base_val).strip():
                lines.append(f"    {attr_name}: {base_val}\n")
                try:
                    base_attrs[attr_name] = float(str(base_val).split("+")[0])
                except (ValueError, TypeError):
                    pass

        # ── 强化后总览：基础值（+目标等级加成） ──
        lines.append(f"\n  ── 强化后属性：Lv{target_lv} 总览 ──\n")

        # 计算每个属性的目标等级总值和加成量
        enhanced_result = apply_enhancement(base_attrs, enh_bonus, target_lv)
        old_enhanced = apply_enhancement(base_attrs, enh_bonus, cur_lv) if cur_lv != target_lv else {}

        for field_idx in sorted(enhanced_result.keys()):
            aname = ATTR_DISPLAY_NAMES.get(field_idx, f"字段{field_idx}")
            attr_name = ATTR_FIELD_MAP.get(field_idx, aname)
            base_val = base_attrs.get(attr_name)
            per_lv = enh_bonus.get(attr_name, 0)
            bonus_total = per_lv * target_lv

            # 格式化：整数不显示小数点；浮点保留合理位数
            def _fmt(v):
                if abs(v - round(v)) < 1e-9:
                    return str(int(round(v)))
                return f"{v:.4g}"

            base_display = _fmt(base_val) if base_val is not None else "0"
            bonus_display = _fmt(bonus_total)

            sign = "+" if bonus_total >= 0 else ""
            lines.append(f"    {aname}: {base_display}（{sign}{bonus_display}）\n")

        # ── 等级差异对比（仅当 cur_lv ≠ target_lv 时显示） ──
        if cur_lv != target_lv:
            lines.append(f"\n  ── Lv{cur_lv}→Lv{target_lv} 差异 ──\n")
            for field_idx in sorted(enhanced_result.keys()):
                aname = ATTR_DISPLAY_NAMES.get(field_idx, f"字段{field_idx}")
                new_v = float(enhanced_result.get(field_idx, 0))
                old_v = float(old_enhanced.get(field_idx, 0))
                diff = new_v - old_v
                sign = "+" if diff >= 0 else ""
                lines.append(f"    {aname}: {_fmt(old_v)} → "
                             f"{_fmt(new_v)} （{sign}{_fmt(diff)}）\n")

        self._enh_preview_tb.insert("0.0", "".join(lines))

    def _cmd_apply_enhance(self, target_lv: int = None) -> None:
        """将当前选择的强化等级应用到选中物品。

        正确做法：仅写入「强化」字段(索引23)；若物品在权威参考库中，则将
        基础属性(7~13)重置为权威基础值（保持「基础」而非「强化后」）。绝不直接
        把强化加成并入基础属性，避免与游戏内计算叠加。
        """
        try:
            self._apply_enhance_impl(target_lv)
        except Exception as exc:
            # 发生异常时确保弹窗关闭并给出明确错误提示
            self._set_status(f"强化应用失败: {exc}", C_ERR)
            if getattr(self, "_enh_status_lbl", None) is not None:
                try:
                    self._enh_status_lbl.configure(
                        text=f"❌ 失败: {exc}", text_color=C_ERR)
                except Exception:
                    pass
            try:
                self._close_enh_dlg()
            except Exception:
                pass
            # 重新抛出以帮助调试
            traceback.print_exc()

    def _apply_enhance_impl(self, target_lv: int = None) -> None:
        """强化应用的核心实现（供 _cmd_apply_enhance 调用并统一异常处理）。"""
        row, item = self._get_enhance_target()
        if item is None:
            self._set_status("请先选中一件物品再强化", C_WARN)
            if getattr(self, "_enh_status_lbl", None) is not None:
                self._enh_status_lbl.configure(text="❌ 未选中物品",
                                               text_color=C_ERR)
            return

        if target_lv is None:
            try:
                menu = getattr(self, "_enh_level_menu", None)
                if menu is None:
                    raise ValueError("强化等级控件未初始化")
                target_lv = int(menu.get())
            except (ValueError, AttributeError) as e:
                target_lv = 0
                self._set_status(f"读取强化等级失败，默认设为 Lv0: {e}", C_WARN)
        target_lv = max(ENHANCE_MIN_LEVEL, min(target_lv, ENHANCE_MAX_LEVEL))

        # 确保 item 有足够的字段
        while len(item) < 28:
            item.append("0")

        old_lv = item[23] if len(item) > 14 else "0"
        # 仅设置强化等级字段
        item[23] = str(target_lv)

        # 基础属性：有权威参考则重置为权威基础值（不改变"基础"语义）
        name = item[1].strip() if len(item) > 1 else ""
        ea = self.refdata.get("equip_attrs", {}).get(name) if self.refdata else None
        if ea:
            for field_idx, attr_name in ATTR_FIELD_MAP.items():
                if field_idx < len(item):
                    base = _parse_attr_val(ea.get(attr_name, ""))
                    if base is not None:
                        item[field_idx] = base

        # 写回模型与视图
        if hasattr(self, "_flush_current_bag"):
            self._flush_current_bag()
        if hasattr(self, "_rebuild_sheet") and self.sheet is not None:
            self._rebuild_sheet()

        if row is not None:
            try:
                self.sheet.select_row(row)
            except Exception:
                pass
            self._last_selected_row = row
            if hasattr(self, "_show_item_detail"):
                self._show_item_detail(item)

        msg = (f"已强化: [{name}] Lv{old_lv} → Lv{target_lv}"
               f"  （记得保存存档）")
        self._set_status(msg, C_ACCENT2)
        if getattr(self, "_enh_status_lbl", None) is not None:
            self._enh_status_lbl.configure(text=f"✅ 已设为 Lv{target_lv}",
                                           text_color=C_ACCENT)

        self._close_enh_dlg()
