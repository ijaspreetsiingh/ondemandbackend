<?php

namespace Modules\ProviderManagement\Entities;

use App\Traits\HasUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Modules\UserManagement\Entities\Serviceman;
use Modules\UserManagement\Entities\User;

class ServicemanCashCollection extends Model
{
    use HasFactory, HasUuid;

    protected $casts = [
        'amount' => 'float',
    ];

    protected $fillable = ['provider_id', 'serviceman_id', 'amount', 'collected_by', 'note'];

    public function serviceman(): BelongsTo
    {
        return $this->belongsTo(Serviceman::class, 'serviceman_id');
    }

    public function collector(): BelongsTo
    {
        return $this->belongsTo(User::class, 'collected_by');
    }

    public function scopeFilterDateRange($query, $from, $to): mixed
    {
        return $query
            ->when($from, fn($q) => $q->whereDate('created_at', '>=', $from))
            ->when($to, fn($q) => $q->whereDate('created_at', '<=', $to));
    }
}
