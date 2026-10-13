# utils — 工具函数层

与游戏业务无关的**底层纯函数**，被 `core` / `data` / `ui` 复用。本包**零业务依赖、零
第三方 GUI 依赖**，可单独测试或直接 copy 到其他项目。

## 依赖方向
```
utils.amf    ──► （仅标准库）
utils.color  ──► （仅标准库）
```
> `utils` 不 import `core` / `data` / `ui`，是依赖图的“最底层叶子”。

## 模块清单

| 文件 | 职责 | 关键 API |
| --- | --- | --- |
| `amf.py` | AMF3 的 **U29 变长整数**编解码，用于解析 SAV 中的长度前缀。无第三方依赖。 | `u29_encode(value)` → `bytes`、`u29_decode(data, offset)` → `(value, new_offset)` |
| `color.py` | 颜色小工具：安全地把任意对象转成 `#RRGGBB` 字符串，以及计算相对亮度（用于决定前景色深浅）。 | `safe_hex(s)` → `str`、`luminance(hex_rgb)` → `float(0~1)` |

## `__init__.py`
再导出 `u29_encode, u29_decode, safe_hex, luminance`，便于 `from utils import u29_decode, safe_hex`。

## 约定
- 新增通用辅助函数（字符串/字节/颜色/数学等）放这里；一旦函数耦合了物品/背包等业务
  概念，应移入 `data.common`。
- 保持本包纯函数、无副作用，方便单测与复用。
