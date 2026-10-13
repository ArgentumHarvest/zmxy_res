"""SAV 编解码往返一致性测试（无界面）。

对每个样本 .sav 验证 decode->encode->decode 后 XML 与背包数量一致。
"""
import os
import glob
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
SAVE_EDITOR = os.path.dirname(HERE)
if SAVE_EDITOR not in sys.path:
    sys.path.insert(0, SAVE_EDITOR)
SRC = os.path.join(SAVE_EDITOR, "src")
if SRC not in sys.path:
    sys.path.insert(0, SRC)

from core import decode_sav, encode_sav, decode_sav_string, SaveFile, BAG_FIELDS

CS2 = os.path.dirname(SAVE_EDITOR)
DIRS = [os.path.join(CS2, "sample_saves"),
        os.path.join(CS2, "completed_saves")]

fails = 0
total = 0
for d in DIRS:
    for sp in sorted(glob.glob(os.path.join(d, "*.sav"))):
        total += 1
        name = os.path.basename(sp)
        try:
            xml1, passes = decode_sav(sp)
            sav_str = encode_sav(xml1, passes)
            # 内存内往返，避免临时文件
            xml2, passes2 = decode_sav_string(sav_str)
            if xml1 == xml2:
                sf1 = SaveFile(xml1, passes)
                sf2 = SaveFile(xml2, passes2)
                ok = all(len(sf1.get_bag(x)) == len(sf2.get_bag(x))
                         for x in BAG_FIELDS.values())
                print(f"  ✓ {name}  passes={passes}  背包数量一致={ok}")
            else:
                fails += 1
                print(f"  ✗ {name}  XML 不一致！")
        except Exception as e:
            fails += 1
            print(f"  ✗ {name}  异常: {e}")

print(f"\n合计 {total} 个存档，失败 {fails} 个")
