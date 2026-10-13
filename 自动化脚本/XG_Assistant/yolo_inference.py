from ultralytics import YOLO
import cv2
import torch

class PlayerDetector:
    def __init__(self, model_path="best_player.pt"):
        # 自动选择 GPU (3060 启动！)
        self.device = 'cuda' if torch.cuda.is_available() else 'cpu'
        print(f"🚀 YOLO 推理引擎启动 | 使用设备: {self.device}")
        self.model = YOLO(model_path)
        
        # 预热模型，防止第一帧卡顿
        self.model.predict(source=torch.zeros((1, 3, 640, 640)), device=self.device)

    def detect_player(self, frame, conf=0.5):
        """
        输入: 完整的屏幕截图 (1920x1080)
        输出: (x_center, y_center) 或 None
        """
        # 🌟 性能优化：只推理右侧 ROI 区域，减少计算量
        # 我们裁剪的区域是 [500:1000, 1400:1920]，必须跟采集器一致
        roi = frame[500:1000, 1400:1920]
        
        results = self.model.predict(
            source=roi,
            conf=conf,
            verbose=False,
            device=self.device,
            half=True # 开启半精度推理，速度翻倍
        )

        for result in results:
            if len(result.boxes) > 0:
                # 拿到置信度最高的一个框
                box = result.boxes[0]
                # 获取在 ROI 内部的中心点坐标
                xywh = box.xywh[0].cpu().numpy()
                roi_x_center = xywh[0]
                
                # 🌟 坐标映射回全屏 (1920x1080 体系)
                # 全屏 X = ROI 起点 X + 内部相对 X
                real_x_center = 1400 + roi_x_center
                real_y_center = 500 + xywh[1]
                
                return int(real_x_center), int(real_y_center)
        
        return None