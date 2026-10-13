# ui — 界面层（清新简约 · Mint 风格）

基于 **CustomTkinter + tksheet** 的图形界面。采用 **Mixin 组合** 模式：`EditorApp`
继承多个 `*PageMixin`，把原先集中在一个巨型类里的各页面逻辑按职责拆分到独立文件，
各自只关心自己那一块 UI 与交互，公共窗口/文件操作留在 `app.py`。

## 依赖方向
```
ui.app            ──► core, data.* , ui.theme, 各 *PageMixin
ui.theme          ──► （仅常量，供全局复用）
ui.global_page    ──► core, data, ui.theme
ui.bag_page       ──► core, data, ui.theme
ui.add_item_dialog──► core, data, ui.theme
ui.ref_page       ──► core, data, ui.theme
ui.enhance_page   ──► core, data, ui.theme
```
> 各 `*PageMixin` 之间**互不 import**，仅通过 `EditorApp` 共享状态（`self.save` /
> `self.items` / `self.active_bag` 等），因此不存在循环依赖。
> `EditorApp` 的继承链为 `GlobalPageMixin, BagPageMixin, AddItemDialogMixin,
> RefPageMixin, EnhancePageMixin`（共 5 个 Mixin）。

## 模块清单

| 文件 | 职责 |
| --- | --- |
| `theme.py` | **清新简约(Mint)主题**：薄荷浅底 `#eef6f4`、青绿强调 `#1fa98e`、天蓝次强调 `#43b3e0`、圆角 `CORNER=18`、悬停色与 `apply_theme()` 统一应用函数。改色/换肤只动这里。 |
| `app.py` | `EditorApp` 主窗口：顶栏、导航、状态栏、文件打开/保存、`_roundtrip_check`、`validate`、`main()` 入口；并负责在打开存档后调用 `_load_active_bag()` → `_rebuild_sheet()`。 |
| `global_page.py` | `GlobalPageMixin`：全局属性（角色等级等）表单的切换、填充、应用。 |
| `bag_page.py` | `BagPageMixin`：背包表格工作区、加载当前背包到 `self.items`、按 `self.items` 重绘表格（**只渲染不回写**）、颜色高亮、单元格编辑、行选中、删除、刷新回写。 |
| `add_item_dialog.py` | `AddItemDialogMixin`：按代码/名称搜索添加物品的弹窗与 `_add_item_by_code`。 |
| `ref_page.py` | `RefPageMixin`：参考/校验页，物品详情与参考库统计展示。 |
| `enhance_page.py` | `EnhancePageMixin`：强化页面，强化等级选择(+1/+5/MAX)、目标预览、应用（写入第 14 字段 `强化等级` 并按加成重算 7~13 基础属性）。 |

## `__init__.py`
仅含包说明 docstring（UI 包不强制再导出类，统一从 `ui.app` 取 `EditorApp`）。

## 关键设计点
- **渲染与回写分离**：`_load_active_bag()`（模型 → `self.items`）与 `_rebuild_sheet()`
  （`self.items` → 表格）分离，避免在切换/打开背包时把旧 `self.items` 误写回模型
  （这是重构前就存在的隐藏 bug，已在此修正）。
- 所有颜色/圆角集中 `theme.py`，新增控件请复用主题常量，保持风格统一。
