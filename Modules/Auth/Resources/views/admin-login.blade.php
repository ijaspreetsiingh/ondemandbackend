<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <title>{{ translate('admin_login') }}</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="robots" content="nofollow, noindex"/>
    @php
        /**
         * Login page kabhi bhi 500 na de.
         *
         * Har helper call try/catch me hai. Agar koi business setting missing
         * ho, helper fail ho ya cache down ho — page phir bhi placeholder ke
         * saath render hoga, blank 500 nahi aayega.
         */
        $placeholder = asset('public/assets/admin-module/img/placeholder.png');
        $favIcon = $placeholder;
        $logo = $placeholder;
        $businessName = null;
        $softwareVersion = null;

        try {
            $favIcon = getBusinessSettingsImageFullPath(key: 'business_favicon', settingType: 'business_information', path: 'business/', defaultPath: 'public/assets/admin-module/img/placeholder.png');
        } catch (\Throwable $e) {
        }

        try {
            $logo = getBusinessSettingsImageFullPath(key: 'business_logo', settingType: 'business_information', path: 'business/', defaultPath: 'public/assets/admin-module/img/placeholder.png');
        } catch (\Throwable $e) {
        }

        try {
            $businessNameSetting = business_config('business_name', 'business_information');
            $businessNameValues = is_object($businessNameSetting)
                ? ($businessNameSetting->live_values ?? null)
                : $businessNameSetting;

            if (is_array($businessNameValues)) {
                $businessName = $businessNameValues['business_name'] ?? ($businessNameValues['value'] ?? null);
            } elseif (is_string($businessNameValues)) {
                $businessName = $businessNameValues;
            }

            $businessName = is_string($businessName) && trim($businessName) !== '' ? trim($businessName) : null;
        } catch (\Throwable $e) {
            $businessName = null;
        }

        try {
            $softwareVersion = env('SOFTWARE_VERSION');
        } catch (\Throwable $e) {
            $softwareVersion = null;
        }

        $recaptchaEnabled = false;
        $recaptchaSiteKey = null;

        try {
            $recaptchaSetting = business_config('recaptcha', 'third_party');
            $recaptchaValues = is_object($recaptchaSetting) ? ($recaptchaSetting->live_values ?? null) : null;
            $recaptchaSiteKey = is_array($recaptchaValues) ? ($recaptchaValues['site_key'] ?? null) : null;
            $recaptchaEnabled = is_object($recaptchaSetting) && !empty($recaptchaSetting->is_active) && !empty($recaptchaSiteKey);
        } catch (\Throwable $e) {
            $recaptchaEnabled = false;
            $recaptchaSiteKey = null;
        }

        $brandName = $businessName ?: translate('admin_panel');
    @endphp
    <link rel="shortcut icon" href="{{ $favIcon }}"/>

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@500;600;700;800&family=DM+Sans:wght@400;500;700&display=swap"
          rel="stylesheet"/>
    <link rel="stylesheet" href="{{ asset('public/assets/admin-module') }}/css/toastr.css"/>

    <style>
        :root {
            --ink: #111111;
            --ink-soft: #3a3a3a;
            --muted: #6f6f6f;
            --faint: #9a9a9a;
            --line: #e4e4e4;
            --line-strong: #cfcfcf;
            --paper: #ffffff;
            --soft: #f7f7f7;
            --danger: #c0392b;
        }

        *, *::before, *::after { box-sizing: border-box; }

        html, body { height: 100%; }

        body {
            margin: 0;
            background: var(--paper);
            color: var(--ink);
            font-family: 'DM Sans', -apple-system, 'Segoe UI', Roboto, sans-serif;
            font-size: 14px;
            line-height: 1.5;
            -webkit-font-smoothing: antialiased;
            text-rendering: optimizeLegibility;
        }

        /* ── shell ─────────────────────────────────────────────── */

        .shell {
            display: grid;
            grid-template-columns: 1.02fr 1fr;
            min-height: 100vh;
        }

        /* ── left brand panel ──────────────────────────────────── */

        .brand {
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 44px 48px 40px;
            background-color: #0e0e0e;
            background-image:
                linear-gradient(to right, rgba(255, 255, 255, .045) 1px, transparent 1px),
                linear-gradient(to bottom, rgba(255, 255, 255, .045) 1px, transparent 1px);
            background-size: 56px 56px;
            background-position: -1px -1px;
            color: #ffffff;
            overflow: hidden;
        }

        .brand::after {
            content: "";
            position: absolute;
            inset: 0;
            background: radial-gradient(120% 90% at 8% 0%, rgba(255, 255, 255, .07) 0%, transparent 62%);
            pointer-events: none;
        }

        .brand__top {
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .brand__logo {
            width: 34px;
            height: 34px;
            border-radius: 9px;
            object-fit: contain;
            background: #ffffff;
            padding: 5px;
            flex: 0 0 auto;
        }

        .brand__name {
            font-family: 'Manrope', sans-serif;
            font-size: 14px;
            font-weight: 700;
            letter-spacing: -.1px;
            max-width: 210px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .brand__chip {
            margin-left: 2px;
            padding: 3px 8px;
            border: 1px solid rgba(255, 255, 255, .22);
            border-radius: 999px;
            font-size: 10px;
            font-weight: 500;
            letter-spacing: .1em;
            text-transform: uppercase;
            color: rgba(255, 255, 255, .68);
        }

        .brand__middle {
            position: relative;
            z-index: 1;
            max-width: 460px;
            padding: 40px 0;
        }

        .brand__headline {
            margin: 0 0 16px;
            font-family: 'Manrope', sans-serif;
            font-size: 40px;
            line-height: 1.08;
            font-weight: 700;
            letter-spacing: -1.4px;
        }

        .brand__headline span {
            display: block;
            color: rgba(255, 255, 255, .42);
        }

        .brand__text {
            margin: 0;
            max-width: 380px;
            font-size: 13.5px;
            line-height: 1.65;
            color: rgba(255, 255, 255, .58);
        }

        .brand__rule {
            position: relative;
            z-index: 1;
            height: 1px;
            background: rgba(255, 255, 255, .14);
            margin: 0 0 18px;
        }

        .brand__bottom {
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 11.5px;
            letter-spacing: .02em;
            color: rgba(255, 255, 255, .42);
        }

        .brand__bottom .sep {
            width: 3px;
            height: 3px;
            border-radius: 50%;
            background: rgba(255, 255, 255, .28);
        }

        /* ── right form panel ──────────────────────────────────── */

        .panel {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 40px 48px 32px;
            background: var(--paper);
        }

        .panel__body {
            width: 100%;
            max-width: 372px;
            margin: auto;
            padding: 32px 0;
        }

        .eyebrow {
            margin: 0 0 10px;
            font-size: 10.5px;
            font-weight: 700;
            letter-spacing: .16em;
            text-transform: uppercase;
            color: var(--faint);
        }

        .title {
            margin: 0 0 8px;
            font-family: 'Manrope', sans-serif;
            font-size: 28px;
            line-height: 1.15;
            font-weight: 700;
            letter-spacing: -.8px;
        }

        .lead {
            margin: 0 0 26px;
            font-size: 13.5px;
            color: var(--muted);
        }

        /* error */

        .alert {
            display: flex;
            gap: 10px;
            align-items: flex-start;
            margin: 0 0 22px;
            padding: 12px 14px;
            background: #fdf6f5;
            border: 1px solid #f3d9d5;
            border-left: 2px solid var(--danger);
            border-radius: 8px;
            font-size: 12.5px;
            line-height: 1.55;
            color: #8c2f23;
        }

        .alert svg { flex: 0 0 auto; margin-top: 1px; }
        .alert ul { margin: 0; padding-left: 15px; }
        .alert li + li { margin-top: 3px; }

        /* fields */

        .field { margin-bottom: 18px; }

        .field__head {
            display: flex;
            align-items: baseline;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 7px;
        }

        .field__label {
            font-size: 12px;
            font-weight: 700;
            letter-spacing: .01em;
            color: var(--ink-soft);
        }

        .field__hint {
            border: 0;
            padding: 0;
            background: none;
            font-family: inherit;
            font-size: 12px;
            font-weight: 500;
            color: var(--muted);
            cursor: pointer;
            text-decoration: none;
            border-bottom: 1px solid transparent;
            transition: color .15s ease, border-color .15s ease;
        }

        .field__hint:hover { color: var(--ink); border-color: var(--line-strong); }

        .field__input {
            display: block;
            width: 100%;
            height: 48px;
            padding: 0 14px;
            font-family: inherit;
            font-size: 14px;
            font-weight: 500;
            color: var(--ink);
            background: var(--paper);
            border: 1px solid var(--line);
            border-radius: 10px;
            outline: none;
            transition: border-color .15s ease, box-shadow .15s ease;
        }

        .field__input::placeholder { color: #b0b0b0; font-weight: 400; }

        .field__input:hover { border-color: var(--line-strong); }

        .field__input:focus {
            border-color: var(--ink);
            box-shadow: 0 0 0 3px rgba(17, 17, 17, .07);
        }

        .field__input:-webkit-autofill,
        .field__input:-webkit-autofill:hover,
        .field__input:-webkit-autofill:focus {
            -webkit-text-fill-color: var(--ink);
            -webkit-box-shadow: 0 0 0 1000px #ffffff inset;
            transition: background-color 9999s ease-in-out 0s;
        }

        /* remember */

        .row-between {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 14px;
            margin: 4px 0 24px;
        }

        .check {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            font-size: 13px;
            color: var(--ink-soft);
            cursor: pointer;
            user-select: none;
        }

        .check input {
            width: 16px;
            height: 16px;
            margin: 0;
            accent-color: var(--ink);
            cursor: pointer;
        }

        /* submit */

        .submit {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            width: 100%;
            height: 48px;
            padding: 0 16px 0 18px;
            border: 1px solid var(--ink);
            border-radius: 10px;
            background: var(--ink);
            color: #ffffff;
            font-family: inherit;
            font-size: 13.5px;
            font-weight: 700;
            letter-spacing: .01em;
            cursor: pointer;
            transition: background-color .15s ease, border-color .15s ease, opacity .15s ease;
        }

        .submit svg {
            transition: transform .18s cubic-bezier(.2, .7, .3, 1);
        }

        .submit:hover { background: #000000; }
        .submit:hover svg { transform: translateX(3px); }
        .submit:active { transform: translateY(.5px); }
        .submit:disabled { opacity: .55; cursor: progress; }

        .submit:focus-visible {
            outline: none;
            box-shadow: 0 0 0 3px rgba(17, 17, 17, .18);
        }

        /* demo credentials */

        .demo {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-top: 18px;
            padding: 11px 13px;
            border: 1px dashed var(--line-strong);
            border-radius: 9px;
            background: var(--soft);
            font-size: 12px;
            line-height: 1.6;
            color: var(--ink-soft);
        }

        .demo strong { font-weight: 700; }

        .demo button {
            margin-left: auto;
            border: 1px solid var(--line-strong);
            border-radius: 7px;
            background: #ffffff;
            color: var(--ink);
            font-family: inherit;
            font-size: 11px;
            font-weight: 700;
            padding: 5px 9px;
            cursor: pointer;
            flex: 0 0 auto;
            transition: background-color .15s ease, border-color .15s ease;
        }

        .demo button:hover { background: var(--soft); border-color: var(--ink); }

        .help {
            margin: 22px 0 0;
            font-size: 12px;
            color: var(--faint);
        }

        .help a { color: var(--ink-soft); text-decoration: none; border-bottom: 1px solid var(--line-strong); }

        /* footer */

        .panel__foot {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            padding-top: 18px;
            border-top: 1px solid var(--line);
            font-size: 11.5px;
            color: var(--faint);
        }

        .panel__foot span:last-child {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        /* ── responsive ────────────────────────────────────────── */

        @media (max-width: 980px) {
            .shell { grid-template-columns: 1fr; }

            .brand {
                padding: 20px 24px;
                background-size: 40px 40px;
            }

            .brand__middle, .brand__rule, .brand__bottom { display: none; }

            .panel { padding: 32px 24px 24px; }
            .panel__body { padding: 12px 0 28px; max-width: 420px; }
            .title { font-size: 25px; }
        }

        @media (max-width: 420px) {
            .panel { padding: 24px 18px 18px; }
            .panel__foot { flex-direction: column; align-items: flex-start; gap: 6px; }
        }

        @media (prefers-reduced-motion: reduce) {
            * { transition: none !important; }
        }
    </style>
</head>

<body>
<div class="shell">

    {{-- ── brand panel ─────────────────────────────────────────── --}}
    <aside class="brand">
        <div class="brand__top">
            <img class="brand__logo" src="{{ $logo }}" alt="{{ translate('logo') }}"/>
            <span class="brand__name">{{ $brandName }}</span>
            <span class="brand__chip">{{ translate('admin') }}</span>
        </div>

        <div class="brand__middle">
            <h1 class="brand__headline">
                {{ translate('everything_your_team_runs_on') }}
                <span>{{ translate('one_console') }}</span>
            </h1>
            <p class="brand__text">{{ translate('login_brand_text') }}</p>
        </div>

        <div>
            <div class="brand__rule"></div>
            <div class="brand__bottom">
                @if (!empty($softwareVersion))
                    <span>{{ translate('Software_Version') }} {{ $softwareVersion }}</span>
                    <span class="sep"></span>
                @endif
                <span>{{ translate('admin_console') }}</span>
            </div>
        </div>
    </aside>

    {{-- ── form panel ──────────────────────────────────────────── --}}
    <main class="panel">
        <div class="panel__body">
            <p class="eyebrow">{{ translate('admin_access') }}</p>
            <h2 class="title">{{ translate('admin_Sign_In') }}</h2>
            <p class="lead">{{ translate('sign_in_to_stay_connected') }}</p>

            @if (isset($errors) && $errors->any())
                <div class="alert" role="alert">
                    <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor"
                         stroke-width="1.9" aria-hidden="true">
                        <circle cx="12" cy="12" r="9"/>
                        <path d="M12 7.8v5" stroke-linecap="round"/>
                        <circle cx="12" cy="16.2" r=".95" fill="currentColor" stroke="none"/>
                    </svg>
                    <ul>
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form action="{{ route('admin.auth.login') }}" method="POST" id="login-form" autocomplete="on">
                @csrf

                <div class="field">
                    <div class="field__head">
                        <label class="field__label" for="email">{{ translate('email_or_phone') }}</label>
                    </div>
                    <input class="field__input" type="text" name="email_or_phone" id="email" required
                           value="{{ request()->cookie('remember_email') }}"
                           placeholder="{{ translate('example@gmail.com') }}"
                           autocomplete="username" spellcheck="false" autocapitalize="off"/>
                </div>

                <div class="field">
                    <div class="field__head">
                        <label class="field__label" for="password">{{ translate('password') }}</label>
                        <button type="button" class="field__hint" id="togglePassword" aria-pressed="false">
                            {{ translate('show') }}
                        </button>
                    </div>
                    <input class="field__input" type="password" name="password" id="password" required
                           value="{{ request()->cookie('remember_password') }}"
                           placeholder="••••••••"
                           autocomplete="current-password"/>
                </div>

                <div class="row-between">
                    <label class="check" for="rememberMeCheckbox">
                        <input type="checkbox" name="remember" value="1" id="rememberMeCheckbox"
                            {{ request()->cookie('remember_checked') ? 'checked' : '' }}>
                        <span>{{ translate('Remember me?') }}</span>
                    </label>
                </div>

                @if($recaptchaEnabled)
                    <input type="hidden" name="g-recaptcha-response" id="g-recaptcha-response">
                @endif

                <button class="submit" id="signInBtn" type="submit">
                    <span>{{ translate('sign_in') }}</span>
                    <svg viewBox="0 0 24 24" width="17" height="17" fill="none" stroke="currentColor"
                         stroke-width="2" aria-hidden="true">
                        <path d="M4.5 12h14M12.5 6l6 6-6 6" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>

                @if(config('app.env') == 'demo')
                    <div class="demo">
                        <div>
                            <strong>{{ translate('email') }}</strong> admin@admin.com<br>
                            <strong>{{ translate('password') }}</strong> 12345678
                        </div>
                        <button type="button" class="login-copy">{{ translate('copy') }}</button>
                    </div>
                @endif
            </form>

            <p class="help">{{ translate('login_help_text') }}</p>
        </div>

        <footer class="panel__foot">
            <span>&copy; {{ date('Y') }} {{ $brandName }}</span>
            <span>
                <svg viewBox="0 0 24 24" width="12" height="12" fill="none" stroke="currentColor"
                     stroke-width="2" aria-hidden="true">
                    <path d="M12 3l7 3v5.6c0 4.3-2.9 7.6-7 9.4-4.1-1.8-7-5.1-7-9.4V6l7-3Z" stroke-linejoin="round"/>
                </svg>
                {{ translate('secure_admin_access') }}
            </span>
        </footer>
    </main>

</div>

<script src="{{ asset('public/assets/admin-module') }}/js/jquery-3.6.0.min.js"></script>
<script src="{{ asset('public/assets/admin-module') }}/js/toastr.js"></script>
@php
    $toastrHtml = '';
    try {
        $toastrHtml = Toastr::message();
    } catch (\Throwable $e) {
        $toastrHtml = '';
    }
@endphp
{!! $toastrHtml !!}

<script>
    "use strict";

    (function () {
        var toggle = document.getElementById('togglePassword');
        var password = document.getElementById('password');
        var showLabel = '{{ translate('show') }}';
        var hideLabel = '{{ translate('hide') }}';

        if (toggle && password) {
            toggle.addEventListener('click', function () {
                var visible = password.type === 'text';
                password.type = visible ? 'password' : 'text';
                toggle.textContent = visible ? showLabel : hideLabel;
                toggle.setAttribute('aria-pressed', String(!visible));
            });
        }

        var form = document.getElementById('login-form');
        var submitBtn = document.getElementById('signInBtn');

        if (form) {
            form.addEventListener('submit', function () {
                if (submitBtn) {
                    submitBtn.disabled = true;
                }
            });
        }
    })();

    @if(config('app.env') == 'demo')
    $('.login-copy').on('click', function () {
        $('#email').val('admin@admin.com');
        $('#password').val('12345678');
        toastr.success('{{ translate('Copied successfully') }}');
    });
    @endif
</script>

@if($recaptchaEnabled)
    <script src="https://www.google.com/recaptcha/api.js?render={{ $recaptchaSiteKey }}"></script>
    <script>
        "use strict";

        document.getElementById('login-form').addEventListener('submit', function (e) {
            var tokenField = document.getElementById('g-recaptcha-response');
            var form = this;
            var submitBtn = document.getElementById('signInBtn');

            if (tokenField.value) {
                return;
            }

            e.preventDefault();

            if (typeof grecaptcha === 'undefined') {
                if (submitBtn) submitBtn.disabled = false;
                toastr.error('{{ translate('Invalid recaptcha key provided. Please check the recaptcha configuration.') }}');
                return;
            }

            grecaptcha.ready(function () {
                grecaptcha.execute('{{ $recaptchaSiteKey }}', {action: 'submit'})
                    .then(function (token) {
                        tokenField.value = token;
                        form.submit();
                    })
                    .catch(function () {
                        if (submitBtn) submitBtn.disabled = false;
                        toastr.error('{{ translate('ReCaptcha Failed') }}');
                    });
            });
        });
    </script>
@endif

</body>
</html>
