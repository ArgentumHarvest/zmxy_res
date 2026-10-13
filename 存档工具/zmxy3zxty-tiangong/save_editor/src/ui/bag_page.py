"""背包编辑页（Mixin）。

职责单一：渲染「背包装备 / 已装备 / 道具材料 / 时装」四类背包的表格化编辑，
含行选中高亮、右侧详情抽屉（完整 28 字段分组可编辑）、单元格内联编辑、
批量复选删除、刷新与颜色高亮；并承载「强化」入口（工具栏按钮 + 详情抽屉）
与参考库联动。

布局采用 tksheet 虚拟化表格（替代会严重卡顿的卡片网格）：点击行 → 右侧抽屉
编辑，所见即所得，降低认知成本；几十上百件物品滚动依旧丝滑。
批量删除支持：行号列复选框 + 全选/反选 + 二次确认弹窗 + 加载状态反馈。
依赖: core.constants, data.items, data.synthesis, data.enhancement, utils.color, ui.theme。
"""
import os
import time
import tkinter as tk
from tkinter import messagebox
import customtkinter as ctk
from tksheet import Sheet

from core import load_save
from core.constants import (VISIBLE_FIELDS, ITEM_FIELDS, BAG_FIELDS,
                            QUALITY_COLORS, READONLY_FIELDS, HIDDEN_FIELDS)
from utils.color import safe_hex
from ui.theme import (C_PANEL, C_FRAME, C_ACCENT, C_ACCENT2, C_WARN,
                     C_ERR, C_FG, C_SUB, FONT_FAMILY, CORNER,
                     HOVER_ACCENT, HOVER_ACCENT2, HOVER_ERR,
                     C_BTN_SUB, HOVER_BTN_SUB, C_NAV_BORDER,
                     C_SELECTED_ROW, C_SELECTED_ROW_BORDER)

VIS = VISIBLE_FIELDS
VIS_HEADERS = [ITEM_FIELDS[i][1] for i in VIS]

# tksheet 主题（清新简约 / Mint，复用 ui.theme 令牌，保证全局一致）
_MINT_SHEET = {
    # 表头
    "header_bg": C_FRAME,
    "header_fg": C_FG,
    "header_border_fg": C_NAV_BORDER,
    "header_grid_fg": C_NAV_BORDER,
    # 行号列
    "index_bg": C_FRAME,
    "index_fg": C_SUB,
    "index_border_fg": C_NAV_BORDER,
    "index_grid_fg": C_NAV_BORDER,
    # 左上角
    "top_left_bg": C_FRAME,
    "top_left_fg": C_SUB,
    # 表体
    "table_bg": C_PANEL,
    "table_fg": C_FG,
    "table_grid_fg": C_NAV_BORDER,
    # 选中行
    "table_selected_rows_bg": C_SELECTED_ROW,
    "table_selected_rows_fg": C_FG,
    "table_selected_rows_border_fg": C_SELECTED_ROW_BORDER,
    "index_selected_rows_bg": C_ACCENT,
    "index_selected_rows_fg": "#ffffff",
    # 选中单元格
    "table_selected_cells_bg": C_SELECTED_ROW,
    "table_selected_cells_fg": C_FG,
}

# 详情抽屉字段分组（覆盖全部 28 字段，确保无字段缺失）
DETAIL_GROUPS = [
    ("基础信息", [0, 1, 2, 3, 4, 5, 6, 22]),   # 品质/名称/代码/类型/限制/品质/颜色/数量
    ("属性",     [7, 8, 9, 10, 11, 12, 13, 14]),  # 生命/魔法/攻击/防御/闪避/暴击/回血/回魔
    ("强化",     [23]),                          # 强化等级
    ("成长",     [15, 16, 17, 18, 19, 20, 21]),  # 金木水火土/等级/成长率
    ("其他",     [24, 25, 26, 27]),              # 魔抗/-0-/命中/泣血
]


def _hex(hexstr):
    """0xRRGGBB / #RRGGBB → #rrggbb；非法返回灰色。"""
    h = safe_hex(hexstr)
    return ("#" + h) if h else "#9aa0a6"


def _text_on(hexcolor):
    h = _hex(hexcolor).lstrip("#")
    if len(h) != 6:
        return "#1f2a28"
    r, g, b = int(h[0:2], 16), int(h[2:4], 16), int(h[4:6], 16)
    return "#1f2a28" if (0.299 * r + 0.587 * g + 0.114 * b) > 150 else "#ffffff"


def _qual_hex(qual):
    return _hex(QUALITY_COLORS.get(qual, "0x888888"))


def _fmt(v):
    """格式化单元格显示值：纯整数去掉前导零（如 '0111'→'111'），
    浮点数/非数字原样保留。"""
    s = str(v).strip()
    try:
        iv = int(s)
        # 确认原始字符串确实是「带前导零的整数」再转换
        if s != str(iv):
            return str(iv)
    except (ValueError, TypeError):
        pass
    return s


class BagPageMixin:
    """背包编辑页相关方法。"""

    # ────────────────────────────────────
    # ② 背包编辑页
    # ────────────────────────────────────
    def _switch_to_bag(self, bag_label: str) -> None:
        if self.save is None:
            tk.messagebox.showwarning("未打开", "请先打开一个存档")
            return
        self._flush_current_bag()
        self._apply_global(silent=True)
        self._hide_all_pages()
        self.active_page = bag_label
        self.active_bag = bag_label
        self._highlight_nav(bag_label)

        if self.bag_frame is None:
            self._build_bag_workspace()
        self.bag_frame.pack(fill=tk.BOTH, expand=True, padx=4, pady=4)
        self._update_bag_toolbar()
        self._load_active_bag()
        self._rebuild_sheet()

    def _load_active_bag(self) -> None:
        """从模型读取当前背包到编辑副本 self.items（仅在切换/打开时调用）。"""
        if not self.active_bag or self.active_bag not in BAG_FIELDS:
            self.items = []
            return
        xmlf = BAG_FIELDS[self.active_bag]
        raw_items = self.save.get_bag(xmlf)
        normalized = []
        for it in raw_items:
            while len(it) < 28:
                it.append("0")
            normalized.append(it)
        self.items = normalized

    def _build_bag_workspace(self) -> None:
        bf = ctk.CTkFrame(self.center, fg_color=C_PANEL, corner_radius=CORNER)

        # ── 工具条（单行紧凑布局）──
        bar = ctk.CTkFrame(bf, fg_color=C_PANEL, corner_radius=CORNER, height=44)
        bar.pack(fill=tk.X, padx=4, pady=4)
        # 防止工具条被子组件撑高：固定高度后关闭几何传播
        bar.pack_propagate(False)

        self.bag_title_lbl = ctk.CTkLabel(
            bar, text="", text_color=C_ACCENT,
            font=ctk.CTkFont(family=FONT_FAMILY, size=14, weight="bold"))
        self.bag_title_lbl.pack(side=tk.LEFT, padx=(6, 4), pady=8)

        # ── 选择操作区（批量复选删除）──
        sel_bar = ctk.CTkFrame(bar, fg_color=C_FRAME, corner_radius=6)
        sel_bar.pack(side=tk.LEFT, padx=(4, 6), pady=4)
        # 全选按钮
        self.bag_select_all_btn = ctk.CTkButton(
            sel_bar, text="☑ 全选", width=58, height=26,
            corner_radius=5, command=self._cmd_select_all,
            fg_color=C_BTN_SUB, hover_color=HOVER_BTN_SUB,
            text_color=C_FG, font=ctk.CTkFont(family=FONT_FAMILY, size=10))
        self.bag_select_all_btn.pack(side=tk.LEFT, padx=1, pady=2)
        # 清除选择按钮
        self.bag_deselect_btn = ctk.CTkButton(
            sel_bar, text="☐ 清除", width=58, height=26,
            corner_radius=5, command=self._cmd_deselect_all,
            fg_color=C_BTN_SUB, hover_color=HOVER_BTN_SUB,
            text_color=C_FG, font=ctk.CTkFont(family=FONT_FAMILY, size=10))
        self.bag_deselect_btn.pack(side=tk.LEFT, padx=1, pady=2)
        # 反选按钮
        self.bag_invert_sel_btn = ctk.CTkButton(
            sel_bar, text="⇄ 反选", width=58, height=26,
            corner_radius=5, command=self._cmd_invert_selection,
            fg_color=C_BTN_SUB, hover_color=HOVER_BTN_SUB,
            text_color=C_FG, font=ctk.CTkFont(family=FONT_FAMILY, size=10))
        self.bag_invert_sel_btn.pack(side=tk.LEFT, padx=1, pady=2)

        # 分隔线（固定高度，不用 fill=Y 避免撑开父容器）
        sep = ctk.CTkFrame(sel_bar, fg_color=C_NAV_BORDER, width=1, height=20)
        sep.pack(side=tk.LEFT, padx=3, pady=4)

        # 已选计数标签（紧凑格式，避免溢出截断）
        self.bag_sel_count_lbl = ctk.CTkLabel(
            sel_bar, text="0",
            text_color=C_ACCENT, font=ctk.CTkFont(family=FONT_FAMILY, size=10, weight="bold"))
        self.bag_sel_count_lbl.pack(side=tk.LEFT, padx=3, pady=4)

        ctk.CTkButton(bar, text="+ 添加物品", width=100, height=30, corner_radius=6,
                      command=self._dlg_add_item,
                      fg_color=C_ACCENT, hover_color=HOVER_ACCENT,
                      text_color="#ffffff", font=ctk.CTkFont(family=FONT_FAMILY, size=11, weight="bold")
                      ).pack(side=tk.LEFT, padx=3, pady=7)
        self.bag_add_btn = bar.winfo_children()[-1]
        # 批量删除按钮（支持多选）
        self.bag_del_btn = ctk.CTkButton(
            bar, text="🗑 删除选中", width=90, height=30, corner_radius=6,
            command=self._cmd_batch_delete,
            fg_color=C_ERR, hover_color=HOVER_ERR,
            text_color="#ffffff", font=ctk.CTkFont(family=FONT_FAMILY, size=11, weight="bold"))
        self.bag_del_btn.pack(side=tk.LEFT, padx=3, pady=7)
        ctk.CTkButton(bar, text="⚔ 强化", width=70, height=30, corner_radius=6,
                      command=self._rc_enhance,
                      fg_color=C_ACCENT2, hover_color=HOVER_ACCENT2,
                      text_color="#ffffff", font=ctk.CTkFont(family=FONT_FAMILY, size=11, weight="bold")
                      ).pack(side=tk.LEFT, padx=3, pady=7)
        self.bag_enh_btn = bar.winfo_children()[-1]
        ctk.CTkButton(bar, text="↻ 刷新", width=70, height=30, corner_radius=6,
                      command=self._reload_from_disk,
                      fg_color=C_BTN_SUB, hover_color=HOVER_BTN_SUB,
                      text_color=C_FG, font=ctk.CTkFont(family=FONT_FAMILY, size=11)
                      ).pack(side=tk.LEFT, padx=3, pady=7)
        self.bag_refresh_btn = bar.winfo_children()[-1]
        ctk.CTkButton(bar, text="✎ 编辑", width=70, height=30, corner_radius=6,
                      command=self._cmd_edit_selected,
                      fg_color=C_BTN_SUB, hover_color=HOVER_BTN_SUB,
                      text_color=C_FG, font=ctk.CTkFont(family=FONT_FAMILY, size=11)
                      ).pack(side=tk.LEFT, padx=3, pady=7)
        self.bag_edit_btn = bar.winfo_children()[-1]
        ctk.CTkButton(bar, text="💾 保存", width=70, height=30, corner_radius=6,
                      command=self.cmd_save,
                      fg_color=C_ACCENT, hover_color=HOVER_ACCENT,
                      text_color="#ffffff", font=ctk.CTkFont(family=FONT_FAMILY, size=11, weight="bold")
                      ).pack(side=tk.LEFT, padx=3, pady=7)
        self.bag_save_btn = bar.winfo_children()[-1]

        self.bag_count_lbl = ctk.CTkLabel(bar, text="", text_color=C_SUB,
                                         font=ctk.CTkFont(family=FONT_FAMILY, size=10))
        self.bag_count_lbl.pack(side=tk.RIGHT, padx=8, pady=8)

        # tksheet 虚拟化表格（滚动/编辑均流畅，替代卡顿的卡片网格）
        host = tk.Frame(bf, bg=C_PANEL, highlightthickness=0)
        host.pack(fill=tk.BOTH, expand=True, padx=4, pady=(0, 4))

        sheet = Sheet(
            host,
            data=[["" for _ in range(len(VIS))]],
            headers=VIS_HEADERS,
            default_column_width=100,
            default_row_height=28,
            font=(FONT_FAMILY, 11, "normal"),
            header_font=(FONT_FAMILY, 11, "bold"),
            index_font=(FONT_FAMILY, 10, "normal"),
        )
        sheet.pack(fill=tk.BOTH, expand=True)
        sheet.set_options(**_MINT_SHEET)
        # 选中行高亮（明显区分当前行）
        sheet.set_options(
            selected_rows_bg=C_SELECTED_ROW,
            selected_rows_fg=C_FG,
            selected_cells_bg=C_SELECTED_ROW,
            selected_cells_fg=C_FG,
            table_selected_rows_border_fg=C_SELECTED_ROW_BORDER,
            table_selected_cells_border_fg=C_SELECTED_ROW_BORDER,
        )
        sheet.enable_bindings(
            "single_select", "row_select", "ctrl_select",
            "edit_cell", "copy", "cut", "paste", "delete",
            "undo", "select_all", "deselect",
        )
        # 关闭 tksheet 自带右键菜单，改用自定义菜单
        try:
            sheet.disable_bindings("right_click_popup_menu")
        except Exception:
            pass
        # 列保护：品级/装备代码/装备类型/装备颜色 设为只读
        try:
            sheet.readonly_columns(columns=list(READONLY_FIELDS))
        except Exception:
            pass
        # 列隐藏：上述四列在界面上隐藏（data_indexes=True 保证按数据索引隐藏，
        # 不受 set_sheet_data 后 all_columns_displayed 状态影响）
        try:
            sheet.hide_columns(columns=list(HIDDEN_FIELDS), data_indexes=True)
        except Exception:
            pass
        sheet.extra_bindings([
            ("row_select", self._on_row_selected),
            ("end_edit_cell", self._on_cell_edited),
        ])
        # 绑定复选框事件（行号列勾选/取消 → 更新选中计数）
        try:
            sheet.extra_bindings([("index_checkbox", self._on_index_checkbox)])
        except Exception:
            pass
        # 自定义右键菜单（复制 / 粘贴 / 删除行 / 强化）
        sheet.bind("<Button-3>", self._on_right_click)
        sheet.bind("<Button-2>", self._on_right_click)  # macOS 次级按键
        self.sheet = sheet

        self.bag_frame = bf

    def _update_bag_toolbar(self) -> None:
        """根据当前背包类型控制工具栏按钮可见性（保持原行为）。"""
        if not hasattr(self, "bag_add_btn"):
            return
        is_equip = self.active_bag in getattr(
            self, "ENHANCE_BAGS", ("背包装备", "已装备"))
        if self.active_bag == "已装备":
            # 已装备：隐藏添加、删除、选择操作
            self.bag_add_btn.pack_forget()
            self.bag_del_btn.pack_forget()
            for w in (getattr(self, "bag_select_all_btn", None),
                      getattr(self, "bag_deselect_btn", None),
                      getattr(self, "bag_invert_sel_btn", None),
                      getattr(self, "bag_sel_count_lbl", None)):
                if w is not None:
                    try:
                        w.master.pack_forget()  # 隐藏整个 sel_bar
                    except Exception:
                        pass
        else:
            self.bag_add_btn.pack(side=tk.LEFT, padx=4,
                                  before=self.bag_refresh_btn)
            self.bag_del_btn.pack(side=tk.LEFT, padx=4,
                                  before=self.bag_refresh_btn)
        if is_equip:
            self.bag_enh_btn.pack(side=tk.LEFT, padx=4,
                                  before=self.bag_refresh_btn)
        else:
            self.bag_enh_btn.pack_forget()
        # 编辑 / 保存：始终可见
        self.bag_edit_btn.pack(side=tk.LEFT, padx=4,
                               before=self.bag_refresh_btn)
        self.bag_save_btn.pack(side=tk.LEFT, padx=4,
                               before=self.bag_refresh_btn)

    def _reload_from_disk(self) -> None:
        """刷新：从磁盘重新加载当前存档，丢弃所有未保存的编辑（还原原始数据）。"""
        if not (self.current_path and os.path.isfile(self.current_path)):
            self._set_status("未打开存档，无法从文件还原", C_WARN)
            return
        try:
            self.save = load_save(self.current_path)
            name = os.path.basename(self.current_path)
            self.title_lbl.configure(text=name)
            self._set_status(
                f"已从文件重新加载: {name}（未保存修改已丢弃）", C_ACCENT2)
        except Exception as exc:
            self._set_status(f"重新加载失败: {exc}", C_ERR)
            tk.messagebox.showerror("加载失败", str(exc))
            return
        self.items = []
        self._last_selected_row = None
        self._close_detail()
        if self.active_page == "global":
            self._populate_global_form()
            self.active_bag = "global"  # 重置，避免旧背包标签触发误写
        elif self.active_page in BAG_FIELDS:
            self._load_active_bag()
            self._rebuild_sheet()
        elif self.active_page == "ref":
            self._populate_ref_panel()

    def _rebuild_sheet(self) -> None:
        """渲染当前编辑副本 self.items 到 tksheet（不回写模型、不重读模型）。"""
        if not self.active_bag or self.active_bag not in BAG_FIELDS:
            self._set_status("未选择背包分类", C_WARN)
            return

        # 规范化为 28 字段（就地补全，保持与模型一致）
        normalized: list = []
        for it in self.items:
            while len(it) < 28:
                it.append("0")
            normalized.append(it)
        self.items = normalized

        # 推入表格（单行格式化，整数值去掉前导零）
        data = [[_fmt(c) for c in row] for row in normalized]
        sheet = getattr(self, "sheet", None)
        if sheet is None:
            return
        sheet.set_sheet_data(data, reset_col_positions=False,
                             reset_row_positions=True)
        # 重建行号列复选框（数据刷新后必须重新创建）
        try:
            # 先删除旧复选框（避免残留）
            try:
                sheet.delete_index_checkbox("all")
            except Exception:
                pass
            if data:
                sheet.create_index_checkbox("all")
                # 刷新视图以确保复选框正确渲染
                try:
                    sheet.refresh()
                except Exception:
                    pass
        except Exception:
            pass
        # 重新应用列保护（set_sheet_data 可能重置可见性/只读状态）
        try:
            sheet.readonly_columns(columns=list(READONLY_FIELDS))
        except Exception:
            pass
        try:
            sheet.hide_columns(columns=list(HIDDEN_FIELDS), data_indexes=True)
        except Exception:
            pass

        self.bag_title_lbl.configure(
            text=f"{self.active_bag} ({len(normalized)} 件)")
        self.bag_count_lbl.configure(text=f"共 {len(normalized)} 件")

        # 清空选中态（数据已变，旧选中行失效）
        self._last_selected_row = None
        self._checked_rows = set()  # 重置自维护的复选框状态集合
        self._close_detail()

        self._set_status(
            f"已刷新 {self.active_bag} ({len(normalized)} 件)", C_ACCENT2)
        # 重置选中计数（表格重建后所有复选框归零）
        self._update_sel_count()

    # ── 行选中 / 单元格编辑 ──
    def _on_row_selected(self, event=None) -> None:
        """行选中回调：兼容测试传入的 {"row": n} 与 tksheet 真实选中事件。"""
        idx = None
        if isinstance(event, dict):
            if "row" in event:
                idx = event["row"]
            elif "selected" in event and event["selected"] is not None:
                sel = event["selected"]
                idx = getattr(sel, "row", None)
                if idx is None:
                    rows = getattr(sel, "rows", None)
                    if rows:
                        idx = next(iter(rows))
        if idx is None:
            sheet = getattr(self, "sheet", None)
            if sheet is not None:
                rows = sheet.get_selected_rows()
                idx = min(rows) if rows else None
        if idx is None or not (0 <= idx < len(self.items)):
            return
        self._last_selected_row = idx
        self._render_detail(idx)              # 填充右侧抽屉
        self._show_item_detail(self.items[idx])  # 同步参考面板

    def _on_cell_edited(self, event=None) -> None:
        """单元格内联编辑后写回编辑副本与模型（兼容测试与 tksheet 真实事件）。

        关键：tksheet 的 end_edit_cell 事件中 row/column 为「显示坐标」。
        当存在隐藏列（品级/装备代码/装备类型/装备颜色）时，显示列号与数据
        字段索引并不一致。必须用 sheet.datacn / sheet.datarn 将显示坐标转换为
        数据坐标（字段索引），否则会把编辑值写入偏移后的错误字段，造成错位。
        """
        if not isinstance(event, dict):
            return
        r_disp = event.get("row")
        c_disp = event.get("column")
        v = event.get("value")
        if r_disp is None or c_disp is None or v is None:
            return
        sheet = getattr(self, "sheet", None)
        if sheet is None:
            return
        # 显示坐标 → 数据坐标（字段索引）；读取保护列不会触发编辑事件
        r = sheet.datarn(r_disp)
        c = sheet.datacn(c_disp)
        if not (0 <= r < len(self.items)) or c >= len(self.items[r]):
            return
        self.items[r][c] = str(v)
        self._flush_current_bag()
        field_name = ITEM_FIELDS[c][1] if c < len(ITEM_FIELDS) else f"字段{c}"
        self._set_status(f"已编辑「{field_name}」(行{r + 1})", C_ACCENT2)

    def _render_detail(self, idx: int) -> None:
        """填充右侧详情抽屉：分组展示并编辑全部 28 字段。"""
        if idx < 0 or idx >= len(self.items):
            return
        it = self.items[idx]
        self.detail_title.configure(text=it[1].strip() or "(无名)")
        self.detail_swatch.configure(fg_color=_hex(it[6]) if len(it) > 6 else "#9aa0a6")

        for w in self.detail_body.winfo_children():
            w.destroy()

        for gname, fids in DETAIL_GROUPS:
            grp = ctk.CTkFrame(self.detail_body, fg_color="transparent")
            grp.pack(fill=tk.X, padx=10, pady=(10, 2))
            ctk.CTkLabel(grp, text=gname, text_color=C_ACCENT,
                        font=ctk.CTkFont(family=FONT_FAMILY, size=12, weight="bold")
                        ).pack(anchor="w")
            grid = ctk.CTkFrame(grp, fg_color=C_PANEL, corner_radius=CORNER)
            grid.pack(fill=tk.X, pady=4)
            grid.columnconfigure(0, weight=1)
            grid.columnconfigure(1, weight=1)
            for r, fid in enumerate(fids):
                label = ITEM_FIELDS[fid][1]
                f = ctk.CTkFrame(grid, fg_color="transparent")
                f.grid(row=r // 2, column=r % 2, sticky="ew", padx=6, pady=4)
                ctk.CTkLabel(f, text=label, text_color=C_SUB,
                            font=ctk.CTkFont(family=FONT_FAMILY, size=11)).pack(anchor="w")
                ent = ctk.CTkEntry(f, font=ctk.CTkFont(family=FONT_FAMILY, size=12))
                ent.insert(0, _fmt(it[fid]) if fid < len(it) else "")
                if fid in READONLY_FIELDS:
                    # 受保护列：详情抽屉中同样只读，避免误改
                    ent.configure(state="readonly")
                else:
                    ent.bind("<FocusOut>",
                             lambda e, fid=fid, ent=ent: self._set_field(idx, fid, ent.get()))
                ent.pack(fill=tk.X)

        self._show_detail_panel()

    def _set_field(self, idx: int, fid: int, val: str) -> None:
        if not (0 <= idx < len(self.items)):
            return
        self.items[idx][fid] = str(val)
        if fid == 6:
            self.detail_swatch.configure(fg_color=_hex(val))
        # 同步表格对应单元格（不重建整表，避免卡顿）
        sheet = getattr(self, "sheet", None)
        if sheet is not None:
            try:
                sheet.set_cell_data(idx, fid, str(val))
            except Exception:
                pass
        self._flush_current_bag()
        self._set_status(f"已更新字段「{ITEM_FIELDS[fid][1]}」", C_ACCENT2)

    # ── 批量选择操作 ──
    def _get_checked_rows(self) -> set:
        """获取所有被勾选的行索引集合（数据坐标）。

        使用自维护的 _checked_rows 集合，因为 tksheet 7.6.0 的
        get_index_checkboxes() 不返回 checked 状态、
        get_cell_data(column=-1) 返回的是行号字母而非 checkbox 状态，
        无法可靠地反向读取 index checkbox 勾选态。
        """
        return getattr(self, "_checked_rows", set()).copy()

    def _update_sel_count(self) -> None:
        """更新工具栏选中计数显示和删除按钮状态。"""
        n = len(self._get_checked_rows())
        lbl = getattr(self, "bag_sel_count_lbl", None)
        if lbl is not None:
            lbl.configure(text=str(n))
        # 动态更新删除按钮文字与可用态
        btn = getattr(self, "bag_del_btn", None)
        if btn is not None:
            if n > 0:
                btn.configure(text=f"🗑 删除({n})", state="normal")
            else:
                btn.configure(text="🗑 删除选中", state="normal")

    def _on_index_checkbox(self, event=None) -> None:
        """行号列复选框勾选/取消回调：同步更新 _checked_rows 并刷新计数。

        tksheet 7.6.0 的 index_checkbox 事件中 event 格式为 dict，
        含 'row'（数据坐标）和 'checked' 布尔值。
        由于 tksheet 无法可靠反向读取 checkbox 状态，必须在此处
        同步维护 _checked_rows 集合。
        """
        if not hasattr(self, "_checked_rows"):
            self._checked_rows = set()
        sheet = getattr(self, "sheet", None)
        if sheet is not None and event and isinstance(event, dict):
            try:
                row = int(event.get("row", -1))
                checked = event.get("checked", False)
                if 0 <= row < len(self.items):
                    if checked:
                        self._checked_rows.add(row)
                    else:
                        self._checked_rows.discard(row)
            except (ValueError, TypeError, KeyError):
                pass
        self._update_sel_count()

    def _cmd_select_all(self) -> None:
        """全选：勾选所有行的复选框。"""
        sheet = getattr(self, "sheet", None)
        if sheet is None or not self.items:
            return
        if not hasattr(self, "_checked_rows"):
            self._checked_rows = set()
        try:
            # 确保所有行都有复选框
            try:
                sheet.create_index_checkbox("all")
            except Exception:
                pass
            # 批量勾选（使用 click_index_checkbox，tksheet 7.6.0 可用）
            for r in range(len(self.items)):
                try:
                    sheet.click_index_checkbox(r, True)
                except Exception:
                    pass
            # 统一重绘一次（而非每行重绘）
            try:
                sheet.refresh()
            except Exception:
                try:
                    sheet.redraw()
                except Exception:
                    pass
        except Exception:
            # 最终回退：使用 select_row
            try:
                sheet.select_row("all")
            except Exception:
                pass
        # 同步自维护的选中集合
        self._checked_rows = set(range(len(self.items)))
        self._update_sel_count()
        self._set_status(f"已全选 {len(self.items)} 件", C_ACCENT2)

    def _cmd_deselect_all(self) -> None:
        """清除选择：取消所有勾选/选中。"""
        sheet = getattr(self, "sheet", None)
        if sheet is None:
            return
        try:
            total_rows = len(self.items) if self.items else 0
            # 批量取消勾选（使用 click_index_checkbox）
            for r in range(total_rows):
                try:
                    sheet.click_index_checkbox(r, False)
                except Exception:
                    pass
            # 统一重绘
            try:
                sheet.refresh()
            except Exception:
                try:
                    sheet.redraw()
                except Exception:
                    pass
        except Exception:
            pass
        # 同时清除高亮选中行
        try:
            sheet.deselect(anything_selected=True)
        except Exception:
            pass
        # 清空自维护的选中集合
        self._checked_rows = set()
        self._update_sel_count()
        self._set_status("已清除所有选择", C_SUB)

    def _cmd_invert_selection(self) -> None:
        """反选：翻转每行的选中状态。已勾选的取消，未勾选的勾上。"""
        sheet = getattr(self, "sheet", None)
        if sheet is None or not self.items:
            return
        if not hasattr(self, "_checked_rows"):
            self._checked_rows = set()
        currently_checked = self._get_checked_rows()  # 从自维护集合读取
        all_rows = set(range(len(self.items)))
        to_check = all_rows - currently_checked
        to_uncheck = currently_checked
        try:
            # 批量设置新状态
            for r in to_uncheck:
                try:
                    sheet.click_index_checkbox(r, False)
                except Exception:
                    pass
            for r in to_check:
                try:
                    sheet.click_index_checkbox(r, True)
                except Exception:
                    pass
            # 统一重绘一次
            try:
                sheet.refresh()
            except Exception:
                try:
                    sheet.redraw()
                except Exception:
                    pass
        except Exception:
            pass
        # 同步自维护的选中集合为翻转后的状态
        self._checked_rows = to_check
        self._update_sel_count()
        self._set_status(
            f"已反选：{len(to_check)} 件选中, {len(to_uncheck)} 件取消", C_ACCENT2)
        self._set_status(
            f"已反选：{len(to_check)} 件选中, {len(currently_checked)} 件取消",
            C_ACCENT2)

    # ── 删除（批量 + 单条）──
    def _cmd_batch_delete(self) -> None:
        """批量删除入口：收集选中行 → 二次确认 → 加载反馈 → 执行删除 → 刷新。

        流程：
          1. 收集勾选的行号（支持多选）
          2. 若无选中 → 提示用户
          3. 弹出二次确认对话框，显示待删除数量和物品名称摘要
          4. 用户确认后：禁用按钮 + 显示加载遮罩
          5. 按倒序逐行删除（避免索引偏移）
          6. 写回模型、刷新表格
          7. 显示成功提示 / 错误提示
          8. 自动清除所有选中状态
        """
        rows_to_delete = self._get_checked_rows()

        # 无选中项提示
        if not rows_to_delete:
            # 回退：尝试使用上次单选行
            if (self._last_selected_row is not None
                    and 0 <= self._last_selected_row < len(self.items)):
                rows_to_delete = {self._last_selected_row}
            else:
                self._set_status("请先勾选要删除的物品（可多选），或单击一行后删除",
                                 C_WARN)
                return

        count = len(rows_to_delete)

        # 构建物品名称摘要（用于确认对话框，最多显示前5个）
        names = []
        for r in sorted(rows_to_delete)[:5]:
            if 0 <= r < len(self.items):
                name = str(self.items[r][1]).strip() or "(无名)"
                names.append(f"  · 第{r+1}行: {name}")
        if count > 5:
            names.append(f"  ... 等 {count} 件")

        # 二次确认对话框
        confirm_msg = (
            f"确定要删除以下 {count} 件物品吗？\n\n"
            + "\n".join(names)
            + "\n\n⚠ 此操作无法撤销！"
        )
        if not messagebox.askyesno("批量删除确认", confirm_msg,
                                  icon=messagebox.WARNING):
            self._set_status("已取消删除", C_SUB)
            return

        # ── 执行删除（带加载状态）──
        self._set_status(f"正在删除 {count} 件物品...", C_WARN)
        btn = getattr(self, "bag_del_btn", None)
        if btn is not None:
            btn.configure(state="disabled", text="⏳ 删除中...")

        # 强制刷新 UI 使「删除中」状态可见
        app = getattr(self, "app", None)
        if app is not None:
            try:
                app.update_idletasks()
            except Exception:
                pass

        try:
            start_time = time.monotonic()

            # 倒序删除（避免索引偏移导致删错行）
            sorted_rows = sorted(rows_to_delete, reverse=True)
            deleted_names = []
            for r in sorted_rows:
                if 0 <= r < len(self.items):
                    name = str(self.items[r][1]).strip() or "(无名)"
                    deleted_names.append(name)
                    del self.items[r]

            # 写回模型
            self._flush_current_bag()

            elapsed = time.monotonic() - start_time

            # 清除选中状态
            self._last_selected_row = None
            self._close_detail()
            self._cmd_deselect_all()

            # 刷新表格（单次重建即可）
            self._rebuild_sheet()

            self._set_status(
                f"✓ 已成功删除 {count} 件物品（耗时 {elapsed:.2f}s）",
                C_ACCENT2)

            # 成功提示（非阻塞 toast 式）
            self._show_success_toast(f"已删除 {count} 件物品")

        except Exception as exc:
            self._set_status(f"✗ 删除失败: {exc}", C_ERR)
            messagebox.showerror("删除失败",
                                 f"删除过程中发生错误:\n{exc}\n\n"
                                 "请检查存档文件是否完好，或尝试重新打开存档。")
            # 失败时也刷新表格以恢复一致状态
            try:
                self._load_active_bag()
                self._rebuild_sheet()
            except Exception:
                pass
        finally:
            # 恢复按钮状态
            if btn is not None:
                btn.configure(state="normal", text="🗑 删除选中")
            self._update_sel_count()

    def _show_success_toast(self, msg: str, duration_ms: int = 2000) -> None:
        """显示短暂的成功提示（自动消失），不阻塞主窗口。"""
        app = getattr(self, "app", None)
        if app is None:
            return
        try:
            toast = ctk.CTkToplevel(app)
            toast.overrideredirect(True)
            toast.attributes("-topmost", True)
            # 居中偏下定位
            x = app.winfo_x() + app.winfo_width() // 2 - 150
            y = app.winfo_y() + app.winfo_height() - 120
            toast.geometry(f"300x50+{x}+{y}")
            frame = ctk.CTkFrame(toast, fg_color=C_ACCENT, corner_radius=10)
            frame.pack(fill=tk.BOTH, expand=True, padx=2, pady=2)
            ctk.CTkLabel(frame, text=msg, text_color="#ffffff",
                        font=ctk.CTkFont(family=FONT_FAMILY, size=13, weight="bold")
                        ).pack(expand=True)
            # 自动销毁
            toast.after(duration_ms, toast.destroy)
        except Exception:
            # toast 创建失败时静默忽略，不影响主流程
            pass

    def _cmd_delete_rows(self) -> None:
        """保留旧接口（向后兼容）：委托给批量删除方法。"""
        self._cmd_batch_delete()

    def _flush_current_bag(self) -> None:
        """将当前 items 写回 SaveFile 模型。"""
        if (self.save is not None
                and self.active_bag is not None
                and self.active_bag in BAG_FIELDS
                and self.items is not None):
            xmlf = BAG_FIELDS[self.active_bag]
            self.save.set_bag(xmlf, self.items)

    # ── 右键上下文菜单：复制 / 粘贴 / 删除行 / 强化 ──
    def _on_right_click(self, event=None) -> None:
        """弹出右键菜单：复制本行 / 粘贴为新增行 / 删除本行 / 强化。"""
        if not getattr(self, "items", None):
            return
        sheet = getattr(self, "sheet", None)
        if sheet is None:
            return
        # 选中鼠标下的行（若可识别）
        row = None
        if event is not None:
            try:
                row = sheet.identify_row(event.y)
            except Exception:
                row = None
        if row is None:
            row = self._last_selected_row
        if row is None or not (0 <= row < len(self.items)):
            return
        try:
            sheet.select_row(row)
        except Exception:
            pass
        self._last_selected_row = row
        self._render_detail(row)
        self._show_item_detail(self.items[row])

        menu = tk.Menu(self.app, tearoff=0,
                       font=(FONT_FAMILY, 11),
                       bg=C_PANEL, fg=C_FG,
                       activebackground=C_ACCENT, activeforeground="#ffffff")
        menu.add_command(label="📋 复制本行",
                         command=lambda: self._copy_row(row))
        menu.add_command(label="📌 粘贴为新增行",
                         command=self._paste_row)
        menu.add_separator()
        menu.add_command(label="🗑 删除本行",
                         command=lambda: self._delete_single_row(row))
        menu.add_separator()
        menu.add_command(label="⚔ 强化",
                         command=self._rc_enhance)
        try:
            menu.tk_popup(event.x_root, event.y_root)
        finally:
            menu.grab_release()

    def _copy_row(self, row: int) -> None:
        """复制当前行到内部剪贴板。"""
        if not (0 <= row < len(self.items)):
            self._set_status("复制失败：行无效", C_WARN)
            return
        self._row_clipboard = list(self.items[row])
        self._set_status(f"已复制第 {row + 1} 行到剪贴板", C_ACCENT2)

    def _paste_row(self) -> None:
        """将剪贴板中的行作为新增行插入（在选中行之后，无选中则末尾）。"""
        buf = getattr(self, "_row_clipboard", None)
        if not buf:
            self._set_status("剪贴板为空，请先复制一行", C_WARN)
            return
        ins = self._last_selected_row
        if ins is None or not (0 <= ins < len(self.items)):
            ins = len(self.items) - 1
        new_row = list(buf)
        if len(new_row) > 22:
            new_row[22] = "1"  # 复制行数量归 1
        self.items.insert(ins + 1, new_row)
        self._flush_current_bag()
        self._rebuild_sheet()
        self._set_status("已粘贴为新增行", C_ACCENT2)

    def _delete_row_at(self, row: int) -> None:
        """删除指定行（右键菜单 / 通用，带确认）。"""
        self._delete_single_row(row)

    def _delete_single_row(self, row: int) -> None:
        """删除单行：确认对话框 → 执行 → 刷新。

        右键菜单「删除本行」和工具栏「删除选中」（仅1条时）均走此路径。
        """
        if not (0 <= row < len(self.items)):
            self._set_status("删除失败：行无效", C_WARN)
            return
        name = str(self.items[row][1]).strip() or "(无名)"
        if not messagebox.askyesno(
                "删除确认",
                f"确定要删除这件物品吗？\n\n"
                f"  第{row + 1}行: {name}\n\n"
                f"⚠ 此操作无法撤销！"):
            self._set_status("已取消删除", C_SUB)
            return
        try:
            del self.items[row]
            self._flush_current_bag()
            self._last_selected_row = None
            self._close_detail()
            self._rebuild_sheet()
            self._set_status("✓ 已删除 1 件", C_ACCENT2)
        except Exception as exc:
            self._set_status(f"✗ 删除失败: {exc}", C_ERR)
            messagebox.showerror("删除失败",
                                 f"删除过程中发生错误:\n{exc}")

    def _cmd_edit_selected(self) -> None:
        """编辑按钮：打开右侧详情抽屉编辑选中物品。"""
        row = self._last_selected_row
        if row is None or not (0 <= row < len(self.items)):
            self._set_status("请先选中一行再编辑", C_WARN)
            return
        self._render_detail(row)
        self._show_item_detail(self.items[row])
        self._set_status(f"正在编辑第 {row + 1} 行", C_ACCENT2)
