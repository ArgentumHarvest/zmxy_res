import queue
import threading
import unittest
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import patch
from PIL import Image
import app
from quiz_core import QuestionBank, Reading


class PanelTests(unittest.TestCase):
    def test_confirmed_gem_merchant(self):
        bank = QuestionBank(Path(__file__).with_name('questions.json'))
        question = '善见城中何人可以分解宝石？'
        result = bank.choose(question, ['珍宝商人', '神秘商人', '九天玄女', '王母娘娘'])
        self.assertTrue(result.safe)
        self.assertEqual(result.index, 0)
        self.assertEqual(result.answer, '珍宝商人')
        self.assertEqual(result.source_ids, [57])
        self.assertFalse(bank.choose(question, ['黑市商人', '神秘商人', '九天玄女', '王母娘娘']).safe)

    def test_confirmed_pet_rebirth_wording(self):
        bank = QuestionBank(Path(__file__).with_name('questions.json'))
        q = '宠物转生要找哪个接引人？'
        opts = ['九天玄女', '公冶灵儿', '神秘商人', '王母娘娘']
        result = bank.choose(q, opts)
        self.assertTrue(result.safe)
        self.assertEqual(result.index, 1)
        self.assertEqual(result.source_ids, [135])
        self.assertFalse(bank.choose(q, ['公治灵儿', '甲', '乙', '丙']).safe)
        self.assertFalse(bank.choose('宠物转生不要找哪个接引人？', opts).safe)
        self.assertFalse(bank.choose('下列哪一项不是灵宠转生的条件？', opts).safe)

    def test_answer_remains_visible_when_options_are_missing(self):
        bank = QuestionBank(Path(__file__).with_name('questions.json'))
        decision = bank.choose('天树王每日免费挑战次数几次？', ['5', '', '2', '3'])
        self.assertFalse(decision.safe)
        self.assertEqual(decision.answer, '2')
        self.assertIsNone(decision.index)

    def test_bank_and_shuffled_answers(self):
        bank = QuestionBank(Path(__file__).with_name('questions.json'))
        self.assertEqual(len(bank.records), 172)
        for row in bank.records:
            for pos in range(4):
                choices = ['测试甲', '测试乙', '测试丙']
                choices.insert(pos, row['answer'])
                answer = bank.choose(row['question'], choices)
                self.assertTrue(answer.safe)
                self.assertEqual(answer.index, pos)
        self.assertFalse(bank.choose('下列哪一个是小白龙转职名称？', ['雷霆', '龙影', '暗影', '魔猿']).safe)
        self.assertFalse(bank.choose('世界BOSS伤害达到多少可以获得排行奖励？', ['0.05%', '5%', '50%', '100%']).safe)

    def test_no_input_or_hotkey_code(self):
        for path in Path(__file__).parent.glob('*.py'):
            if path.name.startswith('test_'):
                continue
            text = path.read_text(encoding='utf-8-sig')
            for forbidden in ('SendInput', 'SetCursorPos', 'mouse_event', 'keybd_event', 'GetAsyncKeyState', 'RegisterHotKey', 'win_control'):
                self.assertNotIn(forbidden, text)

    def test_continues_after_transition_and_new_round(self):
        panel = app.App.__new__(app.App)
        panel.events = queue.Queue()
        panel.bank = QuestionBank(Path(__file__).with_name('questions.json'))
        panel.hwnd = 1
        def reading(number):
            return Reading(str(number), '遗忘灵宠潜能需要消耗什么道具？', ['去灵花', '明灵花', '启蒙花', '益灵花'], .99, (0, 0, 100, 100), [], [])
        stream = iter([reading(1), ValueError('正在切换'), reading(2), reading(1)])
        class FastStop:
            stopped = False
            def is_set(self): return self.stopped
            def wait(self, _): return self.stopped
        stop = FastStop()
        def read(_):
            try:
                item = next(stream)
            except StopIteration:
                stop.stopped = True
                raise ValueError('测试结束')
            if isinstance(item, Exception): raise item
            return item
        panel.engine = SimpleNamespace(read=read)
        panel.win = SimpleNamespace(capture=lambda *args: Image.new('RGB', (100, 100), 'white'))
        with patch.object(app, 'locate_panel', return_value=(0, 0, 100, 100)):
            panel.run(2, None, 1, stop)
        events = list(panel.events.queue)
        self.assertEqual([e[2].number for e in events if e[0] == 'answer'], ['1', '2', '1'])
        self.assertTrue(any(e[0] == 'waiting' for e in events))

    def test_pause_discards_pending_result(self):
        panel = app.App.__new__(app.App)
        panel.events = queue.Queue()
        panel.session = 2
        class Var:
            value = ''
            def set(self, v): self.value = v
        panel.status, panel.answer, panel.question, panel.options, panel.detail = [Var() for _ in range(5)]
        panel.answer.set('已暂停')
        panel.root = SimpleNamespace(after=lambda *args: None)
        panel.events.put(('waiting', 1, '旧会话的结果'))
        panel.poll()
        self.assertEqual(panel.answer.value, '已暂停')


if __name__ == '__main__':
    unittest.main()
