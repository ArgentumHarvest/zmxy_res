import cv2
import numpy as np

def test_template_matching():
    # 1. 配置路径
    bg_path = "assets/captcha.png"              # 游戏全屏截图
    tpl_path = "assets/btn_slider.png" # 你用来匹配的特征图

    # 2. 读取图片
    bg_img = cv2.imread(bg_path)
    tpl_img = cv2.imread(tpl_path)

    if bg_img is None:
        print(f"❌ 找不到全屏截图: {bg_path}")
        return
    if tpl_img is None:
        print(f"❌ 找不到特征图: {tpl_path}")
        return

    # 3. 截取 ROI 区域 (注意 Numpy 的切片顺序是 y1:y2, x1:x2)
    x1, y1, x2, y2 = 560, 620, 1360, 800
    roi_img = bg_img[y1:y2, x1:x2]
    
    # 获取特征图的宽和高
    th, tw = tpl_img.shape[:2]

    # 4. 执行模板匹配
    print("🔍 正在 ROI 区域内执行模板匹配...")
    # TM_CCOEFF_NORMED 是最常用的算法，返回值在 -1 到 1 之间
    res = cv2.matchTemplate(roi_img, tpl_img, cv2.TM_CCOEFF_NORMED)
    min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(res)

    print(f"\n======================================")
    print(f"📊 最终匹配置信度 (max_val): {max_val:.4f}")
    print(f"📍 匹配到的左上角相对坐标: {max_loc}")
    print(f"======================================\n")

    # 5. 可视化分析
    # 在 ROI 图上用红框圈出匹配到的位置
    bottom_right = (max_loc[0] + tw, max_loc[1] + th)
    cv2.rectangle(roi_img, max_loc, bottom_right, (0, 0, 255), 2)

    if max_val >= 0.6:
        print("✅ 测试通过！你的 0.6 阈值完全可以抓到它。")
        print("🤔 如果游戏里没抓到，说明是截图时机（动画还没播完）或者分辨率不匹配的问题。")
    else:
        print(f"❌ 测试失败！置信度 {max_val:.4f} 达不到 0.6 的门槛。")
        print("💡 诊断建议：")
        print("1. 检查特征图边缘是不是带进去了半透明的背景像素。")
        print("2. 重新用 Windows 截图工具 (Win+Shift+S) 只截取最中心、最纯色的部分。")

    # 放大一点显示，方便你看清楚红框框在了哪里
    show_img = cv2.resize(roi_img, (roi_img.shape[1]*2, roi_img.shape[0]*2))
    cv2.imshow("ROI Match Result (2x Scaled)", show_img)
    print("\n👉 请查看弹出的图片窗口。按键盘【任意键】退出...")
    cv2.waitKey(0)
    cv2.destroyAllWindows()

if __name__ == "__main__":
    test_template_matching()