"""全面验证: 加载 + 强化系统 + 合成默认值 + 分类过滤 + 参考页 + 校验。

需要 customtkinter / tksheet（GUI 主循环已被短路，不会真正弹窗）。
"""
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

# 抑制 GUI 主循环（测试不需要显示窗口）
tk.Tk.mainloop = lambda self, *a, **k: None

from core import (ATTR_DISPLAY_NAMES, BAG_SLOT_FILTERS, SLOT_CODES,
                  ITEM_FIELDS, VISIBLE_FIELDS, ROLE_LIST, ENHANCE_MAX_LEVEL)
from data.enhancement import parse_enhancement_bonus, apply_enhancement
from data.items import new_item_template
from data.synthesis import (_SYNTHETIC_RECIPES, calc_synthetic_defaults,
                            is_synthetic_equip, get_synthetic_recipes)
from ui.app import EditorApp

CS2 = os.path.dirname(SAVE_EDITOR)
PATH = os.path.join(CS2, "completed_saves", "0.sav")

app = EditorApp()

# ================================================================
# 1) 存档加载: 打开后背包数据正确显示
# ================================================================
print("=== 1. 存档加载 ===")
app._open_save(PATH)
assert app.save is not None, "save 未加载"
assert app.current_path == PATH
s = app.save.summary()
print(f'  bag_equip={s["bag_equip"]} bag_item={s["bag_item"]} '
      f'cur_equip={s["cur_equip"]}')
assert s["bag_item"] > 0, "道具材料为0"

app._switch_to_bag("道具材料")
assert len(app.items) > 0, f"道具材料items为0！summary说有{s['bag_item']}件"
print(f"  ✓ 道具材料正确加载: {len(app.items)} 件")

app._switch_to_bag("背包装备")
print(f"  ✓ 背包装备: {len(app.items)} 件")
status = app.status_lbl.cget("text")
assert "已刷新" in status or "已打开" in status

# ================================================================
# 2) 强化系统
# ================================================================
print("\n=== 2. 强化系统 ===")
bonus = parse_enhancement_bonus("防御+4")
assert bonus == {"防御": 4}, f"解析失败: {bonus}"
print(f'  parse_enhancement_bonus("防御+4") = {bonus} ✓')

bonus2 = parse_enhancement_bonus("生命+5 防御+2")
assert bonus2 == {"生命": 5, "防御": 2}, f"复合解析失败: {bonus2}"
assert parse_enhancement_bonus("无") == {}
assert parse_enhancement_bonus("") == {}
print("  ✓ 强化加成解析全部通过")

base = {"生命": "35", "魔法": "12", "攻击": "4", "防御": "5", "暴击": "0"}
enhanced = apply_enhancement(base, {"防御": 4, "攻击": 3}, level=7)
print(f'  基础{base} + 防御+4/级 攻击+3/级 ×7级:')
for fi in sorted(enhanced):
    print(f'    {ATTR_DISPLAY_NAMES[fi]}: {enhanced[fi]}')
assert enhanced[10] == "33", f"防御应为33(5+4×7): {enhanced[10]}"
assert enhanced[9] == "25", f"攻击应为25(4+3×7): {enhanced[9]}"
print("  ✓ apply_enhancement 计算 ✓")

meta = {'name': '普通的行者服', 'slot': 'zbfj', 'quality': '普通',
        'color': '0xFFFFFF', 'rank': '1'}
ea = {'生命': '35+5', '魔法': '12+13', '攻击': '0', '防御': '5',
      '暴击': '0', '闪避': '0', '回血': '0', '强化后增加属性': '防御+4'}
item_lv0 = new_item_template(meta, code='ptdxzf', equip_attrs=ea, enhancement_level=0)
item_lv7 = new_item_template(meta, code='ptdxzf', equip_attrs=ea, enhancement_level=7)
item_lv10 = new_item_template(meta, code='ptdxzf', equip_attrs=ea, enhancement_level=10)
print(f'  行者服 Lv0防={item_lv0[10]} Lv7防={item_lv7[10]} Lv10防={item_lv10[10]}')
assert item_lv0[7] == "40", f"Lv0生命应=40(35+5最大值): {item_lv0[7]}"
assert item_lv0[10] == "5", f"Lv0防御应=5(基础值): {item_lv0[10]}"
# 强化等级只写入「强化」字段(23)，基础属性(7~13)保持不变（由游戏按等级计算）
assert item_lv7[10] == "5", f"Lv7防御基础值应仍为5(不直接修改基础属性): {item_lv7[10]}"
assert item_lv10[10] == "5", f"Lv10防御基础值应仍为5(不直接修改基础属性): {item_lv10[10]}"
assert item_lv7[23] == "7", f"强化字段应为7: {item_lv7[23]}"
assert item_lv10[23] == "10", f"强化字段应为10: {item_lv10[23]}"
print("  ✓ 模板强化等级（基础属性不变，仅写强化字段）✓")

# ================================================================
# 3) 合成装备默认值
# ================================================================
print("\n=== 3. 合成装备默认值 ===")
all_ea = app.refdata.get("equip_attrs", {})
for name in ["地藏戒", "地藏金戒", "花宴"]:
    sd = calc_synthetic_defaults(name, all_ea)
    if sd:
        attrs_str = ", ".join(
            f"{ATTR_DISPLAY_NAMES[k]}={v}" for k, v in sorted(sd.items()))
        print(f"  {name}: {attrs_str}")
    else:
        print(f"  {name}: 无法计算（组件数据不足）")
print("  ✓ calc_synthetic_defaults 不报错 ✓")

assert is_synthetic_equip("地藏戒") is True
assert is_synthetic_equip("普通的行者服") is False
print("  ✓ is_synthetic_equip 判断 ✓")

n0 = len(app.items)
app._add_item_by_code("_dzj", enhancement_level=0)  # 地藏戒
added = app.items[-1]
print(f"  地藏戒添加后: 生命={added[7]} 攻击={added[9]} 防御={added[10]}")
assert len(app.items) == n0 + 1
print("  ✓ 合成装备添加成功 ✓")

# ================================================================
# 4) 背包分类过滤配置
# ================================================================
print("\n=== 4. 背包分类过滤配置 ===")
for bag_label, slots in BAG_SLOT_FILTERS.items():
    slot_names = [SLOT_CODES.get(s, s) for s in sorted(slots)]
    print(f"  {bag_label}: {slot_names}")
assert "zbwp" in BAG_SLOT_FILTERS["道具材料"]
assert "zbwq" in BAG_SLOT_FILTERS["背包装备"]
assert "zbsz" in BAG_SLOT_FILTERS["时装"]
print("  ✓ 分类过滤配置正确 ✓")
assert isinstance(ROLE_LIST, list) and "悟空" in ROLE_LIST
print(f"  ✓ 角色列表: {ROLE_LIST}")

# ================================================================
# 5) 功能区: 物品详情 + 参考校验
# ================================================================
print("\n=== 5. 参考/校验页 ===")
app._switch_to_ref()  # 首次访问会构建参考面板
assert app.ref_textbox is not None, "ref_textbox 未创建"
app._show_item_detail(app.items[0])
detail_content = app.ref_textbox.get("0.0", tk.END).strip()
assert len(detail_content) > 0, "详情内容为空"
assert "【" in detail_content, "详情缺少标题格式"
print(f"  物品详情内容长度: {len(detail_content)} 字符 ✓")

app._populate_ref_panel()
ref_content = app.ref_textbox.get("0.0", tk.END).strip()
assert "存档概览" in ref_content or "未打开" in ref_content
assert "参考库统计" in ref_content
print(f"  参考校验内容长度: {len(ref_content)} 字符 ✓")

# ================================================================
# 6) 校验引擎
# ================================================================
print("\n=== 6. 校验 ===")
errs, warns = app.validate()
if warns:
    print(f"  示例: {warns[0]}")
    assert "[" in warns[0], "校验不含物品名"
print(f"  错误{len(errs)} 警告{len(warns)} ✓")

# ================================================================
# 7) 删除功能
# ================================================================
print("\n=== 7. 删除 ===")
app._switch_to_bag("背包装备")
if app.items:
    app._last_selected_row = 0
    orig = len(app.items)
    app._cmd_delete_rows()
    assert len(app.items) == orig - 1
    print("  ✓ 删除成功 ✓")
else:
    print("  — 跳过（背包为空）")

# ================================================================
# 8) 常量与API完整性
# ================================================================
print("\n=== 8. 常量与API完整性 ===")
assert ENHANCE_MAX_LEVEL == 10
recipes = get_synthetic_recipes()
assert isinstance(recipes, dict) and len(recipes) > 0
print(f"  ✓ 合成配方数: {len(recipes)}")
print("  ✓ 全部常量和辅助API完整 ✓")

print("\n" + "═" * 31)
print("  全部验证通过 ✅")
print("═" * 31)
