<?php

namespace Modules\BookingModule\Http\Controllers\Api\V1\Serviceman;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Modules\BookingModule\Entities\Booking;
use Modules\BookingModule\Entities\BookingFaceVerification;
use Modules\BookingModule\Entities\BookingRepeat;
use Modules\BookingModule\Entities\ServicemanFaceProfile;
use Modules\BookingModule\Lib\FaceVerificationEngine;
use Modules\ProviderManagement\Entities\Provider;

class FaceVerificationController extends Controller
{
    public function profileStatus(Request $request): JsonResponse
    {
        $serviceman = $request->user()->serviceman;
        if (!$serviceman) {
            return response()->json(['response_code' => 'serviceman_not_found_404'], 404);
        }

        $profile = ServicemanFaceProfile::find($serviceman->id);
        return response()->json([
            'response_code' => 'face_profile_status_200',
            'content' => ['enrolled' => (bool) $profile, 'enrolled_at' => $profile?->enrolled_at],
        ]);
    }

    public function enroll(Request $request, FaceVerificationEngine $engine): JsonResponse
    {
        $request->validate([
            'image' => 'required|image|mimes:jpg,jpeg,png,webp|max:5120',
            'refresh' => 'nullable|boolean',
        ]);
        $serviceman = $request->user()->serviceman;
        if (!$serviceman) {
            return response()->json(['response_code' => 'serviceman_not_found_404'], 404);
        }

        $profile = ServicemanFaceProfile::find($serviceman->id);
        if ($profile && !$request->boolean('refresh')) {
            return response()->json(['response_code' => 'face_profile_exists_409'], 409);
        }

        try {
            $result = $engine->embed($request->file('image')->getRealPath());
        } catch (\InvalidArgumentException $exception) {
            // A clear-face capture failure still uses one of the same three
            // attempts. Otherwise a face hidden by glare/headwear can retry
            // forever and the Provider is never asked to review it.
            return $this->recordUnclearCapture($booking, $bookingId, $repeat, $serviceman, $request);
        } catch (\Throwable $exception) {
            report($exception);
            return response()->json([
                'response_code' => 'face_engine_unavailable_503',
                'message' => 'Face verification is temporarily unavailable. Please contact your provider.',
            ], 503);
        }

        $template = Crypt::encryptString(json_encode($result['embedding'], JSON_THROW_ON_ERROR));
        $photoPath = $request->file('image')->store('face-enrollment', 'local');
        try {
            if ($profile) {
                $oldPhotoPath = $profile->enrollment_photo_path;
                $profile->update([
                    'encrypted_template' => $template,
                    'enrollment_photo_path' => $photoPath,
                    'enrolled_at' => now(),
                ]);
                if ($oldPhotoPath && $oldPhotoPath !== $photoPath) {
                    Storage::disk('local')->delete($oldPhotoPath);
                }
            } else {
                ServicemanFaceProfile::create([
                    'serviceman_id' => $serviceman->id,
                    'encrypted_template' => $template,
                    'enrollment_photo_path' => $photoPath,
                    'enrolled_at' => now(),
                ]);
            }
        } catch (\Throwable $exception) {
            Storage::disk('local')->delete($photoPath);
            throw $exception;
        }

        return response()->json(['response_code' => 'face_profile_saved_200', 'message' => 'Face setup complete.']);
    }

    public function verify(Request $request, string $bookingId, FaceVerificationEngine $engine): JsonResponse
    {
        $request->validate([
            'start_otp' => 'required|string|max:10',
            'booking_type' => 'nullable|in:regular,repeat',
            'image' => 'required|image|mimes:jpg,jpeg,png,webp|max:5120',
        ]);

        $serviceman = $request->user()->serviceman;
        if (!$serviceman) {
            return response()->json(['response_code' => 'serviceman_not_found_404'], 404);
        }

        $repeat = $request->input('booking_type') === 'repeat';
        $booking = $repeat
            ? BookingRepeat::whereKey($bookingId)->where('serviceman_id', $serviceman->id)->first()
            : Booking::whereKey($bookingId)->where('serviceman_id', $serviceman->id)->first();

        if (!$booking || $booking->booking_status !== 'accepted') {
            return response()->json(['response_code' => 'face_booking_not_available_403'], 403);
        }

        if (
            empty($booking->start_otp) ||
            !hash_equals((string) $booking->start_otp, (string) $request->input('start_otp'))
        ) {
            return response()->json(['response_code' => 'default_403', 'message' => 'Incorrect start OTP.'], 200);
        }

        $profile = ServicemanFaceProfile::find($serviceman->id);
        if (!$profile) {
            return response()->json([
                'response_code' => 'face_profile_required_409',
                'message' => 'Set up your face verification from your profile before starting a service.',
            ], 409);
        }

        try {
            $reference = json_decode(Crypt::decryptString($profile->encrypted_template), true, 512, JSON_THROW_ON_ERROR);
            $result = $engine->match($request->file('image')->getRealPath(), $reference);
        } catch (\InvalidArgumentException $exception) {
            return response()->json([
                'response_code' => 'face_capture_invalid_422',
                'message' => 'Keep your face centered and well lit, with eyes, nose and mouth visible. Pagri or a turban is okay when it does not cover your face.',
            ], 422);
        } catch (\Throwable $exception) {
            report($exception);

            // Do not leave the serviceman permanently stuck when the Python
            // engine is down: flag this booking for the Provider's manual
            // approval instead of silently blocking every booking.
            if (!config('face_verification.provider_fallback_on_engine_error', true)) {
                return response()->json([
                    'response_code' => 'face_engine_unavailable_503',
                    'message' => 'Face verification is temporarily unavailable. Please try again later.',
                ], 503);
            }

            $outcome = $this->flagForProviderReview($bookingId, $repeat, $serviceman, $request);
            if (isset($outcome['http_status'])) {
                return response()->json($outcome, $outcome['http_status']);
            }
            $outcome['engine_unavailable'] = true;
        }

        if (!isset($outcome)) {
            $outcome = DB::transaction(function () use ($repeat, $bookingId, $serviceman, $request, $result) {
                // Lock the assigned booking first: concurrent checks for it serialize here.
                $lockedBooking = $repeat
                    ? BookingRepeat::whereKey($bookingId)->where('serviceman_id', $serviceman->id)->lockForUpdate()->first()
                    : Booking::whereKey($bookingId)->where('serviceman_id', $serviceman->id)->lockForUpdate()->first();
                if (
                    !$lockedBooking ||
                    $lockedBooking->booking_status !== 'accepted' ||
                    empty($lockedBooking->start_otp) ||
                    !hash_equals((string) $lockedBooking->start_otp, (string) $request->input('start_otp'))
                ) {
                    return ['response_code' => 'face_booking_not_available_403', 'http_status' => 403];
                }

                $verification = BookingFaceVerification::query()
                    ->where('serviceman_id', $serviceman->id)
                    ->where($repeat ? 'booking_repeat_id' : 'booking_id', $bookingId)
                    ->lockForUpdate()
                    ->first();
                if ($verification && in_array($verification->status, ['verified', 'provider_approved'], true)) {
                    return ['response_code' => 'face_verified_200', 'content' => ['passed' => true]];
                }
                if ($verification && $verification->status === 'pending_review') {
                    return ['response_code' => 'face_review_pending_200', 'content' => ['attempts_remaining' => 0]];
                }

                $verification ??= new BookingFaceVerification([
                    'id' => (string) Str::uuid(),
                    'booking_id' => $repeat ? null : $bookingId,
                    'booking_repeat_id' => $repeat ? $bookingId : null,
                    'provider_id' => $lockedBooking->provider_id,
                    'serviceman_id' => $serviceman->id,
                    'attempts' => 0,
                ]);

                $oldCapture = $verification->last_capture_path;
                if ($result['matched']) {
                    $verification->status = 'verified';
                    $verification->last_capture_path = null;
                    $verification->capture_expires_at = null;
                    $verification->last_match_score = $result['score'];
                    $verification->save();
                    return ['response_code' => 'face_verified_200', 'content' => ['passed' => true], 'delete_capture' => $oldCapture];
                }

                $verification->attempts = min(3, ((int) $verification->attempts) + 1);
                $verification->last_match_score = $result['score'];
                $verification->status = $verification->attempts >= 3 ? 'pending_review' : 'retry';
                if ($verification->attempts >= 3) {
                    $verification->last_capture_path = $request->file('image')->store('face-review', 'local');
                    $verification->capture_expires_at = now()->addDay();
                }
                $verification->save();

                return [
                    'response_code' => $verification->status === 'pending_review' ? 'face_review_pending_200' : 'face_mismatch_retry_200',
                    'content' => [
                        'attempts_used' => (int) $verification->attempts,
                        'attempts_remaining' => max(0, 3 - (int) $verification->attempts),
                    ],
                    'notify_provider' => $verification->status === 'pending_review',
                    'delete_capture' => $oldCapture,
                ];
            });
        }

        if (!empty($outcome['delete_capture'])) {
            Storage::disk('local')->delete($outcome['delete_capture']);
        }
        if (!empty($outcome['notify_provider'])) {
            $this->notifyProvider($booking, $bookingId, $repeat);

            $outcome['message'] = !empty($outcome['engine_unavailable'])
                ? 'Face verification is temporarily unavailable. Your provider has been asked to approve this booking.'
                : 'Please contact your provider. They have been notified.';
        }
        if ($outcome['response_code'] === 'face_mismatch_retry_200') {
            $outcome['message'] = 'Face did not match. Keep your face centered and well lit, with eyes, nose and mouth visible. Pagri or a turban is okay when it does not cover your face.';
        }
        $httpStatus = $outcome['http_status'] ?? 200;
        unset($outcome['http_status'], $outcome['notify_provider'], $outcome['delete_capture'], $outcome['engine_unavailable']);
        return response()->json($outcome, $httpStatus);
    }

    /**
     * Used only when the face engine itself is unavailable. The booking is put
     * into Provider review (without consuming a mismatch attempt) so the
     * Provider can verify the person and start the service manually.
     */
    private function flagForProviderReview(string $bookingId, bool $repeat, $serviceman, Request $request): array
    {
        return DB::transaction(function () use ($bookingId, $repeat, $serviceman, $request) {
            $lockedBooking = $repeat
                ? BookingRepeat::whereKey($bookingId)->where('serviceman_id', $serviceman->id)->lockForUpdate()->first()
                : Booking::whereKey($bookingId)->where('serviceman_id', $serviceman->id)->lockForUpdate()->first();

            if (
                !$lockedBooking ||
                $lockedBooking->booking_status !== 'accepted' ||
                empty($lockedBooking->start_otp) ||
                !hash_equals((string) $lockedBooking->start_otp, (string) $request->input('start_otp'))
            ) {
                return ['response_code' => 'face_booking_not_available_403', 'http_status' => 403];
            }

            $verification = BookingFaceVerification::query()
                ->where('serviceman_id', $serviceman->id)
                ->where($repeat ? 'booking_repeat_id' : 'booking_id', $bookingId)
                ->lockForUpdate()
                ->first();

            if ($verification && in_array($verification->status, ['verified', 'provider_approved'], true)) {
                return ['response_code' => 'face_verified_200', 'content' => ['passed' => true]];
            }
            if ($verification && $verification->status === 'pending_review') {
                return ['response_code' => 'face_review_pending_200', 'content' => ['attempts_remaining' => 0], 'notify_provider' => true];
            }

            $verification ??= new BookingFaceVerification([
                'id' => (string) Str::uuid(),
                'booking_id' => $repeat ? null : $bookingId,
                'booking_repeat_id' => $repeat ? $bookingId : null,
                'provider_id' => $lockedBooking->provider_id,
                'serviceman_id' => $serviceman->id,
            ]);

            $verification->status = 'pending_review';
            $verification->attempts = 0;
            $verification->save();

            return [
                'response_code' => 'face_review_pending_200',
                'content' => ['attempts_remaining' => 0],
                'notify_provider' => true,
            ];
        });
    }

    private function recordUnclearCapture($booking, string $bookingId, bool $repeat, $serviceman, Request $request): JsonResponse
    {
        $outcome = DB::transaction(function () use ($bookingId, $repeat, $serviceman, $request) {
            $lockedBooking = $repeat
                ? BookingRepeat::whereKey($bookingId)->where('serviceman_id', $serviceman->id)->lockForUpdate()->first()
                : Booking::whereKey($bookingId)->where('serviceman_id', $serviceman->id)->lockForUpdate()->first();

            if (
                !$lockedBooking ||
                $lockedBooking->booking_status !== 'accepted' ||
                empty($lockedBooking->start_otp) ||
                !hash_equals((string) $lockedBooking->start_otp, (string) $request->input('start_otp'))
            ) {
                return ['response_code' => 'face_booking_not_available_403', 'http_status' => 403];
            }

            $verification = BookingFaceVerification::query()
                ->where('serviceman_id', $serviceman->id)
                ->where($repeat ? 'booking_repeat_id' : 'booking_id', $bookingId)
                ->lockForUpdate()
                ->first();

            if ($verification && in_array($verification->status, ['verified', 'provider_approved'], true)) {
                return ['response_code' => 'face_verified_200', 'content' => ['passed' => true]];
            }
            if ($verification && $verification->status === 'pending_review') {
                return ['response_code' => 'face_review_pending_200', 'content' => ['attempts_remaining' => 0]];
            }

            $verification ??= new BookingFaceVerification([
                'id' => (string) Str::uuid(),
                'booking_id' => $repeat ? null : $bookingId,
                'booking_repeat_id' => $repeat ? $bookingId : null,
                'provider_id' => $lockedBooking->provider_id,
                'serviceman_id' => $serviceman->id,
                'attempts' => 0,
            ]);

            $verification->attempts = min(3, ((int) $verification->attempts) + 1);
            $needsReview = $verification->attempts >= 3;
            $verification->status = $needsReview ? 'pending_review' : 'retry';
            if ($needsReview) {
                $verification->last_capture_path = $request->file('image')->store('face-review', 'local');
                $verification->capture_expires_at = now()->addDay();
            }
            $verification->save();

            return [
                'response_code' => $needsReview ? 'face_review_pending_200' : 'face_mismatch_retry_200',
                'content' => [
                    'attempts_used' => (int) $verification->attempts,
                    'attempts_remaining' => max(0, 3 - (int) $verification->attempts),
                ],
                'notify_provider' => $needsReview,
            ];
        });

        if (isset($outcome['http_status'])) {
            return response()->json($outcome, $outcome['http_status']);
        }
        if (!empty($outcome['notify_provider'])) {
            $this->notifyProvider($booking, $bookingId, $repeat);
            $outcome['message'] = 'We could not get a clear face image after three tries. Your provider has been asked to review it. Pagri or a turban is okay when your eyes, nose and mouth remain visible.';
        } elseif ($outcome['response_code'] === 'face_mismatch_retry_200') {
            $outcome['message'] = 'Keep your face centered and well lit, with eyes, nose and mouth visible, then retry. Pagri or a turban is okay when it does not cover your face.';
        }

        unset($outcome['notify_provider']);
        return response()->json($outcome, 200);
    }

    private function notifyProvider($booking, string $bookingId, bool $repeat): void
    {
        $provider = Provider::with('owner')->find($booking->provider_id);
        $token = $provider?->owner?->fcm_token;
        if (!$token) {
            return;
        }

        device_notification(
            $token,
            'Face verification needs review',
            'A serviceman could not verify their face. Please review and approve the booking.',
            null,
            $bookingId,
            'face_verification_review',
            null,
            null,
            null,
            null,
            $repeat ? 'repeat' : 'regular',
            $repeat ? 'single' : null
        );
    }
}
