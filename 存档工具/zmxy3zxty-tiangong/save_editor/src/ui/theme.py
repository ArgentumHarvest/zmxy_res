"""界面主题（清新简约 / Mint · 方案③落地版）。

配色：薄荷浅底 + 青绿强调 + 天蓝次强调，传递清爽、干净、低认知负担的情绪。
大圆角 + 柔和阴影，留白充足，新用户零学习成本。

本模块只定义「静态主题资源」，不创建任何控件；由各页模块引用。
更新主题只需改这里，布局代码无需变动（仅替换旧硬编码暖色为下方令牌）。
"""
import customtkinter as ctk

# ── 基础配色 ──
C_BG = "#eef6f4"        # 主背景：薄荷浅底
C_PANEL = "#ffffff"     # 面板/卡片：纯白
C_FRAME = "#f3f9f7"     # 导航/容器：极浅薄荷
C_ACCENT = "#1fa98e"    # 主强调：青绿（打开/保存/主操作）
C_ACCENT2 = "#43b3e0"   # 次强调：天蓝（另存为/成功）
C_WARN = "#e0a31a"      # 警示/校验按钮：琥珀
C_ERR = "#e5564e"       # 危险/删除：珊瑚红
C_FG = "#233b35"        # 主文字：深墨绿
C_SUB = "#6f8c84"       # 次要文字：灰绿

# ── 派生令牌：次级按钮（原暖橙 #ffd9c2/#ffe3d2）──
C_BTN_SUB = "#e3f0ec"       # 次级按钮底：浅薄荷
HOVER_BTN_SUB = "#d2e7e1"   # 次级按钮悬停

# ── 派生令牌：导航分隔线/边框（原暖橙 #ffe0cc）──
C_NAV_BORDER = "#dcebe6"

# ── 选中行高亮（表格选中行背景）──
C_SELECTED_ROW = "#d4f5ee"  # 明亮薄荷绿
C_SELECTED_ROW_BORDER = C_ACCENT  # 选中行左侧边框色

# ── 派生令牌：原生 Listbox（浏览目录 / 添加对话框）──
C_LIST_BG = "#ffffff"        # 列表底
C_LIST_FG = "#233b35"        # 列表文字
C_LIST_SEL = C_ACCENT        # 选中底：青绿
C_LIST_SEL_FG = "#ffffff"    # 选中文字

# ── 悬停态 ──
HOVER_ACCENT = "#188f78"
HOVER_ACCENT2 = "#2f9fd0"
HOVER_ERR = "#cf4540"
HOVER_WARN = "#c98f12"

# ── 字体（Windows 稳定可用；如需更圆润可改 "Microsoft YaHei"）──
FONT_FAMILY = "Microsoft YaHei UI"

# ── 圆角：清新简约强调「大圆润」，统一较大圆角 ──
CORNER = 18


def apply_theme():
    """应用清新简约主题到 CustomTkinter 全局设置（须在创建控件前调用）。"""
    ctk.set_appearance_mode("light")
    # "green" 系最接近薄荷青绿，作用于滑块/滚动条等默认控件色
    ctk.set_default_color_theme("green")
