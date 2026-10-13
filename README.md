# 造梦西游资源合集 (zmxy_res)

本仓库收集了造梦西游系列游戏的素材、源码及相关工具，并对所有 SWF 文件进行了反编译提取。

## 仓库结构

```
├── SWF反编译/              # 从SWF文件中反编译提取的内容
│   ├── AS3源码/            # ActionScript 3 源代码 (2,757个.as文件)
│   ├── 图片素材/           # PNG/JPG图片 (9,444个文件，含精灵帧)
│   ├── 矢量图形/           # SVG矢量形状 (2,443个.svg文件)
│   ├── 音频素材/           # MP3/WAV音频 (28个文件)
│   ├── 字体/               # TTF字体文件 (6个)
│   ├── 文本/               # 文本资源 (17个)
│   └── 二进制数据/         # 二进制数据 (2个)
├── SWF原始文件/            # 98个唯一SWF原始文件
├── 工具/                   # 反编译工具和实用程序
│   ├── ffdec_15.0.0/       # JPEXS Free Flash Decompiler
│   ├── ZaoMengFlashCracker/ # 造3加密SWF文件处理器
│   └── ZaoMengSavesAnalyser/ # 造3游戏存档转换器
├── 源仓库镜像/             # 原始资源仓库的镜像
│   ├── 造梦西游OL/         # 4399小游戏全套资源素材
│   ├── 造梦西游魔改版/     # 魔改版游戏文件和存档
│   └── docs/              # 文档资料
├── Phaser3重写版/          # Phaser3+TypeScript重写版源码
│   ├── src/               # TypeScript源代码 (483个文件)
│   ├── public/assets/     # 游戏素材资源
│   ├── docs/              # 开发文档
│   └── tools/             # 开发工具
├── 存档工具/              # 存档相关工具
├── 文档资料/              # 项目文档
└── 自动化脚本/            # 自动化脚本
```

## 数据来源

| 来源仓库 | 描述 | 大小 |
|---------|------|------|
| [zmcj21/zmxy_res](https://github.com/zmcj21/zmxy_res) | 造梦西游资源主仓库 | 360MB |
| [ministove/zaomeng3-swf](https://github.com/ministove/zaomeng3-swf) | 造梦3 SWF文件 | 17MB |
| [jbji/ZaoMeng_JourneyToTheWest_3_4399_Flash_Utility](https://github.com/jbji/ZaoMeng_JourneyToTheWest_3_4399_Flash_Utility) | SWF加密处理器和存档分析器 | 3MB |
| [kagami-kasumi/zaomengxiyou3-zaixutiantingpian-phaser-version](https://github.com/kagami-kasumi/zaomengxiyou3-zaixutiantingpian-phaser-version) | Phaser3+TS重写版 | 572MB |

## SWF反编译

使用 JPEXS Free Flash Decompiler (ffdec) v15.0.0 对所有 SWF 文件进行反编译，提取了：

- **AS3 ActionScript 源码**: 2,757 个 .as 文件
- **图片素材**: 9,444 个 PNG/JPG 文件（含精灵帧导出）
- **矢量图形**: 2,443 个 SVG 文件
- **音频**: 28 个 MP3/WAV 文件
- **字体**: 6 个 TTF 文件
- **文本**: 17 个文本文件
- **二进制数据**: 2 个文件

## 工具说明

### ffdec (JPEXS Free Flash Decompiler)
用于 SWF 文件反编译，提取源码和素材。

### ZaoMengFlashCracker
造梦西游3加密SWF文件处理器，按字节交换处理被文件头屏蔽的SWF文件。
- 造梦3参数: MY_PIVOT = 200, MY_END = 275
- 造梦2参数: MY_PIVOT = 96, MY_END = 165

### ZaoMengSavesAnalyser
造梦西游3游戏存档转换器，支持将存档转换为XML格式及反向操作。

## 许可证

各子目录的许可证请参考对应源仓库的许可证声明。
