"""存档对象模型 SaveFile 及文件级读写。

SaveFile 将解码后的 XML 封装为可读写对象，提供标量字段(get/set_scalar)、
背包读写(get/set_bag)、概览(summary) 与序列化(to_sav_string)。

依赖: core.codec (编解码), core.constants (背包字段映射), core.xml_repair (XML修复)。
"""
import xml.etree.ElementTree as ET

from core.codec import decode_sav, encode_sav
from core.xml_repair import detect_and_repair_xml, RepairResult
from data.items import parse_items, serialize_items


class SaveFile:
    def __init__(self, xml_string, zlib_passes):
        self.zlib_passes = zlib_passes
        self.root = ET.fromstring(xml_string)
        self._xml_string = xml_string

    def get_scalar(self, name, default=None):
        el = self.root.find(f".//s[@name='{name}']")
        return el.text if el is not None else default

    def set_scalar(self, name, value, typ="Number"):
        el = self.root.find(f".//s[@name='{name}']")
        if el is None:
            el = ET.SubElement(self.root, 's')
            el.set('name', name)
            el.set('type', typ)
        else:
            el.set('type', typ)
        el.text = str(value)

    def get_player_obj(self, index=1):
        return self.root.find(f".//s[@name='player{index}_obj']")

    def get_bag(self, bag_xml_field, player_index=1):
        p = self.get_player_obj(player_index)
        if p is None:
            return []
        el = p.find(f"s[@name='{bag_xml_field}']")
        if el is None or el.text is None:
            return []
        return parse_items(el.text)

    def set_bag(self, bag_xml_field, items, player_index=1):
        p = self.get_player_obj(player_index)
        if p is None:
            return
        el = p.find(f"s[@name='{bag_xml_field}']")
        if el is None:
            el = ET.SubElement(p, 's')
            el.set('name', bag_xml_field)
            el.set('type', 'String')
        el.text = serialize_items(items)

    def to_xml(self):
        return ET.tostring(self.root, encoding='unicode')

    def to_sav_string(self):
        return encode_sav(self.to_xml(), self.zlib_passes)

    def summary(self):
        return {
            "username": self.get_scalar("username"),
            "roleid": self.get_scalar("roleid"),
            "curLevel": self.get_scalar("curLevel"),
            "curExp": self.get_scalar("curExp"),
            "lhValue": self.get_scalar("lhValue"),
            "luckdata": self.get_scalar("luckdata"),
            "bag_equip": len(self.get_bag("bagSaveString")),
            "bag_item": len(self.get_bag("bagdjSaveString")),
            "cur_equip": len(self.get_bag("curSaveString")),
        }


def load_save(path):
    xml_str, passes = decode_sav(path)
    return SaveFile(xml_string=xml_str, zlib_passes=passes)


def load_save_with_repair(path, backup_dir=None):
    """加载存档，XML 解析失败时自动触发修复流程。

    Args:
        path: .sav 文件路径。
        backup_dir: 修复时备份文件的存放目录。为 None 则不创建备份。

    Returns:
        (SaveFile, RepairResult) 元组。
        - 修复成功时 SaveFile 正常可用，RepairResult.success=True
        - 修复失败时 SaveFile 为 None，RepairResult 包含错误详情

    Raises:
        ValueError: 解码阶段即失败（非 XML 问题，而是文件格式根本不对）。
    """
    xml_str, passes = decode_sav(path)

    # 先尝试正常解析
    try:
        save = SaveFile(xml_string=xml_str, zlib_passes=passes)
        return save, RepairResult(
            success=True,
            original_xml=xml_str,
            repaired_xml=xml_str,
            fix_summary="未发现格式问题，文件完好",
        )
    except ET.ParseError:
        pass

    # XML 解析失败 → 触发修复
    result = detect_and_repair_xml(xml_str, backup_dir=backup_dir)

    if result.success:
        save = SaveFile(xml_string=result.repaired_xml, zlib_passes=passes)
        return save, result
    else:
        return None, result


def save_save(save_file, out_path):
    sav = save_file.to_sav_string()
    with open(out_path, 'w', encoding='ascii') as f:
        f.write(sav)
    return out_path
