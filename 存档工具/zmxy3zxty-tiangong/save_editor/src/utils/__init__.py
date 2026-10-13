"""工具函数包：纯算法 / 无业务依赖的通用辅助。

职责单一，不依赖本项目其他模块，可被 core / data / ui 任意引用。
"""

from .amf import u29_encode, u29_decode
from .color import safe_hex, luminance
