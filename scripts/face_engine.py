"""Local face embedding / matching engine.

Runs OpenCV YuNet (detection) + SFace (recognition) in a subprocess so the
Laravel app never has to load native libraries itself.

Turban / pagri / dupatta / cap friendly:
  * detection confidence is deliberately lower than OpenCV's 0.9 default
  * a padded copy of the image is tried so faces near an edge are not missed
  * a contrast-enhanced (CLAHE) copy is tried for low light / deep shadows
  * if more than one face is present the largest (selfie subject) is used

Usage:
  python face_engine.py health
  python face_engine.py embed  <image>
  python face_engine.py match  <image> '<json embedding array>'
"""

import json
import os
import sys

import cv2
import numpy as np

DETECTOR_FILE = "face_detection_yunet_2023mar.onnx"
RECOGNIZER_FILE = "face_recognition_sface_2021dec.onnx"


def models_dir():
    return os.environ.get("FACE_MODEL_DIR") or os.path.join(
        os.path.dirname(__file__), "..", "storage", "app", "private", "face_models"
    )


def model_paths():
    root = models_dir()
    return os.path.join(root, DETECTOR_FILE), os.path.join(root, RECOGNIZER_FILE)


def float_env(name, default):
    try:
        return float(os.environ.get(name, default))
    except (TypeError, ValueError):
        return float(default)


def load_image(image_path):
    """Read a camera capture even when it has no/odd file extension."""
    image = cv2.imread(image_path, cv2.IMREAD_COLOR)
    if image is None:
        try:
            data = np.fromfile(image_path, dtype=np.uint8)
            image = cv2.imdecode(data, cv2.IMREAD_COLOR) if data.size else None
        except Exception:
            image = None
    if image is None or image.size == 0:
        raise ValueError("capture_invalid: Could not read the captured image")
    return image


def enhance(image):
    """CLAHE on the luminance channel: helps beards, turbans and low light."""
    lab = cv2.cvtColor(image, cv2.COLOR_BGR2LAB)
    l_channel, a_channel, b_channel = cv2.split(lab)
    l_channel = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8)).apply(l_channel)
    return cv2.cvtColor(cv2.merge([l_channel, a_channel, b_channel]), cv2.COLOR_LAB2BGR)


def prepare(image, scale=1.0, pad_ratio=0.10, use_clahe=False):
    working = enhance(image) if use_clahe else image
    if scale and abs(scale - 1.0) > 0.01:
        working = cv2.resize(
            working, None, fx=scale, fy=scale, interpolation=cv2.INTER_CUBIC
        )
    height, width = working.shape[:2]
    pad_y, pad_x = int(height * pad_ratio), int(width * pad_ratio)
    if pad_y or pad_x:
        working = cv2.copyMakeBorder(
            working, pad_y, pad_y, pad_x, pad_x, cv2.BORDER_REPLICATE
        )
    return working


def detect_faces(image):
    """Return (working_image, faces, attempts) using progressively harder passes."""
    detector_path, _ = model_paths()
    if not os.path.isfile(detector_path):
        raise RuntimeError("Face model files are missing; run scripts/download_face_models.py")

    score_threshold = max(0.3, min(0.95, float_env("FACE_MIN_DETECTION_SCORE", 0.60)))
    height, width = image.shape[:2]
    upscale = 2.0 if max(width, height) < 900 else 1.0

    attempts = [
        {"scale": 1.0, "pad_ratio": 0.10, "use_clahe": False},
        {"scale": 1.0, "pad_ratio": 0.18, "use_clahe": True},
        {"scale": upscale, "pad_ratio": 0.18, "use_clahe": True},
    ]

    for attempt in attempts:
        working = prepare(image, **attempt)
        working_height, working_width = working.shape[:2]
        detector = cv2.FaceDetectorYN.create(
            detector_path,
            "",
            (working_width, working_height),
            score_threshold,
            0.30,
            5000,
        )
        _, faces = detector.detect(working)
        if faces is not None and len(faces) > 0:
            return working, faces, score_threshold

    raise ValueError(
        "capture_invalid: No face detected. Keep your face centered in good light, "
        "with your eyes, nose and mouth visible. A turban or pagri is okay if it does not cover your face."
    )


def pick_face(faces):
    """Use the largest detected face (the person holding the phone)."""
    if len(faces) == 1:
        return faces[0], 1
    areas = faces[:, 2] * faces[:, 3]
    return faces[int(np.argmax(areas))], int(len(faces))


def embedding(image_path):
    detector_path, recognizer_path = model_paths()
    if not os.path.isfile(detector_path) or not os.path.isfile(recognizer_path):
        raise RuntimeError("Face model files are missing; run scripts/download_face_models.py")

    image = load_image(image_path)
    working, faces, score_threshold = detect_faces(image)
    face, faces_detected = pick_face(faces)

    recognizer = cv2.FaceRecognizerSF.create(recognizer_path, "")
    aligned = recognizer.alignCrop(working, face)
    if aligned is None or aligned.size == 0:
        raise ValueError("capture_invalid: Face could not be aligned; try again")

    vector = recognizer.feature(aligned).reshape(-1).astype(np.float32)
    norm = float(np.linalg.norm(vector))
    if norm == 0:
        raise ValueError("capture_invalid: Face feature could not be created")

    meta = {
        "faces_detected": faces_detected,
        "detection_score": float(face[-1]),
        "detection_threshold": score_threshold,
    }
    return (vector / norm).tolist(), meta


def cosine(a, b):
    left = np.asarray(a, dtype=np.float32).reshape(-1)
    right = np.asarray(b, dtype=np.float32).reshape(-1)
    if left.shape != right.shape or left.size == 0:
        raise ValueError("Face template is invalid")
    left /= max(float(np.linalg.norm(left)), 1e-12)
    right /= max(float(np.linalg.norm(right)), 1e-12)
    return float(np.dot(left, right))


def health():
    detector_path, recognizer_path = model_paths()
    info = {
        "python": sys.version.split()[0],
        "numpy": np.__version__,
        "opencv": cv2.__version__,
        "model_dir": os.path.abspath(models_dir()),
        "detector_model": os.path.isfile(detector_path),
        "recognizer_model": os.path.isfile(recognizer_path),
        "match_threshold": float_env("FACE_MATCH_THRESHOLD", 0.363),
        "min_detection_score": float_env("FACE_MIN_DETECTION_SCORE", 0.60),
    }
    return info, info["detector_model"] and info["recognizer_model"]


if __name__ == "__main__":
    try:
        action = sys.argv[1] if len(sys.argv) > 1 else "health"
        if action == "embed":
            vector, meta = embedding(sys.argv[2])
            print(json.dumps({"ok": True, "embedding": vector, **meta}))
        elif action == "match":
            vector, meta = embedding(sys.argv[2])
            score = cosine(json.loads(sys.argv[3]), vector)
            threshold = float_env("FACE_MATCH_THRESHOLD", 0.363)
            print(json.dumps({
                "ok": True,
                "score": score,
                "matched": score >= threshold,
                "threshold": threshold,
                **meta,
            }))
        elif action == "health":
            info, ready = health()
            print(json.dumps({"ok": ready, "health": info}))
            if not ready:
                sys.exit(2)
        else:
            raise ValueError("Expected action: health, embed or match")
    except Exception as exc:
        message = str(exc)
        print(json.dumps({
            "ok": False,
            "error": message,
            "error_code": "capture_invalid" if message.startswith("capture_invalid:") else "engine_error",
        }))
        sys.exit(2)
