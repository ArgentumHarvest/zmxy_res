import cv2
import numpy as np
import win32gui
from ppadb.client import Client as AdbClient

def test_environment():
    print(f"OpenCV 版本: {cv2.__version__}")
    print(f"Numpy 版本: {np.__version__}")
    
    # 测试 ADB 连接
    client = AdbClient(host="127.0.0.1", port=5037)
    devices = client.devices()
    
    if len(devices) == 0:
        print("未检测到模拟器，请检查雷电模拟器是否开启。")
        return
        
    device = devices[0]
    print(f"成功连接到设备: {device.serial}")
    
    # 执行一次屏幕点击测试 (点击屏幕中心坐标，假设分辨率为 1280x720)
    print("准备发送点击指令到坐标 (640, 360)...")
    device.shell("input tap 640 360")
    print("指令发送成功！请观察模拟器屏幕是否有点击反应。")

if __name__ == "__main__":
    test_environment()