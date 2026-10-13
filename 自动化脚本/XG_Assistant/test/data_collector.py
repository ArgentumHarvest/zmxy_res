import cv2
import os
import time
from screen_capture import capture_screen

def start_collection():
    # 创建保存目录
    save_dir = "dataset/images"
    os.makedirs(save_dir, exist_ok=True)

    print("📸 启动高频数据采集模块！")
    print(f"📂 图片将保存在: {os.path.abspath(save_dir)}")
    print("👉 请切回模拟器，准备手动操作。")
    print("⏳ 3秒后开始抓拍，按 Ctrl+C 停止采集...")
    time.sleep(3)

    count = 0
    try:
        while True:
            # 调用我们极其丝滑的后台盲抓引擎
            img = capture_screen()
            if img is None:
                continue
                
            # 🌟 核心优化：只截取右侧可能出现人物的区域
            # 纵向 500-1000，横向 1400-1920，稍微给大一点视野，确保框全
            roi_img = img[500:1000, 1400:1920]
            
            # 使用时间戳作为文件名，防止覆盖
            filename = os.path.join(save_dir, f"player_{int(time.time()*1000)}.jpg")
            
            # 保存图片 (JPEG 格式压缩率高，适合训练)
            cv2.imwrite(filename, roi_img)
            count += 1
            
            print(f"✅ 抓拍成功: 第 {count} 张")
            
            # 采样频率：每 0.3 秒一张
            # 人物跑到尽头的动画大概 1-2 秒，这样一次能抓到 3-6 张不同奔跑姿态
            time.sleep(0.3)
            
    except KeyboardInterrupt:
        print(f"\n🛑 收到停止指令！采集结束。")
        print(f"🎉 恭喜！你总共收获了 {count} 张珍贵的训练素材。")

if __name__ == "__main__":
    start_collection()