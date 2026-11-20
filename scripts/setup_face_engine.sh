#!/usr/bin/env bash
# One-command face verification setup for the backend server.
#
#   cd /var/www          # or the backend project root
#   bash scripts/setup_face_engine.sh
#
# Optional:
#   PYTHON=/usr/bin/python3.12 bash scripts/setup_face_engine.sh
#   FACE_MODEL_DIR=/opt/face_models bash scripts/setup_face_engine.sh
#
# It creates .venv-face, installs OpenCV + numpy, downloads the YuNet and
# SFace models and prints a health report. Safe to run again.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PYTHON="${PYTHON:-python3}"
VENV_DIR="${FACE_VENV_DIR:-$ROOT/.venv-face}"
VENV_DIR="$(mkdir -p "$(dirname "$VENV_DIR")" 2>/dev/null && cd "$(dirname "$VENV_DIR")" && pwd)/$(basename "$VENV_DIR")" || {
  echo "ERROR: Cannot access FACE_VENV_DIR parent. Choose a writable path, e.g. /opt/demandium-face/.venv-face, or run setup with sudo." >&2
  exit 1
}
if ! command -v "$PYTHON" >/dev/null 2>&1; then
  echo "ERROR: $PYTHON not found. Install Python 3.10-3.12 first (apt install python3 python3-venv python3-pip)." >&2
  exit 1
fi

echo "==> Using $($PYTHON --version)"
if [ ! -d "$VENV_DIR" ]; then
  "$PYTHON" -m venv "$VENV_DIR" || {
    echo "ERROR: Cannot create virtual environment at $VENV_DIR. Set FACE_VENV_DIR to a writable path or run setup with sudo." >&2
    exit 1
  }
fi

echo "==> Installing Python packages"
"$VENV_DIR/bin/python" -m pip install --upgrade pip >/dev/null
"$VENV_DIR/bin/python" -m pip install -r "$ROOT/requirements-face.txt"

export FACE_MODEL_DIR="${FACE_MODEL_DIR:-$ROOT/storage/app/private/face_models}"
echo "==> Downloading face models into $FACE_MODEL_DIR"
"$VENV_DIR/bin/python" scripts/download_face_models.py

echo "==> Running health check"
"$VENV_DIR/bin/python" scripts/face_engine.py health

echo
echo "Done. Add this to .env if you use a non-default Python location:"
echo "  FACE_VENV_DIR=$VENV_DIR"
echo "  FACE_PYTHON_BINARY=$VENV_DIR/bin/python"
echo "  FACE_MODEL_DIR=$FACE_MODEL_DIR"
echo
echo "Then run: php artisan migrate --force && php artisan face:check"
