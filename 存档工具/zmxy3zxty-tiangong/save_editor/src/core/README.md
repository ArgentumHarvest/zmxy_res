# core — 核心逻辑层

存档编解码与对象模型，是整支编辑器的“引擎”。本包**不依赖任何 UI**，也不依赖
`data`/`ui`/`utils` 的顶层符号（仅在函数内部按需导入 `data.items` 以避免循环依赖），
因此可被任意脚本、测试或未来新增的前端独立调用。

## 依赖方向
```
core  ──►  utils.amf / utils.color   （无循环）
  └─（函数内局部导入）─► data.items   （仅在 load_save/save_save 时）
```

## 模块清单

| 文件 | 职责 |
| --- | --- |
| `constants.py` | 全部静态配置：编解码密钥（`CUSTOM_B64`/`STANDARD_B64`/`XOR_KEY`/`ZLIB_LEVEL`/`MAX_ZLIB_PASSES`）、物品 28 字段定义（`ITEM_FIELDS`/`VISIBLE_FIELDS`）、背包字段映射（`BAG_FIELDS`）、槽位/品质/角色枚举（`SLOT_CODES`/`QUALITY_COLORS`/`ROLE_LIST`）、分类过滤（`BAG_SLOT_FILTERS`）、强化上下限（`ENHANCE_MIN_LEVEL`/`ENHANCE_MAX_LEVEL`）等。 |
| `codec.py` | SAV 字符串 ↔ XML 的编解码：`decode_sav_string` / `decode_sav` / `encode_sav`。算法为 自定义 Base64 → XOR 0x5A → 多层 zlib → 剥离 AMF3 头。 |
| `models.py` | `SaveFile` 对象模型（按背包字段读取/写入各物品列表）+ 便捷函数 `load_save(path)` / `save_save(save, path)`。内部通过函数级导入 `from data.items import parse_items, serialize_items` 衔接数据层，规避循环依赖。 |

## `__init__.py`
统一再导出上述全部符号，便于 `from core import load_save, SaveFile, BAG_FIELDS …` 一行引入。

## 约定
- 本包内**不得** import `ui.*`、`tkinter`、`customtkinter`，保持纯逻辑可测试。
- 所有“魔法数字/字符串”集中到 `constants.py`，新增字段或枚举请先改这里。
