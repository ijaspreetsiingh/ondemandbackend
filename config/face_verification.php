<?php

return [
    'python_binary' => env('FACE_PYTHON_BINARY', base_path('.venv-face/bin/python')),
    'model_dir' => env('FACE_MODEL_DIR', storage_path('app/private/face_models')),
    'match_threshold' => (float) env('FACE_MATCH_THRESHOLD', 0.363),
];
