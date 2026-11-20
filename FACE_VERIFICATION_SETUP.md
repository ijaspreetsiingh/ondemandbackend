# Face verification deployment

The matcher runs on the backend server using OpenCV YuNet and SFace. The mobile apps upload camera captures to this Laravel backend; no third-party face-recognition API is called. The enrolled face embedding is encrypted with Laravel `APP_KEY`. The original enrollment capture is not saved. Only the third failed booking capture is retained privately for Provider review, and the scheduler removes it after 24 hours.

## Server setup (one command)

```sh
cd /var/www                 # backend project root
bash scripts/setup_face_engine.sh
php artisan migrate --force
php artisan optimize:clear
php artisan face:check
```

`setup_face_engine.sh` creates `.venv-face`, installs `requirements-face.txt`, downloads the two models into `storage/app/private/face_models`, and prints a health report. Python 3.10+ is supported.

If Python is somewhere else:

```sh
PYTHON=/usr/bin/python3.12 bash scripts/setup_face_engine.sh
```

Then add to `.env` only if you use a non-default location:

```dotenv
FACE_PYTHON_BINARY=/var/www/.venv-face/bin/python
FACE_MODEL_DIR=/var/www/storage/app/private/face_models
FACE_MATCH_THRESHOLD=0.363
FACE_MIN_DETECTION_SCORE=0.60
```

`php artisan face:check` reports exactly what is missing: Python, OpenCV/numpy, model files, or the `serviceman_face_profiles` / `booking_face_verifications` tables. You can also test a real capture:

```sh
php artisan face:check storage/app/private/test-selfie.jpg
```

## Important: run the migration

The `booking_face_verifications` and `serviceman_face_profiles` tables are created by:

```
Modules/BookingModule/Database/Migrations/2026_11_19_000001_create_serviceman_face_verification_tables.php
```

If they are missing, enrollment/verification returns HTTP 500 and the app shows "face verify nahi ho raha". Always run `php artisan migrate --force` after deploying.

## Turbans, pagris, caps, dupattas and beards

The detector is configured to accept covered heads:

- YuNet confidence is lowered from 0.9 to `FACE_MIN_DETECTION_SCORE=0.60`.
- Three detection passes are tried: normal, padded + contrast enhanced (CLAHE), and upscaled.
- If more than one face is present, the largest face (the selfie subject) is used.
- Only the face/eyes need to be visible; a turban, pagri, cap, dupatta, hijab or beard is fine.
- Sunglasses, a hand over the face, or a face partly outside the frame still fail and ask for a retry.

## Runtime behavior

- A Service Man enrolls once after login. The server extracts and encrypts the face embedding. `POST face-profile/enroll` accepts `refresh=1` to replace an old/bad enrollment.
- After customer OTP entry, the camera opens inside the existing OTP popup and submits the OTP and capture.
- An unreadable capture or a capture without a detectable face asks for a retry and does not consume an identity-mismatch attempt. Identity mismatch is limited to three attempts for that booking.
- After three mismatches, Provider receives a booking review notification. Provider can call/message the Service Man and approve that booking once. Approval starts only that booking and does not change the enrolled face.
- If the Python engine itself is unavailable, the booking is sent to Provider review instead of leaving the serviceman stuck (`FACE_PROVIDER_FALLBACK=true`).
- Backend status-change endpoints require a successful face match or that booking's Provider approval.

## Security limitation

SFace compares face images; YuNet detects faces. This implementation does **not** provide certified liveness or anti-spoof detection. A printed photo or replayed screen may fool a static image comparison. Do not treat this as proof of live presence or a high-assurance identity check. Add a liveness-capable SDK or reviewed challenge-response solution before relying on this for fraud prevention.
