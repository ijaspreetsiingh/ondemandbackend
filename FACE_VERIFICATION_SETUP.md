# Face verification deployment

The matcher runs on the backend server using OpenCV YuNet and SFace. The mobile apps upload camera captures to this Laravel backend; no third-party face-recognition API is called. The enrolled face embedding is encrypted with Laravel `APP_KEY`. The original enrollment capture is not saved. Only the third failed booking capture is retained privately for Provider review, and the scheduler removes it after 24 hours.

## Server setup

1. Deploy the backend code and install Python 3.10–3.12 on the server.
2. Create a Python virtual environment and install the pinned packages:

   ```sh
   python3 -m venv /var/www/backend/.venv-face
   /var/www/backend/.venv-face/bin/pip install -r /var/www/backend/requirements-face.txt
   ```

3. Download the two model weights into private storage:

   ```sh
   cd /var/www/backend
   /var/www/backend/.venv-face/bin/python scripts/download_face_models.py
   ```

   The default folder is `storage/app/private/face_models`. Keep it private and outside the web root.
4. Set `FACE_PYTHON_BINARY=/var/www/backend/.venv-face/bin/python`. If using a different model folder, set `FACE_MODEL_DIR`. `FACE_MATCH_THRESHOLD` defaults to `0.363`; calibrate it using representative captures before production rollout.
5. Run `php artisan migrate --force`.
6. Ensure the Laravel scheduler runs every minute (`php artisan schedule:run` from cron) so temporary failed captures are removed after 24 hours.

## Runtime behavior

- A Service Man enrolls once after login. The server extracts and encrypts the face embedding.
- After customer OTP entry, the camera opens inside the existing OTP popup and submits the OTP and capture.
- An unreadable capture or a capture without exactly one detected face asks for a retry and does not consume an identity-mismatch attempt. Identity mismatch is limited to three attempts for that booking.
- After three mismatches, Provider receives a booking review notification. Provider can call/message the Service Man and approve that booking once. Approval starts only that booking and does not change the enrolled face.
- Backend status-change endpoints require a successful face match or that booking's Provider approval.

## Security limitation

SFace compares face images; YuNet detects faces. This implementation does **not** provide certified liveness or anti-spoof detection. A printed photo or replayed screen may fool a static image comparison. Do not treat this as proof of live presence or a high-assurance identity check. Add a liveness-capable SDK or reviewed challenge-response solution before relying on this for fraud prevention.
