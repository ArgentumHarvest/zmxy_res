"""程序入口：启动存档编辑器 GUI。

运行方式：
    python main.py
打包后由 PyInstaller 生成的 exe 亦以此为入口（见同名 spec）。
"""
from ui.app import main

if __name__ == "__main__":
    main()
