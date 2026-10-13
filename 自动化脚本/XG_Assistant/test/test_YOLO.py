from ultralytics import YOLO
import cv2

# ==========================================
# 🎯 [配置区] 把这里改成你刚刚在 debug_frames 里报错的那张图的名字！
# ==========================================
TEST_IMAGE_PATH = "../debug_frames/spawn_AFTER_1773040055.jpg" # 👈 大哥，一定要改这里！

def test_yolo_model():
    print(f"⏳ 正在加载你的专属缺口模型 (best_puzzle.pt)...")
    try:
        model = YOLO("../model/best_puzzle.pt")
    except Exception as e:
        print(f"❌ 模型加载失败，请检查路径: {e}")
        return

    print(f"📸 正在读取案发现场照片: {TEST_IMAGE_PATH}")
    img = cv2.imread(TEST_IMAGE_PATH)

    if img is None:
        print("❌ 照片读取失败！请检查图片名字是否写对，或者图片是否损坏！")
        return

    # 故意把置信度调低到 0.25 (原本是 0.6)，看看模型是不是信心不足才导致没认出来
    print("🔍 正在进行深度学习推演 (置信度阈值=0.25)...")
    results = model.predict(source=img, conf=0.25, verbose=False)
    
    boxes = results[0].boxes
    if len(boxes) == 0:
        print("💀 致命结果：连降低要求后，YOLO 依然什么都没看到！")
        print("   -> 可能原因 1：截图分辨率不对，模型没见过这种尺寸。")
        print("   -> 可能原因 2：模型训练得太少，遇到没见过的背景泛化失败。")
    else:
        print(f"🎉 探测到疑似目标！共发现 {len(boxes)} 个缺口：")
        for box in boxes:
            x1, y1, x2, y2 = map(int, box.xyxy[0].cpu().numpy())
            conf = box.conf[0].item()
            print(f"   🎯 坐标: X({x1}到{x2}), Y({y1}到{y2}) | 置信度: {conf:.2f}")

    # ==========================================
    # 🖼️ 可视化画图：把 YOLO 看到的东西画出来
    # ==========================================
    res_img = results[0].plot() # YOLO 内置绝技，直接把框和概率画在图上
    
    # 缩小一点展示，防止你的屏幕塞不下 1920x1080
    show_img = cv2.resize(res_img, (1280, 720))
    cv2.imshow("YOLO Vision Test - Press ANY key to exit", show_img)
    print("\n👉 请看弹出的图片窗口！看完后按键盘任意键关闭...")
    cv2.waitKey(0)
    cv2.destroyAllWindows()

if __name__ == "__main__":
    test_yolo_model()