<?php

namespace Modules\BookingModule\Http\Controllers\Api\V1\Provider;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Modules\BookingModule\Entities\Booking;
use Modules\BookingModule\Entities\BookingFaceVerification;
use Modules\BookingModule\Entities\BookingRepeat;
use Modules\BookingModule\Entities\ServicemanFaceProfile;
use Modules\UserManagement\Entities\Serviceman;

class ServicemanFaceProfileController extends Controller
{
    public function show(Request $request, string $servicemanId): JsonResponse
    {
        $serviceman = $this->ownedServiceman($request, $servicemanId);
        if (!$serviceman) {
            return response()->json(['response_code' => 'serviceman_not_found_404'], 404);
        }

        $profile = ServicemanFaceProfile::find($serviceman->id);
        $photoDataUri = null;
        if (
            $profile?->enrollment_photo_path &&
            Storage::disk('local')->exists($profile->enrollment_photo_path)
        ) {
            $mime = Storage::disk('local')->mimeType($profile->enrollment_photo_path) ?: 'image/jpeg';
            $photoDataUri = 'data:' . $mime . ';base64,' . base64_encode(
                Storage::disk('local')->get($profile->enrollment_photo_path)
            );
        }

        return response()->json([
            'response_code' => 'serviceman_face_profile_200',
            'content' => [
                'enrolled' => (bool) $profile,
                'enrolled_at' => $profile?->enrolled_at,
                'photo_data_uri' => $photoDataUri,
            ],
        ]);
    }

    public function destroy(Request $request, string $servicemanId): JsonResponse
    {
        $serviceman = $this->ownedServiceman($request, $servicemanId);
        if (!$serviceman) {
            return response()->json(['response_code' => 'serviceman_not_found_404'], 404);
        }

        $profile = ServicemanFaceProfile::find($serviceman->id);
        if (!$profile) {
            return response()->json(['response_code' => 'serviceman_face_profile_not_found_404'], 404);
        }

        $acceptedBookingIds = Booking::where('serviceman_id', $serviceman->id)
            ->where('booking_status', 'accepted')->pluck('id')->all();
        $acceptedRepeatIds = BookingRepeat::where('serviceman_id', $serviceman->id)
            ->where('booking_status', 'accepted')->pluck('id')->all();

        $pendingApprovals = collect();
        if ($acceptedBookingIds || $acceptedRepeatIds) {
            $pendingApprovals = BookingFaceVerification::where('serviceman_id', $serviceman->id)
                ->whereIn('status', ['verified', 'retry', 'pending_review'])
                ->where(function ($query) use ($acceptedBookingIds, $acceptedRepeatIds) {
                    if ($acceptedBookingIds) {
                        $query->whereIn('booking_id', $acceptedBookingIds);
                    }
                    if ($acceptedRepeatIds) {
                        $method = $acceptedBookingIds ? 'orWhereIn' : 'whereIn';
                        $query->{$method}('booking_repeat_id', $acceptedRepeatIds);
                    }
                })->get();
        }

        $capturePaths = $pendingApprovals->pluck('last_capture_path')->filter()->all();
        $photoPath = $profile->enrollment_photo_path;

        DB::transaction(function () use ($profile, $pendingApprovals) {
            foreach ($pendingApprovals as $verification) {
                $verification->status = 'required';
                $verification->attempts = 0;
                $verification->last_capture_path = null;
                $verification->capture_expires_at = null;
                $verification->last_match_score = null;
                $verification->save();
            }
            $profile->delete();
        });

        if ($photoPath) {
            Storage::disk('local')->delete($photoPath);
        }
        foreach ($capturePaths as $path) {
            Storage::disk('local')->delete($path);
        }

        return response()->json([
            'response_code' => 'serviceman_face_profile_deleted_200',
            'message' => 'Face setup removed. The serviceman must enroll again before starting another service.',
            'content' => ['enrolled' => false],
        ]);
    }

    private function ownedServiceman(Request $request, string $servicemanId): ?Serviceman
    {
        $providerId = $request->user()?->provider?->id;
        if (!$providerId) {
            return null;
        }

        return Serviceman::whereKey($servicemanId)
            ->where('provider_id', $providerId)
            ->first();
    }
}
