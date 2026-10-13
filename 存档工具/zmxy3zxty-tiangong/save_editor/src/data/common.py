"""数据层共享小工具。

集中放置被 items / enhancement / synthesis 复用的纯函数，避免循环依赖。
"""
def _parse_attr_val(raw):
    """解析属性值为数值字符串。

    - 浮动值 '35+5' -> 取最大值 '40'
    - 纯数值 / 小数 -> 原样返回
    - 非数值（文字说明 / 空 / '???'）-> None
    """
    if raw is None:
        return None
    s = str(raw).strip()
    # 兼容 xlsx 偶发的双点笔误（如 "0..08" 应为 "0.08"）
    s = s.replace("..", ".")
    if not s or s in ("???", "？", "—", "-", "..."):
        return None
    # 浮动：取最大值
    if "+" in s:
        parts = s.split("+")
        try:
            total = sum(float(p.strip()) for p in parts)
            return str(int(total)) if total == int(total) else str(total)
        except (ValueError, TypeError):
            pass
    try:
        float(s)
        return s
    except ValueError:
        return None
