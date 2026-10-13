from ultralytics import YOLO

if __name__ == '__main__':
    model = YOLO("yolov8n.pt")  # 加载一个预训练的模型

    model.train(data = "dataset2/data.yaml", epochs = 100, imgsz = 640)