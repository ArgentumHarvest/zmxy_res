"""AMF3 U29 变长整数编解码。

纯算法实现，无任何第三方依赖，供 core.codec 复用。
参考: AMF3 规范中的 U29 整数编码（最高位为延续标志）。
"""


def u29_encode(value):
    """将整数编码为 U29 变长字节序列。"""
    if value < 0x80:
        return bytes([value])
    elif value < 0x4000:
        return bytes([(value >> 7) | 0x80, value & 0x7F])
    elif value < 0x200000:
        return bytes([(value >> 14) | 0x80,
                      ((value >> 7) & 0x7F) | 0x80,
                      value & 0x7F])
    else:
        return bytes([(value >> 21) | 0x80,
                      ((value >> 14) & 0x7F) | 0x80,
                      ((value >> 7) & 0x7F) | 0x80,
                      value & 0x7F])


def u29_decode(data, offset):
    """从字节序列的 offset 处解码一个 U29 整数，返回 (value, new_offset)。"""
    value = 0
    for _ in range(4):
        b = data[offset]
        value = (value << 7) | (b & 0x7F)
        offset += 1
        if not (b & 0x80):
            break
    return value, offset
