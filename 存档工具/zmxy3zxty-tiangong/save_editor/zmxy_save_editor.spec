# -*- mode: python ; coding: utf-8 -*-


a = Analysis(
    ['src\\main.py'],
    pathex=[],
    binaries=[],
    datas=[('src/assets/refdata.json', 'assets'), ('src/assets/icon.ico', 'assets')],
    hiddenimports=['core', 'core.xml_repair', 'data', 'ui.app', 'ui.global_page', 'ui.bag_page', 'ui.add_item_dialog', 'ui.ref_page', 'ui.enhance_page', 'utils.amf', 'utils.color'],
    hookspath=['src/config'],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='天工',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon=['src\\assets\\icon.ico'],
)
