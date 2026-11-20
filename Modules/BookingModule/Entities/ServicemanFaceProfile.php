<?php

namespace Modules\BookingModule\Entities;

use Illuminate\Database\Eloquent\Model;

class ServicemanFaceProfile extends Model
{
    protected $table = 'serviceman_face_profiles';
    protected $primaryKey = 'serviceman_id';
    public $incrementing = false;
    protected $keyType = 'string';
    protected $guarded = [];
}
