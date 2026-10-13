"""参考 / 校验页（Mixin）。

职责单一：渲染「参考/校验」页，展示存档概览、参考库统计、物品详情与合成配方。

依赖: core.constants, data.enhancement, ui.theme。
"""
import tkinter as tk
import customtkinter as ctk

from core.constants import SLOT_CODES
from data.enhancement import parse_enhancement_bonus
from ui.theme import (C_PANEL, C_FRAME, C_ACCENT, C_WARN, C_FG,
                     FONT_FAMILY, CORNER, HOVER_WARN)


class RefPageMixin:
    """参考/校验页相关方法。"""

    def _switch_to_ref(self) -> None:
        self._hide_all_pages()
        self.active_page = "ref"
        self._highlight_nav("参考/校验")

        if self.ref_frame is None:
            rf = ctk.CTkScrollableFrame(self.center, fg_color=C_PANEL,
                                        corner_radius=CORNER)
            ctk.CTkLabel(rf, text="参考 / 校验", text_color=C_ACCENT,
                         font=ctk.CTkFont(family=FONT_FAMILY, size=15, weight="bold")
                         ).pack(pady=(8, 4), anchor="w")

            tb = ctk.CTkTextbox(rf, fg_color=C_FRAME, text_color=C_FG,
                                font=ctk.CTkFont(family=FONT_FAMILY, size=11), wrap="word",
                                corner_radius=CORNER)
            tb.pack(fill=tk.BOTH, expand=True, padx=8, pady=4)

            bar = ctk.CTkFrame(rf, fg_color="transparent", corner_radius=CORNER)
            bar.pack(fill=tk.X, padx=8, pady=4)
            ctk.CTkButton(bar, text="运行完整校验", width=150, corner_radius=CORNER,
                          command=self.cmd_validate, fg_color=C_WARN, hover_color=HOVER_WARN,
                          text_color="#ffffff", font=ctk.CTkFont(family=FONT_FAMILY, size=12, weight="bold")
                          ).pack(side=tk.LEFT, padx=4)

            self.ref_frame = rf
            self.ref_textbox = tb

        self.ref_frame.pack(fill=tk.BOTH, expand=True, padx=4, pady=4)
        self._populate_ref_panel()

    def _populate_ref_panel(self) -> None:
        if self.ref_textbox is None:
            return
        lines = ""

        if self.save:
            s = self.save.summary()
            lines += "【存档概览】\n"
            for k, v in s.items():
                lines += f"  {k}: {v}\n"
        else:
            lines += "未打开存档。\n"

        st = self.refdata.get("stats", {})
        lines += "\n【参考库统计】\n"
        lines += (f"  权威装备属性: "
                  f"{len(self.refdata.get('equip_attrs', {}))} 条\n")
        total = st.get("total", 0)
        lines += (f"  代码目录: {total}"
                  f" (实测 {st.get('save_verified', 0)}"
                  f" / 参考 {st.get('catalog_only', 0)})\n")
        lines += (f"  合成配方: {len(self.refdata.get('recipes', []))}"
                  f"   掉落: {len(self.refdata.get('drops', []))}\n")

        self.ref_textbox.delete("0.0", tk.END)
        self.ref_textbox.insert("0.0", lines)

    def _show_item_detail(self, item: list) -> None:
        """生成物品详情文本，写入参考面板（若处于参考页则更新）。"""
        if len(item) < 7:
            return
        code = item[2].strip()
        name = item[1].strip()

        txt = (f"【{name}】\n"
               f"代码: {code}   "
               f"槽位: {SLOT_CODES.get(item[3], item[3])}\n"
               f"角色: {item[4] or '无'}   "
               f"品质: {item[5]}   颜色: {item[6]}\n"
               f"数量: {item[22] if len(item) > 22 else '?'}\n\n")

        cat = self.refdata.get("code_catalog", {}).get(code)
        if cat:
            tag = ("存档实测(可靠)" if cat.get("source") == "save"
                   else "三方参考(仅供参考)")
            txt += f"代码状态: {tag}\n"
        else:
            txt += "代码状态: ⚠ 不在参考库\n"

        # 权威属性
        ea = self.refdata.get("equip_attrs", {}).get(name)
        if ea:
            txt += "\n【权威基础属性(xlsx)】\n"
            for k in ("生命", "魔法", "攻击", "防御", "暴击", "闪避",
                      "回血", "回蓝", "吸血", "魔抗", "命中", "泣血",
                      "强化后增加属性", "描述"):
                if k in ea and ea[k]:
                    txt += f"  {k}: {ea[k]}\n"

            # 强化加成详情
            enh_bonus = parse_enhancement_bonus(
                ea.get("强化后增加属性", ""))
            if enh_bonus:
                cur_lv = int(item[23]) if (len(item) > 23
                                              and item[23].isdigit()) else 0
                txt += "\n【强化加成(每级)】\n"
                for attr, per_lv in enh_bonus.items():
                    total = per_lv * cur_lv
                    txt += f"  {attr}: +{per_lv}/级 "
                    txt += f"(Lv{cur_lv} → +{total})\n"

        # 合成配方
        recipes = [r for r in self.refdata.get("recipes", [])
                   if r["result"] == name or name in (r["a"], r["b"], r["c"])]
        if recipes:
            txt += "\n【合成配方】\n"
            for r in recipes:
                txt += f"  {r['a']} + {r['b']} + {r['c']} → {r['result']}\n"

        # 输出到参考面板（如果在参考页则同步显示）
        if self.ref_textbox is not None:
            self.ref_textbox.delete("0.0", tk.END)
            self.ref_textbox.insert("0.0", txt)
