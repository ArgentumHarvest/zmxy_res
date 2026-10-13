"""全局属性页（Mixin）。

职责单一：渲染「全局快速修改」页，管理 10 个标量字段的表单。
作为 Mixin 被 ui.app.EditorApp 继承，方法通过 self 访问共享状态。

依赖: core.constants (GLOBAL_FIELDS), ui.theme (配色/字体/圆角)。
"""
import tkinter as tk
from tkinter import messagebox
import customtkinter as ctk

from core.constants import GLOBAL_FIELDS
from ui.theme import (C_PANEL, C_ACCENT, C_FG, C_SUB, C_ACCENT2, C_ERR,
                     FONT_FAMILY, CORNER, HOVER_ACCENT, C_FRAME, C_NAV_BORDER)


# 角色ID -> (中文名, 主题色)  1悟/2唐/3戒/4沙/5白
_ROLE_INFO = {
    "1": ("悟空", "#1fa98e"),
    "2": ("唐僧", "#43b3e0"),
    "3": ("八戒", "#e0a31a"),
    "4": ("沙僧", "#6f8c84"),
    "5": ("白龙", "#3b6b5e"),
}


def _role_info(roleid) -> tuple:
    """根据角色ID返回 (角色名, 主色)。未知角色回退到通用英雄。"""
    key = str(roleid).strip()
    return _ROLE_INFO.get(key, ("英雄", "#1fa98e"))


class GlobalPageMixin:
    """全局属性页相关方法。"""

    # ────────────────────────────────────
    # ① 全局属性页
    # ────────────────────────────────────
    def _switch_to_global(self) -> None:
        self._hide_all_pages()
        self.active_page = "global"
        # 关键：离开背包页时必须同步重置 active_bag。否则它仍保留上一个背包标签，
        # 后续保存时 _flush_current_bag 会按旧的 active_bag 把空/过期的 self.items
        # 写回该背包，造成背包装备被清空。
        self.active_bag = "global"
        self._highlight_nav("全局属性")

        if self.global_frame is None:
            gf = ctk.CTkScrollableFrame(self.center, fg_color=C_PANEL,
                                        corner_radius=CORNER)
            # 角色卡头（头像 + 名称/角色 + 关键数值）
            self._build_role_header(gf)

            # 表单卡片（10 个全局字段）
            form = ctk.CTkFrame(gf, fg_color=C_PANEL, corner_radius=CORNER,
                                border_width=1, border_color=C_NAV_BORDER)
            form.pack(fill=tk.X, padx=8, pady=8)
            grid = ctk.CTkFrame(form, fg_color="transparent")
            grid.pack(fill=tk.X, padx=8, pady=8)
            grid.columnconfigure(0, weight=1)
            grid.columnconfigure(1, weight=1)

            for r_idx, (key, label, typ) in enumerate(GLOBAL_FIELDS):
                ctk.CTkLabel(grid, text=label, text_color=C_FG
                             ).grid(row=r_idx, column=0, sticky="w",
                                    padx=6, pady=5)
                entry = ctk.CTkEntry(grid, width=180,
                                     font=ctk.CTkFont(family=FONT_FAMILY, size=12))
                entry.grid(row=r_idx, column=1, sticky="w", padx=6, pady=5)
                self.global_entries[key] = (entry, typ)

            ctk.CTkButton(gf, text="应用到存档", corner_radius=CORNER,
                          command=self._apply_global,
                          fg_color=C_ACCENT, hover_color=HOVER_ACCENT,
                          text_color="#ffffff", font=ctk.CTkFont(family=FONT_FAMILY, size=13, weight="bold")
                          ).pack(pady=12)
            self.global_frame = gf

        self.global_frame.pack(fill=tk.BOTH, expand=True, padx=4, pady=4)
        self._populate_global_form()

    # ── 角色卡头 ──
    def _build_role_header(self, parent) -> None:
        card = ctk.CTkFrame(parent, fg_color=C_FRAME, corner_radius=CORNER)
        card.pack(fill=tk.X, padx=8, pady=(8, 4))

        # 头像色块
        self.role_avatar = ctk.CTkFrame(card, width=56, height=56,
                                        corner_radius=CORNER, fg_color=C_ACCENT)
        self.role_avatar.pack(side=tk.LEFT, padx=12, pady=12)
        self.role_avatar_lbl = ctk.CTkLabel(
            self.role_avatar, text="?", text_color="#ffffff",
            font=ctk.CTkFont(family=FONT_FAMILY, size=22, weight="bold"))
        self.role_avatar_lbl.place(relx=0.5, rely=0.5, anchor="center")

        # 名称 + 角色
        info = ctk.CTkFrame(card, fg_color="transparent")
        info.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=12, pady=10)
        self.role_name_lbl = ctk.CTkLabel(
            info, text="无名英雄", text_color=C_FG,
            font=ctk.CTkFont(family=FONT_FAMILY, size=16, weight="bold"))
        self.role_name_lbl.pack(anchor="w")
        self.role_sub_lbl = ctk.CTkLabel(
            info, text="角色：—", text_color=C_SUB,
            font=ctk.CTkFont(family=FONT_FAMILY, size=12))
        self.role_sub_lbl.pack(anchor="w", pady=(2, 0))

        # 关键数值卡片
        stats = ctk.CTkFrame(card, fg_color="transparent")
        stats.pack(side=tk.RIGHT, padx=12, pady=10)
        self.role_lv_lbl = self._stat_chip(stats, "等级", "0")
        self.role_gold_lbl = self._stat_chip(stats, "灵魂值", "0")

    def _stat_chip(self, parent, label: str, value: str) -> ctk.CTkLabel:
        c = ctk.CTkFrame(parent, fg_color=C_PANEL, corner_radius=CORNER,
                         border_width=1, border_color=C_NAV_BORDER)
        c.pack(side=tk.LEFT, padx=4)
        ctk.CTkLabel(c, text=label, text_color=C_SUB,
                     font=ctk.CTkFont(family=FONT_FAMILY, size=10)
                     ).pack(anchor="w", padx=10, pady=(5, 0))
        vl = ctk.CTkLabel(c, text=value, text_color=C_FG,
                          font=ctk.CTkFont(family=FONT_FAMILY, size=15, weight="bold"))
        vl.pack(anchor="w", padx=10, pady=(0, 5))
        return vl

    def _refresh_role_header(self) -> None:
        if not hasattr(self, "role_name_lbl") or self.save is None:
            return
        uname = self.save.get_scalar("username") or ""
        roleid = self.save.get_scalar("roleid") or ""
        lv = self.save.get_scalar("curLevel") or "0"
        gold = self.save.get_scalar("lhValue") or "0"
        rname, rcolor = _role_info(roleid)
        self.role_name_lbl.configure(text=uname or "无名英雄")
        self.role_sub_lbl.configure(text=f"角色：{rname}")
        self.role_avatar.configure(fg_color=rcolor)
        self.role_avatar_lbl.configure(text=rname[0] if rname else "?")
        self.role_lv_lbl.configure(text=str(lv))
        self.role_gold_lbl.configure(text=str(gold))

    def _populate_global_form(self) -> None:
        if self.save is None:
            return
        for key, (entry, _typ) in self.global_entries.items():
            entry.delete(0, tk.END)
            entry.insert(0, self.save.get_scalar(key) or "")
        self._refresh_role_header()

    def _apply_global(self, silent: bool = False) -> None:
        """将全局属性表单的值写入当前存档。

        事件绑定链路：CTkButton(command=self._apply_global)
                      → _apply_global()
                      → SaveFile.set_scalar() 逐字段写入 XML
        """
        if self.save is None:
            if not silent:
                messagebox.showwarning("未打开存档", "请先打开一个 .sav 存档文件")
            return

        applied = 0
        errors = []
        try:
            for key, (entry, typ) in self.global_entries.items():
                val = entry.get().strip()
                if not val:
                    continue
                if typ == "int":
                    try:
                        val = int(float(val))
                    except ValueError:
                        label = next((l for k, l, _ in GLOBAL_FIELDS if k == key), key)
                        errors.append(f"「{label}」的值「{val}」不是合法整数")
                        continue
                self.save.set_scalar(key, val,
                                      "Number" if typ == "int" else "String")
                applied += 1
            self._refresh_role_header()

            if errors:
                self._set_status(f"部分字段有误（{len(errors)}处）", C_ERR)
                if not silent:
                    messagebox.showerror("应用失败",
                                        "以下字段值不合法，已跳过：\n\n"
                                        + "\n".join(f"• {e}" for e in errors))
            elif applied > 0:
                self._set_status("全局属性已应用", C_ACCENT2)
                if not silent:
                    messagebox.showinfo("应用成功",
                                       f"已成功写入 {applied} 个字段到存档。\n\n"
                                       f"提示：点击「保存存档」后才会持久化到文件。")
            else:
                self._set_status("无需更新（所有字段为空）", C_SUB)

        except Exception as exc:
            self._set_status(f"全局属性应用异常: {exc}", C_ERR)
            if not silent:
                messagebox.showerror("应用异常", f"写入存档时发生错误：\n\n{exc}")
