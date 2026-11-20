import json
import os
import sys

import cv2
import numpy as np


def models_dir():
    return os.environ.get(
        "FACE_MODEL_DIR",
        os.path.join(os.path.dirname(__file__), "..", "storage", "app", "private", "face_models"),
    )


def embedding(image_path):
    root = models_dir()
    detector_path = os.path.join(root, "face_detection_yunet_2023mar.onnx")
    recognizer_path = os.path.join(root, "face_recognition_sface_2021dec.onnx")
    if not os.path.isfile(detector_path) or not os.path.isfile(recognizer_path):
        raise RuntimeError("Face model files are missing; run scripts/download_face_models.py")

    image = cv2.imread(image_path)
    if image is None:
        raise ValueError("capture_invalid: Could not read the captured image")

    height, width = image.shape[:2]
    detector = cv2.FaceDetectorYN.create(
        detector_path, "", (width, height), 0.80, 0.30, 5000
    )
    _, faces = detector.detect(image)
    if faces is None or len(faces) != 1:
        raise ValueError("capture_invalid: Capture exactly one clear face")

    recognizer = cv2.FaceRecognizerSF.create(recognizer_path, "")
    aligned = recognizer.alignCrop(image, faces[0])
    vector = recognizer.feature(aligned).reshape(-1).astype(np.float32)
    norm = float(np.linalg.norm(vector))
    if norm == 0:
        raise ValueError("capture_invalid: Face feature could not be created")
    return (vector / norm).tolist()


def cosine(a, b):
    left = np.asarray(a, dtype=np.float32).reshape(-1)
    right = np.asarray(b, dtype=np.float32).reshape(-1)
    if left.shape != right.shape or left.size == 0:
        raise ValueError("Face template is invalid")
    left /= max(float(np.linalg.norm(left)), 1e-12)
    right /= max(float(np.linalg.norm(right)), 1e-12)
    return float(np.dot(left, right))


if __name__ == "__main__":
    try:
        action = sys.argv[1]
        if action == "embed":
            print(json.dumps({"ok": True, "embedding": embedding(sys.argv[2])}))
        elif action == "match":
            score = cosine(json.loads(sys.argv[3]), embedding(sys.argv[2]))
            threshold = float(os.environ.get("FACE_MATCH_THRESHOLD", "0.363"))
            print(json.dumps({"ok": True, "score": score, "matched": score >= threshold}))
        else:
            raise ValueError("Expected action: embed or match")
    except Exception as exc:
        message = str(exc)
        print(json.dumps({
            "ok": False,
            "error": message,
            "error_code": "capture_invalid" if message.startswith("capture_invalid:") else "engine_error",
        }))
        sys.exit(2)
