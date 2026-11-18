<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasTable('business_settings')) {
            return;
        }

        $exists = DB::table('business_settings')
            ->where('key_name', 'backup_enabled')
            ->where('settings_type', 'backup_settings')
            ->exists();

        if (!$exists) {
            DB::table('business_settings')->insert([
                'id' => (string) Str::uuid(),
                'key_name' => 'backup_enabled',
                'live_values' => '1',
                'test_values' => '1',
                'settings_type' => 'backup_settings',
                'mode' => 'live',
                'is_active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }

    public function down(): void
    {
        if (!Schema::hasTable('business_settings')) {
            return;
        }

        DB::table('business_settings')
            ->where('key_name', 'backup_enabled')
            ->where('settings_type', 'backup_settings')
            ->delete();
    }
};