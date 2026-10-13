"""合成装备默认值计算。

对特定合成装备（地藏戒 / 地藏金戒 / 花宴 / 命定·花宴），按配方 + 组件 +7 强化
属性之和的 2/3 估算合成后的基础属性。

规则（2026-07-16 校对）：
  - 命定·花宴 = 花宴属性 × 1.5
  - 其余合成装备 = 所用组件属性之和 × 2/3
  - 打造小件（马官指环等 6 件）嵌入攻击宝石 +120，且按 +7 强化计入
  - 地藏金戒不继承 山河社稷图 的「泣血」属性；花宴可继承三小件「泣血」
  - 地藏戒本身不可强化（作为组件时取其已算出的合成值，不再叠加宝石/强化）

依赖: core.constants (ATTR_FIELD_MAP), data.common (_parse_attr_val),
      data.enhancement (parse_enhancement_bonus, apply_enhancement)。
"""
from core.constants import ATTR_FIELD_MAP
from data.common import _parse_attr_val
from data.enhancement import parse_enhancement_bonus, apply_enhancement

# 已知合成配方（从 refdata.json recipes 提取并校对）
_SYNTHETIC_RECIPES = {
    "地藏戒":   ("马官指环", "通风灵戒", "提多罗吒戒"),
    "地藏金戒": ("山河社稷图", "地藏戒", "玲珑玉"),
    "花宴":     ("不朽花翼", "镇魂花坠", "破幻花链"),
    # 命定·花宴 不在此表：其属性 = 花宴 × 1.5（见 _compute_synth）
}

# 打造装备（合成时可嵌入攻击宝石 +120）
_CRAFTED = {"马官指环", "通风灵戒", "提多罗吒戒", "不朽花翼", "镇魂花坠", "破幻花链"}

# 合成时的属性排除规则：结果名 -> [(组件名, 排除属性), ...]
_SYNTH_EXCLUDE = {
    "地藏金戒": [("山河社稷图", "泣血")],
}

# 比率型属性（保留 4 位小数，其余取整）
_RATE_FIELDS = {"暴击", "闪避", "魔抗", "命中"}

# 合成时组件装备的默认强化等级（用于计算合成后基础属性）
_SYNTHETIC_COMPONENT_LEVEL = 7


def _component_final(comp_name, all_equip_attrs):
    """计算某组件在 +7 强化（打造件含攻宝石 +120）下的属性 dict（属性名 -> float）。"""
    comp_attrs = all_equip_attrs.get(comp_name)
    if not comp_attrs:
        return None
    comp_base = {}
    for field_idx, attr_name in ATTR_FIELD_MAP.items():
        val = _parse_attr_val(comp_attrs.get(attr_name, ""))
        if val is not None:
            try:
                comp_base[attr_name] = float(val)
            except (ValueError, TypeError):
                pass
    enh_bonus = parse_enhancement_bonus(comp_attrs.get("强化后增加属性", ""))
    enhanced = apply_enhancement(
        {k: str(v) for k, v in comp_base.items()},
        enh_bonus, _SYNTHETIC_COMPONENT_LEVEL)
    final = {}
    for fi, val_str in enhanced.items():
        aname = ATTR_FIELD_MAP[fi]
        try:
            final[aname] = float(val_str)
        except (ValueError, TypeError):
            pass
    if comp_name in _CRAFTED:
        final["攻击"] = final.get("攻击", 0.0) + 120.0
    return final


def _compute_synth(item_name, all_equip_attrs, memo):
    """递归计算合成装备的基础属性 dict（属性名 -> float）。"""
    if item_name in memo:
        return memo[item_name]
    # 命定·花宴：花宴属性 × 1.5
    if item_name == "命定·花宴":
        base = _compute_synth("花宴", all_equip_attrs, memo)
        res = {k: v * 1.5 for k, v in base.items()}
        memo[item_name] = res
        return res
    recipe = _SYNTHETIC_RECIPES.get(item_name)
    if not recipe:
        return None
    total = {aname: 0.0 for aname in ATTR_FIELD_MAP.values()}
    for comp_name in recipe:
        # 组件本身可能也是合成装备（如 地藏戒），优先用其已算结果
        if comp_name in _SYNTHETIC_RECIPES or comp_name == "命定·花宴":
            cf = _compute_synth(comp_name, all_equip_attrs, memo)
        else:
            cf = _component_final(comp_name, all_equip_attrs)
        if cf is None:
            continue
        # 排除规则：本组件不参与合成的属性
        for ex_comp, ex_attr in _SYNTH_EXCLUDE.get(item_name, []):
            if comp_name == ex_comp:
                cf = dict(cf)
                cf.pop(ex_attr, None)
        for k, v in cf.items():
            total[k] = total.get(k, 0.0) + v
    res = {k: total[k] * 2.0 / 3.0 for k in total}
    memo[item_name] = res
    return res


def calc_synthetic_defaults(item_name, all_equip_attrs):
    """按合成配方 + 组件+7强化，计算合成装备的属性默认值。

    返回 dict {field_idx(int): attr_value(str)} 或 None（无法计算时）。
    """
    if not all_equip_attrs:
        return None
    res = _compute_synth(item_name, all_equip_attrs, {})
    if not res:
        return None
    out = {}
    for field_idx, attr_name in ATTR_FIELD_MAP.items():
        v = res.get(attr_name, 0.0)
        if v == 0:
            continue
        if attr_name in _RATE_FIELDS:
            out[field_idx] = str(round(v, 4))
        else:
            out[field_idx] = str(int(round(v)))
    return out if out else None


def is_synthetic_equip(name):
    """判断某装备是否为已知合成装备。"""
    return name in _SYNTHETIC_RECIPES or name == "命定·花宴"


def get_synthetic_recipes():
    """返回合成配方字典的拷贝（结果名 -> 组件元组）。

    命定·花宴 以派生形式返回（花宴 × 1.5）。
    """
    r = dict(_SYNTHETIC_RECIPES)
    r["命定·花宴"] = ("花宴",)
    return r
