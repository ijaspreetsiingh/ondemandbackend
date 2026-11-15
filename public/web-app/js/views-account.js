/* ============================================================
 * Jass Booking — account, auth, messages & information views
 * ============================================================ */
'use strict';

window.Views = window.Views || {};

(() => {
  const { state, ok } = API;
  const U = UI;

  const safeNext = (raw, fallback = '#/') => {
    if (!raw) return fallback;
    const value = String(raw);
    if (value.startsWith('#/')) return value;
    if (value.startsWith('/')) return '#' + value;
    return fallback;
  };

  /* =========================================================
   * LOGIN
   * ========================================================= */
  async function login(view, query = {}) {
    const next = safeNext(query.next, '#/');
    view.innerHTML = `
      <div class="page page--auth">
        <div class="authwrap">
          <div class="authart" aria-hidden="true">
            <span class="eyebrow">Welcome back</span>
            <h2>Your home,<br>in good hands.</h2>
            <ul>
              <li>${U.icon('check', 15)} Track every booking live</li>
              <li>${U.icon('check', 15)} Save addresses for faster checkout</li>
              <li>${U.icon('check', 15)} Rebook your favourite services</li>
            </ul>
          </div>
          <div class="authcard">
            <span class="eyebrow">Sign in</span>
            <h1>Good to see you again</h1>
            <p class="muted">Use the phone number or email linked to your account.</p>

            <form id="login-form" class="formstack">
              ${U.field({ id: 'lg-identity', label: 'Phone or email', placeholder: '98765 43210 or you@email.com', required: true, autocomplete: 'username' })}
              <label class="field">
                <span class="field__label">Password <i>*</i></span>
                <span class="inputwrap">
                  <input class="input" id="lg-pass" type="password" placeholder="Your password" autocomplete="current-password" required>
                  <button type="button" class="inputwrap__btn" id="toggle-pass" aria-label="Show password">${U.icon('eye', 16)}</button>
                </span>
              </label>
              <div class="formrow">
                <span></span>
                <a class="link" href="#/forgot">Forgot password?</a>
              </div>
              <button class="btn btn--primary btn--block btn--lg" type="submit" id="lg-submit">Sign in</button>
            </form>

            <p class="authfoot">New to ${U.esc((state.config && state.config.business_name) || 'Jass Booking')}? <a href="#/signup${next !== '#/' ? '?next=' + encodeURIComponent(next) : ''}">Create an account</a></p>
          </div>
        </div>
      </div>`;

    const form = view.querySelector('#login-form');
    const pass = view.querySelector('#lg-pass');
    const toggle = view.querySelector('#toggle-pass');
    toggle.onclick = () => {
      const show = pass.type === 'password';
      pass.type = show ? 'text' : 'password';
      toggle.innerHTML = U.icon(show ? 'eyeOff' : 'eye', 16);
      toggle.setAttribute('aria-label', show ? 'Hide password' : 'Show password');
    };

    form.onsubmit = async (e) => {
      e.preventDefault();
      const identity = view.querySelector('#lg-identity').value.trim();
      const password = pass.value;
      if (!identity || !password) { U.toast('Enter your details to continue', 'error'); return; }
      const type = identity.includes('@') ? 'email' : 'phone';
      const btn = view.querySelector('#lg-submit');
      btn.disabled = true;
      btn.textContent = 'Signing in…';
      try {
        const res = await API.signin(identity, password, type);
        if (ok(res) && res.content && res.content.token) {
          state.token = res.content.token;
          await loadProfile();
          await API.refreshCartCount();
          App.renderChrome();
          U.toast('Welcome back!', 'success');
          location.hash = next;
        } else {
          U.toast((res && res.message) || 'Those details did not match our records', 'error');
          btn.disabled = false;
          btn.textContent = 'Sign in';
        }
      } catch (err) {
        U.toast(err.message, 'error');
        btn.disabled = false;
        btn.textContent = 'Sign in';
      }
    };
  }

  async function loadProfile() {
    try {
      const res = await API.profile();
      if (ok(res) && res.content) {
        state.user = res.content;
        return res.content;
      }
    } catch (e) { /* keep cached user */ }
    return state.user;
  }

  /* =========================================================
   * SIGNUP
   * ========================================================= */
  async function signup(view, query = {}) {
    const next = safeNext(query.next, '#/');
    view.innerHTML = `
      <div class="page page--auth">
        <div class="authwrap">
          <div class="authart authart--alt" aria-hidden="true">
            <span class="eyebrow">Join us</span>
            <h2>One account.<br>Every service.</h2>
            <ul>
              <li>${U.icon('check', 15)} Book verified professionals</li>
              <li>${U.icon('check', 15)} Upfront prices, no surprises</li>
              <li>${U.icon('check', 15)} Rewards on every booking</li>
            </ul>
          </div>
          <div class="authcard">
            <span class="eyebrow">Create account</span>
            <h1>Let's get you set up</h1>
            <p class="muted">Takes less than a minute.</p>

            <form id="signup-form" class="formstack">
              <div class="grid2">
                ${U.field({ id: 'su-first', label: 'First name', placeholder: 'Aarav', required: true, autocomplete: 'given-name' })}
                ${U.field({ id: 'su-last', label: 'Last name', placeholder: 'Sharma', required: true, autocomplete: 'family-name' })}
              </div>
              ${U.field({ id: 'su-phone', label: 'Phone number', placeholder: '98765 43210', required: true, inputmode: 'tel', autocomplete: 'tel' })}
              ${U.field({ id: 'su-email', label: 'Email', placeholder: 'you@email.com', required: true, type: 'email', autocomplete: 'email' })}
              <div class="grid2">
                <label class="field">
                  <span class="field__label">Password <i>*</i></span>
                  <input class="input" id="su-pass" type="password" placeholder="At least 8 characters" autocomplete="new-password" required minlength="8">
                </label>
                <label class="field">
                  <span class="field__label">Confirm password <i>*</i></span>
                  <input class="input" id="su-pass2" type="password" placeholder="Repeat password" autocomplete="new-password" required>
                </label>
              </div>
              ${U.field({ id: 'su-referral', label: 'Referral code (optional)', placeholder: 'Enter a friend’s code' })}
              <button class="btn btn--primary btn--block btn--lg" type="submit" id="su-submit">Create account</button>
            </form>

            <p class="authfoot">Already have an account? <a href="#/login${next !== '#/' ? '?next=' + encodeURIComponent(next) : ''}">Sign in</a></p>
          </div>
        </div>
      </div>`;

    const form = view.querySelector('#signup-form');
    form.onsubmit = async (e) => {
      e.preventDefault();
      const body = {
        first_name: view.querySelector('#su-first').value.trim(),
        last_name: view.querySelector('#su-last').value.trim(),
        phone: view.querySelector('#su-phone').value.trim(),
        email: view.querySelector('#su-email').value.trim(),
        password: view.querySelector('#su-pass').value,
        confirm_password: view.querySelector('#su-pass2').value,
        gender: 'male',
      };
      const referral = view.querySelector('#su-referral').value.trim();
      if (referral) body.referral_code = referral;

      if (!body.first_name || !body.last_name) { U.toast('Please enter your full name', 'error'); return; }
      if (!body.phone || body.phone.replace(/\D/g, '').length < 10) { U.toast('Enter a valid phone number', 'error'); return; }
      if (!body.email || !body.email.includes('@')) { U.toast('Enter a valid email address', 'error'); return; }
      if (body.password.length < 8) { U.toast('Password must be at least 8 characters', 'error'); return; }
      if (body.password !== body.confirm_password) { U.toast('Passwords do not match', 'error'); return; }

      const btn = view.querySelector('#su-submit');
      btn.disabled = true;
      btn.textContent = 'Creating account…';
      try {
        const res = await API.signup(body);
        if (ok(res)) {
          /* Try an immediate sign-in (email verification may be required first) */
          try {
            const signin = await API.signin(body.phone, body.password, 'phone');
            if (ok(signin) && signin.content && signin.content.token) {
              state.token = signin.content.token;
              await loadProfile();
              await API.refreshCartCount();
              App.renderChrome();
              U.toast('Account created — welcome!', 'success');
              location.hash = next;
              return;
            }
          } catch (err) { /* fall through to the sign-in screen */ }
          U.toast('Account created. Please sign in to continue.', 'success');
          location.hash = '#/login' + (next !== '#/' ? '?next=' + encodeURIComponent(next) : '');
        } else {
          U.toast((res && res.message) || 'Could not create your account', 'error');
          btn.disabled = false;
          btn.textContent = 'Create account';
        }
      } catch (err) {
        U.toast(err.message, 'error');
        btn.disabled = false;
        btn.textContent = 'Create account';
      }
    };
  }

  /* =========================================================
   * FORGOT PASSWORD
   * ========================================================= */
  async function forgot(view) {
    let step = 1;
    let identity = '';
    let identityType = 'email';
    let otp = '';

    const render = () => {
      view.innerHTML = `
        <div class="page page--auth">
          <div class="authwrap">
            <div class="authart authart--alt" aria-hidden="true">
              <span class="eyebrow">Account recovery</span>
              <h2>Back in,<br>in no time.</h2>
              <p class="authart__text">We'll send a one-time code to confirm it's really you.</p>
            </div>
            <div class="authcard">
              <span class="eyebrow">Step ${step} of 3</span>
              <h1>${step === 1 ? 'Reset your password' : step === 2 ? 'Enter the code' : 'Set a new password'}</h1>
              <p class="muted">${step === 1 ? 'Choose how you want to receive your verification code.' : step === 2 ? `We sent a 6-digit code to ${U.esc(identity)}.` : 'Choose a strong password you have not used before.'}</p>
              <div id="forgot-step" class="formstack"></div>
              <p class="authfoot"><a href="#/login">← Back to sign in</a></p>
            </div>
          </div>
        </div>`;

      const host = view.querySelector('#forgot-step');
      if (step === 1) {
        host.innerHTML = `
          <div class="choices">
            <button class="choice ${identityType === 'email' ? 'is-on' : ''}" data-type="email"><b>Email</b><small>Send to my email address</small></button>
            <button class="choice ${identityType === 'phone' ? 'is-on' : ''}" data-type="phone"><b>Phone</b><small>Send by SMS</small></button>
          </div>
          ${U.field({ id: 'fg-identity', label: identityType === 'email' ? 'Email address' : 'Phone number', placeholder: identityType === 'email' ? 'you@email.com' : '98765 43210', required: true })}
          <button class="btn btn--primary btn--block" id="fg-send">Send code</button>`;
        host.querySelectorAll('[data-type]').forEach(btn => {
          btn.onclick = () => { identityType = btn.dataset.type; render(); };
        });
        host.querySelector('#fg-send').onclick = async () => {
          identity = host.querySelector('#fg-identity').value.trim();
          if (!identity) { U.toast('Enter your ' + identityType, 'error'); return; }
          const btn = host.querySelector('#fg-send');
          btn.disabled = true; btn.textContent = 'Sending…';
          try {
            const res = await API.forgotPassword(identity, identityType);
            if (ok(res)) { step = 2; render(); U.toast('Code sent', 'success'); }
            else { U.toast(res.message || 'Could not send the code', 'error'); btn.disabled = false; btn.textContent = 'Send code'; }
          } catch (e) { U.toast(e.message, 'error'); btn.disabled = false; btn.textContent = 'Send code'; }
        };
      } else if (step === 2) {
        host.innerHTML = `
          ${U.field({ id: 'fg-otp', label: 'Verification code', placeholder: '6-digit code', inputmode: 'numeric', maxlength: '6', required: true })}
          <button class="btn btn--primary btn--block" id="fg-verify">Verify code</button>
          <button class="btn btn--ghost btn--block" id="fg-resend">Resend code</button>`;
        host.querySelector('#fg-verify').onclick = async () => {
          otp = host.querySelector('#fg-otp').value.trim();
          if (!otp) { U.toast('Enter the code', 'error'); return; }
          const btn = host.querySelector('#fg-verify');
          btn.disabled = true; btn.textContent = 'Verifying…';
          try {
            const res = await API.verifyResetPin(identity, identityType, otp);
            if (ok(res)) { step = 3; render(); }
            else { U.toast(res.message || 'That code is not valid', 'error'); btn.disabled = false; btn.textContent = 'Verify code'; }
          } catch (e) { U.toast(e.message, 'error'); btn.disabled = false; btn.textContent = 'Verify code'; }
        };
        host.querySelector('#fg-resend').onclick = async () => {
          try { await API.forgotPassword(identity, identityType); U.toast('A new code is on its way', 'success'); }
          catch (e) { U.toast(e.message, 'error'); }
        };
      } else {
        host.innerHTML = `
          ${U.field({ id: 'fg-pass', label: 'New password', type: 'password', placeholder: 'At least 8 characters', required: true })}
          ${U.field({ id: 'fg-pass2', label: 'Confirm password', type: 'password', placeholder: 'Repeat password', required: true })}
          <button class="btn btn--primary btn--block" id="fg-reset">Set new password</button>`;
        host.querySelector('#fg-reset').onclick = async () => {
          const p1 = host.querySelector('#fg-pass').value;
          const p2 = host.querySelector('#fg-pass2').value;
          if (p1.length < 8) { U.toast('Password must be at least 8 characters', 'error'); return; }
          if (p1 !== p2) { U.toast('Passwords do not match', 'error'); return; }
          const btn = host.querySelector('#fg-reset');
          btn.disabled = true; btn.textContent = 'Saving…';
          try {
            const res = await API.resetPassword(identity, identityType, otp, p1, p2);
            if (ok(res)) {
              U.toast('Password updated — please sign in', 'success');
              location.hash = '#/login';
            } else {
              U.toast(res.message || 'Could not reset the password', 'error');
              btn.disabled = false; btn.textContent = 'Set new password';
            }
          } catch (e) { U.toast(e.message, 'error'); btn.disabled = false; btn.textContent = 'Set new password'; }
        };
      }
    };

    render();
  }

  /* =========================================================
   * ACCOUNT HUB
   * ========================================================= */
  async function account(view) {
    if (!state.isLoggedIn()) { location.hash = '#/login?next=' + encodeURIComponent('#/account'); return; }
    view.innerHTML = `<div class="page page--narrow">${U.skeletonRows(2)}</div>`;

    const cfg = state.config || {};
    const user = await loadProfile() || state.user || {};
    const userType = String(user.user_type || '');
    if (userType && !/customer/.test(userType)) { /* still show; provider accounts have limited access */ }

    const walletOn = Number(cfg.wallet_status) === 1;
    const loyaltyOn = Number(cfg.loyalty_point_status) === 1;
    const unreadHint = '';

    view.innerHTML = `
      <div class="page">
        <header class="profilehead">
          <span class="profilehead__avatar">
            ${user.profile_image_full_path
              ? `<img src="${U.esc(user.profile_image_full_path)}" alt="" onerror="this.replaceWith(document.createTextNode('${U.esc(U.initials(user.first_name, user.last_name))}'))">`
              : U.esc(U.initials(user.first_name, user.last_name))}
          </span>
          <div class="profilehead__id">
            <h1>${U.esc([user.first_name, user.last_name].filter(Boolean).join(' ') || 'Your account')}</h1>
            <p>${U.esc(user.phone || '')}${user.email ? ' · ' + U.esc(user.email) : ''}</p>
            ${user.is_email_verified === 0 ? `<span class="pill pill--pending">Email not verified</span>` : ''}
          </div>
          <a class="btn btn--ghost btn--sm" href="#/account/profile">${U.icon('edit', 15)} Edit profile</a>
        </header>

        <div class="statgrid">
          <a class="stat" href="#/orders"><b>${U.esc(user.bookings_count ?? '—')}</b><span>Bookings</span></a>
          <a class="stat" href="#/favorites"><b>${U.icon('heart', 18)}</b><span>Saved services</span></a>
          ${walletOn ? `<a class="stat" href="#/account/wallet"><b>${U.money(user.wallet_balance || 0)}</b><span>Wallet</span></a>` : ''}
          ${loyaltyOn ? `<a class="stat" href="#/account/wallet"><b>${U.esc(user.loyalty_point || 0)}</b><span>Reward points</span></a>` : ''}
        </div>

        <div class="accountgrid">
          <section class="card menu">
            <h3 class="card__title">Activity</h3>
            <a class="menurow" href="#/orders"><span>${U.icon('calendar', 18)} My bookings</span>${U.icon('chevronRight', 15)}</a>
            <a class="menurow" href="#/favorites"><span>${U.icon('heart', 18)} Saved services</span>${U.icon('chevronRight', 15)}</a>
            <a class="menurow" href="#/offers"><span>${U.icon('ticket', 18)} Offers &amp; coupons</span>${U.icon('chevronRight', 15)}</a>
            <a class="menurow" href="#/notifications"><span>${U.icon('bell', 18)} Notifications</span>${U.icon('chevronRight', 15)}</a>
            <a class="menurow" href="#/chat"><span>${U.icon('chat', 18)} Messages</span>${unreadHint}${U.icon('chevronRight', 15)}</a>
          </section>

          <section class="card menu">
            <h3 class="card__title">Account</h3>
            <a class="menurow" href="#/account/profile"><span>${U.icon('user', 18)} Personal details</span>${U.icon('chevronRight', 15)}</a>
            <a class="menurow" href="#/account/addresses"><span>${U.icon('pin', 18)} Saved addresses</span>${U.icon('chevronRight', 15)}</a>
            ${walletOn || loyaltyOn ? `<a class="menurow" href="#/account/wallet"><span>${U.icon('wallet', 18)} Wallet &amp; rewards</span>${U.icon('chevronRight', 15)}</a>` : ''}
            <a class="menurow" href="#/support"><span>${U.icon('shield', 18)} Help &amp; support</span>${U.icon('chevronRight', 15)}</a>
            <a class="menurow" href="#/pages/about_us"><span>${U.icon('info', 18)} About us</span>${U.icon('chevronRight', 15)}</a>
            <a class="menurow" href="#/pages/terms_and_conditions"><span>${U.icon('file', 18)} Terms &amp; privacy</span>${U.icon('chevronRight', 15)}</a>
          </section>
        </div>

        <div class="accountactions">
          <button class="btn btn--ghost btn--block" data-logout>${U.icon('logout', 16)} Sign out</button>
          <button class="btn btn--danger-ghost btn--block" id="delete-account">Delete my account</button>
        </div>
        <p class="hint hint--center">Signed in as ${U.esc(user.phone || user.email || 'customer')}</p>
      </div>`;

    view.querySelector('#delete-account').onclick = async () => {
      const yes = await U.confirmDialog({
        title: 'Delete your account?',
        message: 'This permanently removes your account, bookings history and saved data. This cannot be undone.',
        confirmLabel: 'Delete account', danger: true,
      });
      if (!yes) return;
      try {
        const res = await API.deleteAccount();
        if (ok(res)) {
          state.clearSession();
          App.renderChrome();
          U.toast('Your account has been deleted', 'success');
          location.hash = '#/';
        } else U.toast(res.message || 'Could not delete the account', 'error');
      } catch (e) { U.toast(e.message, 'error'); }
    };
  }

  /* =========================================================
   * PROFILE EDIT
   * ========================================================= */
  async function profileEdit(view) {
    if (!state.isLoggedIn()) { location.hash = '#/login?next=' + encodeURIComponent('#/account/profile'); return; }
    view.innerHTML = `<div class="page page--narrow">${U.skeletonRows(2)}</div>`;
    const user = await loadProfile() || state.user || {};

    view.innerHTML = `
      <div class="page page--narrow">
        <nav class="crumbs"><a href="#/account">Account</a>${U.icon('chevronRight', 12)}<span>Personal details</span></nav>
        <header class="pagehead"><span class="eyebrow">Keep it current</span><h1>Personal details</h1></header>
        <form class="card formstack" id="profile-form">
          <div class="grid2">
            ${U.field({ id: 'pf-first', label: 'First name', value: user.first_name || '', required: true })}
            ${U.field({ id: 'pf-last', label: 'Last name', value: user.last_name || '', required: true })}
          </div>
          <div class="grid2">
            ${U.field({ id: 'pf-phone', label: 'Phone number', value: user.phone || '', required: true, inputmode: 'tel' })}
            ${U.field({ id: 'pf-email', label: 'Email', value: user.email || '', required: true, type: 'email' })}
          </div>
          <label class="field">
            <span class="field__label">Profile photo</span>
            <input class="input input--file" id="pf-photo" type="file" accept="image/png,image/jpeg,image/webp">
            <span class="field__hint">Optional. JPG, PNG or WebP up to 5 MB.</span>
          </label>
          <div class="block__sep"></div>
          <p class="muted">Change password — leave both fields empty to keep your current password.</p>
          <div class="grid2">
            ${U.field({ id: 'pf-pass', label: 'New password', type: 'password', placeholder: 'At least 8 characters' })}
            ${U.field({ id: 'pf-pass2', label: 'Confirm password', type: 'password', placeholder: 'Repeat password' })}
          </div>
          <button class="btn btn--primary btn--block" type="submit" id="pf-save">Save changes</button>
        </form>
      </div>`;

    view.querySelector('#profile-form').onsubmit = async (e) => {
      e.preventDefault();
      const p1 = view.querySelector('#pf-pass').value;
      const p2 = view.querySelector('#pf-pass2').value;
      if (p1 && p1.length < 8) { U.toast('Password must be at least 8 characters', 'error'); return; }
      if (p1 !== p2) { U.toast('Passwords do not match', 'error'); return; }

      const body = {
        first_name: view.querySelector('#pf-first').value.trim(),
        last_name: view.querySelector('#pf-last').value.trim(),
        phone: view.querySelector('#pf-phone').value.trim(),
        email: view.querySelector('#pf-email').value.trim(),
      };
      if (p1) body.password = p1;

      const file = view.querySelector('#pf-photo').files[0];
      const btn = view.querySelector('#pf-save');
      btn.disabled = true;
      btn.textContent = 'Saving…';

      try {
        let res;
        if (file) {
          const fd = new FormData();
          Object.entries(body).forEach(([k, v]) => fd.append(k, v));
          fd.append('profile_image', file);
          res = await API.updateProfile(fd);
        } else {
          res = await API.updateProfile(body);
        }
        if (ok(res)) {
          await loadProfile();
          App.renderChrome();
          U.toast('Profile updated', 'success');
          location.hash = '#/account';
        } else {
          U.toast(res.message || 'Could not save your details', 'error');
          btn.disabled = false;
          btn.textContent = 'Save changes';
        }
      } catch (err) {
        U.toast(err.message, 'error');
        btn.disabled = false;
        btn.textContent = 'Save changes';
      }
    };
  }

  /* =========================================================
   * ADDRESSES
   * ========================================================= */
  async function addresses(view) {
    if (!state.isLoggedIn()) { location.hash = '#/login?next=' + encodeURIComponent('#/account/addresses'); return; }
    view.innerHTML = `<div class="page page--narrow">${U.skeletonRows(3)}</div>`;

    let list = [];
    try {
      const res = await API.getAddresses();
      list = ok(res) ? ((res.content && (res.content.data || res.content.addresses)) || []) : [];
    } catch (e) { /* empty state */ }

    view.innerHTML = `
      <div class="page page--narrow">
        <nav class="crumbs"><a href="#/account">Account</a>${U.icon('chevronRight', 12)}<span>Addresses</span></nav>
        <header class="pagehead pagehead--inline">
          <div><span class="eyebrow">Where we come to help</span><h1>Saved addresses</h1></div>
          <button class="btn btn--primary btn--sm" id="addr-add">${U.icon('plus', 15)} Add</button>
        </header>
        <div id="addr-list">
          ${list.length ? list.map(a => `<article class="addcard" data-id="${U.esc(a.id)}">
            <div class="addcard__head">
              <span class="addcard__icon">${U.icon('pin', 17)}</span>
              <div><b>${U.esc(U.titleCase(a.address_label || 'Address'))}</b>
                <small>${U.esc(U.titleCase(a.address_type || 'service'))}</small></div>
            </div>
            <p>${U.esc(a.address || '')}</p>
            <p class="muted">${U.esc(a.contact_person_name || '')}${a.contact_person_number ? ' · ' + U.esc(a.contact_person_number) : ''}</p>
            <div class="addcard__actions">
              <button class="link" data-edit>${U.icon('edit', 14)} Edit</button>
              <button class="link link--danger" data-del>${U.icon('trash', 14)} Delete</button>
            </div>
          </article>`).join('')
            : U.empty({ icon: 'pin', title: 'No saved addresses', text: 'Add one to check out faster next time.', action: `<button class="btn btn--primary" id="addr-add2">Add address</button>` })}
        </div>
      </div>`;

    const openAdd = (existing) => Views.addressSheet(() => addresses(view), existing);
    const addBtn = view.querySelector('#addr-add');
    if (addBtn) addBtn.onclick = () => openAdd(null);
    const addBtn2 = view.querySelector('#addr-add2');
    if (addBtn2) addBtn2.onclick = () => openAdd(null);

    view.querySelectorAll('.addcard').forEach(card => {
      const a = list.find(x => String(x.id) === String(card.dataset.id));
      const edit = card.querySelector('[data-edit]');
      const del = card.querySelector('[data-del]');
      if (edit) edit.onclick = () => openAdd(a);
      if (del) del.onclick = async () => {
        const yes = await U.confirmDialog({ title: 'Delete this address?', message: a && a.address, confirmLabel: 'Delete', danger: true });
        if (!yes) return;
        try {
          const res = await API.deleteAddress(a.id);
          if (ok(res)) { U.toast('Address deleted', 'success'); addresses(view); }
          else U.toast(res.message || 'Could not delete the address', 'error');
        } catch (e) { U.toast(e.message, 'error'); }
      };
    });
  }

  /* =========================================================
   * FAVORITES
   * ========================================================= */
  async function favorites(view) {
    if (!state.isLoggedIn()) { location.hash = '#/login?next=' + encodeURIComponent('#/favorites'); return; }
    view.innerHTML = `<div class="page">${U.skeletonCards(4)}</div>`;
    let list = [];
    try {
      const res = await API.getFavorites(1, 50);
      if (ok(res)) {
        const c = res.content || {};
        list = c.data || c.serviceList || c.services || [];
      }
    } catch (e) { /* handled below */ }

    view.innerHTML = `
      <div class="page">
        <nav class="crumbs"><a href="#/account">Account</a>${U.icon('chevronRight', 12)}<span>Saved</span></nav>
        <header class="pagehead"><span class="eyebrow">Your shortlist</span><h1>Saved services</h1></header>
        ${list.length ? `<div class="cardgrid">${list.map(U.serviceCard).join('')}</div>`
          : U.empty({ icon: 'heart', title: 'Nothing saved yet', text: 'Tap the heart on a service to keep it here.', action: `<a class="btn btn--primary" href="#/categories">Find services</a>` })}
      </div>`;
  }

  /* =========================================================
   * WALLET & REWARDS
   * ========================================================= */
  async function wallet(view) {
    if (!state.isLoggedIn()) { location.hash = '#/login?next=' + encodeURIComponent('#/account/wallet'); return; }
    view.innerHTML = `<div class="page page--narrow">${U.skeletonRows(3)}</div>`;

    const cfg = state.config || {};
    const walletOn = Number(cfg.wallet_status) === 1;
    const loyaltyOn = Number(cfg.loyalty_point_status) === 1;
    const user = await loadProfile() || state.user || {};
    let tab = (new URLSearchParams((location.hash.split('?')[1] || ''))).get('tab') || (walletOn ? 'wallet' : 'points');
    let txns = [];
    let balance = user.wallet_balance || 0;
    let points = user.loyalty_point || 0;

    async function loadTab() {
      host.innerHTML = U.skeletonRows(3);
      try {
        if (tab === 'wallet') {
          const res = await API.getWalletLedger(1, 30);
          if (ok(res) && res.content) {
            balance = res.content.wallet_balance ?? balance;
            txns = (res.content.transactions && res.content.transactions.data) || [];
          } else txns = [];
        } else {
          const res = await API.getLoyaltyLedger(1, 30);
          if (ok(res) && res.content) {
            points = res.content.loyalty_point ?? points;
            txns = (res.content.transactions && res.content.transactions.data) || [];
          } else txns = [];
        }
      } catch (e) { txns = []; }
      renderTab();
    }

    function renderTab() {
      const amountRow = (t) => {
        const amt = Number(t.amount || t.credit || t.debit || 0);
        const isCredit = String(t.trx_type || '').includes('credit') || String(t.transaction_type || '').includes('credit') || t.credit;
        return `<div class="txn">
          <div class="txn__ic ${isCredit ? 'is-in' : 'is-out'}">${U.icon(isCredit ? 'plus' : 'minus', 15)}</div>
          <div class="txn__body">
            <b>${U.esc(U.titleCase(t.trx_type || t.transaction_type || 'Transaction'))}</b>
            <small>${U.esc(U.fmtDate(t.created_at))}${t.booking && t.booking.readable_id ? ' · Booking #' + U.esc(t.booking.readable_id) : ''}</small>
          </div>
          <b class="txn__amt ${isCredit ? 'is-in' : 'is-out'}">${isCredit ? '+' : '−'}${tab === 'wallet' ? U.money(amt) : U.esc(amt) + ' pts'}</b>
        </div>`;
      };
      host.innerHTML = `
        <div class="balancecard">
          <span>${tab === 'wallet' ? 'Wallet balance' : 'Reward points'}</span>
          <b>${tab === 'wallet' ? U.money(balance) : U.esc(points || 0) + ' pts'}</b>
          ${tab === 'points' && Number(points) > 0 && Number(cfg.add_to_fund_wallet) === 1
            ? `<button class="btn btn--ghost btn--sm" id="convert-points">Convert to wallet</button>` : ''}
        </div>
        ${txns.length ? `<div class="txnlist">${txns.map(amountRow).join('')}</div>`
          : U.empty({ icon: 'wallet', title: 'No transactions yet', text: 'Wallet activity and reward points will show up here.' })}`;
      const convert = host.querySelector('#convert-points');
      if (convert) {
        convert.onclick = async () => {
          const value = window.prompt('How many points would you like to convert?', String(points));
          if (!value) return;
          try {
            const res = await API.moveLoyaltyToWallet(Number(value));
            if (ok(res)) { U.toast('Points converted', 'success'); await loadProfile(); loadTab(); }
            else U.toast(res.message || 'Could not convert points', 'error');
          } catch (e) { U.toast(e.message, 'error'); }
        };
      }
    }

    view.innerHTML = `
      <div class="page page--narrow">
        <nav class="crumbs"><a href="#/account">Account</a>${U.icon('chevronRight', 12)}<span>Wallet</span></nav>
        <header class="pagehead"><span class="eyebrow">Money &amp; rewards</span><h1>Wallet &amp; rewards</h1></header>
        ${(walletOn && loyaltyOn) ? `<div class="tabs" id="wallet-tabs">
          <button class="tabs__btn ${tab === 'wallet' ? 'is-on' : ''}" data-tab="wallet">Wallet</button>
          <button class="tabs__btn ${tab === 'points' ? 'is-on' : ''}" data-tab="points">Reward points</button>
        </div>` : ''}
        <div id="wallet-body"></div>
      </div>`;

    const host = view.querySelector('#wallet-body');
    view.querySelectorAll('#wallet-tabs [data-tab]').forEach(btn => {
      btn.onclick = () => {
        tab = btn.dataset.tab;
        view.querySelectorAll('#wallet-tabs [data-tab]').forEach(b => b.classList.remove('is-on'));
        btn.classList.add('is-on');
        loadTab();
      };
    });

    if (!walletOn && !loyaltyOn) {
      host.innerHTML = U.empty({ icon: 'wallet', title: 'Wallet is not enabled', text: 'This store does not use a wallet or reward points right now.' });
      return;
    }
    await loadTab();
  }

  /* =========================================================
   * NOTIFICATIONS
   * ========================================================= */
  async function notifications(view) {
    if (!state.isLoggedIn()) { location.hash = '#/login?next=' + encodeURIComponent('#/notifications'); return; }
    view.innerHTML = `<div class="page page--narrow">${U.skeletonRows(4)}</div>`;
    let list = [];
    try {
      const res = await API.getNotifications(1, 30);
      if (ok(res)) list = ((res.content && res.content.data) || []);
    } catch (e) { /* empty */ }

    view.innerHTML = `
      <div class="page page--narrow">
        <nav class="crumbs"><a href="#/account">Account</a>${U.icon('chevronRight', 12)}<span>Notifications</span></nav>
        <header class="pagehead"><span class="eyebrow">Updates from us</span><h1>Notifications</h1></header>
        ${list.length ? `<div class="notiflist">${list.map(n => `<article class="notif">
          <span class="notif__ic">${n.cover_image ? `<img src="${U.esc(n.cover_image)}" alt="">` : U.icon('bell', 18)}</span>
          <div><b>${U.esc(n.title || 'Update')}</b><p>${U.esc(n.description || '')}</p>
            <small>${U.esc(U.fmtDate(n.created_at))}</small></div>
        </article>`).join('')}</div>`
          : U.empty({ icon: 'bell', title: 'No notifications', text: 'We will let you know about bookings, offers and updates here.' })}
      </div>`;
  }

  /* =========================================================
   * CHAT
   * ========================================================= */
  let chatPoll = null;
  async function chat(view, channelId) {
    if (!state.isLoggedIn()) { location.hash = '#/login?next=' + encodeURIComponent(channelId ? '#/chat/' + channelId : '#/chat'); return; }
    if (chatPoll) { clearInterval(chatPoll); chatPoll = null; }

    if (!channelId) {
      view.innerHTML = `
        <div class="page page--narrow">
          <header class="pagehead"><span class="eyebrow">Stay in touch</span><h1>Messages</h1></header>
          <div id="inbox">${U.skeletonRows(4)}</div>
        </div>`;
      const host = view.querySelector('#inbox');
      try {
        const res = await API.getChats();
        const content = (res && res.content) || {};
        const admin = content.adminChannel;
        const list = (content.channelList && content.channelList.data) || [];
        const channelRow = (c, isAdmin) => {
          const user = (c.channel_users && c.channel_users[0] && c.channel_users[0].user) || {};
          const name = isAdmin ? 'Jass Booking support' : ([user.first_name, user.last_name].filter(Boolean).join(' ') || 'Conversation');
          const preview = c.last_sent_message || (isAdmin ? 'Questions about a booking? We are here to help.' : 'Tap to open the conversation');
          return `<a class="chatrow" href="#/chat/${U.esc(c.id)}">
            <span class="chatrow__avatar">${isAdmin ? U.icon('shield', 18) : U.esc(U.initials(user.first_name, user.last_name))}</span>
            <span class="chatrow__body"><b>${U.esc(name)}</b><small>${U.esc(String(preview).slice(0, 70))}</small></span>
            <span class="chatrow__meta"><small>${U.esc(U.fmtTime(c.updated_at))}</small></span>
          </a>`;
        };
        host.innerHTML = (admin || list.length)
          ? `<div class="chatlist">
              ${admin ? channelRow(admin, true) : ''}
              ${list.map(c => channelRow(c, false)).join('')}
            </div>`
          : U.empty({ icon: 'chat', title: 'No messages yet', text: 'Start a conversation with our team from any booking.', action: `<a class="btn btn--primary" href="#/support">Contact support</a>` });
      } catch (e) {
        host.innerHTML = U.errorState(e, 'inbox-retry');
        const retry = host.querySelector('#inbox-retry');
        if (retry) retry.onclick = () => chat(view);
      }
      return;
    }

    /* thread */
    view.innerHTML = `
      <div class="page chatpage">
        <div class="chathead">
          <a class="iconbtn" href="#/chat" aria-label="Back">${U.icon('chevronLeft', 18)}</a>
          <div class="chathead__id">
            <b id="chat-title">Conversation</b>
            <small id="chat-sub">Usually replies within a few minutes</small>
          </div>
          <a class="iconbtn" href="#/support" aria-label="Help">${U.icon('info', 18)}</a>
        </div>
        <div class="chatthread" id="chat-thread">${U.skeletonRows(4)}</div>
        <form class="chatform" id="chat-form">
          <input class="input" id="chat-input" placeholder="Write a message…" autocomplete="off" aria-label="Message">
          <button class="btn btn--primary" type="submit" aria-label="Send">${U.icon('arrowRight', 17)}</button>
        </form>
      </div>`;

    const thread = view.querySelector('#chat-thread');
    const myId = (state.user && state.user.id) || '';
    let loaded = false;

    async function load(scroll) {
      try {
        const res = await API.getChatThread(channelId, 1, 60);
        const content = (res && res.content) || {};
        const rows = (content.data || content.conversations || []).slice().reverse();
        if (!rows.length) {
          thread.innerHTML = `<div class="chatempty">${U.icon('chat', 24)}<p>Say hello — our team will reply here.</p></div>`;
          return;
        }
        const fmt = (m) => {
          const mine = String(m.user_id) === String(myId);
          const files = m.conversation_files || [];
          return `<div class="bubble ${mine ? 'bubble--me' : 'bubble--them'}">
            ${!mine ? `<small class="bubble__who">${U.esc((m.user && m.user.first_name) || 'Support')}</small>` : ''}
            ${m.message ? `<p>${U.nl2br(m.message)}</p>` : ''}
            ${files.map(f => `<a class="bubble__file" href="${U.esc(f.file_full_path || '#')}" target="_blank" rel="noopener">${U.icon('file', 14)} ${U.esc(f.original_file_name || 'Attachment')}</a>`).join('')}
            <small class="bubble__time">${U.esc(U.fmtTime(m.created_at))}</small>
          </div>`;
        };
        thread.innerHTML = rows.map(fmt).join('');
        if (scroll !== false) thread.scrollTop = thread.scrollHeight;
        loaded = true;
      } catch (e) {
        if (!loaded) thread.innerHTML = U.empty({ icon: 'chat', title: 'Could not load messages', text: e.message });
      }
    }

    view.querySelector('#chat-form').onsubmit = async (e) => {
      e.preventDefault();
      const input = view.querySelector('#chat-input');
      const text = input.value.trim();
      if (!text) return;
      input.value = '';
      try {
        const res = await API.sendChat(channelId, text);
        if (ok(res)) await load();
        else U.toast(res.message || 'Message could not be sent', 'error');
      } catch (err) { U.toast(err.message, 'error'); }
    };

    await load();
    chatPoll = setInterval(() => { if (document.body.contains(thread)) load(false); else clearInterval(chatPoll); }, 10000);
  }

  /* =========================================================
   * SUPPORT
   * ========================================================= */
  async function support(view) {
    const cfg = state.config || {};
    const social = cfg.social_media || [];

    view.innerHTML = `
      <div class="page page--narrow">
        <header class="pagehead"><span class="eyebrow">We're here to help</span><h1>Help &amp; support</h1>
          <p>Questions about a booking, a payment or a service? Our team is a message away.</p></header>

        <div class="supportgrid">
          <button class="supportcard" id="support-chat">
            <span class="supportcard__ic">${U.icon('chat', 22)}</span>
            <b>Chat with us</b>
            <small>Fastest way to reach the team</small>
          </button>
          ${cfg.business_phone ? `<a class="supportcard" href="tel:${U.esc(cfg.business_phone)}">
            <span class="supportcard__ic">${U.icon('phone', 22)}</span>
            <b>Call us</b><small>${U.esc(cfg.business_phone)}</small>
          </a>` : ''}
          ${cfg.business_email ? `<a class="supportcard" href="mailto:${U.esc(cfg.business_email)}">
            <span class="supportcard__ic">${U.icon('file', 22)}</span>
            <b>Email us</b><small>${U.esc(cfg.business_email)}</small>
          </a>` : ''}
          <a class="supportcard" href="#/track">
            <span class="supportcard__ic">${U.icon('search', 22)}</span>
            <b>Track a booking</b><small>Check progress without signing in</small>
          </a>
        </div>

        <section class="card faqcard">
          <h3 class="card__title">Common questions</h3>
          <details class="faq"><summary>How do I reschedule or cancel?<span>${U.icon('chevronDown', 16)}</span></summary>
            <p>Open the booking from My bookings. You can cancel while it is still pending. For rescheduling, message your professional or our support team.</p></details>
          <details class="faq"><summary>When do I pay?<span>${U.icon('chevronDown', 16)}</span></summary>
            <p>You can choose cash after service at checkout, or pay online securely. Nothing is charged until you confirm the booking.</p></details>
          <details class="faq"><summary>What if I'm not happy with the work?<span>${U.icon('chevronDown', 16)}</span></summary>
            <p>Raise it with us within the re-service window and we will arrange for the professional to come back. Message support with your booking number.</p></details>
        </section>

        ${social.length ? `<section class="card">
          <h3 class="card__title">Follow us</h3>
          <div class="socials">
            ${social.filter(s => Number(s.status) === 1).map(s => `<a class="social" href="${U.esc(s.link)}" target="_blank" rel="noopener">
              ${U.icon('sparkle', 16)} ${U.esc(U.titleCase(s.media))}</a>`).join('')}
          </div>
        </section>` : ''}

        <section class="card">
          <h3 class="card__title">Legal</h3>
          <a class="menurow" href="#/pages/about_us"><span>About us</span>${U.icon('chevronRight', 14)}</a>
          <a class="menurow" href="#/pages/terms_and_conditions"><span>Terms &amp; conditions</span>${U.icon('chevronRight', 14)}</a>
          <a class="menurow" href="#/pages/privacy_policy"><span>Privacy policy</span>${U.icon('chevronRight', 14)}</a>
          <a class="menurow" href="#/pages/cancellation_policy"><span>Cancellation policy</span>${U.icon('chevronRight', 14)}</a>
          <a class="menurow" href="#/pages/refund_policy"><span>Refund policy</span>${U.icon('chevronRight', 14)}</a>
        </section>
      </div>`;

    view.querySelector('#support-chat').onclick = async () => {
      if (!state.isLoggedIn()) { location.hash = '#/login?next=' + encodeURIComponent('#/support'); return; }
      try {
        const res = await API.getChats();
        const admin = res && res.content && res.content.adminChannel;
        if (admin && admin.id) location.hash = '#/chat/' + admin.id;
        else U.toast('Support chat is not available right now. Please call or email us.', 'error');
      } catch (e) { U.toast(e.message, 'error'); }
    };
  }

  /* =========================================================
   * BECOME A PROVIDER (same registration form as the old landing page)
   * ========================================================= */
  const PROVIDER_ENDPOINT = '/page/become-a-provider';
  let providerFormCache = null;

  async function loadProviderForm(force) {
    if (providerFormCache && !force) return providerFormCache;
    const res = await fetch(PROVIDER_ENDPOINT, { credentials: 'same-origin', headers: { Accept: 'text/html' } });
    if (!res.ok) throw new Error('The provider form could not be loaded (' + res.status + ').');
    const html = await res.text();
    const doc = new DOMParser().parseFromString(html, 'text/html');
    const tokenEl = doc.querySelector('input[name="_token"]');
    if (!tokenEl || !tokenEl.value) throw new Error('A secure form session could not be started.');
    const options = (sel) => [...doc.querySelectorAll(sel + ' option')]
      .filter(o => o.value)
      .map(o => ({ id: o.value, name: (o.textContent || '').trim() }));
    const subCategories = [...doc.querySelectorAll('#sub-cat-box .sub-item')].map(el => {
      const input = el.querySelector('input');
      if (!input || !input.value) return null;
      return { id: input.value, name: (el.textContent || '').trim(), parent: el.getAttribute('data-parent') };
    }).filter(Boolean);
    providerFormCache = {
      token: tokenEl.value,
      zones: options('select[name="zone_id"]'),
      categories: options('select[name="main_category_id"]'),
      subCategories,
    };
    return providerFormCache;
  }

  function providerToasts(html) {
    const out = [];
    const re = /toastr\.(success|error)\(\s*'((?:[^'\\]|\\.)*)'/g;
    let m;
    while ((m = re.exec(html))) out.push({ type: m[1], text: m[2].replace(/\\'/g, "'").replace(/\\\\/g, '\\') });
    return out;
  }

  const providerInput = (name, label, opts = {}) => `
    <label class="field">
      <span class="field__label">${label}${opts.required ? ' <i>*</i>' : ''}</span>
      <input class="input${opts.file ? ' input--file' : ''}" name="${name}"
        type="${opts.type || 'text'}"
        ${opts.placeholder ? `placeholder="${U.esc(opts.placeholder)}"` : ''}
        ${opts.required ? 'required' : ''}
        ${opts.accept ? `accept="${opts.accept}"` : ''}
        ${opts.multiple ? 'multiple' : ''}
        ${opts.maxlength ? `maxlength="${opts.maxlength}"` : ''}
        ${opts.inputmode ? `inputmode="${opts.inputmode}"` : ''}
        ${opts.autocomplete ? `autocomplete="${opts.autocomplete}"` : ''}>
      ${opts.hint ? `<small class="field__hint">${opts.hint}</small>` : ''}
    </label>`;

  async function becomeProvider(view) {
    view.innerHTML = `
      <div class="page page--narrow">
        <nav class="crumbs"><a href="#/">Home</a>${U.icon('chevronRight', 12)}<span>Become a provider</span></nav>
        <header class="pagehead">
          <span class="eyebrow">Partner with us</span>
          <h1>Become a provider</h1>
          <p>Bring your skills to customers nearby. Share your business details and the services you offer — our team reviews every request and creates your provider account.</p>
        </header>
        <div id="provider-body">${U.skeletonRows(4)}</div>
      </div>`;

    const body = view.querySelector('#provider-body');
    let data;
    try {
      data = await loadProviderForm();
    } catch (err) {
      body.innerHTML = `${U.errorState(err, 'provider-retry')}
        <p class="providernote">You can also open the <a class="link" href="${PROVIDER_ENDPOINT}">standard provider form</a>.</p>`;
      const retry = view.querySelector('#provider-retry');
      if (retry) retry.onclick = () => becomeProvider(view);
      return;
    }

    const zoneOptions = data.zones.map(z => `<option value="${U.esc(z.id)}">${U.esc(z.name)}</option>`).join('');
    const catOptions = data.categories.map(c => `<option value="${U.esc(c.id)}">${U.esc(c.name)}</option>`).join('');
    const identityTypes = [
      ['passport', 'Passport'], ['driving_license', 'Driving license'], ['nid', 'National ID'],
      ['trade_license', 'Trade license'], ['company_id', 'Company ID'],
    ].map(([v, l]) => `<option value="${v}">${l}</option>`).join('');

    body.innerHTML = `
      <p class="providernote">Fill in your details and choose your zone and category. Our team reviews your request; after approval your provider ID is created. In one zone, only the active provider of a category serves customers.</p>

      <form class="providerform" id="provider-form" novalidate>
        <input type="hidden" name="_token" value="${U.esc(data.token)}">

        <section class="providercard">
          <h2>Contact person details</h2>
          <div class="formgrid2">
            ${providerInput('contact_person_name', 'Full name', { required: true, placeholder: 'Your full name', maxlength: 191, autocomplete: 'name' })}
            ${providerInput('contact_person_phone', 'Phone', { required: true, placeholder: '+91 98765 43210', inputmode: 'tel', autocomplete: 'tel' })}
            ${providerInput('contact_person_email', 'Email', { type: 'email', placeholder: 'you@email.com', autocomplete: 'email' })}
          </div>
        </section>

        <section class="providercard">
          <h2>Business details</h2>
          <div class="formgrid2">
            ${providerInput('company_name', 'Business name', { required: true, maxlength: 191 })}
            ${providerInput('company_phone', 'Business phone', { required: true, inputmode: 'tel' })}
            ${providerInput('company_email', 'Business email', { type: 'email', required: true })}
            ${providerInput('company_address', 'Business address', { required: true, maxlength: 255 })}
          </div>
          ${providerInput('logo', 'Business logo', { type: 'file', required: true, accept: 'image/*', file: true, hint: 'Square or wide image works best. JPG, PNG or WebP.' })}
        </section>

        <section class="providercard">
          <h2>Login credentials</h2>
          <p class="field__hint">These become your provider login after approval.</p>
          <div class="formgrid2">
            ${providerInput('account_email', 'Login email', { type: 'email', required: true, autocomplete: 'email' })}
            ${providerInput('account_phone', 'Login phone', { required: true, inputmode: 'tel', placeholder: '+91 98765 43210' })}
            ${providerInput('password', 'Password', { type: 'password', required: true, autocomplete: 'new-password', hint: 'At least 8 characters.' })}
            ${providerInput('confirm_password', 'Confirm password', { type: 'password', required: true, autocomplete: 'new-password' })}
          </div>
        </section>

        <section class="providercard">
          <h2>Identity verification</h2>
          <div class="formgrid2">
            <label class="field">
              <span class="field__label">Identity type <i>*</i></span>
              <select class="input" name="identity_type" required>${identityTypes}</select>
            </label>
            ${providerInput('identity_number', 'Identity number', { required: true, maxlength: 191 })}
          </div>
          ${providerInput('identity_images[]', 'Identity documents', { type: 'file', accept: 'image/*', multiple: true, file: true, hint: 'Optional. Upload one or more clear photos.' })}
        </section>

        <section class="providercard">
          <h2>Service area &amp; category</h2>
          <div class="formgrid2">
            <label class="field">
              <span class="field__label">Zone <i>*</i></span>
              <select class="input" name="zone_id" id="provider-zone" required>
                <option value="">Select zone</option>${zoneOptions}
              </select>
            </label>
            <label class="field">
              <span class="field__label">Category <i>*</i></span>
              <select class="input" name="main_category_id" id="provider-category" required>
                <option value="">Select category</option>${catOptions}
              </select>
              <small class="field__hint">Choose a category to offer all of its services, or pick specific services below.</small>
            </label>
          </div>

          <div class="field">
            <span class="field__label">Services you want to provide</span>
            <div class="picks" id="provider-subs"></div>
            <small class="field__hint" id="provider-subs-empty" hidden>No services found under this category.</small>
          </div>

          <div class="formgrid2">
            ${providerInput('latitude', 'Latitude', { placeholder: '28.6139', inputmode: 'decimal' })}
            ${providerInput('longitude', 'Longitude', { placeholder: '77.2090', inputmode: 'decimal' })}
          </div>
        </section>

        <div id="provider-errors"></div>

        <button class="btn btn--primary btn--lg" type="submit" id="provider-submit">Submit request</button>
        <p class="field__hint">Submitting starts a review — nothing is charged and no account is created until our team approves.</p>
      </form>`;

    const form = body.querySelector('#provider-form');
    const catSelect = form.querySelector('#provider-category');
    const picksHost = form.querySelector('#provider-subs');
    const picksEmpty = form.querySelector('#provider-subs-empty');
    const errorHost = form.querySelector('#provider-errors');

    const paintServices = () => {
      const list = data.subCategories.filter(s => s.parent === catSelect.value);
      picksHost.innerHTML = list.map(s => `
        <label class="pick">
          <input type="checkbox" name="sub_category_ids[]" value="${U.esc(s.id)}">
          <span>${U.esc(s.name)}</span>
        </label>`).join('');
      picksHost.hidden = !list.length;
      picksEmpty.hidden = !!list.length || !catSelect.value;
    };
    catSelect.onchange = paintServices;
    paintServices();

    const showErrors = (list) => {
      errorHost.innerHTML = list.length
        ? `<div class="providererrors" role="alert"><b>Please fix the following:</b><ul>${list.map(t => `<li>${U.esc(t)}</li>`).join('')}</ul></div>`
        : '';
      if (list.length) errorHost.scrollIntoView({ behavior: 'smooth', block: 'center' });
    };

    form.onsubmit = async (e) => {
      e.preventDefault();
      const btn = form.querySelector('#provider-submit');
      const fd = new FormData(form);
      const pass = String(fd.get('password') || '');
      const confirm = String(fd.get('confirm_password') || '');
      const logo = fd.get('logo');
      const problems = [];
      if (!String(fd.get('contact_person_name') || '').trim()) problems.push('Contact person name is required.');
      if (!String(fd.get('contact_person_phone') || '').trim()) problems.push('Contact person phone is required.');
      if (!String(fd.get('company_name') || '').trim()) problems.push('Business name is required.');
      if (!String(fd.get('company_email') || '').trim()) problems.push('Business email is required.');
      if (!String(fd.get('company_address') || '').trim()) problems.push('Business address is required.');
      if (!logo || !logo.size) problems.push('Please upload your business logo.');
      if (pass.length < 8) problems.push('Password must be at least 8 characters.');
      if (pass !== confirm) problems.push('Password and confirm password do not match.');
      if (!String(fd.get('identity_number') || '').trim()) problems.push('Identity number is required.');
      if (!String(fd.get('zone_id') || '').trim()) problems.push('Please choose your zone.');
      if (!String(fd.get('main_category_id') || '').trim()) problems.push('Please choose your category.');
      if (problems.length) { showErrors(problems); return; }

      showErrors([]);
      const label = btn.textContent;
      btn.disabled = true;
      btn.textContent = 'Submitting…';
      try {
        await fetch(PROVIDER_ENDPOINT, { method: 'POST', body: fd, credentials: 'same-origin', redirect: 'follow' });
        // Laravel flashes the result in the session; the next render of the form carries it.
        const check = await fetch(PROVIDER_ENDPOINT + '?_=' + Date.now(), { credentials: 'same-origin', headers: { Accept: 'text/html' } });
        const messages = providerToasts(await check.text());
        providerFormCache = null;
        const success = messages.find(m => m.type === 'success');
        const failures = [...new Set(messages.filter(m => m.type === 'error').map(m => m.text))];

        if (success) {
          body.innerHTML = `
            <div class="providercard providerdone">
              <span class="providerdone__ic">${U.icon('check', 26)}</span>
              <h2>Request submitted</h2>
              <p>${U.esc(success.text)}</p>
              <div class="providerdone__actions">
                <a class="btn btn--primary" href="#/">Back to home</a>
                <a class="btn btn--ghost" href="#/support">Contact support</a>
              </div>
            </div>`;
          UI.scrollToTop();
          return;
        }
        if (failures.length) {
          showErrors(failures);
          U.toast(failures[0], 'error');
        } else {
          showErrors(['The request could not be submitted. Please check your details and try again.']);
        }
      } catch (err) {
        U.toast(err.message || 'Network error — please try again.', 'error');
      } finally {
        if (document.body.contains(btn)) { btn.disabled = false; btn.textContent = label; }
      }
    };
  }

  /* =========================================================
   * CONTENT PAGES
   * ========================================================= */
  async function page(view, key) {
    const pageKey = key || 'about_us';
    view.innerHTML = `<div class="page page--narrow">${U.skeletonRows(3)}</div>`;
    let pages = {};
    try {
      const res = await API.getPages();
      pages = (res && res.content) || {};
    } catch (e) { /* fall through */ }

    const item = pages[pageKey] || pages[pageKey.replace(/-/g, '_')];
    const titleMap = {
      about_us: 'About us', terms_and_conditions: 'Terms & conditions', privacy_policy: 'Privacy policy',
      cancellation_policy: 'Cancellation policy', refund_policy: 'Refund policy', return_policy: 'Return policy',
    };
    const title = titleMap[pageKey] || U.titleCase(pageKey);

    if (!item || !item.value) {
      view.innerHTML = `<div class="page page--narrow">
        <nav class="crumbs"><a href="#/account">Account</a>${U.icon('chevronRight', 12)}<span>${U.esc(title)}</span></nav>
        <header class="pagehead"><h1>${U.esc(title)}</h1></header>
        ${U.empty({ icon: 'file', title: 'Not available yet', text: 'This page has not been published. Please contact support if you need this information.' })}
      </div>`;
      return;
    }

    view.innerHTML = `
      <div class="page page--prose">
        <nav class="crumbs"><a href="#/">Home</a>${U.icon('chevronRight', 12)}<span>${U.esc(title)}</span></nav>
        <header class="pagehead"><h1>${U.esc(title)}</h1>
          <p class="muted">Last updated ${U.esc(U.fmtDate(item.updated_at, false))}</p></header>
        <article class="card prose__body">${item.value}</article>
      </div>`;
  }

  function notFound(view) {
    view.innerHTML = `<div class="page">${U.empty({
      icon: 'search', title: 'Page not found', text: 'The link may be broken, or the page may have moved.',
      action: `<a class="btn btn--primary" href="#/">Back to home</a>`,
    })}</div>`;
  }

  Object.assign(window.Views, {
    login, signup, forgot, account, profileEdit, addresses, favorites, wallet,
    notifications, chat, support, becomeProvider, page, notFound,
  });
})();
