"""按代码添加物品对话框与添加逻辑（Mixin）。

职责单一：提供「按代码/名称添加物品」对话框，支持强化等级、角色、类型、品质
过滤，并将生成的新物品追加到当前背包。列表默认按「类型 → 品质」排序；背包装备
页签同时支持添加「头衔」类物品。

依赖: core.constants, data.items, data.synthesis, ui.theme。
"""
import tkinter as tk
import customtkinter as ctk
import re

from core.constants import (BAG_FIELDS, BAG_SLOT_FILTERS, SLOT_CODES, ROLE_LIST,
                            ROLE_ID_MAP, ENHANCE_MIN_LEVEL, ENHANCE_MAX_LEVEL,
                            SLOT_ORDER, QUALITY_ORDER)
from data.items import new_item_template
from data.synthesis import is_synthetic_equip, calc_synthetic_defaults
from ui.theme import (C_PANEL, C_ACCENT, C_ACCENT2, C_WARN,
                     C_ERR, C_FG, C_SUB, FONT_FAMILY, CORNER,
                     HOVER_ACCENT, HOVER_ACCENT2,
                     C_BTN_SUB, HOVER_BTN_SUB,
                     C_LIST_BG, C_LIST_FG, C_LIST_SEL, C_LIST_SEL_FG)

# 制作书：显示归类名称（不修改物品实际 slot 字段）
TYPE_BOOK = "制作书"


def _norm_search(s):
    """搜索归一化：小写、去除空格/常见分隔符，用于名称/代码模糊匹配。"""
    if not s:
        return ""
    return re.sub(r"[\s·•\-—_/]", "", s).lower()


class AddItemDialogMixin:
    """按代码添加物品相关方法。"""

    def _dlg_add_item(self) -> None:
        if not self.active_bag or self.active_bag not in BAG_FIELDS:
            return

        slot_filter = BAG_SLOT_FILTERS.get(self.active_bag, set())

        dlg = ctk.CTkToplevel(self.app)
        self._place_toplevel(dlg, 660, 620)
        dlg.grab_set()
        dlg.title("按代码 / 名称添加物品")

        # ── 搜索栏 ──
        search = ctk.CTkEntry(dlg, placeholder_text="名称或代码…",
                              width=380, font=ctk.CTkFont(family=FONT_FAMILY, size=12))
        search.pack(fill=tk.X, padx=12, pady=(12, 2))

        # ── 选项行1：强化等级 + 角色 ──
        opt_row = ctk.CTkFrame(dlg, fg_color="transparent", corner_radius=CORNER)
        opt_row.pack(fill=tk.X, padx=12, pady=2)

        ctk.CTkLabel(opt_row, text="强化:", text_color=C_FG,
                     font=ctk.CTkFont(family=FONT_FAMILY, size=11)).pack(side=tk.LEFT)
        enh_choices = ["0"] + [str(v) for v in range(ENHANCE_MIN_LEVEL + 1, ENHANCE_MAX_LEVEL + 1)]
        enh_menu = ctk.CTkOptionMenu(opt_row, values=enh_choices, width=90,
                                    fg_color=C_PANEL, button_color=C_ACCENT,
                                    button_hover_color=HOVER_ACCENT,
                                    text_color=C_FG,
                                    font=ctk.CTkFont(family=FONT_FAMILY, size=12),
                                    corner_radius=CORNER)
        enh_menu.pack(side=tk.LEFT, padx=6)
        enh_menu.set("0")

        ctk.CTkLabel(opt_row, text="  角色:", text_color=C_FG,
                     font=ctk.CTkFont(family=FONT_FAMILY, size=11)).pack(side=tk.LEFT, padx=(12, 0))
        role_menu = ctk.CTkOptionMenu(
            opt_row, values=ROLE_LIST, width=80,
            fg_color=C_PANEL, button_color=C_ACCENT, button_hover_color=HOVER_ACCENT,
            text_color=C_FG,
            font=ctk.CTkFont(family=FONT_FAMILY, size=12),
            corner_radius=CORNER)
        role_menu.pack(side=tk.LEFT, padx=6)
        # 默认角色：优先当前存档角色，减少手动选择
        default_role = "全部"
        if getattr(self, "save", None) is not None:
            role_id = self.save.get_scalar("roleid")
            if role_id is not None:
                default_role = ROLE_ID_MAP.get(str(role_id).strip(), "全部")
        role_menu.set(default_role)

        # ── 选项行2：类型 + 品质 ──
        opt_row2 = ctk.CTkFrame(dlg, fg_color="transparent", corner_radius=CORNER)
        opt_row2.pack(fill=tk.X, padx=12, pady=2)

        ctk.CTkLabel(opt_row2, text="类型:", text_color=C_FG,
                     font=ctk.CTkFont(family=FONT_FAMILY, size=11)).pack(side=tk.LEFT)
        # 当前背包允许的类型（中文），按 SLOT_ORDER 排序
        type_pairs = [(s, SLOT_CODES[s]) for s in slot_filter if s in SLOT_CODES]
        type_pairs.sort(key=lambda p: SLOT_ORDER.index(p[0])
                        if p[0] in SLOT_ORDER else len(SLOT_ORDER))
        type_choices = ["全部"] + [nm for _s, nm in type_pairs]
        # 若当前背包允许物品/材料，则额外提供「制作书」显示类别
        if not slot_filter or "zbwp" in slot_filter:
            type_choices.append(TYPE_BOOK)
        type_menu = ctk.CTkOptionMenu(
            opt_row2, values=type_choices, width=110,
            fg_color=C_PANEL, button_color=C_ACCENT2, button_hover_color=HOVER_ACCENT2,
            text_color=C_FG,
            font=ctk.CTkFont(family=FONT_FAMILY, size=12),
            corner_radius=CORNER)
        type_menu.pack(side=tk.LEFT, padx=6)
        type_menu.set("全部")

        ctk.CTkLabel(opt_row2, text="  品质:", text_color=C_FG,
                     font=ctk.CTkFont(family=FONT_FAMILY, size=11)).pack(side=tk.LEFT, padx=(12, 0))
        # 当前背包目录中出现的品质，按 QUALITY_ORDER 排序
        quals = set()
        for _code, meta in self.refdata.get("code_catalog", {}).items():
            if (not slot_filter) or meta.get("slot", "") in slot_filter:
                quals.add(meta.get("quality", ""))
        qual_choices = ["全部"] + sorted(
            quals, key=lambda q: QUALITY_ORDER.index(q)
            if q in QUALITY_ORDER else len(QUALITY_ORDER))
        quality_menu = ctk.CTkOptionMenu(
            opt_row2, values=qual_choices, width=120,
            fg_color=C_PANEL, button_color=C_ACCENT2, button_hover_color=HOVER_ACCENT2,
            text_color=C_FG,
            font=ctk.CTkFont(family=FONT_FAMILY, size=12),
            corner_radius=CORNER)
        quality_menu.pack(side=tk.LEFT, padx=6)
        quality_menu.set("全部")

        # 背包类型提示
        slot_names = ", ".join(SLOT_CODES.get(s, s)
                               for s in sorted(slot_filter)) or "全部"
        hint = f"当前: {self.active_bag}  →  {slot_names}"
        ctk.CTkLabel(dlg, text=hint, text_color=C_SUB,
                     font=ctk.CTkFont(family=FONT_FAMILY, size=9)).pack(padx=12, pady=(0, 2))

        # ── 已选数量提示 ──
        sel_count_lbl = ctk.CTkLabel(
            dlg, text="已选 0 项（单击条目切换选中，再次单击取消）",
            text_color=C_ACCENT2,
            font=ctk.CTkFont(family=FONT_FAMILY, size=11, weight="bold"))
        sel_count_lbl.pack(anchor="w", padx=12, pady=(0, 2))

        # ── 物品列表（统一自然多选：单击条目切换选中/取消）──
        lb = tk.Listbox(dlg, bg=C_LIST_BG, fg=C_LIST_FG,
                        font=("Microsoft YaHei UI", 10),
                        selectbackground=C_LIST_SEL,
                        selectforeground=C_LIST_SEL_FG, activestyle="none",
                        selectmode=tk.MULTIPLE)
        lb.pack(side=tk.TOP, fill=tk.BOTH, expand=True, padx=12, pady=(4, 8))

        catalog = self.refdata.get("code_catalog", {})
        disp_map: dict = {}  # display_string → code

        def refresh_list(query="", role_filt="全部",
                         type_filt="全部", quality_filt="全部"):
            # 委托给可独立测试的保护方法（逻辑完全一致）
            self._refresh_add_list(lb, catalog, slot_filter, disp_map,
                                   count_lbl, query, role_filt,
                                   type_filt, quality_filt)

        count_lbl = ctk.CTkLabel(dlg, text="", text_color=C_SUB,
                                font=ctk.CTkFont(family=FONT_FAMILY, size=9))
        count_lbl.pack(padx=12, pady=(0, 2), anchor="w")

        on_filter = lambda: refresh_list(
            search.get(), role_menu.get(), type_menu.get(), quality_menu.get())
        search.bind("<KeyRelease>", lambda e: on_filter())
        role_menu.configure(command=lambda _: on_filter())
        type_menu.configure(command=lambda _: on_filter())
        quality_menu.configure(command=lambda _: on_filter())
        refresh_list()

        def _update_sel_count():
            n = len(lb.curselection())
            sel_count_lbl.configure(
                text=f"已选 {n} 项（单击条目切换选中，再次单击取消）")
            if add_btn.winfo_exists():
                add_btn.configure(text=f"添加 ({n})" if n else "添加")

        lb.bind("<<ListboxSelect>>", lambda e: _update_sel_count())

        def _get_selected_codes() -> list:
            codes = []
            for idx in lb.curselection():
                disp = lb.get(idx)
                code = disp_map.get(disp)
                if code:
                    codes.append(code)
            return codes

        def do_add():
            codes = _get_selected_codes()
            if not codes:
                self._set_status("请至少选择一个物品", C_WARN)
                return
            lv = int(enh_menu.get().split("(")[0].strip())
            for code in codes:
                self._add_item_by_code(code, enhancement_level=lv)
            self._set_status(f"已添加 {len(codes)} 件物品，记得保存", C_ACCENT2)
            dlg.destroy()

        def _on_double_click(event):
            """双击条目：仅添加被双击的那一项并关闭对话框。"""
            idx = lb.nearest(event.y)
            disp = lb.get(idx)
            code = disp_map.get(disp)
            if not code:
                return
            lv = int(enh_menu.get().split("(")[0].strip())
            self._add_item_by_code(code, enhancement_level=lv)
            dlg.destroy()

        btn_bar = ctk.CTkFrame(dlg, fg_color="transparent", corner_radius=CORNER)
        btn_bar.pack(side=tk.BOTTOM, fill=tk.X, padx=12, pady=10)
        add_btn = ctk.CTkButton(btn_bar, text="添加", width=120, corner_radius=CORNER,
                      command=do_add, fg_color=C_ACCENT, hover_color=HOVER_ACCENT,
                      text_color="#ffffff", font=ctk.CTkFont(family=FONT_FAMILY, size=13, weight="bold"))
        add_btn.pack(side=tk.LEFT, padx=6)
        ctk.CTkButton(btn_bar, text="取消", width=80, corner_radius=CORNER,
                      command=dlg.destroy, fg_color=C_BTN_SUB, hover_color=HOVER_BTN_SUB,
                      text_color=C_FG, font=ctk.CTkFont(family=FONT_FAMILY, size=13)
                      ).pack(side=tk.LEFT, padx=6)
        lb.bind("<Double-Button-1>", _on_double_click)

        # 保存引用供测试/外部检查
        self._add_dlg_role_menu = role_menu
        self._add_dlg_lb = lb
        self._add_dlg_sel_count_lbl = sel_count_lbl
        self._add_dlg_add_btn = add_btn

    def _refresh_add_list(self, lb, catalog: dict, slot_filter: set,
                          disp_map: dict, count_lbl, query: str = "",
                          role_filt: str = "全部", type_filt: str = "全部",
                          quality_filt: str = "全部") -> None:
        """渲染「按代码/名称添加」对话框的物品列表。

        纯逻辑方法（不依赖 GUI 主循环），便于单元测试：按槽位(类型)过滤、
        按品质过滤、按角色过滤、按关键词搜索，并按「类型 → 品质 → 代码」
        默认排序后展示。可被对话框内的闭包 `refresh_list` 委托调用。
        """
        lb.delete(0, tk.END)
        disp_map.clear()
        q = _norm_search(query)
        rows = []
        for code, meta in catalog.items():
            name = meta.get("name", "")
            slot = meta.get("slot", "zbwp")
            restriction = meta.get("restriction", "")
            qual = meta.get("quality", "")
            is_book = TYPE_BOOK in name
            # 槽位过滤
            if slot_filter and slot not in slot_filter:
                continue
            # 类型过滤：制作书为显示归类，不影响实际 slot
            if type_filt == TYPE_BOOK:
                if not is_book:
                    continue
            elif type_filt != "全部" and SLOT_CODES.get(slot, slot) != type_filt:
                continue
            # 品质过滤（按存储字符串，含可能空格，如 "神 器"）
            if quality_filt != "全部" and qual != quality_filt:
                continue
            # 角色过滤
            if role_filt != "全部" and restriction and restriction != role_filt:
                continue
            # 关键词搜索（名称/代码模糊匹配）
            if q and q not in _norm_search(name) and q not in _norm_search(code):
                continue
            # 排序键：类型 → 品质 → 代码（制作书仍按实际 slot 排序，仅显示不同）
            slot_rank = SLOT_ORDER.index(slot) if slot in SLOT_ORDER else len(SLOT_ORDER)
            qual_rank = QUALITY_ORDER.index(qual) if qual in QUALITY_ORDER else len(QUALITY_ORDER)
            rows.append((slot_rank, qual_rank, code, meta, is_book))
        # 默认按类型与品质排序
        rows.sort(key=lambda r: (r[0], r[1], r[2]))
        count = 0
        for _sr, _qr, code, meta, is_book in rows:
            name = meta.get("name", "")
            restriction = meta.get("restriction", "")
            qual = meta.get("quality", "")
            src_tag = "★实测" if meta.get("source") == "save" else "·参考"
            # 显示归类：名称含「制作书」的物品显示为「制作书」，不修改实际类型字段
            slot_nm = TYPE_BOOK if is_book else SLOT_CODES.get(meta.get("slot", "zbwp"), meta.get("slot", "zbwp"))
            role_bracket = f"[{restriction}]" if restriction else ""
            qual_bracket = f" [{qual}]" if qual else ""
            display = (f"[{src_tag}] {name}{role_bracket}{qual_bracket}"
                       f"  ({code})  {slot_nm}")
            lb.insert(tk.END, display)
            disp_map[display] = code
            count += 1
            if count >= 500:
                break
        if count == 0:
            lb.insert(tk.END, "（无匹配）")
        # 更新计数提示
        try:
            count_lbl.configure(text=f"共 {count} 项匹配")
        except Exception:
            pass

    def _add_item_by_code(self, code: str, enhancement_level: int = 0) -> None:
        """根据代码向当前背包追加一件物品（含强化 + 合成默认值）。

        强化等级只写入「强化」字段(索引14)，基础属性(7~13)保持参考库原始值，
        由游戏在读取时按 强化等级×每级加成 计算最终属性（不直接修改基础属性）。
        """
        meta = self.refdata.get("code_catalog", {}).get(code, {})
        name = meta.get("name", "")

        # equip_attrs 查找：先精确匹配，再模糊匹配（兼容 code_catalog 与
        # equip_attrs 之间名称含/缺中间点 "·" 等微小差异）
        ea_dict = self.refdata.get("equip_attrs", {})
        ea = ea_dict.get(name) if name else None
        if ea is None and name:
            for candidate in (name.replace("·", ""), name.replace("", "·").strip()):
                if candidate and candidate != name and candidate in ea_dict:
                    ea = ea_dict[candidate]
                    break

        # 合成装备预计算默认值（覆盖全部已知合成装备，包括命定·花宴）
        synth_defaults = None
        if is_synthetic_equip(name):
            synth_defaults = calc_synthetic_defaults(
                name, ea_dict)

        new_item = new_item_template(
            meta, count=1, code=code,
            equip_attrs=ea, enhancement_level=enhancement_level)

        # 用合成预计算值覆盖基础为 0 的属性
        if synth_defaults:
            for fi, val in synth_defaults.items():
                if fi < len(new_item) and new_item[fi] == "0":
                    new_item[fi] = val

        self.items.append(new_item)
        self._flush_current_bag()
        self._rebuild_sheet()
        # 表格(self.sheet)已移除改为卡片网格；保留兼容引用(可能为 None)
        sheet = getattr(self, "sheet", None)
        if sheet is not None:
            try:
                sheet.select_row(len(self.items) - 1)
            except Exception:
                pass
        self._show_item_detail(new_item)

        enh_tag = f" +{enhancement_level}" if enhancement_level > 0 else ""
        self._set_status(
            f"已添加: {name}{enh_tag} ({code})  — 记得保存", C_ACCENT2)
