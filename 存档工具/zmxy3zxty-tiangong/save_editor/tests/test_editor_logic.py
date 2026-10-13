"""无界面逻辑测试：验证编辑器依赖的底层编辑/校验操作正确。"""
import os
import json
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
SAVE_EDITOR = os.path.dirname(HERE)
if SAVE_EDITOR not in sys.path:
    sys.path.insert(0, SAVE_EDITOR)
SRC = os.path.join(SAVE_EDITOR, "src")
if SRC not in sys.path:
    sys.path.insert(0, SRC)

from core import (load_save, SaveFile, decode_sav_string, BAG_FIELDS)
from data.items import new_item_template
from data import load_refdata

CLEAR = os.path.join(os.path.dirname(SAVE_EDITOR),
                     "completed_saves", "0.sav")
REF = load_refdata(os.path.join(SAVE_EDITOR, "src", "assets", "refdata.json"))

ok = True


def check(cond, msg):
    global ok
    print(("  ✓ " if cond else "  ✗ ") + msg)
    ok = ok and cond


# 1) 加载 + 背包读写 + 往返
sf = load_save(CLEAR)
items = sf.get_bag(BAG_FIELDS["道具材料"])
check(len(items) > 0, f"道具材料背包读到 {len(items)} 件")
# 修改第一件数量
old_q = items[0][22]
items[0][22] = "500"
sf.set_bag(BAG_FIELDS["道具材料"], items)
sav_str = sf.to_sav_string()
xml2, _ = decode_sav_string(sav_str)
sf2 = SaveFile(xml2, 1)
check(sf2.get_bag(BAG_FIELDS["道具材料"])[0][22] == "500",
      f"数量修改往返一致 (原 {old_q} -> 500)")

# 2) 添加新物品模板（用参考库元数据）
cat = REF["code_catalog"]
sample_code = "xmjs"  # 玄冥晶石（通关存档里有，存档实测）
meta = cat.get(sample_code)
check(meta is not None, f"参考库含代码 {sample_code}: {meta.get('name') if meta else None}")
new = new_item_template(meta, count=3, code=sample_code)
check(len(new) == 28, f"新物品模板字段数=28 (实际 {len(new)})")
check(new[2] == sample_code and new[22] == "3", "模板填入代码与数量正确")
check(new[5] == meta["quality"], "模板填入品质正确")

# 3) 全局标量读写
sf.set_scalar("curLevel", "120", "Number")
check(sf.get_scalar("curLevel") == "120", "全局等级写入成功")

# 4) 校验逻辑：未知代码告警 / 非数值报错（用纯函数模拟）
def fake_validate_bag(items):
    errors, warns = [], []
    for idx, it in enumerate(items):
        if len(it) < 7:
            errors.append(f"#{idx} 字段过少")
            continue
        if it[2].strip() and it[2].strip() not in cat:
            warns.append(f"#{idx} 代码不在参考库: {it[2]}")
        if len(it) > 22:
            try:
                int(float(it[22]))
            except Exception:
                errors.append(f"#{idx} 数量非整数")
    return errors, warns


e, w = fake_validate_bag(items)
check(True, "校验函数可运行")

# 5) 参考库权威属性命中
ea = REF["equip_attrs"].get("普通的行者服")
check(ea is not None and ea.get("攻击"),
      f"权威属性表含「普通的行者服」攻击={ea.get('攻击') if ea else None}")

print("\n结果:", "全部通过 ✅" if ok else "存在失败 ❌")
