import time
import random
import cv2
import os
from datetime import datetime

# --- 核心依赖模块 ---
from screen_capture import capture_screen     
from vision import find_target_center          
from device_control import DeviceController    
from yolo_inference import PlayerDetector     
from captcha_solver import CaptchaSolver       

# --- 全局参数配置 ---
import config 

class GameBot:
    def __init__(self, window_title="雷电模拟器"):
        
        self.window_title = window_title
        self.controller = DeviceController(window_title=self.window_title)
        
        self.detector = PlayerDetector(config.MODELS["player"])
        self.captcha_solver = CaptchaSolver(self.controller, window_title=self.window_title, model_path=config.MODELS["captcha"])
        
        self.current_state = "UNKNOWN"         
        self.state_start_time = time.time()    
        
        self.is_running_forward = True         
        self.last_skill_time = 0               
        self.last_restart_time = 0             
        self.last_network_click_time = 0       
        
        self.challenge_count = 1
        self.has_entered_dungeon = False       

    def get_screen_state(self, img):
        if self.current_state == "NETWORK_LAG":
            if find_target_center(img, config.ASSETS["btn_network_confirm"], threshold=config.VISION["match_threshold"])[0]:
                return "NETWORK_LAG"
                
        y1, y2, x1, x2 = config.VISION["captcha_roi"]
        captcha_roi = img[y1:y2, x1:x2]
        if find_target_center(captcha_roi, config.ASSETS["captcha_slider"], threshold=config.VISION["captcha_threshold"])[0]:
            return "CAPTCHA"
            
        if find_target_center(img, config.ASSETS["settlement"], threshold=config.VISION["match_threshold"])[0]:
            return "SETTLEMENT"
            
        if find_target_center(img, config.ASSETS["btn_attack"], threshold=config.VISION["match_threshold"])[0]:
            return "IN_DUNGEON"
        
        return "UNKNOWN"

    def check_and_transition_network_lag(self, img):
        pos, _, _ = find_target_center(img, config.ASSETS["btn_network_confirm"], threshold=config.VISION["match_threshold"])
        if pos:
            self.current_state = "NETWORK_LAG"
            self.state_start_time = time.time()
            self.last_network_click_time = 0 
            return True
        return False

    def write_log(self, reason):
        """统一日志写入接口：处理手动和被动中断"""
        now_str = datetime.now().strftime("%Y-%m-%d %H:%M")
        log_msg = f"[{now_str}] 本轮挑战次数: {self.challenge_count} | 结束原因: {reason}\n"
        
        with open("log.txt", "a", encoding="utf-8") as f:
            f.write(log_msg)
        print(f"📝 运行记录已保存至 log.txt: {log_msg.strip()}")

    def run(self):
        try:
            while True:
                img = capture_screen(window_title=self.window_title)
                if img is None: 
                    time.sleep(0.01)
                    continue

                new_state = self.get_screen_state(img)

                if new_state != self.current_state:
                    self.current_state = new_state
                    self.state_start_time = time.time() 
                    
                    if self.current_state == "IN_DUNGEON" and not self.has_entered_dungeon:
                        print(f"\n⚔️ [进程汇报] 已切入战斗状态，当前正在进行第 {self.challenge_count} 次挑战...")
                        self.has_entered_dungeon = True
                else:
                    elapsed = time.time() - self.state_start_time
                    
                    if self.current_state == "IN_DUNGEON":
                        if elapsed > config.TIMEOUTS["dungeon_stuck"]:
                            if not self.check_and_transition_network_lag(img):
                                self.is_running_forward = True
                                self.state_start_time = time.time()
                            
                    elif self.current_state == "SETTLEMENT":
                        if elapsed > config.TIMEOUTS["settlement_stuck"]:
                            if not self.check_and_transition_network_lag(img):
                                self.last_restart_time = 0
                                self.state_start_time = time.time()
                                
                    elif self.current_state == "UNKNOWN":
                        if elapsed > config.TIMEOUTS["unknown_stuck"]:
                            if not self.check_and_transition_network_lag(img):
                                self.state_start_time = time.time()
                            
                    elif self.current_state == "CAPTCHA":
                        if elapsed > config.TIMEOUTS["captcha_fatal"]:
                            self.kill_emulator_and_exit(reason="人机验证处理严重超时(超过20秒卡死)")

                if self.current_state == "CAPTCHA":
                    self.handle_captcha(img)
                elif self.current_state == "SETTLEMENT":
                    self.handle_settlement(img)
                elif self.current_state == "IN_DUNGEON":
                    self.handle_dungeon(img)
                elif self.current_state == "NETWORK_LAG":
                    self.handle_network_lag(img)
                else:
                    self.handle_unknown()

                time.sleep(0.01)

        except KeyboardInterrupt:
            # 🌟 捕获玩家手动按 Ctrl+C 中断，记录挑战次数后抛出给主程序收尾
            self.write_log("手动终止(Ctrl+C)")
            raise 
        except Exception as e:
            # 🌟 捕获其他意料之外的报错崩溃
            self.write_log(f"程序异常崩溃: {str(e)}")
            raise

    def handle_network_lag(self, img):
        joy_right = config.COORDS["joystick_right"]
        self.controller.stop_auto_attack()
        self.controller.touch_up(joy_right[0], joy_right[1])
        
        now = time.time()
        if self.last_network_click_time == 0 or (now - self.last_network_click_time > config.TIMEOUTS["network_retry"]):
            pos, _, _ = find_target_center(img, config.ASSETS["btn_network_confirm"], threshold=config.VISION["match_threshold"])
            if pos:
                self.controller.click(pos[0], pos[1])
                self.last_network_click_time = now

    def handle_captcha(self, img):
        joy_right = config.COORDS["joystick_right"]
        self.controller.stop_auto_attack()
        self.controller.touch_up(joy_right[0], joy_right[1])
        self.is_running_forward = False 
        
        print("\n🚨 [安全防御] 触发人机验证！启动定位...")
        
        action_executed = self.captcha_solver.solve(img)
        if not action_executed:
            print("⚠️ [FSM] 动画未播完或单次定位失败，不熔断，等待下一帧重试...")
            time.sleep(0.5)
            return

        print("⏳ [FSM] 指令执行完毕，等待服务端判定反馈...")
        time.sleep(4)
        
        reward_img = capture_screen(window_title=self.window_title) 
        confirm_pos, _, _ = find_target_center(reward_img, config.ASSETS["btn_confirm"], threshold=config.VISION["match_threshold"])
        
        if confirm_pos:
            print(f"✅ [FSM] 验证完美通过！点击领取奖励，恢复日常任务。(第 {self.challenge_count} 次挑战)")
            self.controller.click(confirm_pos[0], confirm_pos[1])
            time.sleep(1.5) 
            self.state_start_time = time.time()
            self.last_restart_time = time.time()
        else:
            print("🛑 [FSM] 警报：服务端未确认成功，判定为操作误差，执行自我保护熔断！")
            self.kill_emulator_and_exit(reason="滑动完成后，未识别到[确认领取]奖励弹窗")

    def kill_emulator_and_exit(self, reason="未知故障"):
        # 统一调用日志写入
        self.write_log(reason)
        
        print(f"\n💥 [熔断器] 触发终极防封机制！")
        os.system("taskkill /F /T /IM dnplayer.exe") 
        print("💀 模拟器已强制关闭，脚本安全退出。")
        os._exit(0)

    def handle_settlement(self, img):
        joy_right = config.COORDS["joystick_right"]
        self.controller.stop_auto_attack()
        self.controller.touch_up(joy_right[0], joy_right[1])
        
        res_pos, _, _ = find_target_center(img, config.ASSETS["btn_restart"], threshold=config.VISION["match_threshold"])
        if res_pos:
            now = time.time()
            if now - self.last_restart_time > 3.0:
                self.is_running_forward = True 
                self.controller.click(res_pos[0], res_pos[1])
                self.last_restart_time = now
                
                self.challenge_count += 1
                print(f"\n⚔️ [进程汇报] 重新开启副本，开始第 {self.challenge_count} 次挑战...")
                
                time.sleep(0.5)

    def handle_dungeon(self, img):
        joy_right = config.COORDS["joystick_right"]
        joy_left = config.COORDS["joystick_left"]
        
        go_pos, _, _ = find_target_center(img, config.ASSETS["btn_go"], threshold=config.VISION["match_threshold"])
        if go_pos and not self.is_running_forward:
            self.is_running_forward = True

        if self.is_running_forward:
            self.controller.stop_auto_attack()
            self.controller.touch_down(joy_right[0], joy_right[1])
            
            player_pos = self.detector.detect_player(img, conf=0.25)
            if player_pos and player_pos[0] > 1400:
                self.is_running_forward = False
                
                self.controller.touch_up(joy_right[0], joy_right[1])
                time.sleep(0.05)
                self.controller.click(joy_left[0], joy_left[1]) 
                self.last_skill_time = 0 
                self.controller.start_auto_attack()
        else:
            self.controller.start_auto_attack()
            now = time.time()
            if now - self.last_skill_time > random.uniform(1.5, 2.5):
                target = random.choice(config.COORDS["skills"])
                self.controller.click(target[0], target[1])
                self.last_skill_time = now

    def handle_unknown(self):
        joy_right = config.COORDS["joystick_right"]
        self.controller.stop_auto_attack()
        self.controller.touch_up(joy_right[0], joy_right[1])