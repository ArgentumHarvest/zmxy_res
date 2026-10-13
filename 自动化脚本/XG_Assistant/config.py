# config.py
# ==========================================
# 🤖 AI 挂机大脑 - 全局参数配置表
# ==========================================

# 1. 核心模型路径
MODELS = {
    "player": "model/best_player.pt",
    "captcha": "model/best_puzzle.pt"
}

# 2. 图像特征/UI资源路径
ASSETS = {
    "captcha_slider": "assets/btn_slider.png",           # 人机验证特征
    "settlement": "assets/img_settlement_mark.png",      # 结算画面特征
    "btn_attack": "assets/btn_attack.png",               # 副本中特征 (普攻按钮)
    "btn_restart": "assets/btn_restart.png",             # 再次挑战按钮
    "btn_go": "assets/btn_go.png",                       # 前进箭头
    "btn_confirm": "assets/btn_confirm.png",             # 验证成功后的奖励确认
    "btn_network_confirm": "assets/btn_confirm_2.0.png"  # 网络断开/卡顿确定按钮
}

# 3. 物理操作坐标 (X, Y)
COORDS = {
    "joystick_right": (430, 920),                        # 摇杆：向右跑
    "joystick_left": (130, 920),                         # 摇杆：向左跑
    "skills": [(1440, 990), (1500, 830), (1670, 770), (1850, 770)] # 技能盘坐标列表
}

# 4. 视觉识别区域 (ROI: [y1:y2, x1:x2]) 与 匹配阈值
VISION = {
    "captcha_roi": (620, 800, 560, 1360),                # 人机验证弹窗的粗略扫描区
    "match_threshold": 0.8,                              # 通用模板匹配阈值
    "captcha_threshold": 0.7                             # 验证码滑块的匹配阈值 (可略低)
}

# 5. 状态机超时熔断器 (单位：秒)
TIMEOUTS = {
    "dungeon_stuck": 180,                                # 副本卡墙超时 (触发重新跑图)
    "settlement_stuck": 30,                              # 结算界面卡死超时 (触发冷却重置)
    "unknown_stuck": 30,                                 # 未知黑屏状态超时
    "captcha_fatal": 20,                                 # 验证码处理超时 (触发杀进程)
    "network_retry": 30                                  # 网络弹窗再次点击间隔
}