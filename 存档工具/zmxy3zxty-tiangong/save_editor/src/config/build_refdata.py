"""
生成参考数据库 refdata.json
- 装备属性表(xlsx)：官方权威基础属性 -> equip_attrs（按装备名）
- 合成 / 掉落 / 宝石属性(xlsx)：配方与掉落参考
- 物品代码表(存档装备代码)：三方参考，代码+格式
- 扫描用户提供的全部 .sav：提取真实在档物品代码（权威），覆盖/补全代码目录
合并策略：以 xlsx 装备属性为权威属性源；代码目录 = 三方表 + 存档实测（存档实测标记 source=save，优先）
"""
import os, json, glob
import openpyxl
from core import load_save, BAG_FIELDS, normalize_quality

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))   # cs2 目录
XLSX = os.path.join(BASE, "equip_data", "equip_attr_v1.1c.xlsx")
CODEFILE = os.path.join(BASE, "equip_data", "item_codes.txt")
SAVE_DIRS = [
    os.path.join(BASE, "sample_saves"),
    os.path.join(BASE, "completed_saves"),
]

def find_header_row(ws, keywords):
    for r in range(1, min(ws.max_row, 8) + 1):
        vals = [str(ws.cell(row=r, column=c).value or "") for c in range(1, ws.max_column + 1)]
        if any(k in v for v in vals for k in keywords):
            return r, vals
    return None, None

def load_xlsx():
    wb = openpyxl.load_workbook(XLSX, data_only=True, read_only=True)
    out = {"equip_attrs": {}, "recipes": [], "drops": [], "gems": []}

    # 装备属性（权威）
    ws = wb["装备属性"]
    hr, headers = find_header_row(ws, ["装备名"])
    if hr:
        cols = {h: i for i, h in enumerate(headers)}
        def col(name): return cols.get(name)
        for r in range(hr + 1, ws.max_row + 1):
            name = ws.cell(row=r, column=col("装备名") + 1).value
            if not name:
                continue
            name = str(name).strip()
            rec = {}
            for key in ["职业", "品质", "生命", "魔法", "攻击", "防御", "暴击", "闪避",
                        "回血", "回蓝", "吸血", "魔抗", "命中", "泣血", "强化后增加属性", "描述"]:
                c = col(key)
                if c is not None:
                    v = ws.cell(row=r, column=c + 1).value
                    rec[key] = ("" if v is None else str(v).strip())
            out["equip_attrs"][name] = rec

    # 合成
    ws = wb["合成"]
    hr, headers = find_header_row(ws, ["道具一"])
    if hr:
        for r in range(hr + 1, ws.max_row + 1):
            a = ws.cell(row=r, column=1).value
            if not a:
                continue
            out["recipes"].append({
                "a": str(ws.cell(row=r, column=1).value or "").strip(),
                "b": str(ws.cell(row=r, column=2).value or "").strip(),
                "c": str(ws.cell(row=r, column=3).value or "").strip(),
                "result": str(ws.cell(row=r, column=4).value or "").strip(),
            })

    # 掉落
    ws = wb["掉落"]
    hr, headers = find_header_row(ws, ["BOSS名称"])
    if hr:
        for r in range(hr + 1, ws.max_row + 1):
            a = ws.cell(row=r, column=1).value
            if not a:
                continue
            out["drops"].append({
                "boss": str(ws.cell(row=r, column=1).value or "").strip(),
                "stage": str(ws.cell(row=r, column=2).value or "").strip(),
                "loot": str(ws.cell(row=r, column=3).value or "").strip(),
            })

    # 宝石属性
    ws = wb["宝石属性"]
    hr, headers = find_header_row(ws, ["宝石名称"])
    if hr:
        for r in range(hr + 1, ws.max_row + 1):
            a = ws.cell(row=r, column=1).value
            if not a:
                continue
            out["gems"].append({
                "gem": str(ws.cell(row=r, column=1).value or "").strip(),
                "level": str(ws.cell(row=r, column=2).value or "").strip(),
                "attr": str(ws.cell(row=r, column=3).value or "").strip(),
                "value": str(ws.cell(row=r, column=4).value or "").strip(),
            })
    wb.close()
    return out

def load_code_file():
    """三方物品代码表：品质|装备名称|装备代码|装备类型|人物限制|装备品质|装备颜色|..."""
    catalog = {}
    with open(CODEFILE, 'r', encoding='utf-8') as f:
        lines = f.read().splitlines()
    # 跳过表头（含 '装备名称'）
    for line in lines:
        if not line.strip() or '装备名称' in line:
            continue
        f = line.split('|')
        if len(f) < 7:
            continue
        code = f[2].strip()
        if not code:
            continue
        catalog[code] = {
            "name": f[1].strip(),
            "slot": f[3].strip(),
            "restriction": f[4].strip(),
            "quality": normalize_quality(f[5].strip()),
            "color": f[6].strip(),
            "rank": f[0].strip(),
            "source": "catalog",
        }
    return catalog

def scan_saves():
    """从全部 .sav 提取真实在档物品代码。"""
    real = {}
    savs = []
    for d in SAVE_DIRS:
        savs += glob.glob(os.path.join(d, "*.sav"))
    for sp in savs:
        try:
            sf = load_save(sp)
        except Exception as e:
            print(f"  [跳过] {os.path.basename(sp)}: {e}")
            continue
        for bag in BAG_FIELDS.values():
            for item in sf.get_bag(bag):
                if len(item) < 7:
                    continue
                code = item[2].strip()
                if not code:
                    continue
                real[code] = {
                    "name": item[1].strip(),
                    "slot": item[3].strip(),
                "restriction": item[4].strip(),
                "quality": normalize_quality(item[5].strip()),
                    "color": item[6].strip(),
                    "rank": item[0].strip(),
                    "source": "save",
                }
    return real

def main():
    print("加载 xlsx 装备属性表（权威）...")
    data = load_xlsx()
    print(f"  装备属性条目: {len(data['equip_attrs'])}")
    print(f"  合成配方: {len(data['recipes'])}  掉落: {len(data['drops'])}  宝石: {len(data['gems'])}")

    print("加载三方物品代码表（参考）...")
    catalog = load_code_file()
    print(f"  代码目录(三方): {len(catalog)}")

    print("扫描提供的 .sav 提取真实代码...")
    real = scan_saves()
    print(f"  真实代码(存档实测): {len(real)}")

    # 合并：三方表打底，存档实测覆盖
    merged = dict(catalog)
    for code, meta in real.items():
        merged[code] = meta  # 存档实测优先
    data["code_catalog"] = merged
    data["stats"] = {
        "catalog_only": sum(1 for v in merged.values() if v["source"] == "catalog"),
        "save_verified": sum(1 for v in merged.values() if v["source"] == "save"),
        "total": len(merged),
    }

    # 输出到 src/assets/refdata.json（与运行时 _resource_path 的资源目录保持一致）
    out_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                            "assets", "refdata.json")
    with open(out_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=1)
    print(f"已写出 {out_path}")
    print(f"代码目录总计 {data['stats']['total']}：存档实测 {data['stats']['save_verified']}，仅三方表 {data['stats']['catalog_only']}")

if __name__ == "__main__":
    main()
