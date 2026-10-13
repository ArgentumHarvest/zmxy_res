import cv2
import numpy as np
import os

def find_target_center(screen_matrix, template_path, threshold=0.6):
    """
    [核心基础 UI 感知算法]
    在屏幕大图 (Screen) 中寻找目标小图 (Template)，并返回其物理中心点坐标。
    目前广泛应用于状态机 (FSM) 的场景判定，如：寻找结算按钮、普攻按钮等。
    
    参数:
    screen_matrix: numpy.ndarray, 从设备实时抓取的 BGR 画面矩阵 (通常为 1920x1080)
    template_path: str, 目标小图片(UI 特征)的相对路径
    threshold: float, 匹配相似度阈值 (0.0 到 1.0，越大越严格，推荐 0.8)
    
    返回:
    (x, y): 目标中心点的坐标元组，如果没找到则返回 None
    max_val: float, 当前最高匹配相似度
    bounding_box: tuple, (x, y, w, h) 匹配到的矩形区域
    """
    
    # 1. 前置安全校验：检查模板文件是否存在，防止程序因路径错误崩溃
    if not os.path.exists(template_path):
        print(f"❌ 视觉模块错误：找不到特征模板文件 {template_path}，请检查路径！")
        return None, 0.0, None
        
    # 2. 将模板文件加载进内存 (保持与屏幕截图一致的 BGR 格式)
    template = cv2.imread(template_path, cv2.IMREAD_COLOR)
    if template is None:
        print(f"❌ 视觉模块错误：特征模板文件 {template_path} 图像损坏或无法读取！")
        return None, 0.0, None
        
    # 提取模板的物理像素尺寸 (高，宽)
    th, tw = template.shape[:2]

    # 3. 核心计算机视觉算法：模板匹配 (Template Matching)
    # 采用 TM_CCOEFF_NORMED (归一化相关系数匹配)
    # 该算法对游戏画面中常见的光照微调、全局色彩渐变具有极其优秀的鲁棒性
    result = cv2.matchTemplate(screen_matrix, template, cv2.TM_CCOEFF_NORMED)

    # 4. 提取概率矩阵中的极值点与对应的绝对坐标
    # min_val, max_val: 最小和最大匹配相似度
    # min_loc, max_loc: 对应的左上角特征坐标 (x, y)
    min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)

    # 5. 置信度决策：判定屏幕中是否存在该特征 UI
    if max_val >= threshold:
        # 计算目标的【绝对中心点坐标】 (这正是鼠标/手指需要点击的交互锚点)
        center_x = max_loc[0] + tw // 2
        center_y = max_loc[1] + th // 2
        
        # 将结果、最高相似度、以及包围盒特征返回，供 FSM 决策或 Debug 绘图使用
        return (center_x, center_y), max_val, (max_loc[0], max_loc[1], tw, th)
    else:
        # 相似度未达标，判定特征未出现在当前画面中
        return None, max_val, None