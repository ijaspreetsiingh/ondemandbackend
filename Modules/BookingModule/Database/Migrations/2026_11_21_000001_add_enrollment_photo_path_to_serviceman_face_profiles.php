<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasTable('serviceman_face_profiles') &&
            !Schema::hasColumn('serviceman_face_profiles', 'enrollment_photo_path')) {
            Schema::table('serviceman_face_profiles', function (Blueprint $table) {
                $table->string('enrollment_photo_path')->nullable()->after('encrypted_template');
            });
        }
    }

    public function down(): void
    {
        if (Schema::hasTable('serviceman_face_profiles') &&
            Schema::hasColumn('serviceman_face_profiles', 'enrollment_photo_path')) {
            Schema::table('serviceman_face_profiles', function (Blueprint $table) {
                $table->dropColumn('enrollment_photo_path');
            });
        }
    }
};
