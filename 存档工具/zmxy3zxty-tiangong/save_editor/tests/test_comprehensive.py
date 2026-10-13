"""全面边界 / 异常 / 核心逻辑测试（Request 9 配套）。

覆盖：编解码边界、SaveFile 模型、物品解析/模板、强化解析、属性解析、
合成默认值、品质归一化、校验引擎异常、单元格编辑异常路径。
GUI 主循环已被短路（tk.Tk.mainloop = lambda ...）。
"""
import os
import sys
import base64
import tkinter as tk

HERE = os.path.dirname(os.path.abspath(__file__))
SAVE_EDITOR = os.path.dirname(HERE)
if SAVE_EDITOR not in sys.path:
    sys.path.insert(0, SAVE_EDITOR)
SRC = os.path.join(SAVE_EDITOR, "src")
if SRC not in sys.path:
    sys.path.insert(0, SRC)

tk.Tk.mainloop = lambda self, *a, **k: None

from core.codec import (decode_sav, decode_sav_string, encode_sav,
                        _xor_bytes, XOR_KEY, _TO_CUSTOM)
from core.models import SaveFile, load_save, load_save_with_repair
from core.xml_repair import detect_and_repair_xml
from core.constants import (BAG_FIELDS, normalize_quality, QUALITY_ORDER,
                            QUALITY_COLORS)
from data.items import parse_items, serialize_items, new_item_template
from data.enhancement import parse_enhancement_bonus, apply_enhancement
from data.common import _parse_attr_val
from data.synthesis import (is_synthetic_equip, calc_synthetic_defaults,
                            get_synthetic_recipes)
from ui.app import EditorApp

CS2 = os.path.dirname(SAVE_EDITOR)
PATH = os.path.join(CS2, "completed_saves", "0.sav")


def xor_old(data: bytes) -> bytes:
    """旧版逐字节生成器（用于一致性对比）。"""
    return bytes(b ^ XOR_KEY for b in data)


results = []


def check(name, fn):
    try:
        fn()
        results.append((name, "PASS"))
        print(f"  PASS  {name}")
    except AssertionError as e:
        results.append((name, f"FAIL: {e}"))
        print(f"  FAIL  {name}: {e}")
    except Exception as e:  # noqa
        results.append((name, f"ERROR: {e!r}"))
        print(f"  ERROR {name}: {e!r}")


def expect_raises(fn, exc_types):
    try:
        fn()
    except exc_types:
        return
    raise AssertionError(f"未抛出预期异常 {exc_types}")


# ============================================================
# 1) 编解码 codec
# ============================================================
print("=== 1. 编解码 codec ===")

def t_xor_consistency():
    sample = bytes(range(256)) * 50
    assert _xor_bytes(sample) == xor_old(sample)
check("XOR translate 与旧生成器输出一致", t_xor_consistency)

def t_roundtrip_xml():
    xml = "<root><a>中文</a><b>123</b></root>"
    for p in (1, 2):
        enc = encode_sav(xml, p)
        out, out_p = decode_sav_string(enc)
        assert out == xml, f"往返不一致: {out!r}"
        assert out_p == p, f"zlib_passes 丢失: {out_p}"
check("XML 编解码往返 + zlib_passes 保持", t_roundtrip_xml)

def t_invalid_b64():
    expect_raises(lambda: decode_sav_string("@@@@ 非法 base64 @@@@"),
                  (ValueError, base64.binascii.Error, Exception))
check("非法 base64 抛异常", t_invalid_b64)

def t_bad_marker():
    xor_bytes = bytes(b ^ XOR_KEY for b in b"\x00\x00\x00")  # data[0]=0x5A≠0x06
    std = base64.b64encode(xor_bytes).decode()
    custom = std.translate(_TO_CUSTOM)
    expect_raises(lambda: decode_sav_string(custom), ValueError)
check("AMF3 标记缺失抛 ValueError", t_bad_marker)

def t_decode_file():
    xml, passes = decode_sav(PATH)
    assert passes >= 1 and xml.lstrip().startswith("<")
check("真实 .sav 文件解码成功", t_decode_file)


# ============================================================
# 2) SaveFile 模型
# ============================================================
print("\n=== 2. SaveFile 模型 ===")

def t_parse_error():
    expect_raises(lambda: SaveFile("<not xml", 1), Exception)
check("非法 XML 构造抛异常", t_parse_error)

def t_missing_player():
    sf = SaveFile("<root></root>", 1)
    assert sf.get_bag("bagSaveString") == []
check("缺失 player 对象时 get_bag 返回空", t_missing_player)

def t_missing_bag():
    sf = SaveFile("<root><player1_obj></player1_obj></root>", 1)
    assert sf.get_bag("bagSaveString") == []
check("缺失背包节点时 get_bag 返回空", t_missing_bag)

def t_set_scalar_create():
    sf = SaveFile("<root></root>", 1)
    sf.set_scalar("curLevel", 50)
    assert sf.get_scalar("curLevel") == "50"
    assert sf.root.find(".//s[@name='curLevel']") is not None
check("set_scalar 创建新字段", t_set_scalar_create)

def t_set_scalar_update():
    sf = SaveFile("<root></root>", 1)
    sf.set_scalar("curLevel", "50")
    sf.set_scalar("curLevel", "99")
    assert sf.get_scalar("curLevel") == "99"
check("set_scalar 更新已存在字段", t_set_scalar_update)

def t_set_bag_create():
    sf = SaveFile("<root><s name='player1_obj'></s></root>", 1)
    row = ["普 通", "测试", "tc", "zbwp", "", "普 通", "0xFFFFFF"] + ["0"] * 21
    sf.set_bag("bagSaveString", [row])
    got = sf.get_bag("bagSaveString")
    assert len(got) == 1 and got[0][2] == "tc"
check("set_bag 创建新背包节点", t_set_bag_create)

def t_summary():
    app = EditorApp()
    app._open_save(PATH)
    s = app.save.summary()
    for k in ("bag_equip", "bag_item", "cur_equip"):
        assert isinstance(s[k], int) and s[k] >= 0
    assert s["username"] is not None
check("summary() 返回完整非负统计", t_summary)

def t_repair_valid():
    save, result = load_save_with_repair(PATH)
    assert result.success and save is not None
check("load_save_with_repair(完好文件) 成功", t_repair_valid)

def t_repair_engine():
    xml_bad = "<root><s name='x'>\x01控制字符</s></root>"
    res = detect_and_repair_xml(xml_bad)
    assert res.success, f"修复失败: {res.errors}"
    assert "\x01" not in res.repaired_xml
check("detect_and_repair_xml 清除非法控制字符", t_repair_engine)


# ============================================================
# 3) 物品 items
# ============================================================
print("\n=== 3. 物品 items ===")

def t_parse_empty():
    assert parse_items("") == []
check("空字符串解析为空列表", t_parse_empty)

def t_parse_single():
    assert parse_items("a|b|c}") == [["a", "b", "c"]]
check("单物品解析", t_parse_single)

def t_parse_records():
    assert parse_items("a}b}") == [["a"], ["b"]]
check("多记录解析(跳过空记录)", t_parse_records)

def t_serialize_rt():
    items = [["a", "b", "c"], ["1", "2", "3"]]
    assert parse_items(serialize_items(items)) == items
check("序列化→解析 往返一致", t_serialize_rt)

def t_template_lv0():
    meta = {"rank": "1", "name": "测试装", "code": "tc", "slot": "zbwp",
            "restriction": "", "quality": "普通", "color": "0xFFFFFF"}
    t = new_item_template(code_meta=meta, enhancement_level=0)
    assert t[1] == "测试装" and t[23] == "0" and len(t) == 28
check("新模板 Lv0: 名称正确 / 强化字段=0 / 28 字段", t_template_lv0)

def t_template_lv10():
    meta = {"rank": "1", "name": "测试装", "code": "tc", "slot": "zbwp",
            "restriction": "", "quality": "普通", "color": "0xFFFFFF"}
    t = new_item_template(code_meta=meta, enhancement_level=10)
    assert t[23] == "10"
check("新模板 Lv10: 强化字段=10", t_template_lv10)

def t_template_lv_negative():
    meta = {"rank": "1", "name": "测试装", "code": "tc", "slot": "zbwp",
            "restriction": "", "quality": "普通", "color": "0xFFFFFF"}
    t = new_item_template(code_meta=meta, enhancement_level=-1)
    assert t[23] == "0"  # 负数按 0 处理
check("新模板 Lv<0: 强化字段归 0(不崩溃)", t_template_lv_negative)

def t_template_no_meta():
    t = new_item_template()
    assert t[1] == "新物品" and len(t) == 28
check("无 meta 模板: 默认名称 / 28 字段", t_template_no_meta)


# ============================================================
# 4) 强化 enhancement
# ============================================================
print("\n=== 4. 强化 enhancement ===")

def t_parse_empty():
    for s in ("无", "", "-", None):
        assert parse_enhancement_bonus(s) == {}
check("强化解析: 无/空/横杠 → 空 dict", t_parse_empty)

def t_parse_single():
    assert parse_enhancement_bonus("防御+4") == {"防御": 4}
check("强化解析: 单属性", t_parse_single)

def t_parse_multi():
    assert parse_enhancement_bonus("生命+5 防御+2") == {"生命": 5, "防御": 2}
check("强化解析: 多属性", t_parse_multi)

def t_parse_alias():
    assert parse_enhancement_bonus("蓝量+3") == {"魔法": 3}
    assert parse_enhancement_bonus("血量+10") == {"生命": 10}
    assert parse_enhancement_bonus("回蓝+2") == {"回魔": 2}
check("强化解析: 别名归一化(蓝量/血量/回蓝)", t_parse_alias)

def t_parse_float():
    assert parse_enhancement_bonus("防御+4.5") == {"防御": 4.5}
check("强化解析: 浮点加成", t_parse_float)

def t_parse_unknown():
    assert parse_enhancement_bonus("神秘+7") == {"神秘": 7}
check("强化解析: 未知属性保留", t_parse_unknown)

def t_parse_no_num():
    assert parse_enhancement_bonus("防御+") == {}
check("强化解析: 缺数值 → 空", t_parse_no_num)

def t_apply_missing_base():
    out = apply_enhancement({}, {"防御": 4}, 7)
    assert out[10] == "28"  # 0 + 4*7
check("apply: 基础缺失按 0 计算", t_apply_missing_base)

def t_apply_int_fmt():
    out = apply_enhancement({"攻击": "4"}, {"攻击": 3}, 7)
    assert out[9] == "25"  # 4 + 3*7
check("apply: 整数结果保持整数格式", t_apply_int_fmt)


# ============================================================
# 5) 属性解析 common
# ============================================================
print("\n=== 5. 属性解析 common ===")

def t_attr_plus():
    assert _parse_attr_val("35+5") == "40"
    assert _parse_attr_val("35+5+10") == "50"
check("_parse_attr_val: 浮动取最大值(35+5=40)", t_attr_plus)

def t_attr_float():
    assert _parse_attr_val("12.5") == "12.5"
check("_parse_attr_val: 纯小数原样", t_attr_float)

def t_attr_invalid():
    for s in ("", None, "???", "abc", "—"):
        assert _parse_attr_val(s) is None
check("_parse_attr_val: 空/非数值 → None", t_attr_invalid)


# ============================================================
# 6) 合成 synthesis
# ============================================================
print("\n=== 6. 合成 synthesis ===")

def t_is_synthetic():
    assert is_synthetic_equip("地藏戒") is True
    assert is_synthetic_equip("命定·花宴") is True
    assert is_synthetic_equip("普通的行者服") is False
check("is_synthetic_equip 判断", t_is_synthetic)

def t_calc_missing():
    assert calc_synthetic_defaults("不存在的装备", {"x": {}}) is None
    assert calc_synthetic_defaults("地藏戒", {}) is None
check("calc: 未知装备/缺组件 → None", t_calc_missing)

def t_calc_ok():
    app = EditorApp()
    app._open_save(PATH)
    sd = calc_synthetic_defaults("地藏戒", app.refdata.get("equip_attrs", {}))
    assert isinstance(sd, dict) and len(sd) > 0
check("calc: 地藏戒 返回非空属性 dict", t_calc_ok)

def t_recipes():
    r = get_synthetic_recipes()
    assert isinstance(r, dict) and len(r) == 4
check("get_synthetic_recipes: 4 条配方拷贝", t_recipes)


# ============================================================
# 7) 常量 constants
# ============================================================
print("\n=== 7. 常量 constants ===")

def t_norm_quality():
    assert normalize_quality(None) is None
    assert normalize_quality("") == ""
    assert normalize_quality("普 通") == "普 通"
    assert normalize_quality("普通") == "普 通"
    assert normalize_quality("未知品质") == "未知品质"
check("normalize_quality 各类输入", t_norm_quality)

def t_quality_order():
    assert len(QUALITY_ORDER) == 14
    assert len(set(QUALITY_ORDER)) == 14
check("QUALITY_ORDER: 14 项且无重复", t_quality_order)

def t_quality_colors():
    assert set(QUALITY_COLORS.keys()) == set(QUALITY_ORDER)
check("QUALITY_COLORS 覆盖 QUALITY_ORDER 全层级", t_quality_colors)


# ============================================================
# 8) 校验引擎异常 app.validate
# ============================================================
print("\n=== 8. 校验引擎异常 ===")

def t_validate_none():
    app = EditorApp()
    app.save = None
    errs, warns = app.validate()
    assert any("未打开存档" in e for e in errs)
check("validate: 未打开存档报错", t_validate_none)

def _open_bag(app):
    app._open_save(PATH)
    for bag in ("背包装备", "道具材料"):
        app._switch_to_bag(bag)
        if app.items:
            return bag
    return None

def t_validate_neg_qty():
    app = EditorApp()
    if not _open_bag(app):
        raise AssertionError("无可编辑背包")
    app.items[0][22] = "-5"
    app._flush_current_bag()
    errs, warns = app.validate()
    assert any("数量需≥1" in e for e in errs), errs
check("validate: 数量为负报错", t_validate_neg_qty)

def t_validate_bad_attr():
    app = EditorApp()
    if not _open_bag(app):
        raise AssertionError("无可编辑背包")
    app.items[0][7] = "abc"  # 生命 非数值
    app._flush_current_bag()
    errs, warns = app.validate()
    assert any("非法" in e for e in errs), errs
check("validate: 数值字段非法报错", t_validate_bad_attr)

def t_validate_bad_color():
    app = EditorApp()
    if not _open_bag(app):
        raise AssertionError("无可编辑背包")
    app.items[0][6] = "red"
    app._flush_current_bag()
    errs, warns = app.validate()
    assert any("颜色异常" in w for w in warns), warns
check("validate: 颜色格式异常告警", t_validate_bad_color)

def t_validate_unknown_code():
    app = EditorApp()
    if not _open_bag(app):
        raise AssertionError("无可编辑背包")
    app.items[0][2] = "zzz_not_in_catalog"
    app._flush_current_bag()
    errs, warns = app.validate()
    assert any("代码不在参考库" in w for w in warns), warns
check("validate: 未知代码告警", t_validate_unknown_code)


# ============================================================
# 9) 单元格编辑异常路径 _on_cell_edited
# ============================================================
print("\n=== 9. 单元格编辑异常路径 ===")

def t_edit_non_dict():
    app = EditorApp()
    app.items = [["普 通", "x", "c"] + ["0"] * 25]
    app.active_bag = "背包装备"
    app._on_cell_edited("not a dict")  # 不应抛异常
    assert app.items[0][1] == "x"
check("_on_cell_edited 非 dict 事件安全忽略", t_edit_non_dict)

def t_edit_missing_keys():
    app = EditorApp()
    app.items = [["普 通", "x", "c"] + ["0"] * 25]
    app.active_bag = "背包装备"
    app._on_cell_edited({"row": 0})      # 缺 column/value
    app._on_cell_edited({"row": 0, "column": 0})  # 缺 value
    assert app.items[0][1] == "x"
check("_on_cell_edited 缺键安全忽略", t_edit_missing_keys)

def t_edit_oob():
    app = EditorApp()
    app.items = [["普 通", "x", "c"] + ["0"] * 25]
    app.active_bag = "背包装备"
    app._on_cell_edited({"row": 99999, "column": 0, "value": "z"})
    app._on_cell_edited({"row": 0, "column": 99999, "value": "z"})
    assert app.items[0][1] == "x"
check("_on_cell_edited 越界行列安全忽略", t_edit_oob)


# ============================================================
# 汇总
# ============================================================
print("\n" + "=" * 52)
pass_n = sum(1 for _, s in results if s.startswith("PASS"))
fail_n = sum(1 for _, s in results if not s.startswith("PASS"))
for name, status in results:
    icon = "✅" if status.startswith("PASS") else "❌"
    print(f"  {icon} {name}: {status}")
print("=" * 52)
print(f"总计: {pass_n} 通过, {fail_n} 失败")
if fail_n == 0:
    print("全面边界/异常测试通过 ✅")
    sys.exit(0)
else:
    print("存在失败项 ❌")
    sys.exit(1)
