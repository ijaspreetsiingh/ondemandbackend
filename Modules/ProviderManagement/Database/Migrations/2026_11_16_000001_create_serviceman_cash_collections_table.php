<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{
    /**
     * Provider apne serviceman se cash-after-service ka pending commission
     * jab recover karta hai tab yahan entry banti hai. Isi ledger se
     * serviceman-wise "kitna paisa lena hai" calculate hota hai.
     *
     * @return void
     */
    public function up()
    {
        if (Schema::hasTable('serviceman_cash_collections')) {
            return;
        }

        Schema::create('serviceman_cash_collections', function (Blueprint $table) {
            $table->char('id', 36)->primary();
            $table->char('provider_id', 36)->index();
            $table->char('serviceman_id', 36)->index();
            $table->double('amount')->default(0);
            $table->char('collected_by', 36)->nullable();
            $table->text('note')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('serviceman_cash_collections');
    }
};
