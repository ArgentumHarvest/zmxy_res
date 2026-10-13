"""核心逻辑包：SAV 编解码与存档对象模型。

对外统一暴露常用符号，方便调用方 `from core import decode_sav, SaveFile, ...`。
"""
from .constants import (
    CUSTOM_B64, STANDARD_B64, XOR_KEY, ZLIB_LEVEL, MAX_ZLIB_PASSES,
    ATTR_DISPLAY_NAMES, ITEM_FIELDS, VISIBLE_FIELDS, BAG_FIELDS,
    SLOT_CODES, QUALITY_COLORS, QUALITY_ORDER, QUALITY_SPACE_MAP, normalize_quality,
    ATTR_FIELD_MAP, BAG_SLOT_FILTERS,
    GLOBAL_FIELDS, ROLE_LIST, ENHANCE_MIN_LEVEL, ENHANCE_MAX_LEVEL,
)
from .codec import decode_sav_string, decode_sav, encode_sav
from .models import SaveFile, load_save, save_save
