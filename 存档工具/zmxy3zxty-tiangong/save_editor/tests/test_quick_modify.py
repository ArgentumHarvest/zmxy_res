"""回归测试：全局「快速修改」不应清空背包装备。

覆盖场景：
  1) 在全局快速修改页重新打开存档（self.items 被置空、active_bag 仍可能残留旧背包）
     并保存时，背包装备数据必须保持完整（不被空 items 覆盖）。
  2) 常规背包内联编辑后能正确持久化（无回归）。
"""
import os
import sys
import tkinter as tk

# 抑制 GUI 主循环与弹窗
tk.Tk.mainloop = lambda self, *a, **k: None
import tkinter.messagebox as _mb
_mb.showerror = lambda *a, **k: None
_mb.showwarning = lambda *a, **k: None
_mb.showinfo = lambda *a, **k: None
_mb.askyesno = lambda *a, **k: True

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)
SRC = os.path.join(ROOT, "src")
if SRC not in sys.path:
    sys.path.insert(0, SRC)

from ui.app import EditorApp
from core.models import load_save, save_save
from core.constants import BAG_FIELDS

CS2 = os.path.dirname(ROOT)
PATH = os.path.join(CS2, "completed_saves", "0.sav")


def _fresh_app():
    return EditorApp()


def test_quick_modify_no_bag_clear():
    app = _fresh_app()
    app._open_save(PATH)
    before = app.save.get_bag("bagSaveString")
    assert len(before) > 0, "测试存档背包装备为空，无法验证"

    # 进入背包页加载数据
    app._switch_to_bag("背包装备")
    assert len(app.items) == len(before)

    # 切到全局快速修改页（active_bag 必须被重置为 "global"）
    app._switch_to_global()
    assert app.active_bag == "global", f"全局页 active_bag 未重置: {app.active_bag!r}"

    # 在全局页“重新打开同一存档”：self.items 被置空
    app._open_save(PATH)
    assert app.active_bag == "global", "重新打开后 active_bag 仍残留旧背包"
    assert len(app.items) == 0, "重新打开后 self.items 应被置空"

    # 模拟快速修改 + 保存
    try:
        app.global_entries["lhValue"][0].insert(0, "999999")
    except Exception:
        pass
    app._apply_global(silent=True)
    app._flush_current_bag()
    tmp = PATH + ".qm_test.sav"
    save_save(app.save, tmp)

    reloaded = load_save(tmp)
    after = reloaded.get_bag("bagSaveString")
    try:
        os.remove(tmp)
    except Exception:
        pass

    assert len(after) == len(before), (
        f"快速修改后背包装备被清空/改变: {len(before)} -> {len(after)}")
    print(f"  ✓ 快速修改不清空背包: {len(before)} -> {len(after)}")


def test_bag_inline_edit_persists():
    app = _fresh_app()
    app._open_save(PATH)
    app._switch_to_bag("背包装备")
    n0 = len(app.items)
    # 内联改第一行名称
    app.items[0][1] = "回归测试改名"
    app._flush_current_bag()
    tmp = PATH + ".qm_test2.sav"
    save_save(app.save, tmp)
    reloaded = load_save(tmp)
    got = reloaded.get_bag("bagSaveString")
    try:
        os.remove(tmp)
    except Exception:
        pass
    assert len(got) == n0, f"背包件数变化: {n0} -> {len(got)}"
    assert got[0][1] == "回归测试改名", "内联编辑未持久化"
    print(f"  ✓ 背包内联编辑持久化: 件数 {n0} 保持不变且改名生效")


if __name__ == "__main__":
    test_quick_modify_no_bag_clear()
    test_bag_inline_edit_persists()
    print("\n✅ 快速修改回归测试全部通过")
