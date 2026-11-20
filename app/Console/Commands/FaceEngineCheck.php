<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Schema;
use Modules\BookingModule\Lib\FaceVerificationEngine;

/**
 * Server-side diagnosis for the face verification engine.
 *
 *   php artisan face:check
 *   php artisan face:check storage/app/private/test-selfie.jpg
 *
 * Common failures it reports clearly:
 *   - Python / .venv-face not installed
 *   - opencv-contrib / numpy not installed
 *   - YuNet / SFace model files missing
 *   - face_* tables not migrated
 */
class FaceEngineCheck extends Command
{
    protected $signature = 'face:check {image? : Optional capture to test embedding against}';

    protected $description = 'Check face verification setup (Python, OpenCV, models, tables) and optionally test a capture';

    public function handle(FaceVerificationEngine $engine): int
    {
        $this->line('Face verification diagnostics');
        $this->line('-----------------------------');

        try {
            $this->info('Python binary : ' . $engine->binary());
        } catch (\Throwable $exception) {
            $this->error('Python binary : NOT FOUND');
            $this->error('  ' . $exception->getMessage());
        }

        $health = $engine->health();
        if (isset($health['health']) && is_array($health['health'])) {
            foreach ($health['health'] as $key => $value) {
                $this->line(sprintf('%-22s: %s', $key, is_bool($value) ? ($value ? 'yes' : 'no') : $value));
            }
        }
        if ($health['ok'] ?? false) {
            $this->info('Engine        : READY');
        } else {
            $this->error('Engine        : NOT READY');
            if (!empty($health['error'])) {
                $this->error('  ' . $health['error']);
            }
        }

        try {
            $hasProfiles = Schema::hasTable('serviceman_face_profiles');
            $hasVerifications = Schema::hasTable('booking_face_verifications');
            $this->line('serviceman_face_profiles table   : ' . ($hasProfiles ? 'yes' : 'NO — run php artisan migrate --force'));
            $this->line('booking_face_verifications table : ' . ($hasVerifications ? 'yes' : 'NO — run php artisan migrate --force'));
        } catch (\Throwable $exception) {
            $this->warn('Database check skipped: ' . $exception->getMessage());
        }

        $image = $this->argument('image');
        if ($image) {
            $path = str_starts_with($image, '/') || preg_match('/^[A-Za-z]:[\\\\\\/]/', $image)
                ? $image
                : base_path($image);

            if (!is_file($path)) {
                $this->error('Test capture  : file not found — ' . $path);
                return self::FAILURE;
            }

            try {
                $result = $engine->embed($path);
                $this->info(sprintf(
                    'Test capture  : OK (faces=%s, score=%.3f, embedding=%d values)',
                    $result['faces_detected'] ?? '?',
                    $result['detection_score'] ?? 0,
                    count($result['embedding'] ?? [])
                ));
            } catch (\Throwable $exception) {
                $this->error('Test capture  : FAILED — ' . $exception->getMessage());
                return self::FAILURE;
            }
        }

        return ($health['ok'] ?? false) ? self::SUCCESS : self::FAILURE;
    }
}
