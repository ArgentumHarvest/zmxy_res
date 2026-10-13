import sys
import traceback
import multiprocessing

# 引入我们解耦后的核心模块
from game_bot import GameBot

def start_bot(window_title):
    """
    [独立进程入口]
    每个模拟器窗口将运行在这个函数中。
    在多开模式下，操作系统会为每个窗口分配一个完全独立的 Python 进程。
    """
    print(f"[{window_title}] 🤖 挂机引擎初始化中...")
    try:
        # 实例化大脑引擎，将特定的窗口名作为参数传入！
        bot = GameBot(window_title=window_title)
        # 启动主循环监听
        bot.run()
        
    except KeyboardInterrupt:
        # 捕获当前子进程的 Ctrl+C 指令
        print(f"\n[{window_title}] 🛑 收到撤退指令，当前独立进程正在退出...")
        sys.exit(0)
        
    except Exception as e:
        # 捕获致命错误，附带窗口名前缀，方便多开时排查是哪个号出了 Bug
        print(f"\n[{window_title}] ❌ 系统发生严重崩溃: {e}")
        traceback.print_exc()
        sys.exit(1)


def main():
    print("==================================================")
    print("                  🚀 XG助手启动                  ")
    print("==================================================")
    print("⚠️ 注意：模拟器可以挂后台，但请不要最小化，")
    print("         请不要把鼠标指针放在模拟器窗口上")
    print("提示: 运行过程中如需安全停止，请在控制台按 Ctrl + C \n")
    
    # ==========================================
    # 🌟 [配置区] 在这里选择你要挂机的窗口名称
    # ==========================================
    # 单开写法: 
    # target_windows = ["雷电模拟器"]
    
    # 多开写法 (确保模拟器窗口标题与这里一模一样): 
    # target_windows = ["雷电模拟器", "雷电模拟器-1", "雷电模拟器-2"]
    
    target_windows = ["雷电模拟器"] 

    processes = []

    try:
        # 遍历配置的窗口，为每一个窗口分配一个独立的进程 (Process)
        for win_title in target_windows:
            # target 指定运行的函数，args 传入窗口名参数 (注意逗号不可省略)
            p = multiprocessing.Process(target=start_bot, args=(win_title,))
            processes.append(p)
            p.start() # 扣下扳机，启动进程！
            print(f"✅ 已分配独立运算核心监控: {win_title} (PID: {p.pid})")

        # 主进程在这里挂起，等待所有子进程结束 (实际上由于 while True，会一直运行)
        for p in processes:
            p.join()
            
    except KeyboardInterrupt:
        # 当你在控制台按下 Ctrl+C 时，主进程会接管并统一清理所有子号
        print("\n\n🛑 主控台收到人为中断信号 (KeyboardInterrupt)！")
        print("🔧 正在向所有模拟器进程下达强制撤退指令...")
        
        # 遍历并终止所有正在运行的子进程，防止留下内存僵尸
        for p in processes:
            if p.is_alive():
                p.terminate()
                p.join()
                
        print("✅ 所有进程已安全清理，系统完全停止，再见！")
        sys.exit(0)

if __name__ == "__main__":
    # ⚠️ Windows 系统下使用多进程，必须加上 freeze_support() 
    # 这是为了防止以后如果你用 PyInstaller 打包成 .exe 时出现无限疯狂弹窗的 Bug
    multiprocessing.freeze_support()
    main()