"""回归测试集合。

运行方式（在 save_editor 目录下）：
    python tests/test_roundtrip.py      # 编解码往返（无需 GUI 依赖）
    python tests/test_editor_logic.py   # 底层逻辑（无需 GUI 依赖）
    python tests/smoke_test.py          # GUI 冒烟（需 customtkinter/tksheet）
    python tests/test_all.py            # 综合验证（需 customtkinter/tksheet）
    python tests/test_fixes.py          # 历史修复回归（需 customtkinter/tksheet）

各测试已自动将 save_editor 根目录加入 sys.path，可直接 `python tests/xxx.py` 运行。
"""
