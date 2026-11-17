<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Platform fee ko booking par snapshot karo.
     *
     * Placement par provider ka platform_fee_amount customer ke
     * total_booking_amount me jud jaata hai (customer final payment me pay
     * karta hai). Snapshot isliye rakhte hain ki baad me admin/provider
     * platform fee change kare to purani booking ka settlement math na toote.
     *
     * 0 / NULL = purani bookings (platform fee customer se nahi liya gaya tha;
     * wo provider ke share se kata tha — purana behaviour).
     *
     * @return void
     */
    public function up()
    {
        Schema::table('bookings', function (Blueprint $table) {
            if (!Schema::hasColumn('bookings', 'platform_fee')) {
                $table->decimal('platform_fee', 10, 2)->default(0)
                    ->comment('Platform fee snapshot included in total_booking_amount (0 = legacy, provider-borne)');
            }
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('bookings', function (Blueprint $table) {
            if (Schema::hasColumn('bookings', 'platform_fee')) {
                $table->dropColumn('platform_fee');
            }
        });
    }
};
