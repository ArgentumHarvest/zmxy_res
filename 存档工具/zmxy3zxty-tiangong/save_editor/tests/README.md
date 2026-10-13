# tests — 测试套件

用受管 venv（`python -m venv` 隔离，含 `customtkinter` / `tksheet` / `tkinterdnd2`）
运行的验证脚本。**GUI 主循环已被短路**（`tk.Tk.mainloop = lambda ...`），因此测试
不真正弹窗，可在无显示环境下跑。

## 运行方式
```bash
# 在 save_editor/ 目录下，使用含 GUI 依赖的 venv
python tests/test_all.py                # 最全面：加载+强化+合成+过滤+参考+校验+删除+常量
python tests/smoke_test.py              # 冒烟：打开→添加→删除→校验
python tests/test_roundtrip.py          # 编解码往返：11 个样本存档
python tests/test_editor_logic.py       # 物品模板/全局等级/校验
python tests/test_fixes.py              # 历史 bug 回归
python tests/test_full_functionality.py # 全功能：打开/全局/背包切换编辑删除添加/强化/参考校验/保存
python tests/test_edit_real.py          # 真实编辑流程：select→open→set→close 验证单元格可编辑
python tests/test_new_features.py       # 本次优化配套：中文右键菜单/强化弹窗/已装备隐藏按钮/刷新还原/类型品质筛选排序/称号支持/拖拽解析/窗口钳制
```

## 文件说明
| 文件 | 覆盖点 |
| --- | --- |
| `test_all.py` | 端到端：存档加载、强化系统、合成默认值、背包分类过滤、参考/校验页、删除、常量 API 完整性。 |
| `smoke_test.py` | 打开存档 → 按代码添加 → 删除 → 校验，快速确认主流程不崩。 |
| `test_roundtrip.py` | `decode_sav` / `encode_sav` 往返一致性与背包数量一致性（11 个 `.sav`）。 |
| `test_editor_logic.py` | 物品模板字段、全局等级写入、权威属性表校验。 |
| `test_fixes.py` | 校验提示含物品名、删除依赖 `last_selected_row`、刷新状态反馈等历史修复回归。 |
| `test_full_functionality.py` | 10 个功能模块逐项验证：打开存档、全局属性、背包切换/编辑/删除/添加、强化页面、参考校验页、校验引擎、保存往返。 |
| `test_edit_real.py` | 忠实复现真实编辑路径（`enable_bindings("edit_cell")` + `open_text_editor`→`set_text`→`close_text_editor`），确认单元格编辑框可打开、回调触发、表格更新。 |
| `test_new_features.py` | 本次优化配套：中文右键菜单标签、强化弹窗入口（右键/按钮）、已装备页签隐藏添加/删除按钮、刷新还原未保存编辑、添加对话框类型/品质筛选与按类型→品质排序、称号类物品支持、拖拽路径解析与加载、窗口尺寸钳制居中。 |

## 约定
- 新增功能请配套最小测试；涉及 UI 交互的测试通过调用 `_switch_to_*` / `_cmd_*` 等
  下划线前缀的“受保护方法”驱动，避免依赖真实鼠标事件。
- 测试只 import `core` / `data` / `ui`，**不**引用任何已废弃的根目录旧模块。
