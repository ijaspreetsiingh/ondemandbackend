<?php

return [
    // Leave null to auto-detect (Linux venv, Windows venv, python3, python, py).
    // Set FACE_PYTHON_BINARY=/var/www/backend/.venv-face/bin/python to force one.
    'python_binary' => env('FACE_PYTHON_BINARY') ?: null,

    // Permit installing the isolated environment outside the webroot when the
    // deploy user cannot write into the backend checkout.
    'venv_dir' => env('FACE_VENV_DIR') ?: base_path('.venv-face'),

    'model_dir' => env('FACE_MODEL_DIR') ?: storage_path('app/private/face_models'),

    // SFace cosine distance threshold. 0.363 is the OpenCV reference value.
    'match_threshold' => (float) env('FACE_MATCH_THRESHOLD', 0.363),

    // YuNet confidence. Lower than the 0.9 default so turbans, pagris, caps,
    // dupattas, beards and glasses do not hide the face from the detector.
    'min_detection_score' => (float) env('FACE_MIN_DETECTION_SCORE', 0.60),

    // If the Python engine is temporarily unavailable, let the Provider
    // manually approve that booking instead of leaving the serviceman stuck.
    'provider_fallback_on_engine_error' => (bool) env('FACE_PROVIDER_FALLBACK', true),
];
