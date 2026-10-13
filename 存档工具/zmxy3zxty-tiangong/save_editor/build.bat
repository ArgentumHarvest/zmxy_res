@echo off
REM 天工 · 造梦西游3 再续天庭篇 存档编辑器 打包脚本
REM 依赖: pip install customtkinter tksheet pyinstaller openpyxl tkinterdnd2
REM 更新参考库: python src/config/build_refdata.py
REM 说明: 使用 "python -m PyInstaller" 而非裸 pyinstaller 命令，避免 venv 下
REM       Scripts 目录未加入 PATH 导致 "不是内部或外部命令" 的问题。

REM ───────────────────────────────────────────────────────────────
REM 关键修复 1：无论以何种方式(双击 / 在其它目录调用)启动本脚本，
REM 都先切到脚本自身所在目录，保证后续相对路径
REM (src\main.py / src\assets\...) 始终有效。否则从其它目录调用会报
REM "Script file 'src/main.py' does not exist." 导致打包失败。
REM ───────────────────────────────────────────────────────────────
cd /d "%~dp0"

REM ───────────────────────────────────────────────────────────────
REM 关键修复 2：自动补齐缺失的依赖，避免「缺少模块 → 打包产物运行即崩溃」
REM 这类问题。核心依赖为必装项；tkinterdnd2(拖拽)为可选，装不上仅提示警告。
REM ───────────────────────────────────────────────────────────────
set "CORE_DEPS=customtkinter tksheet pyinstaller openpyxl"
python -c "import importlib.util as u,sys; sys.exit(0 if all(u.find_spec(x) for x in ['customtkinter','tksheet','PyInstaller','openpyxl']) else 1)" >nul 2>nul
if errorlevel 1 (
    echo [提示] 检测到缺失的核心依赖，正在自动安装: %CORE_DEPS%
    python -m pip install --upgrade %CORE_DEPS%
    if errorlevel 1 (
        echo [错误] 核心依赖安装失败，请检查网络或手动执行:
        echo        python -m pip install %CORE_DEPS%
        pause
        exit /b 1
    )
)

REM tkinterdnd2 为可选依赖（拖拽功能）；缺失时打包仍继续，仅拖拽不可用。
python -c "import importlib.util as u,sys; sys.exit(0 if u.find_spec('tkinterdnd2') else 1)" >nul 2>nul
if errorlevel 1 (
    echo [提示] 正在尝试安装可选依赖 tkinterdnd2(文件拖拽功能)...
    python -m pip install tkinterdnd2 >nul 2>nul
    if errorlevel 1 (
        echo [警告] tkinterdnd2 安装失败，打包继续；成品 exe 的拖拽功能将不可用。
    )
)

REM 关键修复 3：--add-data / --icon / --additional-hooks-dir / 入口 全部使用
REM 基于脚本目录的绝对路径。否则配合 --specpath build 时，PyInstaller 会把
REM 相对路径按 build\ 目录解析，导致 "Unable to find ...\build\src\assets\refdata.json"
REM （二次打包或残留 build\天工.spec 必现）。改用 %~dp0 绝对路径彻底规避。
python -m PyInstaller --onefile --windowed --noconfirm --clean ^
  --name "天工" ^
  --specpath build ^
  --icon "%~dp0src\assets\icon.ico" ^
  --add-data "%~dp0src\assets\refdata.json;assets" ^
  --add-data "%~dp0src\assets\icon.ico;assets" ^
  --additional-hooks-dir "%~dp0src\config" ^
  --hidden-import "core" ^
  --hidden-import "core.xml_repair" ^
  --hidden-import "data" ^
  --hidden-import "ui.app" ^
  --hidden-import "ui.global_page" ^
  --hidden-import "ui.bag_page" ^
  --hidden-import "ui.add_item_dialog" ^
  --hidden-import "ui.ref_page" ^
  --hidden-import "ui.enhance_page" ^
  "%~dp0src\main.py"

if errorlevel 1 (
    echo [错误] 打包失败，请查看上方日志定位问题。
    pause
    exit /b 1
)
echo [完成] 打包成功，产物位于 dist/天工.exe
pause
