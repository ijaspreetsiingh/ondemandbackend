<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddAutoAssignAnyCategoryToProvidersTable extends Migration
{
    public function up(): void
    {
        if (!Schema::hasColumn('providers', 'auto_assign_any_category')) {
            Schema::table('providers', function (Blueprint $table) {
                $table->boolean('auto_assign_any_category')->default(false)->after('auto_assign_mode')
                    ->comment('Allow nearest active provider technician regardless of technician subcategory assignment');
            });
        }
    }

    public function down(): void
    {
        if (Schema::hasColumn('providers', 'auto_assign_any_category')) {
            Schema::table('providers', function (Blueprint $table) {
                $table->dropColumn('auto_assign_any_category');
            });
        }
    }
}
