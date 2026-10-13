# PyInstaller 钩子：把 tkinterdnd2 及其 tkdnd Tcl 运行时（含 win-x64 的 dll/tcl）一并打包，
# 保证单文件 exe 内拖拽功能可用。
# tkinterdnd2 为可选依赖：若未安装，拖拽功能在运行时被 app.py 优雅降级，
# 此处仅尽力收集数据文件，缺包时不抛错以免中断整个打包流程。
from PyInstaller.utils.hooks import collect_data_files

try:
    datas = collect_data_files("tkinterdnd2")
except Exception:
    datas = []
