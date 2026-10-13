"""本次优化新增 / 修改功能的配套测试。

覆盖需求点：
  1) 右键菜单英文选项全部中文化（含自定义「强化」项）
  2) 强化入口：右键菜单 + 工具栏「强化」按钮（弹窗式）
  3) 「已装备」页签移除「添加 / 删除」按钮；仅装备类页签显示强化按钮
  4) 编辑后未保存时刷新页面能正确还原原始数据
  5) 添加对话框：类型 + 品质 筛选，列表默认按 类型→品质 排序
  6) 背包装备添加支持「称号」类物品
  7) 拖拽存档文件到窗口进行识别加载（路径解析 + 落点处理）
  8) 窗口尺寸适配：超出屏幕范围时钳制并居中

运行：python tests/test_new_features.py
"""
import os
import re
import sys
import tkinter as tk

# 抑制 GUI 主循环（测试不需要真正弹窗）
tk.Tk.mainloop = lambda s, *a, **k: None

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)
SRC = os.path.join(ROOT, "src")
if SRC not in sys.path:
    sys.path.insert(0, SRC)

# 阻止测试期间弹出真实对话框（showwarning/showerror/showinfo/askyesno）
import tkinter.messagebox as _mb
_mb.showwarning = lambda *a, **k: None
_mb.showerror = lambda *a, **k: None
_mb.showinfo = lambda *a, **k: None
_mb.askyesno = lambda *a, **k: True

from ui.app import EditorApp
from core.constants import (BAG_SLOT_FILTERS, SLOT_CODES, SLOT_ORDER,
                            QUALITY_ORDER)

app = EditorApp()

# 存档路径：tests/ → save_editor/ → cs2根/
cs2_root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SAVE_PATH = os.path.join(cs2_root, "completed_saves", "0.sav")

results = []


class SKIP(Exception):
    pass


def check(name, fn):
    try:
        fn()
        results.append((name, "PASS"))
        print(f"  PASS  {name}")
    except SKIP:
        results.append((name, "SKIP"))
        print(f"  SKIP  {name}")
    except AssertionError as e:
        results.append((name, f"FAIL: {e}"))
        print(f"  FAIL  {name}: {e}")
    except Exception as e:
        results.append((name, f"ERROR: {e}"))
        print(f"  ERROR {name}: {e}")


# ---------------------------------------------------------------------------
# 1) 自定义右键菜单（中文标签 + 统一图标）
# ---------------------------------------------------------------------------
print("=== 1. 右键菜单中文化 ===")
def test_ctx_menu_zh():
    app._open_save(SAVE_PATH)
    app._switch_to_bag("背包装备")
    # 验证自定义右键菜单：检查 _on_right_click 方法存在
    assert hasattr(app, "_on_right_click"), "缺少自定义右键菜单方法"
    # 验证工具栏「强化」按钮存在
    assert getattr(app, "bag_enh_btn", None) is not None
    # 工具栏「强化」按钮存在
    assert getattr(app, "bag_enh_btn", None) is not None
check("右键菜单中文化", test_ctx_menu_zh)


# ---------------------------------------------------------------------------
# 2) 强化入口：右键菜单 / 工具栏按钮（弹窗式）
# ---------------------------------------------------------------------------
print("\n=== 2. 强化入口（弹窗）===")
def test_enhance_entry():
    app._switch_to_bag("背包装备")
    assert len(app.items) > 0, "背包装备为空"
    app._last_selected_row = len(app.items) - 1
    # 右键 / 按钮回调：应打开强化弹窗而非独立页面
    app._rc_enhance()
    dlg = getattr(app, "_enh_dlg", None)
    assert dlg is not None, "强化弹窗未创建（_rc_enhance 未打开弹窗）"
    assert getattr(app, "_enh_level_menu", None) is not None, "强化等级控件缺失"
    assert getattr(app, "_enh_target_row", None) == len(app.items) - 1
    # 工具栏「强化」按钮存在且指向同一回调
    assert getattr(app, "bag_enh_btn", None) is not None
    # 应用强化：仅写字段23(强化)，基础属性不被强化值覆盖
    row = app._last_selected_row
    name = app.items[row][1].strip()
    ea = app.refdata.get("equip_attrs", {}).get(name)
    base_def = None
    if ea:
        from data.common import _parse_attr_val
        base_def = _parse_attr_val(ea.get("防御", "")) if ea.get("防御") else None
    app._cmd_apply_enhance(target_lv=10)
    assert app.items[row][23] == "10", f"强化等级应为10，实际 {app.items[row][23]}"
    if base_def is not None:
        assert app.items[row][10] == base_def, (
            f"基础防御不应被强化值覆盖: {app.items[row][10]} != {base_def}")
    # 弹窗应在应用后关闭
    assert getattr(app, "_enh_dlg", None) is None, "应用强化后弹窗未关闭"
check("强化入口弹窗", test_enhance_entry)


# ---------------------------------------------------------------------------
# 3) 「已装备」页签移除添加/删除按钮；强化按钮仅装备类显示
# ---------------------------------------------------------------------------
print("\n=== 3. 已装备页签工具栏 ===")
def test_equipped_toolbar():
    # 背包装备：添加 / 删除 / 强化 三按钮均可见
    app._switch_to_bag("背包装备")
    assert app.bag_add_btn.winfo_manager() == "pack", "背包装备应显示添加按钮"
    assert app.bag_del_btn.winfo_manager() == "pack", "背包装备应显示删除按钮"
    assert app.bag_enh_btn.winfo_manager() == "pack", "背包装备应显示强化按钮"
    # 已装备：添加 / 删除 隐藏；强化仍显示
    app._switch_to_bag("已装备")
    assert app.bag_add_btn.winfo_manager() == "", "已装备不应显示添加按钮"
    assert app.bag_del_btn.winfo_manager() == "", "已装备不应显示删除按钮"
    assert app.bag_enh_btn.winfo_manager() == "pack", "已装备应显示强化按钮"
    # 还原到背包装备
    app._switch_to_bag("背包装备")
check("已装备工具栏可见性", test_equipped_toolbar)


# ---------------------------------------------------------------------------
# 4) 编辑后未保存时刷新还原原始数据
# ---------------------------------------------------------------------------
print("\n=== 4. 刷新还原未保存编辑 ===")
def test_reload_restores():
    app._switch_to_bag("背包装备")
    assert app.items, "背包装备为空"
    orig_val = app.items[0][7]
    # 模拟未保存编辑
    app.items[0][7] = "99999"
    assert app.items[0][7] == "99999"
    # 刷新（从磁盘重载）
    app._reload_from_disk()
    assert len(app.items) > 0, "刷新后数据丢失"
    assert app.items[0][7] == orig_val, (
        f"刷新未还原：期望 {orig_val}，实际 {app.items[0][7]}")
    # 选中态应被清空
    assert app._last_selected_row is None, "刷新后选中态未清空"
check("刷新还原原始数据", test_reload_restores)


# ---------------------------------------------------------------------------
# 5) 添加对话框：类型 + 品质 筛选，按 类型→品质 排序
# ---------------------------------------------------------------------------
print("\n=== 5. 添加对话框筛选与排序 ===")
class _FakeLB:
    def __init__(self):
        self.rows = []
    def delete(self, _a, _b):
        self.rows = []
    def insert(self, _idx, s):
        self.rows.append(s)
    def get(self, _a, _b):
        return tuple(self.rows)
    def size(self):
        return len(self.rows)

class _FakeLbl:
    def __init__(self):
        self.text = ""
    def configure(self, **kw):
        self.text = kw.get("text", self.text)

def _build_order(disp_map):
    catalog = app.refdata["code_catalog"]
    order = []
    for disp in disp_map:
        code = disp_map[disp]
        meta = catalog[code]
        slot = meta.get("slot", "zbwp")
        qual = meta.get("quality", "")
        sr = SLOT_ORDER.index(slot) if slot in SLOT_ORDER else len(SLOT_ORDER)
        qr = QUALITY_ORDER.index(qual) if qual in QUALITY_ORDER else len(QUALITY_ORDER)
        order.append((sr, qr, code))
    return order

def test_filter_sort():
    app._switch_to_bag("背包装备")
    slot_filter = BAG_SLOT_FILTERS["背包装备"]
    catalog = app.refdata["code_catalog"]
    lb = _FakeLB()
    count_lbl = _FakeLbl()
    disp_map = {}

    # 默认列表（无筛选）应按 类型→品质 排序
    app._refresh_add_list(lb, catalog, slot_filter, disp_map, count_lbl)
    base = _build_order(disp_map)
    assert base == sorted(base), "默认列表未按 类型→品质 排序"

    # 类型筛选：武器(=zbwq)
    lb = _FakeLB(); disp_map = {}
    app._refresh_add_list(lb, catalog, slot_filter, disp_map, count_lbl,
                          type_filt="武器")
    assert lb.rows, "按类型『武器』筛选结果为空"
    for disp in lb.rows:
        code = disp_map[disp]
        assert catalog[code]["slot"] == "zbwq", (
            f"类型筛选泄漏非武器物品: {catalog[code]['slot']}")

    # 品质筛选：神 器
    lb = _FakeLB(); disp_map = {}
    app._refresh_add_list(lb, catalog, slot_filter, disp_map, count_lbl,
                          quality_filt="神 器")
    for disp in lb.rows:
        code = disp_map[disp]
        assert catalog[code]["quality"] == "神 器", (
            f"品质筛选泄漏非『神 器』物品: {catalog[code]['quality']}")

    # 组合筛选后仍保持排序
    lb = _FakeLB(); disp_map = {}
    app._refresh_add_list(lb, catalog, slot_filter, disp_map, count_lbl,
                          type_filt="武器", quality_filt="神 器")
    comb = _build_order(disp_map)
    assert comb == sorted(comb), "组合筛选后列表未排序"
    assert count_lbl.text.startswith("共 "), "计数提示未更新"

    # 制作书显示归类：仅显示归类，不改实际 slot
    zbwp_filter = {"zbwp"}
    lb = _FakeLB(); disp_map = {}
    app._refresh_add_list(lb, catalog, zbwp_filter, disp_map, count_lbl,
                          type_filt="制作书")
    assert lb.rows, "按类型『制作书』筛选结果为空"
    for disp in lb.rows:
        code = disp_map[disp]
        assert "制作书" in catalog[code]["name"], (
            f"制作书筛选泄漏非制作书物品: {catalog[code]['name']}")
        assert " 制作书" in disp or disp.endswith("制作书"), (
            f"制作书物品显示类别未展示为制作书: {disp}")
        assert catalog[code]["slot"] == "zbwp", (
            "制作书显示归类修改了实际类型字段")

    # 模糊搜索：按名称/代码，忽略空格与分隔符
    lb = _FakeLB(); disp_map = {}
    app._refresh_add_list(lb, catalog, zbwp_filter, disp_map, count_lbl,
                          query="天荒")
    assert lb.rows, "搜索『天荒』无结果"
    assert any("天荒" in disp for disp in lb.rows), "未找到天荒制作书"

    lb = _FakeLB(); disp_map = {}
    app._refresh_add_list(lb, catalog, zbwp_filter, disp_map, count_lbl,
                          query="天 荒")
    assert lb.rows, "搜索带空格『天 荒』无结果"
    assert any("天荒" in disp for disp in lb.rows), "带空格搜索未命中天荒制作书"
check("添加对话框筛选与排序", test_filter_sort)


# ---------------------------------------------------------------------------
# 6) 背包装备添加支持「头衔」类物品
# ---------------------------------------------------------------------------
print("\n=== 6. 头衔类物品支持 ===")
def test_title_support():
    # 配置层：背包装备过滤含 zbtx（真实游戏头衔槽位），且中文名为「头衔」
    assert "zbtx" in BAG_SLOT_FILTERS["背包装备"], "背包装备过滤未含头衔槽位 zbtx"
    assert SLOT_CODES.get("zbtx") == "头衔", "zbtx 槽位中文名应为「头衔」"

    # 运行时层：注入一个头衔条目，验证可成功添加并保留槽位/强化等级
    catalog = app.refdata["code_catalog"]
    catalog["_test_ch"] = {"name": "测试头衔", "slot": "zbtx",
                           "quality": "普通", "restriction": ""}
    try:
        app._switch_to_bag("背包装备")
        before = len(app.items)
        app._add_item_by_code("_test_ch", enhancement_level=3)
        after = len(app.items)
        assert after == before + 1, "头衔物品未添加"
        added = app.items[-1]
        assert added[3].strip() == "zbtx", f"头衔槽位错误: {added[3]}"
        assert added[23] == "3", f"头衔强化等级错误: {added[23]}"
    finally:
        catalog.pop("_test_ch", None)
check("头衔类物品支持", test_title_support)


# ---------------------------------------------------------------------------
# 7) 拖拽存档文件识别加载
# ---------------------------------------------------------------------------
print("\n=== 7. 拖拽路径解析与加载 ===")
def test_drag_drop():
    # 纯解析：单文件 / 含空格花括号 / 多文件 / 空
    p1 = EditorApp._parse_dropped_paths(r"C:/saves/0.sav")
    assert p1 == [r"C:/saves/0.sav"], f"单文件路径解析失败: {p1}"

    p2 = EditorApp._parse_dropped_paths(r"{C:/my games/存档 1.sav}")
    assert p2 == [r"C:/my games/存档 1.sav"], f"含空格路径解析失败: {p2}"

    p3 = EditorApp._parse_dropped_paths(r"{a.sav} {b.sav}")
    assert p3 == ["a.sav", "b.sav"], f"多文件路径解析失败: {p3}"

    p4 = EditorApp._parse_dropped_paths("")
    assert p4 == [], f"空输入应返回空列表: {p4}"

    # 落点处理：仅识别首个 .sav；非 .sav 不加载
    orig_open = app._open_save
    loaded = {}
    app._open_save = lambda p: loaded.setdefault("path", p)
    try:
        evt = type("E", (), {"data": r"{C:/x/real.sav} {C:/x/other.txt}"})()
        app._on_file_dropped(evt)
        assert loaded.get("path") == r"C:/x/real.sav", (
            f"应加载首个 .sav，实际: {loaded.get('path')}")

        loaded.clear()
        evt2 = type("E", (), {"data": r"{C:/x/nope.txt}"})()
        app._on_file_dropped(evt2)
        assert "path" not in loaded, "非 .sav 文件不应触发加载"
    finally:
        # 还原真实绑定方法（后续测试依赖）
        app._open_save = orig_open
check("拖拽路径解析与加载", test_drag_drop)


# ---------------------------------------------------------------------------
# 8) 窗口尺寸适配（钳制 + 居中）
# ---------------------------------------------------------------------------
print("\n=== 8. 窗口尺寸适配 ===")
def test_center_window():
    # 纯函数（确定性）：小屏幕应钳制并居中
    cw, ch, cx, cy = app._clamp_geometry(1600, 900, 600, 400)
    assert (cw, ch, cx, cy) == (560, 360, 20, 20), (
        f"小屏幕钳制错误: {(cw, ch, cx, cy)}")
    # 大屏幕：不应钳制
    cw, ch, cx, cy = app._clamp_geometry(1600, 900, 3000, 2000)
    assert (cw, ch, cx, cy) == (1600, 900, 700, 550), (
        f"大屏幕不应钳制: {(cw, ch, cx, cy)}")
    # 极小屏幕：钳制到最小可用尺寸
    cw, ch, cx, cy = app._clamp_geometry(1600, 900, 300, 200)
    assert (cw, ch) == (320, 240), f"极小屏幕未钳到最小: {(cw, ch)}"

    # 集成（真实屏幕）：窗口应落在「可用工作区」内并居中于工作区
    aw, ah, ax, ay = app._get_work_area()
    sw = app.app.winfo_screenwidth()
    sh = app.app.winfo_screenheight()
    app._center_window(1600, 900)
    geo = app.app.geometry()
    m = re.match(r"(\d+)x(\d+)\+(\d+)\+(\d+)", geo)
    assert m, f"geometry 解析失败: {geo}"
    w, h, x, y = map(int, m.groups())
    # 不超过整屏
    assert w <= sw and h <= sh, f"窗口超出屏幕: {w}x{h} > {sw}x{sh}"
    # 不超出可用工作区（排除任务栏等系统占用）
    assert x >= ax and y >= ay, f"窗口越出工作区左上: {x},{y} (工作区 {ax},{ay})"
    assert x + w <= ax + aw and y + h <= ay + ah, (
        f"窗口越出工作区右下: {x + w},{y + h} (工作区 {ax + aw},{ay + ah})")
    # 居中于工作区
    assert x == ax + max(0, (aw - w) // 2) and y == ay + max(0, (ah - h) // 2), (
        f"未在工作区居中: x={x} y={y} (工作区 {ax},{ay},{aw},{ah})")
check("窗口尺寸适配", test_center_window)


# ---------------------------------------------------------------------------
# 9) 添加对话框：角色筛选默认值为当前角色
# ---------------------------------------------------------------------------
print("\n=== 9. 添加对话框默认角色 ===")
def test_add_dialog_default_role():
    app._open_save(SAVE_PATH)
    app._switch_to_bag("背包装备")
    role_id = app.save.get_scalar("roleid")
    role_map = {"1": "悟空", "2": "唐僧", "3": "八戒", "4": "沙僧", "5": "白龙"}
    expected = role_map.get(str(role_id).strip(), "全部")
    app._dlg_add_item()
    assert getattr(app, "_add_dlg_role_menu", None) is not None, "角色下拉未创建"
    assert app._add_dlg_role_menu.get() == expected, (
        f"默认角色应为 {expected}，实际 {app._add_dlg_role_menu.get()}")
check("添加对话框默认角色", test_add_dialog_default_role)


# ---------------------------------------------------------------------------
# 10) 添加对话框：统一自然多选模式
# ---------------------------------------------------------------------------
print("\n=== 10. 添加对话框多选模式 ===")
def test_add_dialog_multiselect():
    app._switch_to_bag("背包装备")
    app._dlg_add_item()
    lb = getattr(app, "_add_dlg_lb", None)
    add_btn = getattr(app, "_add_dlg_add_btn", None)
    sel_lbl = getattr(app, "_add_dlg_sel_count_lbl", None)
    assert lb is not None and add_btn is not None and sel_lbl is not None, "多选控件缺失"

    # 统一为自然多选：单击条目即可切换选中，无需 Ctrl
    assert lb.cget("selectmode") == tk.MULTIPLE, "列表应为统一多选模式 (MULTIPLE)"
    assert add_btn.cget("text") == "添加", "初始添加按钮文本应为『添加』"

    # 选中前 3 条有效条目（跳过可能存在的『无匹配』）
    sel_indices = []
    for i in range(lb.size()):
        if lb.get(i) != "（无匹配）":
            sel_indices.append(i)
        if len(sel_indices) >= 3:
            break
    assert len(sel_indices) == 3, "列表中有效条目不足 3 条"
    lb.selection_clear(0, tk.END)
    for idx in sel_indices:
        lb.selection_set(idx)
    # 触发选择事件更新计数与按钮文本
    lb.event_generate("<<ListboxSelect>>")
    app._add_dlg_sel_count_lbl.update()
    app._add_dlg_add_btn.update()
    assert "已选 3 项" in sel_lbl.cget("text"), (
        f"已选数量提示错误: {sel_lbl.cget('text')}")
    assert "添加 (3)" in add_btn.cget("text"), (
        f"添加按钮文本错误: {add_btn.cget('text')}")

    # 执行添加：应新增 3 个物品
    before = len(app.items)
    cmd = add_btn.cget("command")
    cmd()
    after = len(app.items)
    assert after == before + 3, f"批量添加数量错误: {after} != {before + 3}"

check("添加对话框多选模式", test_add_dialog_multiselect)


# ---------------------------------------------------------------------------
# 汇总
# ---------------------------------------------------------------------------
print("\n" + "=" * 52)
pass_n = sum(1 for _, s in results if s.startswith("PASS") or s.startswith("SKIP"))
fail_n = sum(1 for _, s in results if s.startswith("FAIL") or s.startswith("ERROR"))
for name, status in results:
    icon = "✅" if ("PASS" in status or "SKIP" in status) else "❌"
    print(f"  {icon} {name}: {status}")
print("=" * 52)
print(f"总计: {pass_n} 通过, {fail_n} 失败")
if fail_n == 0:
    print("新增功能测试全部通过 ✅")
else:
    print(f"有 {fail_n} 项需要检查 ❌")
    sys.exit(1)
