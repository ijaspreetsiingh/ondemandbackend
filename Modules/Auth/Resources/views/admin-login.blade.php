<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <title>{{ translate('admin_login') }}</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="robots" content="nofollow, noindex"/>
    @php($favIcon = getBusinessSettingsImageFullPath(key: 'business_favicon', settingType: 'business_information', path: 'business/', defaultPath: 'public/assets/admin-module/img/placeholder.png'))
    <link rel="shortcut icon" href="{{ $favIcon }}"/>

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <link rel="stylesheet" href="{{ asset('public/assets/admin-module') }}/css/toastr.css"/>

    <style>
        :root {
            --ink: #0f172a;
            --muted: #64748b;
            --line: #e4e8f2;
            --field: #f7f9fd;
            --brand-1: #4f46e5;
            --brand-2: #7c3aed;
            --brand-3: #06b6d4;
            --danger: #dc2626;
        }

        * { box-sizing: border-box; }

        html, body { min-height: 100%; }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 32px 18px;
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif;
            color: var(--ink);
            background:
                radial-gradient(1100px 620px at 12% -5%, #22346e 0%, transparent 58%),
                radial-gradient(900px 520px at 102% 105%, #3a1f6e 0%, transparent 58%),
                linear-gradient(165deg, #060a16 0%, #0b1229 55%, #080e20 100%);
            -webkit-font-smoothing: antialiased;
        }

        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(90px);
            pointer-events: none;
            z-index: 0;
        }

        .orb-1 { width: 440px; height: 440px; background: #4f46e5; top: -140px; left: -120px; opacity: .45; }
        .orb-2 { width: 400px; height: 400px; background: #06b6d4; bottom: -160px; right: -110px; opacity: .30; }
        .orb-3 { width: 320px; height: 320px; background: #a855f7; top: 42%; right: 18%; opacity: .22; }

        .auth-shell {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 452px;
        }

        .auth-card {
            position: relative;
            background: #ffffff;
            border-radius: 26px;
            padding: 38px 34px 30px;
            box-shadow:
                0 44px 120px -32px rgba(2, 6, 23, .85),
                0 0 0 1px rgba(255, 255, 255, .07);
            overflow: hidden;
            animation: card-in .45s cubic-bezier(.2, .7, .3, 1) both;
        }

        @keyframes card-in {
            from { opacity: 0; transform: translateY(14px) scale(.985); }
            to { opacity: 1; transform: none; }
        }

        .auth-card::before {
            content: "";
            position: absolute;
            inset: 0 0 auto 0;
            height: 5px;
            background: linear-gradient(90deg, var(--brand-1), var(--brand-2), var(--brand-3));
        }

        .auth-brand {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 26px;
        }

        .auth-brand__left {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 0;
        }

        .auth-logo {
            width: 46px;
            height: 46px;
            border-radius: 14px;
            object-fit: contain;
            background: var(--field);
            border: 1px solid var(--line);
            padding: 6px;
            flex: 0 0 auto;
        }

        .auth-brand__name {
            display: block;
            font-size: 15px;
            font-weight: 700;
            letter-spacing: -.2px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 190px;
        }

        .auth-brand__tag {
            display: inline-block;
            margin-top: 3px;
            font-size: 10.5px;
            font-weight: 700;
            letter-spacing: .09em;
            text-transform: uppercase;
            color: var(--brand-1);
            background: rgba(79, 70, 229, .10);
            border: 1px solid rgba(79, 70, 229, .18);
            border-radius: 999px;
            padding: 3px 9px;
        }

        .auth-version {
            flex: 0 0 auto;
            font-size: 10.5px;
            font-weight: 600;
            color: var(--muted);
            background: var(--field);
            border: 1px solid var(--line);
            border-radius: 999px;
            padding: 5px 10px;
            white-space: nowrap;
        }

        .auth-title {
            margin: 0 0 6px;
            font-size: 27px;
            line-height: 1.15;
            font-weight: 800;
            letter-spacing: -.7px;
        }

        .auth-subtitle {
            margin: 0 0 24px;
            font-size: 14px;
            line-height: 1.5;
            color: var(--muted);
        }

        .auth-alert {
            display: flex;
            gap: 10px;
            align-items: flex-start;
            margin-bottom: 20px;
            padding: 12px 14px;
            border-radius: 13px;
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #991b1b;
            font-size: 13px;
            line-height: 1.5;
        }

        .auth-alert ul { margin: 0; padding-left: 16px; }
        .auth-alert li + li { margin-top: 4px; }

        .field { margin-bottom: 18px; }

        .field__label {
            display: block;
            margin-bottom: 7px;
            font-size: 12.5px;
            font-weight: 600;
            letter-spacing: .02em;
            color: #334155;
        }

        .field__control { position: relative; }

        .field__control input {
            width: 100%;
            height: 54px;
            padding: 0 48px 0 46px;
            font-family: inherit;
            font-size: 15px;
            font-weight: 500;
            color: var(--ink);
            background: var(--field);
            border: 1.5px solid var(--line);
            border-radius: 14px;
            outline: none;
            transition: border-color .15s ease, box-shadow .15s ease, background-color .15s ease;
        }

        .field__control input::placeholder { color: #a3aec3; font-weight: 400; }

        .field__control input:focus {
            background: #ffffff;
            border-color: var(--brand-1);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, .14);
        }

        .field__icon {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            width: 20px;
            height: 20px;
            color: #94a3b8;
            pointer-events: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .field__icon svg { width: 19px; height: 19px; }

        .field__toggle {
            position: absolute;
            top: 50%;
            right: 8px;
            transform: translateY(-50%);
            width: 38px;
            height: 38px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 0;
            border-radius: 11px;
            background: transparent;
            color: #94a3b8;
            cursor: pointer;
            transition: background-color .15s ease, color .15s ease;
        }

        .field__toggle:hover { background: #eef2fa; color: var(--brand-1); }
        .field__toggle svg { width: 19px; height: 19px; }

        .auth-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin: 2px 0 22px;
        }

        .check {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            font-size: 13.5px;
            font-weight: 500;
            color: #475569;
            cursor: pointer;
            user-select: none;
        }

        .check input {
            appearance: none;
            -webkit-appearance: none;
            width: 18px;
            height: 18px;
            margin: 0;
            border: 1.5px solid #cbd5e1;
            border-radius: 5px;
            background: #ffffff;
            cursor: pointer;
            position: relative;
            transition: border-color .15s ease, background-color .15s ease;
        }

        .check input:checked {
            background: linear-gradient(135deg, var(--brand-1), var(--brand-2));
            border-color: transparent;
        }

        .check input:checked::after {
            content: "";
            position: absolute;
            left: 5px;
            top: 1.5px;
            width: 5px;
            height: 10px;
            border: solid #ffffff;
            border-width: 0 2px 2px 0;
            transform: rotate(43deg);
        }

        .check input:focus-visible { box-shadow: 0 0 0 3px rgba(79, 70, 229, .22); }

        .btn-submit {
            width: 100%;
            height: 54px;
            border: 0;
            border-radius: 14px;
            font-family: inherit;
            font-size: 15px;
            font-weight: 700;
            letter-spacing: .01em;
            color: #ffffff;
            cursor: pointer;
            background: linear-gradient(135deg, var(--brand-1) 0%, var(--brand-2) 100%);
            box-shadow: 0 16px 34px -14px rgba(79, 70, 229, .85);
            transition: transform .12s ease, box-shadow .15s ease, filter .15s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-submit svg { width: 18px; height: 18px; }

        .btn-submit:hover { transform: translateY(-1px); box-shadow: 0 20px 40px -14px rgba(79, 70, 229, .95); }
        .btn-submit:active { transform: translateY(0); filter: brightness(.97); }
        .btn-submit:disabled { opacity: .7; cursor: not-allowed; transform: none; }

        .auth-demo {
            margin-top: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 14px;
            border-radius: 13px;
            background: linear-gradient(135deg, rgba(79, 70, 229, .08), rgba(6, 182, 212, .08));
            border: 1px dashed rgba(79, 70, 229, .35);
            font-size: 12.5px;
            color: #3730a3;
        }

        .auth-demo button {
            flex: 0 0 auto;
            width: 34px;
            height: 34px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: 1px solid rgba(79, 70, 229, .3);
            border-radius: 10px;
            background: #ffffff;
            color: var(--brand-1);
            cursor: pointer;
        }

        .auth-demo button svg { width: 16px; height: 16px; }
        .auth-demo div { line-height: 1.5; }
        .auth-demo strong { font-weight: 700; }

        .auth-foot {
            margin-top: 26px;
            padding-top: 18px;
            border-top: 1px solid var(--line);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            font-size: 11.5px;
            color: #94a3b8;
            text-align: center;
        }

        .auth-note {
            margin: 18px 0 0;
            text-align: center;
            font-size: 11.5px;
            color: rgba(226, 232, 240, .55);
            letter-spacing: .01em;
        }

        @media (max-width: 480px) {
            body { padding: 18px 12px; }
            .auth-card { padding: 30px 22px 24px; border-radius: 22px; }
            .auth-title { font-size: 23px; }
            .auth-brand__name { max-width: 140px; }
        }

        @media (prefers-reduced-motion: reduce) {
            .auth-card { animation: none; }
        }
    </style>
</head>

<body>
<span class="orb orb-1" aria-hidden="true"></span>
<span class="orb orb-2" aria-hidden="true"></span>
<span class="orb orb-3" aria-hidden="true"></span>

@php
    $logo = getBusinessSettingsImageFullPath(key: 'business_logo', settingType: 'business_information', path: 'business/', defaultPath: 'public/assets/admin-module/img/placeholder.png');
    $businessNameSetting = business_config('business_name', 'business_information')?->live_values;
    if (is_array($businessNameSetting)) {
        $businessNameSetting = $businessNameSetting['business_name'] ?? ($businessNameSetting['value'] ?? null);
    }
    $businessName = is_string($businessNameSetting) && trim($businessNameSetting) !== '' ? $businessNameSetting : null;
@endphp

<main class="auth-shell">
    <section class="auth-card">
        <div class="auth-brand">
            <div class="auth-brand__left">
                <img class="auth-logo" src="{{ $logo }}" alt="{{ translate('logo') }}"/>
                <div>
                    <span class="auth-brand__name">{{ $businessName ?: translate('admin_panel') }}</span>
                    <span class="auth-brand__tag">{{ translate('admin') }}</span>
                </div>
            </div>
            <span class="auth-version">{{ translate('Software_Version') }} {{ env('SOFTWARE_VERSION') }}</span>
        </div>

        <h1 class="auth-title">{{ translate('admin_Sign_In') }}</h1>
        <p class="auth-subtitle">{{ translate('sign_in_to_stay_connected') }}</p>

        @if ($errors->any())
            <div class="auth-alert" role="alert">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" width="18" height="18"
                     style="flex:0 0 auto;margin-top:1px">
                    <circle cx="12" cy="12" r="9"/>
                    <path d="M12 8v4.5" stroke-linecap="round"/>
                    <circle cx="12" cy="16" r=".9" fill="currentColor" stroke="none"/>
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
                <label class="field__label" for="email">{{ translate('email') }}</label>
                <div class="field__control">
                    <span class="field__icon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7">
                            <rect x="3" y="5" width="18" height="14" rx="3"/>
                            <path d="m4.5 7.5 6.4 4.6a2 2 0 0 0 2.2 0l6.4-4.6" stroke-linecap="round"/>
                        </svg>
                    </span>
                    <input type="text" name="email_or_phone" id="email" required
                           value="{{ request()->cookie('remember_email') }}"
                           placeholder="{{ translate('example@gmail.com') }}"
                           autocomplete="username" spellcheck="false"/>
                </div>
            </div>

            <div class="field">
                <label class="field__label" for="password">{{ translate('password') }}</label>
                <div class="field__control">
                    <span class="field__icon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7">
                            <rect x="4" y="10" width="16" height="10" rx="3"/>
                            <path d="M8 10V7.5a4 4 0 0 1 8 0V10" stroke-linecap="round"/>
                            <circle cx="12" cy="15" r="1.4" fill="currentColor" stroke="none"/>
                        </svg>
                    </span>
                    <input type="password" name="password" id="password" required
                           value="{{ request()->cookie('remember_password') }}"
                           placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;"
                           autocomplete="current-password"/>
                    <button type="button" class="field__toggle" id="togglePassword"
                            aria-label="{{ translate('show_password') }}" aria-pressed="false">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" id="eyeOpen">
                            <path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12Z"/>
                            <circle cx="12" cy="12" r="3.2"/>
                        </svg>
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" id="eyeClosed"
                             style="display:none">
                            <path d="M3 3l18 18" stroke-linecap="round"/>
                            <path d="M10.6 6.1A9.9 9.9 0 0 1 12 6c6 0 9.5 6 9.5 6a17.6 17.6 0 0 1-3.2 3.9M6.2 7.9A17.2 17.2 0 0 0 2.5 12S6 18 12 18a9.7 9.7 0 0 0 3.6-.7"/>
                            <path d="M9.9 9.9a3 3 0 0 0 4.2 4.2"/>
                        </svg>
                    </button>
                </div>
            </div>

            <div class="auth-row">
                <label class="check" for="rememberMeCheckbox">
                    <input type="checkbox" name="remember" value="1" id="rememberMeCheckbox"
                        {{ request()->cookie('remember_checked') ? 'checked' : '' }}>
                    <span>{{ translate('Remember me?') }}</span>
                </label>
            </div>

            @php($recaptcha = business_config('recaptcha', 'third_party'))
            @if(isset($recaptcha) && $recaptcha->is_active)
                <input type="hidden" name="g-recaptcha-response" id="g-recaptcha-response">
            @endif

            <button class="btn-submit" id="signInBtn" type="submit">
                {{ translate('sign_in') }}
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M5 12h13M13 6l6 6-6 6" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>

            @if(env('APP_ENV') == 'demo')
                <div class="auth-demo">
                    <button type="button" class="login-copy" aria-label="{{ translate('copy') }}">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
                            <rect x="9" y="9" width="11" height="11" rx="2.5"/>
                            <path d="M15 5.5A2.5 2.5 0 0 0 12.5 3H6.5A2.5 2.5 0 0 0 4 5.5v6A2.5 2.5 0 0 0 6.5 14"
                                  stroke-linecap="round"/>
                        </svg>
                    </button>
                    <div>
                        <strong>{{ translate('email') }}:</strong> admin@admin.com<br>
                        <strong>{{ translate('password') }}:</strong> 12345678
                    </div>
                </div>
            @endif
        </form>

        <div class="auth-foot">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" width="14" height="14">
                <path d="M12 3l7 3v5.5c0 4.3-2.9 7.6-7 9.5-4.1-1.9-7-5.2-7-9.5V6l7-3Z" stroke-linejoin="round"/>
                <path d="m9.2 12 2 2 3.6-3.8" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <span>{{ translate('secure_admin_access') }}</span>
        </div>
    </section>

    <p class="auth-note">&copy; {{ date('Y') }} {{ $businessName ?: translate('admin_panel') }} &middot; {{ translate('all_rights_reserved') }}</p>
</main>

<script src="{{ asset('public/assets/admin-module') }}/js/jquery-3.6.0.min.js"></script>
<script src="{{ asset('public/assets/admin-module') }}/js/toastr.js"></script>
{!! Toastr::message() !!}

<script>
    "use strict";

    (function () {
        var toggle = document.getElementById('togglePassword');
        var password = document.getElementById('password');
        var eyeOpen = document.getElementById('eyeOpen');
        var eyeClosed = document.getElementById('eyeClosed');

        if (toggle && password) {
            toggle.addEventListener('click', function () {
                var visible = password.type === 'text';
                password.type = visible ? 'password' : 'text';
                toggle.setAttribute('aria-pressed', String(!visible));
                if (eyeOpen) eyeOpen.style.display = visible ? '' : 'none';
                if (eyeClosed) eyeClosed.style.display = visible ? 'none' : '';
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

    @if(env('APP_ENV') == 'demo')
    $('.login-copy').on('click', function () {
        $('#email').val('admin@admin.com');
        $('#password').val('12345678');
        toastr.success('{{ translate('Copied successfully') }}');
    });
    @endif
</script>

@php($recaptcha = business_config('recaptcha', 'third_party'))
@if(isset($recaptcha) && $recaptcha->is_active)
    <script src="https://www.google.com/recaptcha/api.js?render={{ $recaptcha->live_values['site_key'] }}"></script>
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
                grecaptcha.execute('{{ $recaptcha->live_values['site_key'] }}', {action: 'submit'})
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
