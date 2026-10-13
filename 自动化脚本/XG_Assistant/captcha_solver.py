import cv2
import numpy as np
import time
import random
import traceback
import os
import math
from ultralytics import YOLO
from screen_capture import capture_screen

class CaptchaSolver:
    """
    几何制导解算器：
    利用 YOLO 锁定目标缺口，结合帧差法与双直角特征提取拼图起点，
    通过 1:1 物理映射与贝塞尔曲线模拟真人滑动。
    """
    def __init__(self, controller, window_title="雷电模拟器", model_path="model/best_puzzle.pt"):
        self.controller = controller
        self.window_title = window_title
        print(f"⏳ 正在加载视觉制导模型...")
        self.model = YOLO(model_path)
        
        # --- 物理参数 (需根据模拟器分辨率微调) ---
        self.SLIDER_START_X = 650         # 滑块在底部的物理起始中心 X
        self.SLIDER_START_Y = 713         # 滑块在底部的物理起始中心 Y
        self.SPAWN_ROI = (520, 330, 627, 646) # 拼图出生时的安全探测区
        
        # --- Debug 输出环境 ---
        self.debug_dir = "debug_frames"
        os.makedirs(self.debug_dir, exist_ok=True)

    def solve(self, img):
        """
        主解算入口：
        感知阶段 (YOLO) -> 捕获阶段 (Corner Logic) -> 执行阶段 (Human-like Move)
        """
        try:
            # 1. 靶心锁定：获取缺口绝对左边缘
            results = self.model.predict(source=img, conf=0.6, verbose=False)
            boxes = results[0].boxes
            if len(boxes) == 0:
                print("❌ YOLO 未能在画面中检测到拼图缺口！")
                return False
                
            best_box = boxes[0].xyxy[0].cpu().numpy()
            x1, y1, x2, y2 = map(int, best_box)
            target_left_x = x1 # 锁定目标基准线
            
            # 2. 几何锚定：提取拼图出生时的绝对左边缘
            piece_start_x = self._get_piece_corner_x()
            if not piece_start_x:
                return False

            # 3. 距离计算与拟人化偏置
            distance_to_move = target_left_x - piece_start_x
            final_mouse_x = self.SLIDER_START_X + distance_to_move
            
            print(f"🎯 视觉差: {distance_to_move}px | 目标点: {final_mouse_x}")
            
            # 4. 执行拟人化滑动
            self._move_human_like(self.SLIDER_START_X, final_mouse_x)
            
            # 抬起前随机停顿 300-600ms，模拟人类“看一眼对齐没”的心理
            time.sleep(random.uniform(0.3, 0.6))
            self.controller.touch_up(final_mouse_x, self.SLIDER_START_Y)
            
            return True
            
        except Exception as e:
            print(f"\n❌ [Solver致命错误]: {e}")
            traceback.print_exc()
            self.controller.touch_up(self.SLIDER_START_X, self.SLIDER_START_Y)
            return False

    def _get_piece_corner_x(self):
        """
        [视觉核心] 究极固定坐标判定逻辑
        完全抛弃边缘点定位，只做一道选择题：最左侧是“墙”还是“尖头”？
        如果是尖头 -> 有左凸起 -> 起点 582
        如果是高墙 -> 无左凸起 -> 起点 566
        """
        rx1, ry1, rx2, ry2 = self.SPAWN_ROI
        
        bg_screen = capture_screen(window_title=self.window_title)
        if bg_screen is None: return None
        bg_gray = cv2.cvtColor(bg_screen[ry1:ry2, rx1:rx2], cv2.COLOR_BGR2GRAY)
        bg_gray = cv2.GaussianBlur(bg_gray, (3, 3), 0)
        
        self.controller.touch_down(self.SLIDER_START_X, self.SLIDER_START_Y)
        time.sleep(0.8)
        
        fg_screen = capture_screen(window_title=self.window_title)
        if fg_screen is None: return None
        fg_gray = cv2.cvtColor(fg_screen[ry1:ry2, rx1:rx2], cv2.COLOR_BGR2GRAY)
        fg_gray = cv2.GaussianBlur(fg_gray, (3, 3), 0)
        
        diff = cv2.absdiff(bg_gray, fg_gray)
        _, thresh = cv2.threshold(diff, 30, 255, cv2.THRESH_BINARY)
        
        contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        if not contours: return None
            
        c = max(contours, key=cv2.contourArea)
        px, py, pw, ph = cv2.boundingRect(c)
        
        # 提取出整个拼图方块的二值化画面
        piece_thresh = thresh[py:py+ph, px:px+pw]
        
        # 计算每一列的白色像素数量（垂直投影高度）
        col_counts = np.sum(piece_thresh > 0, axis=0)
        
        # 提取最左侧前 5 列的最大像素高度
        # 拼图高度一般在 80 左右。
        # 如果是实体直边，前 5 列必定包含一条很长的垂直线，高度通常 > 40。
        # 如果只是圆弧凸起的最尖端，前 5 列的高度极小，通常 < 25。
        if len(col_counts) > 0:
            left_edge_height = np.max(col_counts[:5])
        else:
            left_edge_height = 0

        # --- 🌟 终极选择题鉴定 ---
        if left_edge_height < 30:
            # print(f"🧬 形状鉴定：左侧高度 {left_edge_height}px (尖头) -> 存在 [左凸起] -> 起点锁定在 582")
            return 582
        else:
            # print(f"🧬 形状鉴定：左侧高度 {left_edge_height}px (高墙) -> 无 [左凸起] -> 起点锁定在 566")
            return 566

    def _move_human_like(self, start_x, end_x):
        """
        [物理核心] 拟人化运动模型
        新增要求：每次强制滑过 5-10 像素，再缓慢回拉。
        """
        distance = end_x - start_x
        if distance == 0: return

        steps = random.randint(20, 35)
        control_y = self.SLIDER_START_Y + random.randint(-5, 5)
        
        # 🌟 强制过冲：每次必然超过终点 5 到 10 个像素
        overshoot = random.randint(5, 10) 
        target_temp = end_x + overshoot

        # --- 第一阶段：滑向过冲点 ---
        for i in range(steps + 1):
            t = i / steps
            t_ease = t * t * (3 - 2 * t)
            
            curr_x = int(start_x + (target_temp - start_x) * t_ease)
            curr_y = int((1-t)**2 * self.SLIDER_START_Y + 2*(1-t)*t * control_y + t**2 * self.SLIDER_START_Y)
            
            self.controller.touch_move(curr_x, curr_y)
            
            delay = 0.005 + 0.012 * (1 - math.sin(math.pi * t))
            time.sleep(delay)

        # 停顿一下，模拟发现滑过了的反应时间
        time.sleep(random.uniform(0.15, 0.3))
        
        # --- 第二阶段：缓慢回拉 ---
        # 增加步数，增加延迟，使回拉动作明显变慢
        back_steps = random.randint(8, 15) 
        for j in range(back_steps + 1):
            t_b = j / back_steps
            curr_x = int(target_temp + (end_x - target_temp) * t_b)
            self.controller.touch_move(curr_x, self.SLIDER_START_Y)
            # 缓慢回拉：每次移动后停顿 0.03~0.06 秒
            time.sleep(random.uniform(0.03, 0.06))