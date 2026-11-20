<?php

namespace Modules\BookingModule\Entities;

use Illuminate\Database\Eloquent\Model;

class BookingFaceVerification extends Model
{
    protected $table = 'booking_face_verifications';
    public $incrementing = false;
    protected $keyType = 'string';
    protected $guarded = [];
    protected $casts = [
        'approved_at' => 'datetime',
        'capture_expires_at' => 'datetime',
        'last_match_score' => 'float',
    ];
}

