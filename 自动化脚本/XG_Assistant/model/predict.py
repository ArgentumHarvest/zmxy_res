import cv2
from ultralytics import YOLO

model = YOLO("best_puzzle.pt")

image_path = "../dataset/captcha/captcha_1772874620.jpg"
img = cv2.imread(image_path)

# imread读取的是BGR格式，训练用的是RGB格式，需要转换
img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

results = model.predict(img_rgb)

for result in results:
    boxes = result.boxes
    for box in boxes:
        x1, y1, x2, y2 = map(int, box.xyxy[0])
        confidence = box.conf[0]
        class_id = int(box.cls[0])
        
        # 画框和置信度
        cv2.rectangle(img, (x1, y1), (x2, y2), (0, 255, 0), 2)
        label = f"{model.names[class_id]}: {confidence:.2f}"
        cv2.putText(img, label, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)

cv2.imshow("Detection", img)
cv2.waitKey(0)

cv2.destroyAllWindows()
