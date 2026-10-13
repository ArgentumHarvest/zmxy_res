"""物品数据模型：28 字段记录的解析、序列化与模板生成。

依赖: core.constants (字段映射), data.common (_parse_attr_val)。
"""
from core.constants import ATTR_FIELD_MAP
from data.common import _parse_attr_val


def parse_items(bag_string):
    """将背包字符串解析为二维列表（每条物品为字段数组）。"""
    if not bag_string:
        return []
    out = []
    for rec in bag_string.split('}'):
        if rec == '':
            continue
        out.append(rec.split('|'))
    return out


def serialize_items(items):
    """将二维列表序列化回背包字符串。"""
    return '}'.join('|'.join(fields) for fields in items)


def new_item_template(code_meta=None, count=1, code=None, equip_attrs=None,
                      enhancement_level=0):
    """生成一个 28 字段的新物品记录。

    参数：
      code_meta        : code_catalog 条目
      count            : 数量
      code             : 物品代码
      equip_attrs      : equip_attrs 条目（权威属性表）
      enhancement_level : 强化等级 (0~10)，0 表示不强化
    """
    def _attr(field_idx):
        key = ATTR_FIELD_MAP.get(field_idx)
        if equip_attrs and key in equip_attrs:
            val = _parse_attr_val(equip_attrs[key])
            if val is not None:
                return val
        return "0"

    # 基础属性（未强化）
    _attr_keys = list(ATTR_FIELD_MAP.keys())
    base_attrs = {}
    for field_idx in _attr_keys:
        base_attrs[field_idx] = _attr(field_idx)

    # 注意：强化等级只写入「强化」字段(索引23)，基础属性(7-13)始终保持
    # 原始值，由游戏在读取时按 强化等级 × 每级加成 计算最终属性。
    # 切勿把强化加成直接并入基础属性，否则会与游戏内计算叠加导致数值异常。

    # 强化字段
    str_enh = str(enhancement_level) if enhancement_level > 0 else "0"

    # 法宝(zbfb)需要初始化五行属性、等级与成长率；其它类型保持占位默认值，
    # 避免字段错位。法宝要求：五行(金木水火土)全部开启、等级=1、成长率=3。
    slot = code_meta.get("slot", "zbwp") if code_meta else "zbwp"
    is_fabao = (slot == "zbfb")
    wuxing = ["true", "true", "true", "true", "true"] if is_fabao else \
             ["false", "false", "false", "false", "false"]
    level_val = "1" if is_fabao else "0"
    growth_val = "3" if is_fabao else "0"

    if code_meta:
        base = [
            str(code_meta.get("rank", "1")),
            code_meta.get("name", ""),
            code or code_meta.get("code", ""),
            slot,
            code_meta.get("restriction", ""),
            code_meta.get("quality", "普通"),
            code_meta.get("color", "0xFFFFFF"),
        ] + [base_attrs.get(i, "0") for i in range(7, 14)] + [
            base_attrs.get(14, "0"),                    # 14 回蓝（原硬编码"0"）
            wuxing[0], wuxing[1], wuxing[2], wuxing[3], wuxing[4],  # 15-19 金木水火土
            level_val, growth_val,                      # 20 等级, 21 成长率
            str(count),                                # 22 数量
            str_enh,                                   # 23 强化
            base_attrs.get(24, "0"),                   # 24 魔抗（原硬编码"0"）
            "0",                                       # 25 -0-
            base_attrs.get(26, "0"),                   # 26 命中（原硬编码"0"）
            base_attrs.get(27, "0"),                   # 27 泣血（原硬编码"0"）
        ]
    else:
        # 无 code_meta 时同样补齐为完整 28 字段（含 27 号 泣血），避免字段错位
        base = ["1", "新物品", "newitem", "zbwp", "", "普通", "0xFFFFFF"] \
               + ["0"] * 7 + ["0"] + ["false"] * 5 \
               + ["0", "0", str(count), "0", "0", "0", "0", "0"]
    return base
