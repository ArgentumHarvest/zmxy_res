"""颜色工具：十六进制解析与相对亮度计算。

用于背包表格中按物品颜色字段做单元格高亮（对比前景色）。
"""


def safe_hex(s):
    """将 '0xRRGGBB' 形式清洗为 6 位十六进制字符串；非法返回 None。"""
    s = s.replace("0x", "").replace("0X", "")
    if len(s) == 6 and all(c in "0123456789abcdefABCDEF" for c in s):
        return s
    return None


def luminance(hex_rgb):
    """计算 6 位十六进制 RGB 的相对亮度（0~1）。"""
    r, g, b = (int(hex_rgb[i:i + 2], 16) for i in (0, 2, 4))
    return (0.299 * r + 0.587 * g + 0.114 * b) / 255.0
