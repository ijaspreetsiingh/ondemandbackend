<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Per-provider "Extra Charge Distribution".
     *
     * Provider edit ke "Independent Commission" section ke neeche admin decide
     * karta hai ki customer ke final payment me jo extra charges lagte hain
     * (visiting / global extra charge, tax, platform-payment fee) unka paisa
     * kisko milega:
     *   - admin         -> poora charge admin ka
     *   - provider      -> poora charge provider ka
     *   - serviceman    -> poora charge serviceman ka (uski earning me jud jaata hai)
     *   - final_amount  -> charge final amount me count hoga, yaani rehta hai
     *                      commissionable base me aur admin%/provider% se bat jaata hai
     *
     * Format: {"extra_fee":"serviceman","tax":"admin","platform_fee":"final_amount"}
     * NULL / missing key = us charge ka default owner (purana behaviour).
     *
     * @return void
     */
    public function up()
    {
        Schema::table('providers', function (Blueprint $table) {
            if (!Schema::hasColumn('providers', 'extra_charge_owners')) {
                $table->json('extra_charge_owners')->nullable()
                    ->comment('Per-provider charge owner map: admin|provider|serviceman|final_amount');
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
        Schema::table('providers', function (Blueprint $table) {
            if (Schema::hasColumn('providers', 'extra_charge_owners')) {
                $table->dropColumn('extra_charge_owners');
            }
        });
    }
};
