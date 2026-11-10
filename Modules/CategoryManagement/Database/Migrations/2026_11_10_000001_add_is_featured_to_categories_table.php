<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddIsFeaturedToCategoriesTable extends Migration
{
    public function up()
    {
        if (!Schema::hasColumn('categories', 'is_featured')) {
            Schema::table('categories', function (Blueprint $table) {
                $table->boolean('is_featured')->default(0)->after('is_active');
            });
        }
    }

    public function down()
    {
        if (Schema::hasColumn('categories', 'is_featured')) {
            Schema::table('categories', function (Blueprint $table) {
                $table->dropColumn('is_featured');
            });
        }
    }
}