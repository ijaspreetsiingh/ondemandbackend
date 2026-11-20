import os
import urllib.request

root = os.environ.get(
    "FACE_MODEL_DIR",
    os.path.join(os.path.dirname(__file__), "..", "storage", "app", "private", "face_models"),
)
os.makedirs(root, mode=0o700, exist_ok=True)
models = {
    "face_detection_yunet_2023mar.onnx":
        "https://github.com/opencv/opencv_zoo/raw/refs/heads/main/models/face_detection_yunet/face_detection_yunet_2023mar.onnx",
    "face_recognition_sface_2021dec.onnx":
        "https://github.com/opencv/opencv_zoo/raw/refs/heads/main/models/face_recognition_sface/face_recognition_sface_2021dec.onnx",
}
for filename, url in models.items():
    target = os.path.join(root, filename)
    if not os.path.exists(target):
        print("Downloading", filename)
        request = urllib.request.Request(url, headers={"User-Agent": "face-model-setup"})
        with urllib.request.urlopen(request, timeout=120) as response, open(target, "wb") as output:
            output.write(response.read())
        os.chmod(target, 0o600)
print("Face model files are ready in", os.path.abspath(root))
