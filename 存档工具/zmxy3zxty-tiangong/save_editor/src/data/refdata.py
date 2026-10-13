"""参考数据库加载（运行时读取 refdata.json）。

依赖: 仅标准库 json。
"""
import json


def load_refdata(path):
    """读取参考库 JSON，返回 dict；失败时返回空结构的兜底字典。"""
    try:
        with open(path, "r", encoding="utf-8") as fh:
            return json.load(fh)
    except Exception:
        return {
            "equip_attrs": {}, "code_catalog": {},
            "recipes": [], "drops": [], "gems": [],
            "stats": {},
        }
