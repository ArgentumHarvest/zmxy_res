# save_editor —— 可视化存档编辑器

《造梦西游3 再续天庭篇》图形化存档编辑器。基于 **CustomTkinter + tksheet** 构建界面，
采用**温暖活泼（方案 3）**视觉风格（奶油底 `#fff8f0` + 珊瑚橙 `#ff7a59` + 圆角卡片），
编解码与数据规则由 `src/core/` `src/data/` 提供，参考数据来自 `src/assets/refdata.json`。

---

## 目录

- [技术栈](#技术栈)
- [运行与构建](#运行与构建)
- [代码结构与职责](#代码结构与职责)
- [核心数据模型](#核心数据模型)
- [关键算法](#关键算法)
- [校验引擎](#校验引擎)
- [测试](#测试)
- [已知约定 / 注意事项](#已知约定--注意事项)

> 各子包（core / data / ui / utils）均有独立 `README.md` 详述内部模块与依赖方向，
> 本文档聚焦整体结构与对外契约。

---

## 技术栈

| 组件 | 用途 |
| --- | --- |
| `customtkinter` | 现代化 Tk 界面（方案 3 暖色主题，见 `src/ui/theme.py`） |
| `tksheet` | 高性能表格（背包编辑，单元格编辑需 `enable_bindings("edit_cell")` 开启） |
| `tkinterdnd2` | 文件拖拽支持（非强制，缺失则自动降级） |
| `openpyxl` | 读取 xlsx 装备属性表（仅构建期 `src/config/build_refdata.py` 需要） |
| `pyinstaller` | 打包为单文件 exe |

---

## 运行与构建

```bash
pip install customtkinter tksheet pyinstaller openpyxl tkinterdnd2

python src/main.py                              # 源码运行（入口 main.py → ui.app.main）
python src/config/build_refdata.py              # 重建 src/assets/refdata.json
build.bat                                       # 打包（或 pyinstaller 同名 .spec）
```

- **运行入口**：`src/main.py` → `from ui.app import main; main()`（窗口由 `EditorApp` 承载）。
- **打包产物**：`dist/造梦西游3再续天庭篇存档编辑器.exe`（onefile、windowed、内嵌 `refdata.json` 与 `icon.ico`）。
- **打包环境提示**：沙箱清理阶段会被 `sitecustomize.py` 拦截 `os.remove`，需先设
  `CODEBUDDY_SAFE_DELETE_SANDBOX=0` 再运行 `build.bat` / `pyinstaller`。

---

## 代码结构与职责

重构后代码按**功能模块拆分到独立子包**，每个包职责单一、命名清晰、依赖方向无环：
`utils` ← `core`/`data` ← `ui`（详见各包内 `README.md`）。

```
save_editor/
├── src/                      # 项目源码目录
│   ├── main.py               #   入口：from ui.app import main; main()
│   ├── core/                 #   核心逻辑层（纯逻辑，无 UI）
│   │   ├── constants.py      #     全部静态配置：密钥/字段定义/枚举/过滤
│   │   ├── codec.py          #     SAV↔XML 编解码
│   │   └── models.py         #     SaveFile 对象模型 + load/save
│   ├── data/                 #   数据模型层（物品/强化/合成/参考库规则）
│   │   ├── common.py         #     共享小工具（属性值解析）
│   │   ├── items.py          #     物品 28 字段解析/序列化/模板
│   │   ├── enhancement.py    #     强化系统解析与叠加
│   │   ├── synthesis.py      #     合成装备默认值计算
│   │   └── refdata.py        #     参考库加载
│   ├── ui/                   #   界面层（方案 3 暖色主题 + Mixin 组合）
│   │   ├── theme.py          #     主题常量与 apply_theme()
│   │   ├── app.py            #     EditorApp 主窗口 + main() 入口
│   │   ├── global_page.py    #     全局属性页 Mixin
│   │   ├── bag_page.py       #     背包表格页 Mixin
│   │   ├── add_item_dialog.py #    按代码添加物品弹窗 Mixin
│   │   ├── ref_page.py       #     参考/校验页 Mixin
│   │   └── enhance_page.py   #     强化页面 Mixin
│   ├── utils/                #   工具函数层（零业务依赖）
│   │   ├── amf.py            #     AMF3 U29 变长整数编解码
│   │   └── color.py          #     颜色字符串/亮度工具
│   ├── config/               #   构建与维护脚本
│   │   ├── build_refdata.py  #     由 xlsx + 代码表 + 样本存档 生成 refdata.json
│   │   └── hook-tkinterdnd2.py #   PyInstaller 钩子（可选依赖）
│   └── assets/               #   运行时资源文件
│       ├── refdata.json      #     参考数据库
│       └── icon.ico          #     窗口图标
├── tests/                    # 自动化测试（GUI 主循环已短路）
│   ├── test_all.py
│   ├── smoke_test.py
│   ├── test_roundtrip.py
│   ├── test_editor_logic.py
│   ├── test_fixes.py
│   ├── test_full_functionality.py
│   └── test_edit_real.py
├── dist/                     # 打包输出目录（PyInstaller 生成 exe）
├── README.md
├── build.bat                 # 打包脚本（pyinstaller 封装）
└── zmxy_save_editor.spec  # PyInstaller 打包配置
```

### 架构要点

- **页面切换**：`EditorApp` 继承 5 个 `*PageMixin` 组合各页面逻辑 ——
  `GlobalPageMixin` / `BagPageMixin` / `AddItemDialogMixin` / `RefPageMixin` /
  `EnhancePageMixin`。各 Mixin 分散到对应文件，互不 import，仅通过 `EditorApp` 共享
  `self.save` / `self.items` / `self.active_bag` 等状态，无循环依赖。
- **渲染与回写分离**（重构关键修复）：
  - `_load_active_bag()`：模型 → `self.items`（在打开存档 / 切换背包时调用）。
  - `_rebuild_sheet()`：`self.items` → 表格渲染（**只渲染、不回写、不重读**）。
  - `_flush_current_bag()`：编辑后写回模型（删除 / 添加 / 刷新时显式调用）。
  > 旧版 `_rebuild_sheet` 会先回写再重读，导致切换背包时把上一背包的 `self.items`
  > 误写覆盖新背包数据——该隐藏 bug 已随拆分一并修正。

---

## 核心数据模型

### 物品 = 28 字段列表

整包字符串由多条**物品记录**以 `}` 拼接而成，每条记录内字段以 `|` 分隔；因此
**一个物品 = 一段 `}` 分隔记录 = 一个长度为 28 的字段数组**（索引从 0 起）。
可见列见 `core.constants.VISIBLE_FIELDS = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,22]`。
完整字段定义见 `core.constants.ITEM_FIELDS`，关键映射：

| 索引 | 含义 | 类型 |
| --- | --- | --- |
| 0 | 品级 | text |
| 1 | 名称 | text |
| 2 | 代码 | text |
| 3 | 槽位 (`zbwq/zbfj/zbsp/zbfb/zbwp/zbsz/zbtx`) | text |
| 4 | 角色限制 | text |
| 5 | 品质 | text |
| 6 | 颜色 (`0xRRGGBB`) | text |
| 7 | 生命 | num |
| 8 | 魔法 | num |
| 9 | 攻击 | num |
| 10 | 防御 | num |
| 11 | 暴击 | num |
| 12 | 闪避% | float |
| 13 | 回血 | num |
| 14 | 强化等级 | int |
| 15–19 | 法宝成长 1–5 | bool |
| 20 | 成长值1 | num |
| 21 | 成长倍率 | float |
| 22 | 数量 | int |
| 23–27 | 保留/未知字段 | num/float |

### 四类背包

`core.constants.BAG_FIELDS` 将界面分类映射到 XML 节点字段名：

| 界面标签 | XML 字段 |
| --- | --- |
| 背包装备 | `bagSaveString` |
| 已装备 | `curSaveString` |
| 道具材料 | `bagdjSaveString` |
| 时装 | `bagszSaveString` |

各分类有对应的**槽位过滤**（`BAG_SLOT_FILTERS`），添加物品时按当前背包自动过滤可选代码。

### `SaveFile` 对象模型（`core/models.py`）

- `load_save(path)` / `save_save(sf, out_path)`：文件级读写。
- `get_scalar(name)` / `set_scalar(name, value, typ)`：读写 XML 标量字段（如 `username`、`curLevel`、`lhValue`）。
- `get_bag(xml_field)` / `set_bag(xml_field, items)`：读写某背包物品列表。
- `get_player_obj(index)`：取 `playerN_obj` 节点。
- `to_sav_string()` / `summary()`：序列化与概览。

---

## 关键算法

- **编解码** (`core.codec.decode_sav` / `encode_sav`)：自定义 Base64 → XOR `0x5A` → zlib（多层）→ AMF3 头剥离/重构。
- **属性值解析** (`data.common._parse_attr_val`)：浮动值 `35+5` 取最大值 `40`；非数值返回 `None`。
- **强化系统** (`data.enhancement.parse_enhancement_bonus` / `apply_enhancement`)：解析「强化后增加属性」文本（如 `防御+4`），按等级 0~10 线性叠加到基础属性。
- **合成默认值** (`data.synthesis.calc_synthetic_defaults`)：对 `地藏戒/地藏金戒/花宴/命定·花宴` 按配方 + 组件 +7 强化属性之和的 2/3 估算合成后属性（需 `refdata.json` 提供组件属性）。
- **物品模板** (`data.items.new_item_template`)：按代码目录 + 权威属性表生成 28 字段新物品，可带强化等级。

---

## 校验引擎

`ui.app.EditorApp.validate()` 返回 `(errors, warnings)`：

- **错误**：未打开存档、字段数不足、缺代码、数值字段非法、数量 < 1、数量非整数。
- **警告**：等级超范围(1~300)、灵魂值为负、代码不在参考库、数量过大、颜色格式异常。

保存时强制拦截错误，存在警告时弹窗二次确认；保存后执行往返编解码自检。

---

## 测试

测试位于 `tests/`，会短路 `tk.Tk.mainloop` 以避免弹窗阻塞，直接驱动真实方法：

```bash
python tests/test_all.py                # 综合：加载+强化+合成+过滤+参考+校验+删除+常量
python tests/smoke_test.py              # 冒烟：打开→添加→删除→校验
python tests/test_roundtrip.py          # 往返编解码一致性（11 个 .sav）
python tests/test_editor_logic.py       # 物品模板/全局等级/校验
python tests/test_fixes.py              # 历史 bug 回归
python tests/test_full_functionality.py # 全功能：打开/全局/背包切换编辑删除添加/强化/参考校验/保存
python tests/test_edit_real.py          # 真实编辑流程：select→open→set→close 验证单元格可编辑
```

| 测试 | 覆盖点 |
| --- | --- |
| `test_all.py` | 端到端：存档加载、强化、合成、背包过滤、参考/校验、删除、常量 API |
| `smoke_test.py` | 打开存档 → 按代码添加 → 删除 → 校验，快速确认主流程不崩 |
| `test_roundtrip.py` | `decode_sav` / `encode_sav` 往返一致性与背包数量一致性（11 个 `.sav`） |
| `test_editor_logic.py` | 物品模板字段、全局等级写入、权威属性表校验 |
| `test_fixes.py` | 历史修复回归：校验提示含物品名、删除依赖 `last_selected_row`、刷新状态反馈 |
| `test_full_functionality.py` | 10 个功能模块逐项验证（含强化页面、参考校验页、保存往返） |
| `test_edit_real.py` | 忠实复现真实编辑路径（`enable_bindings("edit_cell")` + 打开/设值/关闭编辑框），确认真实可编辑 |

---

## 已知约定 / 注意事项

- 参考库 `refdata.json` 来自 xlsx + 样本存档，**非游戏全量数据**；标记为 `source: save`（实测）的代码比纯三方参考更可靠。
- 颜色字段规范格式为 `0xRRGGBB`（8 位十六进制），否则校验告警（但通常仍可正常载入）。
- 不同样本存档的 zlib 层数不同，编辑器解码时自动探测（`SaveFile.zlib_passes`），回写时使用相同层数。
- `tkinterdnd2` 为可选依赖：缺失时拖拽功能自动禁用，不影响其余功能。
- 各包主题/配色集中在 `src/ui/theme.py`，改版换肤只动该文件。
- tksheet 单元格编辑需在 `enable_bindings` 中显式启用 `"edit_cell"`（非旧版 `"editable"`），
  并配 `extra_bindings([("edit_cell", fn)])` 注册回调——二者缺一不可。
