<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Modules\BusinessSettingsModule\Entities\BusinessSettings;

/**
 * Agora (calling) credentials ko server par command line se dekhne / set karne
 * / verify karne ke liye. Call flow ke "Call failed (errInvalidToken)" ka
 * sabse common reason yahi hai ki business_settings me App ID / App Certificate
 * galat ya purana pada hai — isse admin panel kholne ki zaroorat nahi rehti.
 *
 *   php artisan agora:show
 *   php artisan agora:set <app_id> <certificate>
 *   php artisan agora:test
 */
class AgoraCredentials extends Command
{
    protected $signature = 'agora:{action : show|set|test}
                            {--app-id= : Agora project App ID (32 hex chars)}
                            {--certificate= : Agora project App Certificate}';

    protected $description = 'Agora calling credentials dekho, set karo aur token verify karo (errInvalidToken fix)';

    public function handle(): int
    {
        $action = $this->argument('action');

        return match ($action) {
            'show' => $this->show(),
            'set'  => $this->set(),
            'test' => $this->test(),
            default => $this->unknown($action),
        };
    }

    private function unknown(string $action): int
    {
        $this->error("Unknown action '{$action}'. Use: show | set | test");

        return self::FAILURE;
    }

    /* ------------------------------------------------------------------ */

    private function row(): ?BusinessSettings
    {
        return BusinessSettings::where('key_name', 'agora')
            ->where('settings_type', 'third_party')
            ->first();
    }

    private function show(): int
    {
        $row = $this->row();

        if (!$row) {
            $this->warn('Koi agora config row nahi mila (Business Settings > 3rd Party > Agora me kabhi save nahi hua).');
            $this->line('Set karne ke liye: php artisan agora:set <app_id> <certificate>');

            return self::FAILURE;
        }

        $values   = (array) ($row->live_values ?? []);
        $appId    = trim((string) ($values['agora_app_id'] ?? ''));
        $cert     = trim((string) ($values['agora_app_certificate'] ?? ''));
        $isActive = (int) $row->is_active;

        $this->info('Stored Agora credentials (business_settings.key_name = "agora"):');
        $this->line('  is_active           : ' . ($isActive === 1 ? '1 (ON)' : "0 (OFF) — isse saare calls 'not configured' fail honge"));
        $this->line('  agora_app_id        : ' . ($appId !== '' ? $appId : '(khali)'));
        $this->line('  agora_app_certificate: ' . ($cert !== '' ? substr($cert, 0, 8) . '…' . substr($cert, -4) . ' (' . strlen($cert) . ' chars)' : '(khali)'));

        if ($appId !== '' && !preg_match('/^[0-9a-f]{32}$/i', $appId)) {
            $this->error('  >>> App ID 32 lowercase hex chars nahi hai — galat value pari hai!');
        }

        if ($cert !== '' && !preg_match('/^[0-9a-f]{32}$/i', $cert)) {
            $this->error('  >>> Certificate 32 lowercase hex chars nahi hai — galat value pari hai (spaces/quotes/purana secret?)');
        }

        $this->newLine();
        $this->line('Sahi values ke liye: php artisan agora:set <app_id> <certificate>');
        $this->line('Phir verify:         php artisan agora:test');

        return self::SUCCESS;
    }

    private function set(): int
    {
        $appId = trim((string) $this->option('app-id'));
        $cert  = trim((string) $this->option('certificate'));

        if ($appId === '' || $cert === '') {
            $this->error('Dono values chahiye: php artisan agora:set --app-id=<APP_ID> --certificate=<CERT>');

            return self::FAILURE;
        }

        if (!preg_match('/^[0-9a-f]{32}$/i', $appId)) {
            $this->error("App ID format galat hai (32 hex chars hone chahiye): {$appId}");

            return self::FAILURE;
        }

        if (!preg_match('/^[0-9a-f]{32}$/i', $cert)) {
            $this->error("Certificate format galat hai (32 hex chars hone chahiye): {$cert}");

            return self::FAILURE;
        }

        if ($appId === $cert) {
            $this->error('App ID aur Certificate same hain — dono alag values hain, dobara check karo.');

            return self::FAILURE;
        }

        $values = [
            'party_name'            => 'agora',
            'agora_app_id'          => $appId,
            'agora_app_certificate' => $cert,
            'status'                => 1,
        ];

        BusinessSettings::updateOrCreate(
            ['key_name' => 'agora', 'settings_type' => 'third_party'],
            [
                'key_name'    => 'agora',
                'live_values' => $values,
                'test_values' => $values,
                'settings_type' => 'third_party',
                'mode'        => 'live',
                'is_active'   => 1,
            ]
        );

        // business_config() redis cache me 1h tak purani row rakh sakta hai.
        \Illuminate\Support\Facades\Cache::forget('bc_third_party_agora');

        $this->info('Agora credentials save ho gaye (is_active = 1).');
        $this->line('Ab verify karo: php artisan agora:test');

        return self::SUCCESS;
    }

    private function test(): int
    {
        $row = $this->row();

        if (!$row) {
            $this->error('Agora config row hi nahi hai. Pehle agora:set chalao.');

            return self::FAILURE;
        }

        $values = (array) ($row->live_values ?? []);
        $appId  = trim((string) ($values['agora_app_id'] ?? ''));
        $cert   = trim((string) ($values['agora_app_certificate'] ?? ''));

        if ((int) $row->is_active !== 1) {
            $this->error('is_active = 0 hai — pehle agora:set se ON karo.');
        }

        if ($appId === '' || $cert === '') {
            $this->error('App ID ya Certificate khali hai — agora:set se set karo.');

            return self::FAILURE;
        }

        $channel = 'diag-' . substr((string) \Illuminate\Support\Str::uuid(), 0, 8);
        $uid     = '987654321';

        $token = \Modules\ChattingModule\Lib\AgoraToken::build($appId, $cert, $channel, $uid, 3600);

        // ---- Round-trip verify (official Token006 structure) ----
        $version = substr($token, 0, 3);
        $tokenAppId = substr($token, 3, 32);
        $content = base64_decode(substr($token, 35));

        $pos = 0;
        $sigLen = unpack('v', substr($content, $pos, 2))[1]; $pos += 2;
        $sig = substr($content, $pos, $sigLen); $pos += $sigLen;
        $pos += 4; // crc channel
        $pos += 4; // crc uid
        $msgLen = unpack('v', substr($content, $pos, 2))[1]; $pos += 2;
        $msg = substr($content, $pos, $msgLen);

        $sigExpected = hash_hmac('sha256', $appId . $channel . $uid . $msg, $cert, true);

        $ok = true;
        $this->line("channel: {$channel}");
        $this->line("token (pura, client ko yahi jata hai):");
        $this->line("  {$token}");
        $this->line("version: {$version} " . ($version === '006' ? 'OK' : 'FAIL'));
        $ok = $ok && $version === '006';
        $this->line('embedded app id: ' . ($tokenAppId === $appId ? 'OK' : 'FAIL'));
        $ok = $ok && $tokenAppId === $appId;
        $this->line('signature (certificate se HMAC): ' . ($sig === $sigExpected ? 'OK' : 'FAIL'));
        $ok = $ok && $sig === $sigExpected;

        if ($ok) {
            $this->info('PASS — token structure aur signature sahi hai.');
            $this->line('Agar calls par fir bhi errInvalidToken aaye to matlab Agora console me');
            $this->line('App Certificate is project ke liye enabled nahi hai (ya purana secret hai).');
            $this->line('Agora console > Project > Security: App Certificate ON hona chahiye.');
        } else {
            $this->error('FAIL — token build galat hai.');

            return self::FAILURE;
        }

        return self::SUCCESS;
    }
}
