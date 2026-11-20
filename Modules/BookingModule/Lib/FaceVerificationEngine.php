<?php

namespace Modules\BookingModule\Lib;

use RuntimeException;
use Symfony\Component\Process\Process;

class FaceVerificationEngine
{
    private static ?string $resolvedBinary = null;

    public function embed(string $imagePath): array
    {
        return $this->run(['embed', $imagePath]);
    }

    public function match(string $imagePath, array $reference): array
    {
        return $this->run(['match', $imagePath, json_encode($reference, JSON_THROW_ON_ERROR)]);
    }

    /**
     * Diagnostics for `php artisan face:check`. Never throws.
     */
    public function health(): array
    {
        try {
            [$result] = $this->execute(['health']);
            return $result;
        } catch (\Throwable $exception) {
            return ['ok' => false, 'error' => $exception->getMessage()];
        }
    }

    /**
     * Resolve the Python interpreter once per PHP worker.
     *
     * Works on Linux (`python3`, `.venv-face/bin/python`) and Windows
     * (`.venv-face/Scripts/python.exe`, `py`), so local development does not
     * need a Linux-only path in .env.
     */
    public function binary(): string
    {
        if (self::$resolvedBinary !== null) {
            return self::$resolvedBinary;
        }

        $candidates = array_filter(array_unique([
            config('face_verification.python_binary'),
            rtrim((string) config('face_verification.venv_dir'), '/\\') . '/bin/python',
            rtrim((string) config('face_verification.venv_dir'), '/\\') . '/bin/python3',
            rtrim((string) config('face_verification.venv_dir'), '/\\') . '/Scripts/python.exe',
            rtrim((string) config('face_verification.venv_dir'), '/\\') . '/Scripts/python',
            '/usr/bin/python3',
            '/usr/local/bin/python3',
            'python3',
            'python',
            'py',
        ]));

        foreach ($candidates as $candidate) {
            if ($this->isUsablePython($candidate)) {
                return self::$resolvedBinary = $candidate;
            }
        }

        throw new RuntimeException(
            'No usable face-verification Python was found. Python must import numpy and opencv-contrib '
            . 'with FaceDetectorYN and FaceRecognizerSF available. Run scripts/setup_face_engine.sh '
            . 'with a writable FACE_VENV_DIR, then set FACE_PYTHON_BINARY and FACE_MODEL_DIR.'
        );
    }

    private function isUsablePython(string $candidate): bool
    {
        $looksLikePath = str_contains($candidate, '/') || str_contains($candidate, '\\');
        if ($looksLikePath && !is_file($candidate)) {
            return false;
        }

        try {
            $process = new Process([
                $candidate,
                '-c',
                'import cv2, numpy; assert hasattr(cv2, "FaceDetectorYN") and hasattr(cv2, "FaceRecognizerSF"); print(cv2.__version__, numpy.__version__)',
            ], base_path(), null, null, 10);
            $process->run();
            return $process->isSuccessful();
        } catch (\Throwable) {
            return false;
        }
    }

    private function run(array $arguments): array
    {
        [$result, $successful] = $this->execute($arguments);

        if (!$successful || empty($result['ok'])) {
            $message = $result['error'] ?? 'Face model failed';
            if (($result['error_code'] ?? null) === 'capture_invalid') {
                throw new \InvalidArgumentException($message);
            }
            throw new RuntimeException($message);
        }

        return $result;
    }

    /**
     * @return array{0: array, 1: bool} decoded JSON and process exit status
     */
    private function execute(array $arguments): array
    {
        $script = base_path('scripts/face_engine.py');
        if (!is_file($script)) {
            throw new RuntimeException('Face engine script is missing: scripts/face_engine.py');
        }

        $process = new Process(
            array_merge([$this->binary(), $script], $arguments),
            base_path(),
            [
                'FACE_MODEL_DIR' => (string) config('face_verification.model_dir'),
                'FACE_MATCH_THRESHOLD' => (string) config('face_verification.match_threshold', 0.363),
                'FACE_MIN_DETECTION_SCORE' => (string) config('face_verification.min_detection_score', 0.60),
            ],
        );
        $process->setTimeout(60);
        $process->run();

        $output = trim($process->getOutput());
        $result = json_decode($output, true);
        if (!is_array($result)) {
            $stderr = trim($process->getErrorOutput());
            $reason = $stderr !== '' ? $stderr : ($output !== '' ? $output : 'no output');
            throw new RuntimeException('Face model returned an invalid response: ' . $reason);
        }

        return [$result, $process->isSuccessful()];
    }
}
