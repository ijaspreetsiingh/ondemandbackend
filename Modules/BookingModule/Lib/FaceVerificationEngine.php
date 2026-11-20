<?php

namespace Modules\BookingModule\Lib;

use RuntimeException;
use Symfony\Component\Process\Process;

class FaceVerificationEngine
{
    public function embed(string $imagePath): array
    {
        return $this->run(['embed', $imagePath]);
    }

    public function match(string $imagePath, array $reference): array
    {
        return $this->run(['match', $imagePath, json_encode($reference, JSON_THROW_ON_ERROR)]);
    }

    private function run(array $arguments): array
    {
        $python = env('FACE_PYTHON_BINARY', 'python3');
        $script = base_path('scripts/face_engine.py');
        $process = new Process(array_merge([$python, $script], $arguments), base_path());
        $process->setTimeout(40);
        $process->run();

        $output = trim($process->getOutput());
        $result = json_decode($output, true);
        if (!$process->isSuccessful() || !is_array($result) || empty($result['ok'])) {
            $message = is_array($result) ? ($result['error'] ?? 'Face model failed') : 'Face model returned an invalid response';
            if (($result['error_code'] ?? null) === 'capture_invalid') {
                throw new \InvalidArgumentException($message);
            }
            throw new RuntimeException($message);
        }

        return $result;
    }
}
