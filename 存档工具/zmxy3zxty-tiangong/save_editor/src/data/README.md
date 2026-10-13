# data — 数据模型层

物品、强化、合成与参考库的**数据结构与计算规则**。本包负责把 XML 节点 ↔ Python 列表
（物品 28 字段）之间来回转换，并封装游戏专属的业务逻辑。所有模块只依赖 `core.constants`
与彼此，**不触碰 UI**。

## 依赖方向
```
data.common   ──► core.constants
data.items    ──► core.constants, data.common
data.enhancement ──► core.constants
data.synthesis ──► core.constants, data.common, data.enhancement
data.refdata  ──► （仅标准库 json）
```

## 模块清单

| 文件 | 职责 | 关键 API |
| --- | --- | --- |
| `common.py` | 各数据模块共享的小工具，主要是属性原始值解析 `_parse_attr_val(raw)`。 | `_parse_attr_val` |
| `items.py` | 物品（28 字段列表）的解析/序列化与模板构造。背包 XML → `list[list]`；反向写回。 | `parse_items`, `serialize_items`, `new_item_template` |
| `enhancement.py` | 强化系统：解析“防御+4”式加成文本、按等级叠加到基础属性。 | `parse_enhancement_bonus`, `apply_enhancement` |
| `synthesis.py` | 合成装备：按配方 + 组件 +7 强化的 2/3 估算合成后基础属性。 | `_SYNTHETIC_RECIPES`, `calc_synthetic_defaults`, `is_synthetic_equip`, `get_synthetic_recipes` |
| `refdata.py` | 加载 `refdata.json` 权威参考库（含各装备属性表、合成配方）。 | `load_refdata(path)` |

## `__init__.py`
再导出业务 API，便于 `from data.items import new_item_template, parse_items` 等按需引入。

## 约定
- 物品在内存中以“长度为 28 的列表”表示，字段索引含义见 `core.constants.ITEM_FIELDS`。
- 新增装备计算规则时，优先放进对应专题模块；跨模块复用的纯函数放回 `common.py`。
- 不要在 `data/` 中 import `ui.*`，保持可脱离界面单独测试（见 `tests/`）。
