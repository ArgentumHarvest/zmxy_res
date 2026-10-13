"""Local-only quiz recognition and conservative answer selection."""
import json
import re
import unicodedata
from dataclasses import dataclass, field
from difflib import SequenceMatcher
from pathlib import Path


def normalize(text):
    text = unicodedata.normalize('NFKC', text).lower()
    # Keep numeric meaning, including decimal points and percent signs.
    return ''.join(c for c in text if c.isalnum() or c in '.%+-')


@dataclass
class Decision:
    safe: bool
    reason: str
    index: int | None = None
    answer: str = ''
    source_ids: list = field(default_factory=list)


class QuestionBank:
    def __init__(self, path):
        self.records = json.loads(Path(path).read_text(encoding='utf-8-sig'))
        self.lookup = {}
        for row in self.records:
            for key in dict.fromkeys(normalize(q) for q in [row['question'], *row.get('question_aliases', [])]):
                self.lookup.setdefault(key, []).append(row)

    def choose(self, question, options):
        rows = self.lookup.get(normalize(question), [])
        if not rows:
            key = normalize(question)
            candidates = sorted(self.lookup, key=lambda q: SequenceMatcher(None, key, q).ratio(), reverse=True)
            hint = ''
            if candidates and SequenceMatcher(None, key, candidates[0]).ratio() >= .75:
                row = self.lookup[candidates[0]][0]
                hint = f"；相近题 #{row['id']}：{row['question']} → {row['answer']}（仅供人工核对）"
            return Decision(False, '题干未精确匹配' + hint)
        answers = ' / '.join(dict.fromkeys(r['answer'] for r in rows))
        if len(options) != 4 or any(not normalize(x) for x in options):
            return Decision(False, '题目已匹配，选项未识别完整；请按答案文字选择',
                            answer=answers, source_ids=[r['id'] for r in rows])
        hits = []
        for i, option in enumerate(options):
            matched = [r for r in rows if normalize(option) in
                       {normalize(a) for a in [r['answer'], *r.get('answer_aliases', [])]}]
            if matched:
                hits.append((i, matched))
        if len(hits) != 1:
            return Decision(False, '题目已匹配，选项位置无法唯一确定；请核对答案文字',
                            answer=answers, source_ids=[r['id'] for r in rows])
        i, matches = hits[0]
        return Decision(True, '题干和答案均匹配', i, options[i], [r['id'] for r in matches])


@dataclass
class Reading:
    number: str
    question: str
    options: list
    confidence: float
    panel: tuple
    centers: list
    raw: list

    @property
    def signature(self):
        return (self.number, normalize(self.question), tuple(map(normalize, self.options)))


def locate_panel(image):
    """Find the large peach-colored scroll in the supplied screenshot."""
    import cv2
    import numpy as np
    rgb = np.asarray(image.convert('RGB')).astype(np.int16)
    r, g, b = rgb[:, :, 0], rgb[:, :, 1], rgb[:, :, 2]
    mask = ((r > 175) & (g > 115) & (b > 80) & (r-g > 18) & (r-g < 100) & (g-b > 5)).astype('uint8') * 255
    mask = cv2.morphologyEx(mask, cv2.MORPH_CLOSE, np.ones((9, 9), np.uint8))
    count, labels, stats, _ = cv2.connectedComponentsWithStats(mask)
    ih, iw = mask.shape
    candidates = []
    for x, y, w, h, area in stats[1:]:
        if (w > iw*.35 and h > ih*.25 and 1.35 < w/h < 2.4
                and area > iw*ih*.12 and area/(w*h) > .65):
            candidates.append((area, (int(x), int(y), int(x+w), int(y+h))))
    if not candidates:
        raise ValueError('未找到完整答题卷轴，请进入题目页并保持窗口无遮挡')
    return max(candidates)[1]


class Recognizer:
    def __init__(self):
        from rapidocr_onnxruntime import RapidOCR
        self.engine = RapidOCR(intra_op_num_threads=2, inter_op_num_threads=1)

    def read(self, image):
        import numpy as np
        from PIL import Image, ImageOps
        panel = locate_panel(image)
        crop = image.crop(panel).convert('RGB')
        scale = min(1.0, 1100 / crop.width)
        if scale < 1:
            crop = crop.resize((round(crop.width*scale), round(crop.height*scale)), Image.Resampling.LANCZOS)
        result, _ = self.engine(np.asarray(crop)[:, :, ::-1].copy())
        raw = []
        groups = [[] for _ in range(6)]
        for box, text, score in result or []:
            xs, ys = [float(p[0]) for p in box], [float(p[1]) for p in box]
            cx, cy = (min(xs)+max(xs))/2/crop.width, (min(ys)+max(ys))/2/crop.height
            item = {'text': text, 'score': float(score), 'x': cx, 'y': cy}
            raw.append(item)
            if cy < .20 and .30 < cx < .7:
                groups[0].append(item)
            elif .20 <= cy < .43 and cx > .09:
                groups[1].append(item)
            elif .43 <= cy < .545:
                groups[2].append(item)
            elif .545 <= cy < .657:
                groups[3].append(item)
            elif .657 <= cy < .77:
                groups[4].append(item)
            elif .77 <= cy < .91:
                groups[5].append(item)
        # A text detector often misses the isolated digit "1". Recognize missing
        # rows directly after tightly cropping their dark glyphs, bypassing detection.
        for index, (top, bottom) in enumerate(((.44, .535), (.55, .645), (.66, .755), (.775, .885)), 2):
            if groups[index]:
                continue
            roi = crop.crop((round(crop.width*.075), round(crop.height*top),
                             round(crop.width*.92), round(crop.height*bottom)))
            ink = roi.convert('L').point(lambda v: 255 if v < 125 else 0)
            box = ink.getbbox()
            if box is None:
                continue
            glyphs = ImageOps.expand(roi.crop(box), border=8, fill='white')
            factor = max(1, min(3, 96/glyphs.height))
            glyphs = glyphs.resize((round(glyphs.width*factor), round(glyphs.height*factor)), Image.Resampling.LANCZOS)
            recovered, _ = self.engine(np.asarray(glyphs)[:, :, ::-1].copy(), use_det=False, use_cls=False, use_rec=True)
            if recovered:
                text, score = recovered[0]
                if text and float(score) >= .85:
                    item = {'text': text, 'score': float(score), 'x': .15,
                            'y': (top+bottom)/2, 'recovered': True}
                    groups[index].append(item)
                    raw.append(item)
        texts = [''.join(x['text'] for x in sorted(g, key=lambda i: (round(i['y']*20), i['x']))) for g in groups]
        header = re.search(r'第\s*(\d+)\s*题', texts[0])
        if not header:
            raise ValueError('未识别到“第几题”，可能尚未开始、正在切换或本轮已结束')
        if not groups[1]:
            raise ValueError('暂时没有读清题干，正在重试')
        x1, y1, x2, y2 = panel
        centers = [(round(x1+(x2-x1)*.55), round(y1+(y2-y1)*cy)) for cy in (.486, .598, .710, .822)]
        confidence = min(x['score'] for g in groups for x in g)
        return Reading(header[1], texts[1], texts[2:], confidence, panel, centers, raw)
