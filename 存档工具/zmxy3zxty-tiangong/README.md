# 造梦西游再续天庭篇 存档编辑器（天工）

图形化存档编辑器，基于 CustomTkinter + tksheet 构建，可直接打开加密的 `.sav` 存档，在可视化界面中编辑角色属性、背包物品、强化与合成，校验后保存回游戏。

---

## 关于《造梦西游3 再续天庭篇》

> **再续天庭启凌霄，共赴前缘续新篇**

《造梦西游3 再续天庭篇》是经典 Flash 游戏《造梦西游 3》的高质量同人改版，由多位社区大佬持续开发与维护 
该改版在《造梦西游 3》的基础上新增了大量原创剧情、角色、副本与装备系统，包括截教、三霄、不周山等全新关卡，是造梦同人圈中热度极高的作品。

## 一、原理与编解码

### 1.1 存档编解码流水线

再续天庭篇的存档经过 **4 层编码/加密**，完整流水线如下：

```
.sav 文件 (文本)
  ↓ ① 自定义 Base64 解码
二进制数据
  ↓ ② XOR 0x5A 逐字节异或解密
解密后数据
  ↓ ③ Zlib 解压 (可能 1~2 轮，自动探测)
AMF3 包装数据
  ↓ ④ 剥离 AMF3 String 包装 (4字节头)
XML 明文
```

### 1.2 物品数据模型

存档中的物品以 **`|` 分隔字段、`}` 分隔记录**，每条记录即一个长度为 **28** 的字段数组。关键字段如下：

| 索引 | 含义 | 类型 |
|------|------|------|
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
| 22 | 数量 | int |

四类背包映射到 XML 节点字段：

| 界面标签 | XML 字段 |
|----------|----------|
| 背包装备 | `bagSaveString` |
| 已装备 | `curSaveString` |
| 道具材料 | `bagdjSaveString` |
| 时装 | `bagszSaveString` |

### 1.3 物品记录结构

一条「背包装备」记录示例（字段以 `|` 分隔）：

```
5|天罪|xltz|zbwq|八戒|邪灵|0x666666|1000|240|...|1|0|...|1
```

其中 **第 23 列（索引 22）为物品数量**；颜色字段规范格式为 `0xRRGGBB`。编辑器在保存时会执行往返编解码自检，确保写回的 `.sav` 可被游戏正常读取。

---

## 二、使用方法

### 2.1 EXE 直接使用（无需 Python 环境）

1. 从 [Releases](https://github.com) 页面下载 `天工.exe` ，或按 [2.3](#23-从源码打包为-exe) 自行打包
2. 双击运行，打开图形化编辑器界面
3. 点击「打开存档」选择 `.sav` 文件（或拖拽文件到窗口，需 `tkinterdnd2` 支持）
4. 在分类页（全局属性 / 背包 / 强化 / 参考校验）中编辑数据
5. 点击「保存」，编辑器会校验并写回存档（**建议先备份原存档**）

> **注意**: 仓库默认不含打包好的 `dist/` 二进制；请从 Releases 获取，或按 2.3 自行构建。

### 2.2 源码运行

```bash
pip install customtkinter tksheet tkinterdnd2
cd save_editor
python src/main.py
```

> **注意**: `tkinterdnd2` 为可选依赖（文件拖拽）；缺失时拖拽功能自动禁用，不影响其余编辑功能。

### 2.3 从源码打包为 EXE

```bash
pip install pyinstaller customtkinter tksheet tkinterdnd2 openpyxl
cd save_editor
build.bat
```

或使用 `pyinstaller` 直接打包（配置见 `zmxy_save_editor.spec`）：

```bash
cd save_editor
pyinstaller --onefile --windowed --name "天工" ^
  --icon "src/assets/icon.ico" ^
  --add-data "src/assets/refdata.json;assets" ^
  --add-data "src/assets/icon.ico;assets" ^
  "src/main.py"
```

输出文件在 `save_editor/dist/` 目录下。

### 2.4 自动化测试

仓库内置示例存档 `sample_saves/0.sav`（与 `completed_saves/0.sav` 相同），测试套件基于此运行：

```bash
cd save_editor
pip install customtkinter tksheet tkinterdnd2

python tests/test_all.py                 # 综合：加载+强化+合成+过滤+参考+校验+删除+常量
python tests/smoke_test.py               # 冒烟：打开→添加→删除→校验
python tests/test_roundtrip.py           # 往返编解码一致性
python tests/test_full_functionality.py # 全功能流程
```

> **注意**: 测试会短路 GUI 主循环，无需显示窗口，不会弹窗阻塞。

---

## 三、致谢

### 致谢

- **游戏作者** — 感谢制作《造梦西游3 再续天庭篇》的各位大佬的持续开发与维护，为大家带来如此优秀的同人作品。

---

## 目录结构

```
zmxy3zxty-tiangong/
├── save_editor/          # 应用源码
│   ├── src/              # 编解码核心 + 数据模型 + UI + 工具
│   ├── tests/            # 自动化测试（基于 sample_saves / completed_saves）
│   ├── build.bat         # 打包脚本
│   └── README.md         # 详细开发文档（架构 / 算法 / 校验）
├── sample_saves/         # 示例存档（含 0.sav）
├── completed_saves/      # 测试用存档集合（含 0.sav）
└── README.md
```

> 重新生成参考库 `src/assets/refdata.json` 需要原始 `equip_data/`（装备属性表与物品代码表）及更多样本存档，本仓库未包含这些原始素材；仓库内已附带一份可用的 `refdata.json`。

---

## License

MIT License

---

*天工 · 造梦西游3 再续天庭篇 存档编辑器*
