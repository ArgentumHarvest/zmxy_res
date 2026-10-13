"""程序化冒烟测试：驱动编辑器真实方法（不依赖手动点击），捕获 tksheet/回调 API 错误。"""
import os
import sys
import tkinter as tk
import customtkinter as ctk

HERE = os.path.dirname(os.path.abspath(__file__))
SAVE_EDITOR = os.path.dirname(HERE)
if SAVE_EDITOR not in sys.path:
    sys.path.insert(0, SAVE_EDITOR)
SRC = os.path.join(SAVE_EDITOR, "src")
if SRC not in sys.path:
    sys.path.insert(0, SRC)

# 让 mainloop 不阻塞
tk.Tk.mainloop = lambda self, *a, **k: None

from ui.app import EditorApp
from core import VISIBLE_FIELDS, ITEM_FIELDS, BAG_FIELDS
from core.constants import HIDDEN_FIELDS

# 显示列顺序（与 tksheet 隐藏 HIDDEN_FIELDS 后的 displayed_columns 一致）。
# _on_cell_edited 接收「显示列」索引，需经 sheet.datacn 转为数据字段索引。
_DISPLAYED = [i for i in range(28) if i not in HIDDEN_FIELDS]
def disp(field):
    return _DISPLAYED.index(field)

CS2 = os.path.dirname(SAVE_EDITOR)
PATH = os.path.join(CS2, "completed_saves", "0.sav")

app = EditorApp()

# 0) 拖拽支持（非强制，缺依赖时自动降级）
print(f"  ✓ 拖拽支持状态: {'已启用' if getattr(app, '_dnd_ok', False) else '已降级(无 tkinterdnd2)'}")
assert hasattr(app, "_dnd_ok")

# 1) 通过统一入口打开（验证状态栏/标题/右侧面板刷新 + 无异常）
app._open_save(PATH)
assert app.current_path == PATH, "current_path 未更新"
status_txt = app.status_lbl.cget("text")
assert "已打开" in status_txt and os.path.basename(PATH) in status_txt, \
    f"状态栏未显示文件名：{status_txt}"
assert os.path.basename(PATH) in app.title_lbl.cget("text"), "标题未显示文件名"
app._switch_to_ref()  # 首次访问会构建参考面板
ref_txt = app.ref_textbox.get("0.0", tk.END)
assert "未打开存档" not in ref_txt, "右侧面板仍为'未打开存档'"
print(f"  ✓ 打开存档后状态栏/标题/右侧面板已刷新: {status_txt.strip()}")

app._switch_to_bag("背包装备")
app._rebuild_sheet()
if not app.items:                      # 该存档背包装备可能为空，改用道具材料
    app._switch_to_bag("道具材料")
    app._rebuild_sheet()
print("  ✓ 构建UI / 加载存档 / 刷新网格(含颜色高亮) 无异常")

# 2) 模拟选中行 -> 右侧参考面板
app._on_row_selected({"row": 0})
print("  ✓ 行选中 -> 参考面板渲染 无异常")

# 表头为真实属性名
print("  ✓ 表头:", [ITEM_FIELDS[i][1] for i in VISIBLE_FIELDS])

# 3) 模拟编辑数量列(显示列索引 = 字段22 在隐藏 HIDDEN_FIELDS 后的显示顺序位置) -> 写回模型
col_qty = disp(22)
xmlf = BAG_FIELDS[app.active_bag]
before = app.items[0][22]
app._on_cell_edited({"row": 0, "column": col_qty, "value": "888"})
app._flush_current_bag()
after = app.save.get_bag(xmlf)[0][22]
print(f"  ✓ 单元格编辑往返: {before} -> {after}")
assert after == "888"

# 4) 校验
errs, warns = app.validate()
print(f"  ✓ validate 运行: 错误 {len(errs)} / 警告 {len(warns)}")

# 5) 按代码添加：立即写入模型并生效
code = "xmjs"
xmlf = BAG_FIELDS[app.active_bag]
n0 = len(app.items)
n0_model = len(app.save.get_bag(xmlf))
app._add_item_by_code(code)
n1 = len(app.items)
n1_model = len(app.save.get_bag(xmlf))
assert n1 == n0 + 1, "添加后当前列表数量未+1"
assert n1_model == n0_model + 1, "添加后模型背包数量未+1（未生效）"
assert app.save.get_bag(xmlf)[-1][2] == code, "模型末件代码不匹配"
print(f"  ✓ 按代码添加生效: 列表 {n0}->{n1}，模型背包 {n0_model}->{n1_model}，代码={code}")

# 6) 添加对话框可正常构建（按钮栏不会被列表挤出窗口）
app._dlg_add_item()
print("  ✓ 添加对话框构建无异常（含搜索/列表/按钮栏）")

# 7) 全局表单 -> 应用
app._switch_to_global()
app.global_entries["curLevel"][0].delete(0, "end")
app.global_entries["curLevel"][0].insert(0, "150")
app._apply_global(silent=True)
print(f"  ✓ 全局等级应用: {app.save.get_scalar('curLevel')}")

print("\n冒烟测试通过 ✅")
