from ultralytics import YOLO

if __name__ == '__main__':
    # 加载训练好的模型
    model = YOLO("best.pt")

    # 在测试集上评估模型
    metrics = model.val(data="dataset1/data.yaml", split='test')
    
    print("-" * 30)
    print(f"测试集评估完成！")
    print(f"mAP@0.5:    {metrics.box.map50:.4f}") # 两框重叠面积大于一半则为正确
    print(f"mAP@0.5:95: {metrics.box.map:.4f}") # 两框重叠面积从0.5到0.95的占比平均值

