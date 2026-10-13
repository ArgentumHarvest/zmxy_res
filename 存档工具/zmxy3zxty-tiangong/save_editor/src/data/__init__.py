"""数据层包：物品模型、强化系统、合成计算、参考库加载。

对外统一暴露常用符号，方便调用方 `from data import new_item_template, ...`。
"""
from .items import parse_items, serialize_items, new_item_template
from .enhancement import parse_enhancement_bonus, apply_enhancement
from .synthesis import (
    _SYNTHETIC_RECIPES, _SYNTHETIC_COMPONENT_LEVEL,
    calc_synthetic_defaults, is_synthetic_equip, get_synthetic_recipes,
)
from .refdata import load_refdata
