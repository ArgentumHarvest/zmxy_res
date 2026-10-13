"""UI 包：界面层。

包含：
  - theme.py          方案③温暖活泼主题（配色/字体/圆角/动效资源）
  - app.py            主程序 EditorApp（组合各页 Mixin，管理窗口与共享状态）
  - global_page.py    全局属性页
  - bag_page.py       背包编辑页
  - add_item_dialog.py 按代码添加物品对话框
  - ref_page.py       参考/校验页

原则上 UI 层只负责「呈现与交互」，所有数据计算走 core / data 层。
"""
