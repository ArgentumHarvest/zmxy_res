import time
import random
import threading
import win32gui
import win32api
import win32con

class DeviceController:
    """
    [底层物理操作驱动]
    基于 Windows Win32 API 封装的模拟器底层控制模块。
    特色功能：
    1. 后台静默操作：使用 PostMessage 直接向窗口句柄发送消息，不占用真实鼠标。
    2. 渲染层穿透：精准定位模拟器的 RenderWindow 渲染层，解决点击无效问题。
    3. 动态分辨率适配：支持任意大小的模拟器窗口，自动映射 1920x1080 逻辑坐标。
    4. 异步并发：内置守护线程独立执行高频操作(如连点普攻)，绝不阻塞主状态机。
    """
    def __init__(self, window_title="雷电模拟器"):
        # 1. 寻找模拟器主窗口句柄
        self.hwnd = win32gui.FindWindow(None, window_title)
        
        # 2. 寻找雷电模拟器的真实渲染层 (RenderWindow)
        # ⚠️ 核心细节：雷电等大多安卓模拟器的主窗口接收不到鼠标点击，
        # 必须把消息发给它的子窗口 "TheRender" 才能生效。
        self.render_hwnd = win32gui.FindWindowEx(self.hwnd, 0, "RenderWindow", "TheRender")
        if not self.render_hwnd:
            self.render_hwnd = self.hwnd # 兜底策略：如果没有子窗口，就直接发给主窗口

        # 3. 异步连点器状态初始化
        self.is_auto_attacking = False
        self.attack_pos = (1820, 965) # 普攻按钮的默认逻辑坐标 (1920x1080标准)
        
        # 4. 启动后台连点守护线程
        # daemon=True 表示当主程序退出时，这个线程也会随之强行终止，防止内存泄漏或僵尸进程
        threading.Thread(target=self._auto_attack_loop, daemon=True).start()

    def _convert_coords(self, x, y):
        """
        [坐标动态映射引擎]
        将算法层输入的绝对逻辑坐标 (基于 1920x1080)
        实时转换为当前模拟器窗口大小下的真实物理坐标。
        无论玩家怎么拉伸模拟器窗口，点击永远精准！
        """
        # 获取渲染窗口的真实内部区域大小 (Client Rect)
        rect = win32gui.GetClientRect(self.render_hwnd)
        w, h = rect[2], rect[3]
        
        # 按比例缩放坐标
        return int(x * (w / 1920)), int(y * (h / 1080))

    def touch_down(self, x, y):
        """物理级指令：手指/鼠标按下"""
        rx, ry = self._convert_coords(x, y)
        lparam = win32api.MAKELONG(rx, ry)
        win32gui.PostMessage(self.render_hwnd, win32con.WM_LBUTTONDOWN, win32con.MK_LBUTTON, lparam)

    def touch_up(self, x, y):
        """物理级指令：手指/鼠标抬起"""
        rx, ry = self._convert_coords(x, y)
        lparam = win32api.MAKELONG(rx, ry)
        win32gui.PostMessage(self.render_hwnd, win32con.WM_LBUTTONUP, 0, lparam)

    def touch_move(self, x, y):
        """
        物理级指令：按住拖拽 (模拟滑动)
        结合 touch_down 和 touch_up，构成验证码破解或摇杆滑动的核心动作
        """
        rx, ry = self._convert_coords(x, y)
        lparam = win32api.MAKELONG(rx, ry)
        # 注意：拖动时 wparam 必须传 win32con.MK_LBUTTON，表示左键按住状态下的移动
        win32gui.PostMessage(self.render_hwnd, win32con.WM_MOUSEMOVE, win32con.MK_LBUTTON, lparam)

    def click(self, x, y):
        """
        原子化动作：单击 (按下 -> 随机停顿 -> 抬起)
        加入 20ms~50ms 随机延迟，模拟真实按压的肉体反馈，避免被反作弊检测为超人类极速连点。
        """
        self.touch_down(x, y)
        time.sleep(random.uniform(0.02, 0.05))
        self.touch_up(x, y)

    # ========================================================
    # 🌟 异步多线程执行器 (Async Action Executor)
    # ========================================================

    def _auto_attack_loop(self):
        """
        [独立守护线程]
        在这个死循环里，只要 is_auto_attacking 为 True，
        就会持续不断地向模拟器狂按普攻。
        分离式架构：它完全不影响主程序的图像识别和过图逻辑！
        """
        while True:
            if self.is_auto_attacking:
                # 执行静默点击
                self.click(self.attack_pos[0], self.attack_pos[1])
                # 攻速控制：每秒约点击 4~6 次，并加入随机扰动防检测
                time.sleep(random.uniform(0.15, 0.25))
            else:
                # 未开启连点时，让出 CPU 时间片，防止线程空转卡死 CPU
                time.sleep(0.1)

    def start_auto_attack(self):
        """触发器：开启多线程连点"""
        self.is_auto_attacking = True
        
    def stop_auto_attack(self):
        """触发器：关闭多线程连点"""
        self.is_auto_attacking = False