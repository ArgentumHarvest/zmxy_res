import cv2
from screen_capture import get_adb_device, capture_screen

print("正在连接模拟器抓图...")
device = get_adb_device()

if device:
    # 抓取一张没有任何电脑边框的纯净 ADB 画面
    img = capture_screen(device)
    
    # 保存到当前文件夹
    cv2.imwrite("test_bg.png", img)
    print("✅ 纯净画面已保存为 test_bg.png，请在文件夹中查看！")