"""忠实复现真实编辑流程（不再直接调用回调）。

模拟用户在单元格上编辑并回车：select_cell -> open_text_editor -> 设值 ->
close_text_editor（与 GUI 按 Enter 走的完全相同的代码路径）。
验证：编辑框能被打开、edit_cell 回调被触发、表格数据被更新。
"""
import os
import sys
import tkinter as tk

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)
SRC = os.path.join(ROOT, "src")
if SRC not in sys.path:
    sys.path.insert(0, SRC)
tk.Tk.mainloop = lambda s, *a, **k: None

from tksheet import Sheet
from tksheet.functions import new_tk_event

root = tk.Tk()
root.withdraw()

sheet = Sheet(root, headers=["品级", "名称", "攻击"])
# 使用修复后的绑定（"edit_cell" 才能开启单元格编辑）
sheet.enable_bindings((
    "edit_cell", "single", "drag_select", "arrowkeys",
    "right_click_popup_menu", "copy", "cut", "paste",
    "delete", "undo", "select_all"))
sheet.pack()

captured = {}
def cb(event):
    captured["row"] = event.row
    captured["col"] = event.column
    captured["value"] = event.value
sheet.extra_bindings([("edit_cell", cb)])

sheet.set_sheet_data([["普通", "行者服", "10"], ["稀有", "苍生挂饰", "20"]])

print("edit_cell_enabled      :", sheet.MT.edit_cell_enabled)
print("table_edit_cell_enabled:", sheet.MT.table_edit_cell_enabled())

assert sheet.MT.edit_cell_enabled is True, "单元格编辑未启用（根因未修复）"
assert sheet.MT.table_edit_cell_enabled() is True, "表格可编辑判定为假"

# —— 忠实模拟一次真实编辑：把第 0 行第 2 列（攻击）改成 99999 ——
sheet.MT.select_cell(0, 2)
sheet.MT.open_text_editor(r=0, c=2)
sheet.MT.text_editor.window.set_text("99999")
# 真实 GUI 中文本编辑器有焦点；headless 下补一个焦点，走与 GUI 相同的 close_text_editor 路径
sheet.MT.focus_get = lambda: sheet.MT.text_editor.window
sheet.MT.close_text_editor(new_tk_event("Return"))

print("回调捕获:", captured)
print("编辑后数据:", sheet.get_sheet_data())

assert captured.get("row") == 0 and captured.get("col") == 2, "edit_cell 回调未触发"
assert captured.get("value") == "99999", f"回调值错误: {captured.get('value')!r}"
assert sheet.get_sheet_data()[0][2] == "99999", "表格数据未被更新"

print("\n✅ 真实编辑流程验证通过：单元格可编辑、回调触发、数据持久更新")
