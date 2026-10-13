import cv2
import numpy as np
import win32gui
import win32ui
import ctypes

# ========================================================
# 🌟 环境初始化：解决 Windows 高分屏缩放导致的像素偏差
# 必须在进程启动最前端执行，否则会导致 GetWindowRect 获取的坐标不准
# ========================================================
ctypes.windll.user32.SetProcessDPIAware()

def capture_screen(window_title="雷电模拟器"):
    """
    高性能后台抓图函数：
    利用 Win32 GDI 接口与 PrintWindow 模式 3 (PW_RENDERFULLCONTENT)
    支持在窗口被遮挡的情况下依然获取到硬件加速渲染的画面。
    """
    # 1. 寻找目标窗口句柄
    hwnd = win32gui.FindWindow(None, window_title)
    if not hwnd:
        print(f"❌ 视觉驱动错误：未找到目标窗口 [{window_title}]")
        return None

    # 2. 获取真实的物理像素边界
    # 在开启 DPIAware 后，此函数返回的是未经过系统缩放的原始像素尺寸
    left, top, right, bottom = win32gui.GetWindowRect(hwnd)
    width = right - left
    height = bottom - top

    # 3. 创建内存设备上下文 (Device Context)
    hwndDC = win32gui.GetWindowDC(hwnd)
    mfcDC  = win32ui.CreateDCFromHandle(hwndDC)
    saveDC = mfcDC.CreateCompatibleDC()

    # 4. 创建兼容位图对象并绑定到内存 DC
    saveBitMap = win32ui.CreateBitmap()
    saveBitMap.CreateCompatibleBitmap(mfcDC, width, height)
    saveDC.SelectObject(saveBitMap)

    # 5. 核心：执行窗口画面拷贝
    # 参数 3 (PW_RENDERFULLCONTENT) 是针对雷电、蓝叠等开启了 DirectX/OpenGL 加速模拟器的关键
    # 它能够强制重绘内容到内存 DC，解决普通截图方法截出来是黑屏的问题
    result = ctypes.windll.user32.PrintWindow(hwnd, saveDC.GetSafeHdc(), 3)

    img_bgr = None
    if result == 1:
        # 6. 将位图数据转换为 Numpy 矩阵
        bmpinfo = saveBitMap.GetInfo()
        bmpstr = saveBitMap.GetBitmapBits(True)
        # 注意：这里抓到的是 BGRA 格式 (带 Alpha 通道)
        img_bgra = np.frombuffer(bmpstr, dtype='uint8').reshape((bmpinfo['bmHeight'], bmpinfo['bmWidth'], 4))
        # 抛弃 Alpha 通道，转为 OpenCV 标准的 BGR
        img_bgr = img_bgra[:, :, :3]
        
        # 7. 画面预处理：裁剪非游戏区域
        # 裁剪掉模拟器的标题栏、侧边工具栏等干扰项，只保留游戏内部画面
        border_top, border_bottom, border_left, border_right = 34, 2, 2, 38
        h, w = img_bgr.shape[:2]
        if h > border_top + border_bottom and w > border_left + border_right:
            img_bgr = img_bgr[border_top:h-border_bottom, border_left:w-border_right]
        
        # 8. 坐标系归一化
        # 强制将不同缩放比例下的画面统一缩放回 1920x1080，确保后续特征匹配坐标的一致性
        img_bgr = cv2.resize(img_bgr, (1920, 1080))

    # ========================================================
    # 🌟 内存回收：极其重要！
    # Windows GDI 对象如果不手动释放，会导致系统内核内存泄漏 (Handle Leak)
    # 长时间挂机脚本必须严格执行以下清理逻辑
    # ========================================================
    win32gui.DeleteObject(saveBitMap.GetHandle())
    saveDC.DeleteDC()
    mfcDC.DeleteDC()
    win32gui.ReleaseDC(hwnd, hwndDC)
    
    return img_bgr