"""全面功能验证：逐一测试所有功能模块。

覆盖：打开存档、全局属性、背包切换/编辑/删除/添加、强化页面、
参考校验页、校验引擎、保存文件。
"""
import os
import sys
import tkinter as tk
import tempfile
import shutil

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)
SRC = os.path.join(ROOT, "src")
if SRC not in sys.path:
    sys.path.insert(0, SRC)
tk.Tk.mainloop = lambda s, *a, **k: None

from ui.app import EditorApp
from core.constants import BAG_FIELDS, GLOBAL_FIELDS, HIDDEN_FIELDS

# 显示列顺序（与 tksheet 隐藏 HIDDEN_FIELDS 后的 displayed_columns 一致）。
# 注意：_on_cell_edited 接收的是「显示列」索引，需经 sheet.datacn 转为数据字段索引。
_DISPLAYED = [i for i in range(28) if i not in HIDDEN_FIELDS]
def disp(field):
    """数据字段索引 -> 显示列索引。"""
    return _DISPLAYED.index(field)

app = EditorApp()
# 测试文件位于 save_editor/tests/，存档目录在 cs2 根目录（再上一级）
cs2_root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
path = os.path.join(cs2_root, "completed_saves", "0.sav")

results = []
DotDict = type("DotDict", (dict,), {"__getattr__": lambda s, k: s[k]})


class SkipError(Exception):
    pass


def check(name, fn):
    try:
        fn()
        results.append((name, "PASS"))
        print(f"  PASS")
    except SkipError:
        raise
    except AssertionError as e:
        results.append((name, f"FAIL: {e}"))
        print(f"  FAIL: {e}")
    except Exception as e:
        results.append((name, f"ERROR: {e}"))
        print(f"  ERROR: {e}")


# 1. 打开存档
print("=== 1. 打开存档 ===")
def test_open():
    app._open_save(path)
    assert app.save is not None, "save not loaded"
    assert app.current_path == path, f"{app.current_path} != {path}"
check("打开存档", test_open)

# 2. 全局属性页
print("=== 2. 全局属性页 ===")
def test_global():
    app._switch_to_global()
    assert app.active_page == "global"
    app._populate_global_form()
    for key, (entry, _typ) in app.global_entries.items():
        entry.delete(0, tk.END)
        entry.insert(0, "99")
    app._apply_global(silent=True)
    val = app.save.get_scalar("curLevel")
    assert val == 99 or val == "99"
check("全局属性", test_global)

# 3. 背包表格切换
print("=== 3. 背包表格 ===")
def test_bag_switch():
    for bag in ["背包装备", "已装备", "道具材料", "时装"]:
        app._switch_to_bag(bag)
        assert app.active_bag == bag
check("背包切换", test_bag_switch)

# 4. 属性编辑（修复后）
print("=== 4. 属性编辑 ===")
def test_edit():
    app._switch_to_bag("道具材料")
    if not app.items:
        raise SkipError("empty bag")
    orig = app.items[0][7]
    evt = DotDict(row=0, column=disp(7), value="12345", name="end_edit_table",
                 loc=None, widget=app.sheet, key="Return",
                 boxes=[], selected={}, cells_table={}, data={})
    app._on_cell_edited(evt)
    assert app.items[0][7] == "12345", f"got {app.items[0][7]}"


try:
    check("属性编辑", test_edit)
except SkipError:
    results.append(("属性编辑", "SKIP (empty bag)"))
    print("  SKIP")

# 5. 删除行
print("=== 5. 删除行 ===")
def test_delete():
    app._switch_to_bag("道具材料")
    if not app.items:
        raise SkipError("empty bag")
    orig = len(app.items)
    app._last_selected_row = 0
    app._cmd_delete_rows()
    assert len(app.items) == orig - 1
try:
    check("删除行", test_delete)
except SkipError:
    results.append(("删除行", "SKIP"))
    print("  SKIP")

# 6. 添加物品
print("=== 6. 添加物品 ===")
def test_add():
    app._switch_to_bag("背包装备")
    before = len(app.items)
    app._add_item_by_code("_dzj", enhancement_level=5)
    after = len(app.items)
    assert after == before + 1
check("添加物品", test_add)

# 7. 强化（装备页签弹窗）
print("=== 7. 强化弹窗 ===")
def test_enhance():
    app._switch_to_bag("背包装备")
    if not app.items:
        raise SkipError("empty bag")
    app._last_selected_row = len(app.items) - 1
    # 打开强化弹窗（针对选中物品）
    app._open_enhance_dialog()
    assert app._enh_dlg is not None, "强化弹窗未创建"
    assert app._enh_level_menu is not None, "强化等级控件缺失"
    app._enh_level_menu.set("10")
    row = app._last_selected_row
    name = app.items[row][1].strip()
    ea = app.refdata.get("equip_attrs", {}).get(name)
    # 应用强化（直接传等级，验证核心逻辑）
    app._cmd_apply_enhance(target_lv=10)
    assert app.items[row][23] == "10", f"强化等级应为10: {app.items[row][23]}"
    # 基础属性不应被直接改写为强化后数值（以防御为例）
    if ea:
        from data.common import _parse_attr_val
        base_def = _parse_attr_val(ea.get("防御", ""))
        if base_def is not None:
            assert app.items[row][10] == base_def, \
                f"基础防御不应被强化值覆盖: {app.items[row][10]} != {base_def}"
check("强化弹窗", test_enhance)

# 8. 参考/校验页
print("=== 8. 参考/校验页 ===")
def test_ref():
    app._switch_to_ref()
    assert app.active_page == "ref"
    assert app.ref_textbox is not None
    content = app.ref_textbox.get("0.0", tk.END).strip()
    assert len(content) > 0
    assert "参考库统计" in content
check("参考/校验", test_ref)

# 9. 校验引擎
print("=== 9. 校验引擎 ===")
def test_validate():
    errs, warns = app.validate()
    assert isinstance(errs, list) and isinstance(warns, list)
    print(f"    {len(errs)}错/{len(warns)}警")
check("校验引擎", test_validate)

# 10. 保存文件往返
print("=== 10. 保存文件 ===")
def test_save():
    tmpdir = tempfile.mkdtemp()
    tmpfile = os.path.join(tmpdir, "test_full.sav")
    from core import save_save, load_save
    save_save(app.save, tmpfile)
    reloaded = load_save(tmpfile)
    match = True
    for lbl, xmlf in BAG_FIELDS.items():
        o = len(app.save.get_bag(xmlf))
        r = len(reloaded.get_bag(xmlf))
        if o != r:
            match = False
    shutil.rmtree(tmpdir)
    assert match
check("保存文件", test_save)


# 汇总
print("\n" + "=" * 50)
pass_count = sum(1 for _, s in results if s.startswith("PASS") or s.startswith("SKIP"))
fail_count = sum(1 for _, s in results if s.startswith("FAIL") or s.startswith("ERROR"))
for name, status in results:
    icon = "\u2705" if ("PASS" in status or "SKIP" in status) else "\u274c"
    print(f"  {icon} {name}: {status}")
print("=" * 50)
print(f"\u603b\u8ba1: {pass_count} \u901a\u8fc7, {fail_count} \u5931\u8d25")
if fail_count == 0:
    print("\u5168\u90e8\u529f\u80fd\u6a21\u5757\u9a8c\u8bc1\u901a\u8fc7 \u2705")
else:
    print(f"\u6709 {fail_count} \u4e2a\u529f\u80fd\u9700\u8981\u68c0\u67e5 \u274c")
