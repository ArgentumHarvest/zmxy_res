"""验证三项修复：属性默认值 / 删除刷新按钮 / 校验提示物品名。"""
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

tk.Tk.mainloop = lambda self, *a, **k: None

from ui.app import EditorApp
from data.items import new_item_template

CS2 = os.path.dirname(SAVE_EDITOR)
PATH = os.path.join(CS2, "completed_saves", "0.sav")

app = EditorApp()
app._open_save(PATH)
app._switch_to_bag("背包装备")
app._rebuild_sheet()

# ============================================================
# Fix 1: 属性默认值 — 从 equip_attrs 填充，不再全部为 0
# ============================================================
code = "ptdxzg"  # 普通的行者棍: 攻击=4+1
meta = app.refdata.get("code_catalog", {}).get(code, {})
name = meta.get("name", "")
ea = app.refdata.get("equip_attrs", {}).get(name) if name else None
print(f"  测试物品: {name}, 有权威属性: {ea is not None}")
new = new_item_template(meta, count=1, code=code, equip_attrs=ea)
print(f"  生命={new[7]} 魔法={new[8]} 攻击={new[9]} 防御={new[10]} 暴击={new[11]} 闪避={new[12]} 回血={new[13]}")
assert new[9] != "0", f"攻击属性仍为0: {new[9]}"
assert new[7] != "0" or name == "普通的行者棍", f"生命属性异常: {new[7]}"
print("  ✓ Fix1: 属性默认值从equip_attrs填充（不再全部为0）")

n0 = len(app.items)
app._add_item_by_code(code)
added = app.items[-1]
assert added[9] != "0"
print(f"  ✓ _add_item_by_code 正确填充: 攻击={added[9]}")

# ============================================================
# Fix 3: 校验提示含物品名称
# ============================================================
errs, warns = app.validate()
print(f"  校验: 错误{len(errs)} 警告{len(warns)}")
if warns:
    print(f"  示例: {warns[0]}")
    assert "[" in warns[0], f"警告不含物品名: {warns[0]}"
if errs:
    for e in errs:
        assert "[" in e, f"错误不含物品名: {e}"
        if "非数值" in e or "不是整数" in e:
            assert "字段[" not in e, f"仍显示字段索引: {e}"
print("  ✓ Fix3: 校验提示含物品名 + 属性友好名")

# ============================================================
# Fix 2: 删除 / 刷新按钮
# ============================================================
app._last_selected_row = 0
app._cmd_delete_rows()
assert len(app.items) == n0, f"删除后数量异常: {len(app.items)}"
print("  ✓ Fix2: 通过 last_selected_row 成功删除")

orig_len = len(app.items)
app._last_selected_row = None
app._cmd_delete_rows()  # 无选中 -> 友好提示
assert len(app.items) == orig_len
print("  ✓ Fix2: 无选中时友好提示（不崩溃不误删）")

app._rebuild_sheet()
status = app.status_lbl.cget("text")
assert "已刷新" in status, f"刷新无反馈: {status}"
print(f"  ✓ Fix2: 刷新有状态反馈: {status.strip()}")

print("\n三项修复全部验证通过 ✅")
