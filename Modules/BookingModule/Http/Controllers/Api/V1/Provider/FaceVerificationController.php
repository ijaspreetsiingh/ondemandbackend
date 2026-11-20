<?php

namespace Modules\BookingModule\Http\Controllers\Api\V1\Provider;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Modules\BookingModule\Entities\Booking;
use Modules\BookingModule\Entities\BookingFaceVerification;
use Modules\BookingModule\Entities\BookingStatusHistory;
use Modules\BookingModule\Entities\BookingRepeat;
use Modules\UserManagement\Entities\Serviceman;

class FaceVerificationController extends Controller
{
    public function review(Request $request, string $bookingId): JsonResponse
    {
        $request->validate(['booking_type' => 'required|in:regular,repeat']);
        $provider = $request->user()->provider;
        if (!$provider) {
            return response()->json(['response_code' => 'provider_not_found_404'], 404);
        }

        $repeat = $request->input('booking_type') === 'repeat';
        $verification = BookingFaceVerification::query()
            ->where('provider_id', $provider->id)
            ->where($repeat ? 'booking_repeat_id' : 'booking_id', $bookingId)
            ->first();

        if (!$verification) {
            return response()->json(['response_code' => 'face_review_not_found_404'], 404);
        }

        $serviceman = Serviceman::with('user')->find($verification->serviceman_id);
        $booking = $repeat
            ? BookingRepeat::find($bookingId)
            : Booking::find($bookingId);

        $image = null;
        if (
            $verification->status === 'pending_review' &&
            $verification->last_capture_path &&
            (!$verification->capture_expires_at || $verification->capture_expires_at->isFuture()) &&
            Storage::disk('local')->exists($verification->last_capture_path)
        ) {
            $mime = Storage::disk('local')->mimeType($verification->last_capture_path) ?: 'image/jpeg';
            $image = 'data:' . $mime . ';base64,' . base64_encode(
                Storage::disk('local')->get($verification->last_capture_path)
            );
        }

        return response()->json([
            'response_code' => 'face_review_detail_200',
            'content' => [
                'booking_id' => $bookingId,
                'booking_type' => $repeat ? 'repeat' : 'regular',
                'booking_readable_id' => $booking?->readable_id,
                'booking_status' => $booking?->booking_status,
                'serviceman_id' => $serviceman?->id,
                'serviceman_name' => trim(($serviceman?->user?->first_name ?? '') . ' ' . ($serviceman?->user?->last_name ?? '')),
                'serviceman_phone' => $serviceman?->user?->phone,
                'attempts' => (int) $verification->attempts,
                'match_score' => $verification->last_match_score,
                'status' => $verification->status,
                'capture_data_uri' => $image,
                'can_approve' => $verification->status === 'pending_review'
                    && $booking?->booking_status === 'accepted'
                    && (string) $booking?->serviceman_id === (string) $verification->serviceman_id,
            ],
        ]);
    }

    public function approve(Request $request, string $bookingId): JsonResponse
    {
        $request->validate(['booking_type' => 'required|in:regular,repeat']);
        $provider = $request->user()->provider;
        if (!$provider) {
            return response()->json(['response_code' => 'provider_not_found_404'], 404);
        }

        $repeat = $request->input('booking_type') === 'repeat';
        $verification = BookingFaceVerification::query()
            ->where('provider_id', $provider->id)
            ->where($repeat ? 'booking_repeat_id' : 'booking_id', $bookingId)
            ->where('status', 'pending_review')
            ->first();

        if (!$verification) {
            return response()->json(['response_code' => 'face_review_not_pending_409'], 409);
        }

        $serviceman = Serviceman::with('user')
            ->find($verification->serviceman_id);
        $booking = $repeat
            ? BookingRepeat::whereKey($bookingId)->where('provider_id', $provider->id)->first()
            : Booking::whereKey($bookingId)->where('provider_id', $provider->id)->first();

        if (
            !$booking ||
            !$serviceman ||
            (string) $booking->serviceman_id !== (string) $serviceman->id ||
            $booking->booking_status !== 'accepted'
        ) {
            return response()->json(['response_code' => 'face_booking_not_available_409'], 409);
        }

        if (
            !$repeat &&
            $booking->payment_method === 'offline_payment' &&
            !$booking->is_paid &&
            (
                $booking->booking_offline_payments->isEmpty() ||
                $booking->booking_offline_payments->first()?->payment_status !== 'approved'
            )
        ) {
            return response()->json(['response_code' => 'face_booking_payment_pending_409'], 409);
        }

        $capturePath = null;
        DB::transaction(function () use ($verification, $provider, $request, $repeat, $bookingId, &$capturePath) {
            // Keep row-lock order the same as the serviceman verify endpoint to avoid deadlocks.
            $lockedBooking = $repeat
                ? BookingRepeat::whereKey($bookingId)->where('provider_id', $provider->id)->lockForUpdate()->firstOrFail()
                : Booking::whereKey($bookingId)->where('provider_id', $provider->id)->lockForUpdate()->firstOrFail();
            $locked = BookingFaceVerification::whereKey($verification->id)
                ->where('provider_id', $provider->id)
                ->lockForUpdate()
                ->firstOrFail();
            if ($locked->status !== 'pending_review') {
                abort(409, 'This review has already been handled.');
            }
            if (
                $lockedBooking->booking_status !== 'accepted' ||
                (string) $lockedBooking->serviceman_id !== (string) $locked->serviceman_id
            ) {
                abort(409, 'This booking can no longer be started.');
            }

            $capturePath = $locked->last_capture_path;
            $locked->status = 'provider_approved';
            $locked->approved_by = $request->user()->id;
            $locked->approved_at = now();
            $locked->last_capture_path = null;
            $locked->capture_expires_at = null;
            $locked->save();

            $lockedBooking->booking_status = 'ongoing';
            $lockedBooking->save();
            BookingStatusHistory::create([
                'booking_id' => $repeat ? $lockedBooking->booking_id : $bookingId,
                'booking_repeat_id' => $repeat ? $bookingId : null,
                'changed_by' => $request->user()->id,
                'booking_status' => 'ongoing',
            ]);
        });

        if ($capturePath) {
            Storage::disk('local')->delete($capturePath);
        }

        if ($serviceman->user?->fcm_token) {
            device_notification(
                $serviceman->user->fcm_token,
                'Service started',
                'Your provider approved the face check for this booking.',
                null,
                $bookingId,
                'booking',
                null,
                null,
                null,
                null,
                $repeat ? 'repeat' : 'regular',
                $repeat ? 'single' : null
            );
        }

        return response()->json([
            'response_code' => 'face_review_approved_200',
            'message' => 'This booking was approved once and the service has started.',
            'content' => ['booking_status' => 'ongoing'],
        ]);
    }
}





