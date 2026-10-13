"""Read-only live answer panel; no hotkeys and no simulated input."""
import argparse
import json
import queue
import sys
import threading
import time
from pathlib import Path
from dataclasses import asdict
from quiz_core import QuestionBank, Recognizer, locate_panel

BASE = Path(__file__).resolve().parent


def evaluate(engine, bank, image):
    reading = engine.read(image)
    decision = bank.choose(reading.question, reading.options)
    if reading.confidence < .88:
        decision.safe = False
        decision.reason = '文字不够清楚，请核对题干和选项'
    return reading, decision


class App:
    def __init__(self, root):
        import tkinter as tk
        from tkinter import ttk
        import window_capture as win
        self.root, self.win = root, win
        self.engine = None
        self.bank = QuestionBank(BASE/'questions.json')
        self.events = queue.Queue()
        self.worker = None
        self.stop_event = threading.Event()
        self.stop_event.set()
        self.session = 0
        self.choices = []
        root.title('实时答案面板 · 1.3 问法修复版')
        width, height = 420, 600
        root.geometry(f'{width}x{height}+{max(0, root.winfo_screenwidth()-width-20)}+70')
        root.minsize(350, 480)
        root.configure(bg='#f5f4f0')
        root.attributes('-topmost', True)
        style = ttk.Style()
        style.theme_use('clam')
        style.configure('TFrame', background='#f5f4f0')
        style.configure('TLabel', background='#f5f4f0', font=('Microsoft YaHei UI', 10))
        style.configure('TButton', font=('Microsoft YaHei UI', 10), padding=7)
        frame = ttk.Frame(root, padding=18)
        frame.pack(fill='both', expand=True)
        ttk.Label(frame, text='实时答案', font=('Microsoft YaHei UI', 23, 'bold')).pack(anchor='w')
        ttk.Label(frame, text='你答题、点下一题，这里自动更新。').pack(anchor='w', pady=(5, 15))
        row = ttk.Frame(frame)
        row.pack(fill='x')
        self.combo = ttk.Combobox(row, state='readonly')
        self.combo.pack(side='left', fill='x', expand=True)
        ttk.Button(row, text='刷新', command=self.refresh).pack(side='right', padx=(5, 0))
        actions = ttk.Frame(frame)
        actions.pack(fill='x', pady=10)
        self.start_button = ttk.Button(actions, text='开始显示答案', command=self.start)
        self.start_button.pack(side='left')
        ttk.Button(actions, text='暂停', command=self.pause).pack(side='left', padx=7)
        self.topmost = tk.BooleanVar(value=True)
        ttk.Checkbutton(actions, text='置顶', variable=self.topmost, command=lambda: root.attributes('-topmost', self.topmost.get())).pack(side='right')
        self.status = tk.StringVar(value='正在准备识别引擎…')
        self.answer = tk.StringVar(value='等待开始')
        self.question = tk.StringVar(value='把游戏窗口缩小，面板放在旁边。')
        self.options = tk.StringVar(value='')
        self.detail = tk.StringVar(value='内置 172 条题库 · 全程不操作鼠标键盘')
        labels = []
        for var, font, color, pady in [
            (self.status, ('Microsoft YaHei UI', 10), '#66645d', (5, 15)),
            (self.answer, ('Microsoft YaHei UI', 23, 'bold'), '#16744a', (0, 14)),
            (self.question, ('Microsoft YaHei UI', 12), '#252923', (0, 12)),
            (self.detail, ('Microsoft YaHei UI', 9), '#77766c', (0, 10))]:
            label = ttk.Label(frame, textvariable=var, font=font, foreground=color, wraplength=380, justify='left')
            label.pack(anchor='w', fill='x', pady=pady)
            labels.append(label)
        frame.bind('<Configure>', lambda e: [l.configure(wraplength=max(250, e.width-36)) for l in labels])
        ttk.Button(frame, text='用截图测试', command=self.test_image).pack(side='bottom', anchor='w')
        root.update_idletasks()
        self.hwnd = win.u.GetAncestor(root.winfo_id(), 2)
        root.protocol('WM_DELETE_WINDOW', self.close)
        self.refresh()
        threading.Thread(target=self.prepare, daemon=True).start()
        root.after(100, self.poll)

    def prepare(self):
        try:
            self.engine = Recognizer()
            self.events.put(('ready', 0, '准备就绪，点击“开始显示答案”'))
        except Exception as exc:
            self.events.put(('ready', 0, '引擎启动失败：'+str(exc)))

    def refresh(self):
        if self.worker and self.worker.is_alive():
            self.pause()
        self.choices = self.win.windows()
        self.combo['values'] = [f'{title}  [{hwnd}]' for hwnd, title in self.choices]
        if self.choices:
            self.combo.current(0)
        else:
            self.combo.set('未找到游戏，请先打开客户端再刷新')

    def pause(self):
        self.stop_event.set()
        self.session += 1
        self.status.set('已暂停，点击“开始显示答案”恢复')
        self.answer.set('已暂停')
        self.question.set('')
        self.options.set('')

    def start(self, image_path=None):
        if self.engine is None:
            self.status.set('识别引擎尚未准备好，请稍等')
            return
        if self.worker and self.worker.is_alive():
            if self.stop_event.is_set():
                self.status.set('正在结束上次识别，请稍后再点开始')
            return
        index = self.combo.current()
        if not image_path and (index < 0 or index >= len(self.choices)):
            self.status.set('请打开游戏，然后点“刷新”选择窗口')
            return
        hwnd = self.choices[index][0] if not image_path else None
        self.session += 1
        session = self.session
        self.stop_event = threading.Event()
        self.status.set('正在识别…')
        self.answer.set('等待题目')
        self.worker = threading.Thread(target=self.run, args=(hwnd, image_path, session, self.stop_event), daemon=True)
        self.worker.start()

    def test_image(self):
        from tkinter import filedialog
        if self.worker and self.worker.is_alive():
            self.pause()
            self.status.set('已暂停，稍后再点击“用截图测试”')
            return
        path = filedialog.askopenfilename(filetypes=[('截图', '*.png *.jpg *.jpeg *.bmp')])
        if path:
            self.start(path)

    def run(self, hwnd, image_path, session, stop):
        from PIL import Image, ImageChops, ImageStat
        previous = None
        while not stop.is_set():
            try:
                image = Image.open(image_path).convert('RGB') if image_path else self.win.capture(hwnd, self.hwnd)
                panel = image.crop(locate_panel(image))
                body = panel.crop((0, int(panel.height*.20), panel.width, int(panel.height*.93))).resize((220, 140)).convert('RGB')
                if previous is not None and max(ImageStat.Stat(ImageChops.difference(previous, body)).mean) > 2:
                    self.events.put(('waiting', session, '画面变化，正在识别新题…'))
                previous = body
                reading, decision = evaluate(self.engine, self.bank, image)
                if not stop.is_set():
                    self.events.put(('answer', session, reading, decision, bool(image_path)))
            except Exception as exc:
                previous = None
                if not stop.is_set():
                    self.events.put(('waiting', session, str(exc)))
            if image_path or stop.wait(.65):
                break

    def poll(self):
        try:
            while True:
                kind, session, *data = self.events.get_nowait()
                if kind != 'ready' and session != self.session:
                    continue
                if kind == 'ready':
                    self.status.set(data[0])
                elif kind == 'waiting':
                    self.answer.set('等待题目')
                    self.question.set('')
                    self.options.set('')
                    self.status.set(data[0])
                    self.detail.set('等待你手动进入下一题，会自动继续识别。')
                elif kind == 'answer':
                    reading, decision, offline = data
                    self.status.set(('截图测试' if offline else '持续识别中')+f' · 第 {reading.number} 题 · {time.strftime("%H:%M:%S")}')
                    self.question.set(reading.question)
                    self.options.set('\n'.join(f'{i+1}. {value}' for i, value in enumerate(reading.options)))
                    self.answer.set(f'第 {decision.index+1} 项\n{decision.answer}' if decision.safe
                                    else ('题库参考\n'+decision.answer if decision.answer else '请人工核对'))
                    self.detail.set(decision.reason)
        except queue.Empty:
            pass
        self.root.after(100, self.poll)

    def close(self):
        self.stop_event.set()
        self.root.destroy()


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--image')
    p.add_argument('--report')
    p.add_argument('--smoke-test')
    args = p.parse_args()
    if args.image:
        from PIL import Image
        r, d = evaluate(Recognizer(), QuestionBank(BASE/'questions.json'), Image.open(args.image))
        result = json.dumps({'reading': asdict(r), 'decision': asdict(d), 'mode': 'read-only'}, ensure_ascii=False, indent=2)
        if args.report:
            Path(args.report).write_text(result, encoding='utf-8')
        elif sys.stdout:
            print(result)
        return
    import tkinter as tk
    import window_capture as win
    win.dpi_aware()
    root = tk.Tk()
    if args.smoke_test:
        root.withdraw()
    app = App(root)
    if args.smoke_test:
        deadline = time.monotonic()+30
        while app.engine is None and time.monotonic() < deadline:
            time.sleep(.1)
        assert app.engine is not None
        root.update_idletasks()
        Path(args.smoke_test).write_text('Read-only panel GUI and OCR ready; capture not started', encoding='utf-8')
        app.close()
    else:
        root.mainloop()


if __name__ == '__main__':
    try:
        main()
    except Exception:
        import traceback
        target = Path(sys.executable).parent if getattr(sys, 'frozen', False) else BASE
        (target/'启动错误.txt').write_text(traceback.format_exc(), encoding='utf-8')
        if sys.stderr:
            traceback.print_exc()
        sys.exit(1)
