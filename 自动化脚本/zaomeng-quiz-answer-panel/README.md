# 造梦盒子实时答案面板

一个在游戏窗口旁边显示答题参考答案的 Windows 小工具。**仅适用于造梦盒子客户端内《造梦西游5》的“玄女的考验”答题界面。**

你自己选择答案、点击“下一题”，面板持续识别并更新。程序不控制鼠标键盘，不自动点击，不需要答题快捷键。

## 下载使用

前往 [Releases 下载页面](https://github.com/LuneXrgb/zaomeng-quiz-answer-panel/releases/latest)，下载免安装 ZIP，完整解压后运行其中的 `AnswerPanel/AnswerPanel.exe`。

1. 打开造梦盒子和游戏。
2. 打开答案面板，把游戏窗口缩小一点，将两个窗口并排摆放，不要重叠。
3. 在面板下拉框选择造梦盒子窗口；没找到时点击“刷新”。
4. 点击一次“开始显示答案”，然后在游戏中正常答题。
5. 自己选择选项、点击下一题；面板会继续更新，下一轮也不需要重置。

面板默认置顶，可以取消勾选。需要停止时点击“暂停”。请保留程序旁边的 `_internal` 文件夹，不要单独复制 EXE。

完整操作步骤及常见问题见 [使用说明](docs/使用说明.md)。

## 答案提示

| 显示内容 | 含义 |
| --- | --- |
| 第几项 + 答案 | 题干匹配，答案能唯一对应一个识别到的选项 |
| 题库参考 + 答案 | 题干匹配，但选项不完整、位置不确定或清晰度不足，请按文字核对 |
| 请人工核对 | 题干未可靠匹配，可能是问法差异、新题或识别错误 |
| 等待题目 | 正在换题、未进入题目页或暂时没有读清，会继续重试 |

识别有延迟。选择之前，请确认面板里的题号、题干与游戏当前题目一致。

## 支持范围与限制

- 适配依据为造梦盒子 **1.8.1** 的实际答题截图；不支持浏览器网页、其他客户端或其他游戏。
- 其他造梦盒子版本没有逐个测试；字体、卷轴布局或显示尺寸发生明显变化时可能需要适配。
- 游戏窗口不能最小化、移到屏幕外或被其他窗口遮住；只切换窗口焦点不会停止识别。
- 内置 172 条题库，来自提供的问答文档。并不保证覆盖全部新题，也未逐题核验所有游戏版本中的答案。
- 所有识别在本机完成，无需账号或联网查答案；程序不上传图片，也不自动保存游戏截图。
- 不调用游戏内部接口，不修改游戏数据。

## 1.3 版修复

- 2026-09-08 题库修正：“善见城中何人可以分解宝石？”答案由“黑市商人”改为用户确认的“珍宝商人”，并通过当前游戏截图验证。已下载旧包的用户请重新下载并完整解压，关闭旧面板后打开新版。
- 单个数字选项被文字检测漏掉时，对该行进行单独识别。
- 选项未识别完整时，仍显示已匹配题目的参考答案。
- 将已确认的“宠物转生要找哪个接引人？”与“宠物转生要找哪个NPC？”对应，答案为“公冶灵儿”。
- 仅接受题库明确记录的等价问法；相近题只给人工核对提示，不直接认定为同题。

## 从源码运行

开发环境：Windows 10/11 x64、Python 3.12（需要 Tkinter）。

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe app.py
```

运行测试：

```powershell
.\.venv\Scripts\python.exe test_panel.py
```

测试包括题库及选项换序、已确认问法、否定问题区分、数字含义保留、暂停后的结果丢弃，以及换题和新一轮后的持续识别。

离线测试一张截图（建议裁剪到游戏窗口）：

```powershell
.\.venv\Scripts\python.exe app.py --image "截图.png" --report "识别结果.json"
```

## 打包

安装依赖后，在已启用虚拟环境的 PowerShell 中运行 `build.ps1`，或者直接执行：

```powershell
.\.venv\Scripts\python.exe -m PyInstaller --noconfirm --windowed --onedir --name AnswerPanel --add-data "questions.json;." --collect-data rapidocr_onnxruntime --collect-binaries onnxruntime app.py
```

成品位于 `dist/AnswerPanel`。分发时保留整个文件夹，并附上依赖组件的许可说明；现成下载包已包含第三方许可证。

## 主要文件

| 文件 | 用途 |
| --- | --- |
| `app.py` | 答案面板、持续识别和状态显示 |
| `window_capture.py` | 只读窗口查找与截图 |
| `quiz_core.py` | 卷轴定位、文字识别、题库匹配 |
| `questions.json` | 题库及已确认的等价问法 |
| `test_panel.py` | 匹配和持续识别逻辑测试 |
| `requirements.txt` | 构建版本使用的依赖清单 |

文字识别使用 [RapidOCR](https://github.com/RapidAI/RapidOCR)，推理由 ONNX Runtime 在本机完成，程序使用 PyInstaller 打包。
