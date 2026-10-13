# dataset/captcha/captcha_1772874614.jpg
import cv2
import numpy as np
from ultralytics import YOLO

def nothing(x):
    pass

def debug_solver_logic(image_path="debug_frames/spawn_AFTER_1773040050.jpg", model_path="model/best_puzzle.pt"):
    print("⏳ 正在加载 YOLO 模型...")
    try:
        model = YOLO(model_path)
    except Exception as e:
        print(f"❌ 模型加载失败: {e}")
        return

    # 1. 读取全屏截图
    img = cv2.imread(image_path)
    if img is None:
        print(f"❌ 找不到图片: {image_path}")
        return

    # ==========================================
    # 复现 Solver 第一步：YOLO 定位与 ROI 划定
    # ==========================================
    results = model.predict(source=img, conf=0.6, verbose=False)
    boxes = results[0].boxes
    if len(boxes) == 0:
        print("❌ YOLO 未能检测到缺口！请检查模型或图片。")
        return
        
    best_box = boxes[0].xyxy[0].cpu().numpy() 
    x1, y1, x2, y2 = map(int, best_box)
    
    # 向外扩展 10 像素 (完全按照 solver 逻辑)
    expansion = 25
    roi_x1, roi_y1 = max(0, x1 - expansion), max(0, y1 - expansion)
    roi_x2, roi_y2 = min(img.shape[1], x2 + expansion), min(img.shape[0], y2 + expansion)

    # 切出真实的 ROI (大约 100x100 大小)
    actual_roi = img[roi_y1:roi_y2, roi_x1:roi_x2]

    # 创建调试窗口
    cv2.namedWindow('Solver Logic Debugger', cv2.WINDOW_AUTOSIZE)
    # 初始化滑块在 50 和 150 (当前 solver 的默认值)
    cv2.createTrackbar('Canny Min', 'Solver Logic Debugger', 50, 255, nothing)
    cv2.createTrackbar('Canny Max', 'Solver Logic Debugger', 150, 255, nothing)

    print("\n✅ 调试器已启动！")
    print("👉 左侧：Solver 真实切出的 ROI (为了方便人眼观察，代码里放大了 3 倍)")
    print("👉 右侧：Canny 处理后的边缘图")
    print("按 ESC 键退出并打印最佳参数...")

    while True:
        # 获取当前滑动条的阈值
        c_min = cv2.getTrackbarPos('Canny Min', 'Solver Logic Debugger')
        c_max = cv2.getTrackbarPos('Canny Max', 'Solver Logic Debugger')

        # ==========================================
        # 复现 Solver 第二步：灰度化与 Canny 处理
        # ==========================================
        gray = cv2.cvtColor(actual_roi, cv2.COLOR_BGR2GRAY)
        edges = cv2.Canny(gray, c_min, c_max)
        
        # 计算当前状态的能量值 (白点总数)
        energy = np.sum(edges) // 255

        # ==========================================
        # 可视化渲染 (仅为了显示，不改变底层逻辑)
        # ==========================================
        # 将彩色 ROI 和黑白边缘图都放大 3 倍，否则 100x100 太小看不清
        scale = 3
        roi_disp = cv2.resize(actual_roi, (0, 0), fx=scale, fy=scale, interpolation=cv2.INTER_NEAREST)
        edges_disp = cv2.resize(edges, (0, 0), fx=scale, fy=scale, interpolation=cv2.INTER_NEAREST)
        
        # 把单通道的黑白图转成三通道，以便和彩色图拼接
        edges_bgr = cv2.cvtColor(edges_disp, cv2.COLOR_GRAY2BGR)

        # 左右拼接显示
        panel = np.hstack((roi_disp, edges_bgr))
        
        # 在图像上印上当前的能量值
        cv2.putText(panel, f"Energy: {energy}", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 255, 0), 2)

        cv2.imshow('Solver Logic Debugger', panel)

        # 按 ESC 退出
        if cv2.waitKey(1) & 0xFF == 27:
            print("\n🎉 调试结束！")
            print("请将 captcha_solver.py 中的 Canny 代码修改为：")
            print(f"edges = cv2.Canny(gray, {c_min}, {c_max})")
            break

    cv2.destroyAllWindows()

if __name__ == "__main__":
    debug_solver_logic()