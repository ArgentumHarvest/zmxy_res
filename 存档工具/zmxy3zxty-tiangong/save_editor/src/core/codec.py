"""SAV <-> XML 编解码核心。

解码流程: 自定义 Base64 -> XOR 0x5A -> zlib(可能多层) -> AMF3 头剥离 -> XML 文本
编码流程: XML 文本 -> 拼 AMF3 头 -> zlib(指定层数) -> XOR 0x5A -> 自定义 Base64

依赖: utils.amf (U29 变长整数), core.constants (密钥与字母表)。
"""
import base64
import zlib

from utils.amf import u29_encode, u29_decode
from core.constants import CUSTOM_B64, STANDARD_B64, XOR_KEY, ZLIB_LEVEL, MAX_ZLIB_PASSES

_TO_STANDARD = str.maketrans(CUSTOM_B64, STANDARD_B64)
_TO_CUSTOM = str.maketrans(STANDARD_B64, CUSTOM_B64)

# XOR 加解密表：单字节密钥 0x5A 的逐字节映射（C 级 bytes.translate 用）。
# 对称：table[i] = i ^ XOR_KEY，故编解码可复用同一张表（XOR 自反）。
_XOR_TABLE = bytes([(i & 0xFF) ^ XOR_KEY for i in range(256)])


def _xor_bytes(data: bytes) -> bytes:
    """对整段字节做 XOR 0x5A（C 级 translate，远快于逐字节 Python 生成器）。"""
    return data.translate(_XOR_TABLE)


def decode_sav_string(sav_str):
    """从 .sav 文本字符串解码，返回 (xml_string, zlib_passes)。"""
    raw = sav_str.strip()
    decoded = base64.b64decode(raw.translate(_TO_STANDARD))
    data = _xor_bytes(decoded)
    passes = 0
    for _ in range(MAX_ZLIB_PASSES):
        try:
            data = zlib.decompress(data)
            passes += 1
        except zlib.error:
            break
    if data[0] != 0x06:
        raise ValueError("不是有效的再续天庭存档（AMF3 标记 0x06 缺失）")
    v, off = u29_decode(data, 1)
    xml_len = v >> 1
    xml_bytes = data[off:off + xml_len]
    return xml_bytes.decode('utf-8'), passes


def decode_sav(sav_path):
    """读取 .sav 文件返回 (xml_string, zlib_passes)。"""
    with open(sav_path, 'r', encoding='ascii') as f:
        raw = f.read()
    return decode_sav_string(raw)


def encode_sav(xml_string, zlib_passes=1):
    """将 XML 字符串编码回 .sav 文本。"""
    xml_bytes = xml_string.encode('utf-8')
    amf3_value = (len(xml_bytes) << 1) | 1
    amf3_header = bytes([0x06]) + u29_encode(amf3_value)
    data = amf3_header + xml_bytes
    for _ in range(zlib_passes):
        data = zlib.compress(data, level=ZLIB_LEVEL)
    encrypted = _xor_bytes(data)
    standard_b64 = base64.b64encode(encrypted).decode('ascii')
    return standard_b64.translate(_TO_CUSTOM)
