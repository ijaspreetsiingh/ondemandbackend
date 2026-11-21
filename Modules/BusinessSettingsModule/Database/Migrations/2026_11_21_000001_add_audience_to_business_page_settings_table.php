<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasColumn('business_page_settings', 'audience')) {
            Schema::table('business_page_settings', function (Blueprint $table) {
                $table->string('audience', 20)->default('all')->after('is_default');
            });
        }
    }

    public function down(): void
    {
        if (Schema::hasColumn('business_page_settings', 'audience')) {
            Schema::table('business_page_settings', function (Blueprint $table) {
                $table->dropColumn('audience');
            });
        }
    }
};
