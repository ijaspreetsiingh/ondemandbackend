<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Guarded so a partially applied / re-run deployment never fails here.
        if (!Schema::hasTable('serviceman_face_profiles')) {
            Schema::create('serviceman_face_profiles', function (Blueprint $table) {
                $table->uuid('serviceman_id')->primary();
                $table->longText('encrypted_template');
                $table->timestamp('enrolled_at')->nullable();
                $table->timestamps();
            });
        }

        if (!Schema::hasTable('booking_face_verifications')) {
            Schema::create('booking_face_verifications', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->uuid('booking_id')->nullable();
                $table->uuid('booking_repeat_id')->nullable();
                $table->uuid('provider_id');
                $table->uuid('serviceman_id');
                $table->unsignedTinyInteger('attempts')->default(0);
                $table->string('status', 24)->default('required');
                $table->string('last_capture_path')->nullable();
                $table->timestamp('capture_expires_at')->nullable();
                $table->decimal('last_match_score', 7, 5)->nullable();
                $table->uuid('approved_by')->nullable();
                $table->timestamp('approved_at')->nullable();
                $table->timestamps();

                $table->unique(['booking_id', 'serviceman_id'], 'booking_face_regular_unique');
                $table->unique(['booking_repeat_id', 'serviceman_id'], 'booking_face_repeat_unique');
                $table->index(['provider_id', 'status']);
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('booking_face_verifications');
        Schema::dropIfExists('serviceman_face_profiles');
    }
};
