"""
造梦西游3 再续天庭篇 - 可视化存档编辑器（主程序）
============================================
技术栈: CustomTkinter + tksheet | 编解码: core | 数据: data | 主题: ui.theme

架构说明:
  - EditorApp 由四个单一职责 Mixin 组合而成：
      GlobalPageMixin  -> 全局属性页
      BagPageMixin      -> 背包编辑页
      AddItemDialogMixin-> 按代码添加物品
      RefPageMixin      -> 参考/校验页
  - 页面切换: _hide_all_pages() → pack 目标页面
  - 数据流: save(模型) ←→ items(编辑副本) ←→ sheet(UI展示)
"""
from __future__ import annotations

import glob
import os
import re
import sys
import ctypes
from ctypes import wintypes
import tkinter as tk
from tkinter import filedialog, messagebox

# tkinterdnd2 在导入时会给 tkinter.BaseWidget 打补丁，使其具备
# drop_target_register / dnd_bind 等方法；其 Tcl 扩展(tkdnd)需在根窗口创建后
# 通过 _require() 加载。注意：不要替换 tk.Tk 为 TkinterDnD.Tk（会与 customtkinter
# 的根窗口初始化冲突），而是在现有 CTk 根窗口上启用 DnD。
try:
    from tkinterdnd2 import TkinterDnD, DND_FILES
    _DND_AVAILABLE = True
except Exception:
    TkinterDnD = None
    DND_FILES = None
    _DND_AVAILABLE = False

import customtkinter as ctk

from core import (load_save, save_save, BAG_FIELDS,
                  VISIBLE_FIELDS, ITEM_FIELDS, ATTR_DISPLAY_NAMES)
from core.models import load_save_with_repair
from data.refdata import load_refdata
from ui.theme import (apply_theme, C_BG, C_PANEL, C_FRAME, C_ACCENT, C_ACCENT2,
                     C_WARN, C_ERR, C_FG, C_SUB, FONT_FAMILY, CORNER,
                     HOVER_ACCENT, HOVER_ACCENT2, HOVER_WARN,
                     C_BTN_SUB, HOVER_BTN_SUB, C_NAV_BORDER,
                     C_LIST_BG, C_LIST_FG, C_LIST_SEL, C_LIST_SEL_FG)
from ui.global_page import GlobalPageMixin, GLOBAL_FIELDS
from ui.bag_page import BagPageMixin
from ui.add_item_dialog import AddItemDialogMixin
from ui.ref_page import RefPageMixin
from ui.enhance_page import EnhancePageMixin

# 表格可见列（从 ITEM_FIELDS 中选取）
VIS = VISIBLE_FIELDS
VIS_HEADERS = [ITEM_FIELDS[i][1] for i in VIS]


# ── DPI 感知（必须在创建任何 Tk 窗口 / 读取屏幕尺寸前启用）──
def _enable_dpi_awareness() -> None:
    """启用进程级 DPI 感知，使 winfo_screen* 与系统 API 返回的屏幕尺寸
    处于同一（物理像素）坐标系，避免高分屏下因 DPI 虚拟化导致窗口被系统
    二次放大而超出屏幕可用范围。"""
    if sys.platform.startswith("win"):
        try:
            # PROCESS_SYSTEM_DPI_AWARE = 1：进程采用系统 DPI，坐标系与
            # SPI_GETWORKAREA 一致，且对 Tk 最友好（无需处理逐显示器 DPI 变化）。
            ctypes.windll.shcore.SetProcessDpiAwareness(1)
        except Exception:
            try:
                ctypes.windll.user32.SetProcessDPIAware()
            except Exception:
                pass


_enable_dpi_awareness()

# 应用方案③主题（须在创建任何 CTk 控件前调用）
apply_theme()


class EditorApp(GlobalPageMixin, BagPageMixin, AddItemDialogMixin,
               RefPageMixin, EnhancePageMixin):
    """存档编辑器主类。管理窗口生命周期和所有页面。"""

    def __init__(self) -> None:
        # ── 状态 ──
        self.save = None
        self.current_path = None
        self.active_bag = None        # 当前背包标签名
        self.active_page = None       # 当前页 ('global' | bag_label | 'ref')
        self.items = []               # 当前背包的编辑副本
        self.global_entries = {}      # {field_name: (entry_widget, type_str)}
        self.refdata = self._load_refdata()
        self._last_selected_row = None

        # ── 窗口（强制使用 ctk.CTk，兼容性最优） ──
        self.app = ctk.CTk()
        self.app.title("天工 · 造梦西游3 再续天庭篇 存档编辑器")
        self._center_window(1600, 900)
        self.app.configure(fg_color=C_BG)
        # 用户拖拽缩放时持续钳制到工作区（避免超出可用范围）
        self._clamp_lock = False
        self.app.bind("<Configure>", self._on_configure_clamp)

        # 图标（开发模式 / PyInstaller 打包均兼容）
        self._set_window_icon()

        # 拖拽支持（非破坏性尝试绑定）
        self._setup_drag_drop()

        # 构建界面
        self._build_layout()
        # 首次进入显示引导空状态（无存档时无需说明）
        self._show_empty()
        # 进入主循环
        self.app.mainloop()

    # ────────────────────────────────────
    # 资源 & 初始化辅助
    # ────────────────────────────────────
    @staticmethod
    def _resource_path(rel: str) -> str:
        """返回资源文件绝对路径（兼容 PyInstaller _MEIPASS）。

        资源统一放在 src/assets/（打包后位于 _MEIPASS/assets/）。
        """
        base = getattr(sys, "_MEIPASS",
                       os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
        return os.path.join(base, "assets", rel)

    def _load_refdata(self) -> dict:
        try:
            path = self._resource_path("refdata.json")
            return load_refdata(path)
        except Exception as exc:
            messagebox.showerror("参考库缺失", f"无法加载 refdata.json:\n{exc}")
            return {"equip_attrs": {}, "code_catalog": {},
                    "recipes": [], "drops": [], "gems": [],
                    "stats": {}}

    def _set_window_icon(self) -> None:
        icon_path = self._resource_path("icon.ico")
        if os.path.isfile(icon_path):
            try:
                self.app.iconbitmap(icon_path)
            except Exception:
                pass  # 某些环境不支持

    @staticmethod
    def _clamp_geometry(w: int, h: int, sw: int, sh: int, margin: int = 40):
        """（纯函数，便于单元测试）把 (w,h) 钳制到 sw×sh 内并居中，
        返回 (w, h, x, y)。窗口不超过屏幕减去边距，且不小于最小可用尺寸。"""
        w = min(w, max(320, sw - margin))
        h = min(h, max(240, sh - margin))
        x = max(0, (sw - w) // 2)
        y = max(0, (sh - h) // 2)
        return w, h, x, y

    def _get_work_area(self):
        """获取主屏可用工作区域（排除任务栏 / 系统托盘等系统占用）。

        返回 (avail_w, avail_h, avail_x, avail_y)：可用宽高与左上角偏移。
        Windows 通过 SystemParametersInfo(SPI_GETWORKAREA) 取得真实可用区；
        其他平台或不支持时退回整屏。配合进程 DPI 感知后，返回值为物理像素，
        与 winfo_screen* 处于同一坐标系，便于一致计算。
        """
        try:
            sw = self.app.winfo_screenwidth()
            sh = self.app.winfo_screenheight()
        except Exception:
            sw, sh = 1920, 1080
        avail_w, avail_h, avail_x, avail_y = sw, sh, 0, 0
        if sys.platform.startswith("win"):
            try:
                SPI_GETWORKAREA = 0x0030
                rect = wintypes.RECT()
                ok = ctypes.windll.user32.SystemParametersInfoW(
                    SPI_GETWORKAREA, 0, ctypes.byref(rect), 0)
                if ok:
                    avail_x = rect.left
                    avail_y = rect.top
                    avail_w = rect.right - rect.left
                    avail_h = rect.bottom - rect.top
            except Exception:
                avail_w, avail_h, avail_x, avail_y = sw, sh, 0, 0
        return avail_w, avail_h, avail_x, avail_y

    def _center_window(self, preferred_w: int, preferred_h: int) -> None:
        """将主窗口居中并钳制到屏幕可用工作区（排除任务栏等系统占用）。

        修复点：
        1) 默认尺寸随分辨率自适应——取「偏好尺寸」与「可用区 90%」的较小者，
           而非写死 1600×900，避免小屏直接溢出；
        2) 最大尺寸限制基于「工作区」(SPI_GETWORKAREA) 而非整屏，
           排除任务栏等系统占用区域；
        3) 进程入口已启用 DPI 感知，使坐标与高分屏物理像素一致，
           避免 DPI 虚拟化导致窗口被二次放大而超限。
        """
        avail_w, avail_h, avail_x, avail_y = self._get_work_area()
        margin = 40
        # 最大可用尺寸（留出边距），同时保证最小可用窗口
        max_w = max(360, avail_w - margin)
        max_h = max(240, avail_h - margin)
        # 自适应默认尺寸：不超过可用区 90%，也不超过偏好尺寸
        w = max(360, min(preferred_w, int(avail_w * 0.9)))
        h = max(240, min(preferred_h, int(avail_h * 0.9)))
        # 兜底：防止极端比例屏幕下越界
        w = min(w, max_w)
        h = min(h, max_h)
        # 居中于工作区（考虑任务栏偏移）
        x = avail_x + max(0, (avail_w - w) // 2)
        y = avail_y + max(0, (avail_h - h) // 2)
        self.app.geometry(f"{w}x{h}+{x}+{y}")
        # 立即提交几何，确保「打开时」尺寸即已钳制到工作区
        # （不依赖 <Configure> 事件的触发时机）
        try:
            self.app.update_idletasks()
        except Exception:
            pass
        # 注：不在 CTk 根窗口使用 wm_maxsize / wm_minsize——CustomTkinter
        # 会在设置后忽略 geometry() 而回退到内容自然尺寸。最大尺寸限制改由
        # _on_configure_clamp（<Configure> 回调）在用户缩放时持续钳制到工作区。

    def _on_configure_clamp(self, event=None) -> None:
        """<Configure> 回调：当用户手动拖拽缩放窗口时，持续把窗口钳制到
        屏幕可用工作区（排除任务栏等系统占用）内，确保任何分辨率 / DPI 下
        窗口都不会超出可见范围。仅在越界时介入，不干扰正常缩放。"""
        if getattr(self, "_clamp_lock", False):
            return
        try:
            avail_w, avail_h, avail_x, avail_y = self._get_work_area()
        except Exception:
            return
        try:
            geo = self.app.geometry()
        except Exception:
            return
        m = re.match(r"(\d+)x(\d+)\+(\d+)\+(\d+)", geo)
        if not m:
            return
        w, h, x, y = map(int, m.groups())
        margin = 40
        max_w = max(360, avail_w - margin)
        max_h = max(240, avail_h - margin)
        changed = False
        if w > max_w:
            w = max_w
            changed = True
        if h > max_h:
            h = max_h
            changed = True
        if x + w > avail_x + avail_w:
            x = max(avail_x, avail_x + avail_w - w)
            changed = True
        if y + h > avail_y + avail_h:
            y = max(avail_y, avail_y + avail_h - h)
            changed = True
        if x < avail_x:
            x = avail_x
            changed = True
        if y < avail_y:
            y = avail_y
            changed = True
        if changed:
            self._clamp_lock = True
            try:
                self.app.geometry(f"{w}x{h}+{x}+{y}")
            finally:
                self._clamp_lock = False

    def _place_toplevel(self, tl, preferred_w: int, preferred_h: int) -> None:
        """将子窗口（Toplevel，如「浏览目录 / 添加物品 / 强化」弹窗）钳制到
        工作区内并居中，避免在小屏或高 DPI 屏幕上超出可用范围。"""
        try:
            tl.update_idletasks()
        except Exception:
            pass
        avail_w, avail_h, avail_x, avail_y = self._get_work_area()
        margin = 20
        max_w = max(280, avail_w - margin)
        max_h = max(200, avail_h - margin)
        w = max(280, min(preferred_w, max_w))
        h = max(200, min(preferred_h, max_h))
        x = avail_x + max(0, (avail_w - w) // 2)
        y = avail_y + max(0, (avail_h - h) // 2)
        try:
            tl.geometry(f"{w}x{h}+{x}+{y}")
        except Exception:
            pass

    def _setup_drag_drop(self) -> None:
        """注册文件拖拽（DnD）。在现有 CTk 根窗口上加载 tkdnd 扩展并启用。"""
        if not _DND_AVAILABLE:
            self._dnd_ok = False
            return
        try:
            # 加载 tkdnd Tcl 扩展到当前根窗口的解释器
            TkinterDnD._require(self.app)
            self.app.drop_target_register(DND_FILES)
            self.app.dnd_bind("<<Drop>>", self._on_file_dropped)
            self._dnd_ok = True
        except Exception:
            self._dnd_ok = False

    @staticmethod
    def _parse_dropped_paths(raw: str) -> list:
        """从 tkdnd 的 <<Drop>> 事件数据中解析出文件路径列表。

        tkdnd 对含空格的路径会用花括号包裹，多文件以空格分隔。
        """
        if not raw:
            return []
        s = raw.strip()
        if s.startswith("{") and s.endswith("}") and "}" not in s[1:-1]:
            s = s[1:-1]
        # 提取所有 .sav（含被花括号包裹、含空格的路径）
        cand = re.findall(r"\{?([^{}]*\.sav)\}?", s, re.IGNORECASE)
        if cand:
            return [c.strip().strip("{}").strip().strip('"').strip("'")
                    for c in cand if c.strip()]
        # 退回：按空白切分
        return [p.strip().strip("{}").strip() for p in s.split() if p.strip()]

    # ═══════════════════════════════════
    # 布局构建
    # ═══════════════════════════════════
    def _build_layout(self) -> None:
        """构建三段式布局：顶栏 | 左导航+内容区 | 底部状态栏。"""
        self._build_topbar()
        self._build_body()
        self._build_statusbar()

        # 延迟创建的容器引用
        self.global_frame = None
        self.bag_frame = None
        self.sheet = None
        self.ref_frame = None
        self.ref_textbox = None

    # -- 顶栏 --
    def _build_topbar(self) -> None:
        top = ctk.CTkFrame(self.app, fg_color=C_PANEL, height=46,
                           corner_radius=CORNER)
        top.pack(side=tk.TOP, fill=tk.X)

        self.title_lbl = ctk.CTkLabel(
            top, text="造梦西游3·再续天庭篇 存档编辑器",
            text_color=C_ACCENT, font=ctk.CTkFont(family=FONT_FAMILY, size=14, weight="bold"))
        self.title_lbl.pack(side=tk.LEFT, padx=12)

        btn_area = ctk.CTkFrame(top, fg_color=C_PANEL, corner_radius=CORNER)
        btn_area.pack(side=tk.RIGHT, padx=8)

        btn_specs = [
            ("打开存档", self.cmd_open_file, C_ACCENT, HOVER_ACCENT, "#ffffff"),
            ("浏览目录", self.cmd_browse_dir, C_BTN_SUB, HOVER_BTN_SUB, C_FG),
            ("保存存档", self.cmd_save, C_ACCENT2, HOVER_ACCENT2, "#ffffff"),
            ("另存为", self.cmd_save_as, C_ACCENT2, HOVER_ACCENT2, "#ffffff"),
            ("校验", self.cmd_validate, C_WARN, HOVER_WARN, "#ffffff"),
        ]
        for label, cmd, fg, hfg, tc in btn_specs:
            ctk.CTkButton(btn_area, text=label, width=90, corner_radius=CORNER,
                          command=cmd, fg_color=fg, hover_color=hfg, text_color=tc,
                          font=ctk.CTkFont(family=FONT_FAMILY, size=12, weight="bold")
                          ).pack(side=tk.LEFT, padx=4, pady=8)

    # -- 主体：左导航 | 内容区 --
    def _build_body(self) -> None:
        body = ctk.CTkFrame(self.app, fg_color=C_BG, corner_radius=CORNER)
        body.pack(side=tk.TOP, fill=tk.BOTH, expand=True)

        # 左导航栏
        self.nav = ctk.CTkFrame(body, fg_color=C_FRAME, width=155,
                               corner_radius=CORNER)
        self.nav.pack(side=tk.LEFT, fill=tk.Y, padx=(6, 0), pady=6)
        self.nav.pack_propagate(False)

        self.nav_buttons = {}

        nav_items = [
            ("全局属性", self._switch_to_global),
            ("背包装备", lambda: self._switch_to_bag("背包装备")),
            ("已装备", lambda: self._switch_to_bag("已装备")),
            ("道具材料", lambda: self._switch_to_bag("道具材料")),
            ("时装", lambda: self._switch_to_bag("时装")),
            (None, None),                                    # 分隔线
            ("参考/校验", self._switch_to_ref),
        ]
        for label, cmd in nav_items:
            if label is None:
                ctk.CTkFrame(self.nav, fg_color=C_NAV_BORDER, height=2,
                             corner_radius=2).pack(fill=tk.X, padx=8, pady=6)
                continue
            btn = ctk.CTkButton(
                self.nav, text=label, width=140, anchor="w",
                command=cmd, fg_color="transparent", text_color=C_FG,
                border_width=1, border_color=C_NAV_BORDER, hover_color=HOVER_BTN_SUB,
                font=ctk.CTkFont(family=FONT_FAMILY, size=12, weight="bold"),
                corner_radius=CORNER)
            btn.pack(pady=3, padx=8, fill=tk.X)
            self.nav_buttons[label] = btn

        # 内容容器：center（多页面共享）+ 右侧 detail 抽屉
        self.content = ctk.CTkFrame(body, fg_color=C_BG, corner_radius=CORNER)
        self.content.pack(side=tk.LEFT, fill=tk.BOTH, expand=True,
                          padx=6, pady=6)

        self.center = ctk.CTkFrame(self.content, fg_color=C_BG, corner_radius=CORNER)
        self.center.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        # 右侧详情抽屉（默认隐藏）
        self.detail = ctk.CTkFrame(self.content, fg_color=C_PANEL,
                                   corner_radius=CORNER, width=380)
        self.detail.pack_propagate(False)
        hdr = ctk.CTkFrame(self.detail, fg_color=C_PANEL, corner_radius=CORNER)
        hdr.pack(fill=tk.X, padx=10, pady=10)
        self.detail_swatch = ctk.CTkFrame(hdr, width=34, height=34,
                                         corner_radius=CORNER, fg_color=C_FRAME)
        self.detail_swatch.pack(side=tk.LEFT)
        self.detail_title = ctk.CTkLabel(hdr, text="物品详情", text_color=C_FG,
                                         font=ctk.CTkFont(family=FONT_FAMILY, size=15, weight="bold"))
        self.detail_title.pack(side=tk.LEFT, padx=10, fill=tk.X, expand=True, anchor="w")
        self.detail_close = ctk.CTkButton(
            hdr, text="✕", width=34, height=34, corner_radius=CORNER,
            fg_color=C_BTN_SUB, hover_color=HOVER_BTN_SUB, text_color=C_FG,
            command=self._close_detail)
        self.detail_close.pack(side=tk.RIGHT)
        self.detail_body = ctk.CTkScrollableFrame(
            self.detail, fg_color=C_PANEL, corner_radius=CORNER, label_text="")
        self.detail_body.pack(fill=tk.BOTH, expand=True, padx=4, pady=4)
        self.detail.pack_forget()

        # 引导空状态
        self._build_empty()

    # -- 底部状态栏 --
    def _build_statusbar(self) -> None:
        self.status_lbl = ctk.CTkLabel(
            self.app, text="就绪", text_color=C_SUB,
            font=ctk.CTkFont(family=FONT_FAMILY, size=11), anchor="w")
        self.status_lbl.pack(side=tk.BOTTOM, fill=tk.X,
                             padx=10, pady=(0, 4))

    # -- 引导空状态 --
    def _build_empty(self) -> None:
        ef = ctk.CTkFrame(self.center, fg_color=C_PANEL, corner_radius=CORNER,
                          border_width=2, border_color=C_NAV_BORDER)
        ctk.CTkLabel(ef, text="开始修改你的存档", text_color=C_ACCENT,
                     font=ctk.CTkFont(family=FONT_FAMILY, size=24, weight="bold")
                     ).pack(pady=(40, 6))
        ctk.CTkLabel(ef, text="拖入一个 .sav 文件，或点击下方按钮开始。第一次用也无需说明。",
                     text_color=C_SUB, font=ctk.CTkFont(family=FONT_FAMILY, size=13)
                     ).pack(pady=(0, 18))
        row = ctk.CTkFrame(ef, fg_color="transparent")
        row.pack(pady=6)
        ctk.CTkButton(row, text="📂 打开存档", width=140, height=40,
                      corner_radius=CORNER, fg_color=C_ACCENT, hover_color=HOVER_ACCENT,
                      text_color="#ffffff",
                      font=ctk.CTkFont(family=FONT_FAMILY, size=14, weight="bold"),
                      command=self.cmd_open_file).pack(side=tk.LEFT, padx=6)
        ctk.CTkButton(row, text="📁 浏览目录", width=140, height=40,
                      corner_radius=CORNER, fg_color=C_BTN_SUB, hover_color=HOVER_BTN_SUB,
                      text_color=C_FG,
                      font=ctk.CTkFont(family=FONT_FAMILY, size=14, weight="bold"),
                      command=self.cmd_browse_dir).pack(side=tk.LEFT, padx=6)
        steps = ctk.CTkFrame(ef, fg_color="transparent")
        steps.pack(pady=(24, 0))
        for i, t in enumerate(["打开 .sav", "改属性 / 物品", "校验", "保存"]):
            ctk.CTkLabel(steps, text=f"{i + 1} {t}", text_color=C_SUB,
                        font=ctk.CTkFont(family=FONT_FAMILY, size=12, weight="bold")
                        ).pack(side=tk.LEFT, padx=10)
            if i < 3:
                ctk.CTkLabel(steps, text="→", text_color=C_ACCENT,
                            font=ctk.CTkFont(family=FONT_FAMILY, size=12)
                            ).pack(side=tk.LEFT)
        self.empty_frame = ef

    def _show_empty(self) -> None:
        self._hide_all_pages()
        self.empty_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)
        self.active_page = None
        for btn in self.nav_buttons.values():
            btn.configure(fg_color="transparent", text_color=C_FG)

    def _show_detail_panel(self) -> None:
        self.detail.pack(side=tk.RIGHT, fill=tk.Y, expand=False, padx=6, pady=6)
        self.detail.lift()

    def _close_detail(self) -> None:
        if getattr(self, "detail", None) is not None:
            self.detail.pack_forget()

    # ═══════════════════════════════════
    # 页面切换引擎
    # ═══════════════════════════════════
    def _hide_all_pages(self) -> None:
        for frame in (self.global_frame, self.bag_frame, self.ref_frame,
                      getattr(self, "empty_frame", None)):
            if frame is not None:
                frame.pack_forget()
        self._close_detail()

    def _highlight_nav(self, target: str) -> None:
        for key, btn in self.nav_buttons.items():
            if key == target:
                btn.configure(fg_color=C_ACCENT, text_color="#ffffff")
            else:
                btn.configure(fg_color="transparent", text_color=C_FG)

    def _set_status(self, msg: str, color: str = C_SUB) -> None:
        self.status_lbl.configure(text=msg, text_color=color)

    # ═══════════════════════════════════
    # 文件操作
    # ═══════════════════════════════════
    # -- 统一打开入口（文件选择 / 拖拽 / 目录列表） --
    def _open_save(self, path: str) -> None:
        """核心打开逻辑，被多种入口复用（文件选择 / 拖拽 / 目录列表）。"""
        if not os.path.isfile(path):
            self._set_status(f"文件不存在: {path}", C_ERR)
            return
        try:
            self.save = load_save(path)
        except Exception as exc:
            # 尝试自动修复流程
            self._try_repair_and_open(path, str(exc))
            return
        self.current_path = path
        name = os.path.basename(path)
        self.title_lbl.configure(text=name)
        open_status = f"已打开: {name}  (zlib×{self.save.zlib_passes})"
        self._set_status(open_status, C_ACCENT2)
        # 重置编辑副本与选中态，确保界面数据同步刷新（避免残留旧存档数据）
        self.items = []
        self._last_selected_row = None
        # 根据当前页面刷新数据
        if self.active_page == "global":
            self._populate_global_form()
            self.active_bag = "global"  # 重置，避免旧背包标签触发误写
        elif self.active_page in BAG_FIELDS:
            self._load_active_bag()
            self._rebuild_sheet()
        elif self.active_page == "ref":
            self._populate_ref_panel()
        else:
            self._switch_to_bag("背包装备")
            # 自动切入背包会改写状态栏，重新给出"已打开"提示
            self._set_status(open_status, C_ACCENT2)

    def _try_repair_and_open(self, path: str, original_error: str):
        """当常规加载失败时，尝试修复 XML 并打开。"""
        from core.xml_repair import format_repair_report

        self._set_status("正在检测并尝试修复格式问题...", C_WARN)

        try:
            save, result = load_save_with_repair(
                path,
                backup_dir=os.path.join(os.path.dirname(path), ".repair_backups"),
            )
        except Exception as decode_err:
            messagebox.showerror(
                "打开失败",
                f"无法识别该存档文件（解码阶段即失败）:\n{decode_err}"
            )
            return

        if save is not None and result.success:
            report = format_repair_report(result)
            print(report)  # 控制台输出完整报告

            # 询问用户是否接受修复结果
            fix_msg = (
                f"检测到 XML 格式异常并已自动修复：\n\n"
                f"{result.fix_summary}\n\n"
                f"是否使用修复后的存档继续？"
            )
            if result.backup_path:
                fix_msg += f"\n(原始文件已备份至: {result.backup_path})"

            if messagebox.askyesno("格式修复", fix_msg):
                self.save = save
                self.current_path = path
                name = os.path.basename(path)
                self.title_lbl.configure(text=f"[已修复] {name}")
                open_status = (f"已打开(已修复): {name}  "
                               f"(zlib×{self.save.zlib_passes})")
                self._set_status(open_status, C_WARN)
                self.items = []
                self._last_selected_row = None
                if self.active_page == "global":
                    self._populate_global_form()
                    self.active_bag = "global"  # 重置，避免旧背包标签触发误写
                elif self.active_page in BAG_FIELDS:
                    self._load_active_bag()
                    self._rebuild_sheet()
                else:
                    self._switch_to_bag("背包装备")
                    self._set_status(open_status, C_WARN)
            else:
                self._set_status("用户取消修复", C_SUB)
        else:
            # 修复也失败了
            report = format_repair_report(result)
            print(report)
            detail = "\n".join(result.errors)
            suggest = "\n".join(f"• {s}" for s in result.suggestions)
            msg = (
                f"无法识别该存档文件:\n{original_error}\n\n"
                f"自动修复也无法解决问题:\n{detail}\n\n"
                f"建议:\n{suggest}"
            )
            messagebox.showerror("打开失败", msg)
            self._set_status("存档损坏且无法自动修复", C_ERR)

    def _on_file_dropped(self, event) -> None:
        raw = getattr(event, "data", "") or ""
        paths = self._parse_dropped_paths(raw)
        if not paths:
            self._set_status("未识别到拖入的文件", C_WARN)
            return
        savs = [p for p in paths if p.lower().endswith(".sav")]
        if not savs:
            self._set_status("拖入的不是 .sav 存档文件", C_WARN)
            return
        # 识别并加载第一个存档（_open_save 内部尝试解码，失败会提示）
        try:
            self._open_save(savs[0])
        except Exception as exc:
            self._set_status(f"存档识别失败: {exc}", C_ERR)

    def cmd_open_file(self) -> None:
        path = filedialog.askopenfilename(
            title="选择 .sav 存档",
            filetypes=[("存档文件", "*.sav"), ("全部", "*.*")])
        if path:
            self._open_save(path)

    def cmd_browse_dir(self) -> None:
        d = filedialog.askdirectory(title="选择包含 .sav 的文件夹")
        if not d:
            return
        savs = sorted(glob.glob(os.path.join(d, "*.sav")))
        if not savs:
            messagebox.showinfo("无存档", f"该目录下没有 .sav 文件\n{d}")
            return

        dlg = ctk.CTkToplevel(self.app)
        dlg.title(f"存档列表 — {d}")
        self._place_toplevel(dlg, 540, 440)
        dlg.grab_set()

        ctk.CTkLabel(dlg, text=f"找到 {len(savs)} 个存档:",
                     text_color=C_FG, font=ctk.CTkFont(family=FONT_FAMILY, size=12)
                     ).pack(padx=12, pady=(12, 4), anchor="w")

        lb = tk.Listbox(dlg, bg=C_LIST_BG, fg=C_LIST_FG,
                        font=("Microsoft YaHei UI", 10),
                        selectbackground=C_LIST_SEL,
                        selectforeground=C_LIST_SEL_FG, activestyle="none")
        lb.pack(fill=tk.BOTH, expand=True, padx=12, pady=4)
        for sp in savs:
            lb.insert(tk.END, f"{os.path.basename(sp)}    "
                         f"({os.path.getsize(sp):,} B)")

        pick = lambda: self._pick_sav(savs, lb, dlg)
        lb.bind("<Double-Button-1>", lambda e: pick())

        bar = ctk.CTkFrame(dlg, fg_color="transparent", corner_radius=CORNER)
        bar.pack(side=tk.BOTTOM, fill=tk.X, padx=12, pady=10)
        ctk.CTkButton(bar, text="打开", width=100, corner_radius=CORNER,
                      command=pick, fg_color=C_ACCENT2, hover_color=HOVER_ACCENT2,
                      text_color="#ffffff", font=ctk.CTkFont(family=FONT_FAMILY, size=13, weight="bold")
                      ).pack(side=tk.LEFT, padx=6)
        ctk.CTkButton(bar, text="取消", width=80, corner_radius=CORNER,
                      command=dlg.destroy, fg_color=C_BTN_SUB, hover_color=HOVER_BTN_SUB,
                      text_color=C_FG, font=ctk.CTkFont(family=FONT_FAMILY, size=13)
                      ).pack(side=tk.LEFT, padx=6)

    def _pick_sav(self, paths: list, lb, win) -> None:
        idx = lb.curselection()
        if not idx:
            self._set_status("请先在列表中选择一个存档", C_WARN)
            return
        win.destroy()
        self._open_save(paths[idx[0]])

    # -- 保存 / 另存为（共享逻辑） --
    def _save_to_path(self, path: str, update_current: bool,
                      prompt_warnings: bool) -> None:
        """将当前存档写入 path（含校验与往返自检）。"""
        self._apply_global(silent=True)
        self._flush_current_bag()
        errs, warns = self.validate()
        if errs:
            messagebox.showerror("校验未通过", "\n".join(errs))
            return
        if prompt_warnings and warns and not messagebox.askyesno(
                "校验警告", "存在警告，仍要保存?\n\n" + "\n".join(warns)):
            return
        try:
            save_save(self.save, path)
            if update_current:
                self.current_path = path
                self.title_lbl.configure(text=os.path.basename(path))
            ok = self._roundtrip_check(path)
            verb = "已保存" if update_current else "已另存"
            self._set_status(f"{verb}: {os.path.basename(path)}",
                            C_ACCENT2 if ok else C_WARN)
            msg = f"存档已写入:\n{path}"
            if ok:
                msg += "\n\n往返编解码自检通过"
            messagebox.showinfo("保存成功", msg)
        except Exception as exc:
            messagebox.showerror("保存失败", str(exc))

    def cmd_save(self) -> None:
        if self.save is None:
            messagebox.showwarning("未打开", "请先打开一个存档")
            return
        self._save_to_path(self.current_path, update_current=True,
                           prompt_warnings=True)

    def cmd_save_as(self) -> None:
        if self.save is None:
            messagebox.showwarning("未打开", "请先打开一个存档")
            return
        path = filedialog.asksaveasfilename(
            title="另存为", defaultextension=".sav",
            filetypes=[("存档文件", "*.sav")])
        if not path:
            return
        self._save_to_path(path, update_current=True, prompt_warnings=False)

    def _roundtrip_check(self, path: str) -> bool:
        try:
            s2 = load_save(path)
            for lbl, xmlf in BAG_FIELDS.items():
                if len(self.save.get_bag(xmlf)) != len(s2.get_bag(xmlf)):
                    return False
            return True
        except Exception:
            return False

    # ═══════════════════════════════════
    # ⑤ 校验引擎
    # ═══════════════════════════════════
    def validate(self) -> tuple:
        """执行完整校验，返回 (errors, warnings)。"""
        errors = []
        warns = []

        if self.save is None:
            errors.append("未打开存档")
            return errors, warns

        self._flush_current_bag()

        # 全局标量
        for _key, label, typ in GLOBAL_FIELDS:
            if typ != "int":
                continue
            v = self.save.get_scalar(_key)
            if v in (None, ""):
                continue
            try:
                n = int(float(v))
            except ValueError:
                errors.append(f"全局 '{label}' 非法整数: {v}")
                continue
            if _key == "curLevel" and not (1 <= n <= 300):
                warns.append(f"等级 {n} 超出常见范围(1~300)")
            if _key == "lhValue" and n < 0:
                warns.append(f"灵魂值为负: {n}")

        # 各背包物品
        for bag_label, xmlf in BAG_FIELDS.items():
            for idx, it in enumerate(self.save.get_bag(xmlf)):
                item_name = it[1].strip() if len(it) > 1 else "?"
                loc = f"{bag_label}#{idx + 1} [{item_name}]"

                if len(it) < 7:
                    errors.append(f"{loc} 字段数不足({len(it)})，可能损坏")
                    continue

                code = it[2].strip()
                if not code:
                    errors.append(f"{loc} 缺少代码")
                elif code not in self.refdata.get("code_catalog", {}):
                    warns.append(f"{loc} 代码不在参考库: '{code}'")

                # 数值字段校验
                for fid in (7, 8, 9, 10, 11, 13, 14, 22, 23, 24, 25, 26, 27):
                    if fid < len(it) and it[fid].strip():
                        try:
                            float(it[fid])
                        except ValueError:
                            fname = ATTR_DISPLAY_NAMES.get(fid, f"字段{fid}")
                            errors.append(f"{loc} {fname}非法: {it[fid]}")

                # 数量
                if len(it) > 22:
                    try:
                        qty = int(float(it[22]))
                        if qty < 1:
                            errors.append(f"{loc} 数量需≥1: {it[22]}")
                        elif qty > 999999:
                            warns.append(f"{loc} 数量偏大: {qty}")
                    except ValueError:
                        errors.append(f"{loc} 数量非法: {it[22]}")

                # 颜色格式
                if len(it) > 6:
                    col = it[6].strip()
                    if not (col.startswith("0x") and len(col) == 8
                            and all(c in "0123456789abcdefABCDEF"
                                   for c in col[2:])):
                        warns.append(f"{loc} 颜色异常: {col}")

        return errors, warns

    def cmd_validate(self) -> None:
        if self.save is None:
            messagebox.showwarning("未打开", "请先打开一个存档")
            return
        errs, warns = self.validate()
        msg = ""
        if errs:
            msg += f"❌ 错误({len(errs)}):\n" + "\n".join(errs) + "\n\n"
        if warns:
            msg += f"⚠ 警告({len(warns)}):\n" + "\n".join(warns) + "\n\n"
        if not errs and not warns:
            msg = "✓ 校验通过，未发现明显问题。"
        ec = C_ERR if errs else (C_WARN if warns else C_ACCENT2)
        self._set_status(f"校验: {len(errs)}错/{len(warns)}警", ec)
        messagebox.showinfo("校验结果", msg)


def main():
    """程序入口。"""
    EditorApp()


if __name__ == "__main__":
    main()
