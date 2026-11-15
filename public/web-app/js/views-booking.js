/* ============================================================
 * Jass Booking — booking flow views
 * Cart · checkout · bookings · booking detail · review · track
 * ============================================================ */
'use strict';

window.Views = window.Views || {};

(() => {
  const { state, ok } = API;
  const U = UI;

  const pad = (n) => String(n).padStart(2, '0');
  const sqlDate = (d) => `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}:00`;

  /* =========================================================
   * CART
   * ========================================================= */
  async function cart(view) {
    view.innerHTML = `<div class="page">${U.skeletonRows(1)}${U.skeletonCards(2)}</div>`;

    let res;
    try {
      res = await API.getCart();
    } catch (e) {
      view.innerHTML = `<div class="page">${U.errorState(e, 'cart-retry')}</div>`;
      const retry = view.querySelector('#cart-retry');
      if (retry) retry.onclick = () => cart(view);
      return;
    }

    if (!ok(res)) {
      view.innerHTML = `<div class="page">${U.empty({ icon: 'cart', title: 'Your cart is empty', text: 'Add a service to get started.', action: `<a class="btn btn--primary" href="#/categories">Browse services</a>` })}</div>`;
      return;
    }

    const content = res.content || {};
    const items = (content.cart && content.cart.data) || [];
    state.cartCount = API.countCartItems(content);
    App.syncBadges();

    if (!items.length) {
      view.innerHTML = `<div class="page">${U.empty({ icon: 'cart', title: 'Your cart is empty', text: 'Find a professional for your next job — fixed prices, no surprises.', action: `<a class="btn btn--primary" href="#/categories">Browse services</a>` })}</div>`;
      return;
    }

    const subtotal = items.reduce((sum, i) => sum + (Number(i.service_cost || 0) * Number(i.quantity || 1)), 0);
    const tax = items.reduce((sum, i) => sum + (Number(i.tax_amount) || 0), 0);
    const discount = items.reduce((sum, i) => sum + (Number(i.discount_amount) || 0) + (Number(i.campaign_discount) || 0) + (Number(i.coupon_discount) || 0), 0);
    const total = Number(content.total_cost) || 0;
    const couponCode = items.find(i => i.coupon_code)?.coupon_code || '';
    const referral = Number(content.referral_amount) || 0;
    const extra = Math.max(0, total - (subtotal + tax - discount - referral));

    view.innerHTML = `
      <div class="page page--cart">
        <nav class="crumbs"><a href="#/">Home</a>${U.icon('chevronRight', 12)}<span>Cart</span></nav>
        <header class="pagehead pagehead--inline">
          <div><span class="eyebrow">Almost there</span><h1>Your cart</h1></div>
          <span class="count">${items.length} item${items.length === 1 ? '' : 's'}</span>
        </header>

        <div class="cartlayout">
          <div class="cartitems">
            ${items.map(item => {
              const svc = item.service || {};
              return `<article class="citem" data-id="${U.esc(item.id)}">
                <a class="citem__media" href="#/service/${U.esc(svc.slug || svc.id || '')}">
                  <img src="${U.esc(U.imgSrc(svc.thumbnail_full_path))}" alt="${U.esc(svc.name || '')}" loading="lazy"
                    onerror="this.onerror=null;this.src='${U.FALLBACK_IMG}'">
                </a>
                <div class="citem__body">
                  <div class="citem__top">
                    <div>
                      <h3><a href="#/service/${U.esc(svc.slug || '')}">${U.esc(svc.name || 'Service')}</a></h3>
                      <p class="citem__variant">${U.esc(U.titleCase((item.variant_key || '').replace(/-/g, ' ')))}</p>
                    </div>
                    <button class="iconbtn citem__del" data-act="del" aria-label="Remove item">${U.icon('trash', 17)}</button>
                  </div>
                  <div class="citem__foot">
                    <div class="stepper stepper--sm" data-stepper data-min="1" data-max="99">
                      <button data-step="-1" aria-label="Decrease">${U.icon('minus', 14)}</button>
                      <span data-qty>${item.quantity || 1}</span>
                      <button data-step="1" aria-label="Increase">${U.icon('plus', 14)}</button>
                      <input type="hidden" data-qty-input value="${item.quantity || 1}">
                    </div>
                    <div class="citem__price">
                      <b>${U.money(item.total_cost)}</b>
                      ${item.quantity > 1 ? `<small>${U.money(item.service_cost)} × ${item.quantity}</small>` : ''}
                    </div>
                  </div>
                </div>
              </article>`;
            }).join('')}
          </div>

          <aside class="cartaside">
            <div class="card couponbox">
              <h3>${U.icon('tag', 16)} Have a coupon?</h3>
              <div class="inline-form">
                <input class="input" id="coupon-code" placeholder="Enter code" value="${U.esc(couponCode)}" ${couponCode ? 'disabled' : ''}>
                ${couponCode
                  ? `<button class="btn btn--ghost" id="coupon-remove">Remove</button>`
                  : `<button class="btn btn--ghost" id="coupon-apply">Apply</button>`}
              </div>
              <p class="hint" id="coupon-msg">${couponCode ? `Coupon <b>${U.esc(couponCode)}</b> applied` : 'Discounts are applied to your final bill.'}</p>
            </div>

            <div class="card bill">
              <h3>Bill details</h3>
              <div class="bill__row"><span>Item total</span><b>${U.money(subtotal)}</b></div>
              ${tax > 0 ? `<div class="bill__row"><span>Taxes</span><b>${U.money(tax)}</b></div>` : ''}
              ${discount > 0 ? `<div class="bill__row bill__row--green"><span>Discount</span><b>−${U.money(discount)}</b></div>` : ''}
              ${referral > 0 ? `<div class="bill__row bill__row--green"><span>Referral reward</span><b>−${U.money(referral)}</b></div>` : ''}
              ${extra > 1 ? `<div class="bill__row"><span>Platform fee</span><b>${U.money(extra)}</b></div>` : ''}
              <div class="bill__total"><span>To pay</span><b>${U.money(total)}</b></div>
              <p class="bill__note">${U.icon('shield', 14)} No payment now — settle after the job is done.</p>
            </div>

            <button class="btn btn--primary btn--block btn--lg" id="to-checkout">
              Continue to checkout ${U.icon('arrowRight', 16)}
            </button>
            <button class="btn btn--ghost btn--block" id="wipe">Clear cart</button>
          </aside>
        </div>
      </div>`;

    /* quantity steppers */
    view.querySelectorAll('[data-stepper]').forEach(stepper => {
      const id = stepper.closest('.citem').dataset.id;
      U.bindStepper(stepper, async (value) => {
        try {
          const r = await API.updateQty(id, value);
          if (!ok(r)) { U.toast(r.message || 'Could not update quantity', 'error'); }
          await API.refreshCartCount();
          cart(view);
        } catch (e) { U.toast(e.message, 'error'); }
      });
    });

    /* remove */
    view.querySelectorAll('[data-act="del"]').forEach(btn => {
      btn.onclick = async () => {
        const id = btn.closest('.citem').dataset.id;
        btn.disabled = true;
        try {
          const r = await API.removeCartItem(id);
          if (!ok(r) && r && r.message) U.toast(r.message, 'error');
          await API.refreshCartCount();
          cart(view);
        } catch (e) { U.toast(e.message, 'error'); btn.disabled = false; }
      };
    });

    /* coupon */
    const applyBtn = view.querySelector('#coupon-apply');
    if (applyBtn) {
      applyBtn.onclick = async () => {
        const code = view.querySelector('#coupon-code').value.trim();
        if (!code) { U.toast('Enter a coupon code', 'error'); return; }
        applyBtn.disabled = true;
        try {
          const r = await API.applyCoupon(code);
          if (ok(r)) { U.toast('Coupon applied', 'success'); cart(view); }
          else {
            state.pendingCoupon = code;
            view.querySelector('#coupon-msg').innerHTML = U.esc(r.message || 'This coupon is not valid for your cart');
            view.querySelector('#coupon-msg').classList.add('hint--err');
          }
        } catch (e) {
          view.querySelector('#coupon-msg').textContent = e.message;
          view.querySelector('#coupon-msg').classList.add('hint--err');
        }
        applyBtn.disabled = false;
      };
    }
    const removeBtn = view.querySelector('#coupon-remove');
    if (removeBtn) {
      removeBtn.onclick = async () => {
        try {
          await API.removeCoupon();
          state.pendingCoupon = '';
          cart(view);
        } catch (e) { U.toast(e.message, 'error'); }
      };
    }

    /* clear */
    view.querySelector('#wipe').onclick = async () => {
      const yes = await U.confirmDialog({ title: 'Clear your cart?', message: 'All selected services will be removed.', confirmLabel: 'Clear cart', danger: true });
      if (!yes) return;
      try {
        await API.wipeCart();
        state.cartCount = 0;
        App.syncBadges();
        cart(view);
      } catch (e) { U.toast(e.message, 'error'); }
    };

    /* checkout */
    view.querySelector('#to-checkout').onclick = () => {
      if (!App.requireAuth('#/checkout')) return;
      location.hash = '#/checkout';
    };
  }

  /* =========================================================
   * CHECKOUT
   * ========================================================= */
  async function checkout(view) {
    if (!state.isLoggedIn()) { location.hash = '#/login?next=' + encodeURIComponent('#/checkout'); return; }
    view.innerHTML = `<div class="page">${U.skeletonRows(2)}${U.skeletonCards(2)}</div>`;

    const cfg = state.config || {};
    const guestCheckout = Number(cfg.guest_checkout) === 1;

    const [cartRes, addrRes, payRes] = await Promise.all([
      API.getCart().catch(e => null),
      API.getAddresses().catch(e => null),
      API.getPaymentConfig().catch(e => null),
    ]);

    const cartContent = (cartRes && ok(cartRes) && cartRes.content) || null;
    const items = (cartContent && cartContent.cart && cartContent.cart.data) || [];
    if (!items.length) {
      view.innerHTML = `<div class="page">${U.empty({ icon: 'cart', title: 'Nothing to check out', text: 'Your cart is empty.', action: `<a class="btn btn--primary" href="#/categories">Browse services</a>` })}</div>`;
      return;
    }

    let addresses = (addrRes && ok(addrRes) && addrRes.content && (addrRes.content.data || addrRes.content.addresses)) || [];
    const payCfg = (payRes && ok(payRes) && payRes.content) || {};
    const cartTotal = Number(cartContent.total_cost) || 0;

    const minAmount = Number(cfg.min_booking_amount) || 0;
    const maxAmount = Number(cfg.max_booking_amount) || 0;

    let selectedAddress = addresses[0] || null;
    let payment = '';
    let scheduleMode = 'asap';
    let scheduleDate = '';

    /* build payment options */
    const options = [];
    if (Number(payCfg.cash_after_service ?? cfg.cash_after_service) === 1) {
      options.push({ key: 'cash_after_service', title: 'Cash after service', desc: 'Pay your professional once the work is finished.' });
    }
    if (Number(cfg.digital_payment) === 1) {
      const gateways = payCfg.payment_gateways || cfg.payment_gateways || [];
      gateways.forEach(g => {
        options.push({
          key: g.gateway,
          title: g.label || g.gateway_title || U.titleCase(g.gateway),
          desc: 'Pay securely online now — instant confirmation.',
        });
      });
    }
    if (Number(payCfg.wallet_payment ?? cfg.wallet_payment) === 1) {
      const bal = Number(cartContent.wallet_balance) || 0;
      options.push({
        key: 'wallet_payment',
        title: 'Wallet balance',
        desc: `Available ${U.money(bal)}${bal < cartTotal ? ' — not enough for this order' : ''}`,
        disabled: bal < cartTotal,
      });
    }
    if (!options.length) {
      options.push({ key: 'cash_after_service', title: 'Cash after service', desc: 'Pay your professional once the work is finished.' });
    }
    payment = options.find(o => !o.disabled)?.key || options[0].key;

    /* schedule bounds */
    const adv = cfg.advanced_booking || {};
    const restrictionValue = Number(adv.advanced_booking_restriction_value) || 0;
    const restrictionType = adv.advanced_booking_restriction_type || 'hour';
    const leadMinutes = restrictionType === 'day' ? restrictionValue * 1440
      : restrictionType === 'minute' ? restrictionValue
      : restrictionValue * 60;
    const earliest = new Date(Date.now() + Math.max(30, leadMinutes) * 60000);
    const minDateStr = `${earliest.getFullYear()}-${pad(earliest.getMonth() + 1)}-${pad(earliest.getDate())}`;

    const canInstant = Number(cfg.instant_booking) === 1;
    const canSchedule = Number(cfg.schedule_booking) === 1;
    if (!canInstant && canSchedule) scheduleMode = 'schedule';
    if (!canInstant && !canSchedule) scheduleMode = 'asap';

    const addressCard = (a, i) => `
      <label class="sel ${selectedAddress && a.id === selectedAddress.id ? 'is-on' : ''}" data-addr="${U.esc(a.id)}">
        <input type="radio" name="address" ${selectedAddress && a.id === selectedAddress.id ? 'checked' : ''}>
        <span class="sel__body">
          <span class="sel__top"><b>${U.esc(U.titleCase(a.address_label || 'Address'))}</b>
            <span class="sel__label">${U.esc(a.address_type || 'service')}</span></span>
          <span class="sel__text">${U.esc(a.address || '')}</span>
          <span class="sel__meta">${U.esc(a.contact_person_name || '')}${a.contact_person_number ? ' · ' + U.esc(a.contact_person_number) : ''}</span>
        </span>
      </label>`;

    view.innerHTML = `
      <div class="page page--checkout">
        <nav class="crumbs"><a href="#/cart">Cart</a>${U.icon('chevronRight', 12)}<span>Checkout</span></nav>
        <header class="pagehead"><span class="eyebrow">Review &amp; confirm</span><h1>Checkout</h1></header>

        <div class="checkout">
          <div class="checkout__main">
            <section class="card">
              <div class="card__head"><h3>1 · Service address</h3>
                <button class="link" id="add-addr">${U.icon('plus', 14)} Add address</button>
              </div>
              <div id="addr-list">
                ${addresses.length ? addresses.map(addressCard).join('')
                  : `<p class="muted">No saved address yet. Add one so we know where to come.</p>`}
              </div>
              ${state.zoneId ? `<p class="hint">${U.icon('pin', 13)} Location verified for service in <b>${U.esc(state.zoneName || 'your area')}</b></p>` : ''}
            </section>

            <section class="card">
              <div class="card__head"><h3>2 · When should we come?</h3></div>
              <div class="choices">
                ${canInstant || !canSchedule ? `<button class="choice ${scheduleMode === 'asap' ? 'is-on' : ''}" data-mode="asap">
                  <b>As soon as possible</b><small>Next available professional</small>
                </button>` : ''}
                ${canSchedule ? `<button class="choice ${scheduleMode === 'schedule' ? 'is-on' : ''}" data-mode="schedule">
                  <b>Schedule for later</b><small>Pick a day and time</small>
                </button>` : ''}
              </div>
              <div id="schedule-fields" ${scheduleMode === 'schedule' ? '' : 'hidden'}>
                <div class="grid2">
                  <label class="field"><span class="field__label">Date</span>
                    <input class="input" type="date" id="sched-date" min="${minDateStr}" value="${minDateStr}"></label>
                  <label class="field"><span class="field__label">Time</span>
                    <input class="input" type="time" id="sched-time" value="10:00"></label>
                </div>
                <p class="hint">Earliest available: ${U.esc(U.fmtDate(earliest))}</p>
              </div>
            </section>

            <section class="card">
              <div class="card__head"><h3>3 · Payment method</h3></div>
              <div class="choices choices--list" id="pay-options">
                ${options.map(o => `<button class="choice ${o.key === payment ? 'is-on' : ''} ${o.disabled ? 'is-off' : ''}" data-pay="${U.esc(o.key)}" ${o.disabled ? 'disabled' : ''}>
                  <span class="choice__dot"></span>
                  <span class="choice__text"><b>${U.esc(o.title)}</b><small>${U.esc(o.desc)}</small></span>
                </button>`).join('')}
              </div>
              <p class="hint" id="pay-hint"></p>
            </section>

            <section class="card">
              <div class="card__head"><h3>4 · Order summary</h3></div>
              ${items.map(i => `<div class="summaryline">
                <span>${U.esc((i.service && i.service.name) || 'Service')} <small>${U.esc(U.titleCase((i.variant_key || '').replace(/-/g, ' ')))} × ${i.quantity || 1}</small></span>
                <b>${U.money(i.total_cost)}</b>
              </div>`).join('')}
            </section>
          </div>

          <aside class="checkout__aside">
            <div class="card bill">
              <h3>Payment summary</h3>
              <div class="bill__row"><span>Cart total</span><b>${U.money(cartTotal)}</b></div>
              <div class="bill__total"><span>Payable</span><b>${U.money(cartTotal)}</b></div>
              <p class="bill__note" id="pay-note"></p>
            </div>
            ${minAmount > 0 && cartTotal < minAmount ? `<div class="notice notice--warn">${U.icon('info', 15)} Minimum order value is ${U.money(minAmount)}.</div>` : ''}
            ${maxAmount > 0 && cartTotal > maxAmount ? `<div class="notice notice--warn">${U.icon('info', 15)} Maximum order value is ${U.money(maxAmount)}.</div>` : ''}
            <button class="btn btn--primary btn--block btn--lg" id="place">Confirm booking</button>
            <p class="hint hint--center">By confirming you agree to our <a href="#/pages/terms_and_conditions">terms</a> and <a href="#/pages/cancellation_policy">cancellation policy</a>.</p>
          </aside>
        </div>
      </div>`;

    /* helpers */
    const updatePayNote = () => {
      const note = view.querySelector('#pay-note');
      const hint = view.querySelector('#pay-hint');
      if (!note) return;
      if (payment === 'cash_after_service') {
        note.textContent = 'Pay in cash or UPI directly to your professional after the service.';
        if (hint) hint.textContent = '';
      } else if (payment === 'wallet_payment') {
        note.textContent = 'The amount is deducted from your wallet balance instantly.';
        if (hint) hint.textContent = '';
      } else {
        note.textContent = 'You will be taken to a secure payment page to complete the payment.';
        if (hint) hint.textContent = 'Online payments are processed on our secure checkout. Keep this tab open until you return.';
      }
    };
    updatePayNote();

    /* address select */
    view.querySelectorAll('[data-addr]').forEach(node => {
      node.onclick = () => {
        selectedAddress = addresses.find(a => String(a.id) === String(node.dataset.addr)) || selectedAddress;
        view.querySelectorAll('[data-addr]').forEach(n => n.classList.remove('is-on'));
        node.classList.add('is-on');
      };
    });

    /* add address */
    view.querySelector('#add-addr').onclick = () => addressSheet(addr => {
      addresses = addresses.concat([addr]);
      selectedAddress = addr;
      App.renderChrome();
      checkout(view);
    });

    /* schedule */
    view.querySelectorAll('[data-mode]').forEach(btn => {
      btn.onclick = () => {
        scheduleMode = btn.dataset.mode;
        view.querySelectorAll('[data-mode]').forEach(b => b.classList.remove('is-on'));
        btn.classList.add('is-on');
        view.querySelector('#schedule-fields').hidden = scheduleMode !== 'schedule';
      };
    });

    /* payment */
    view.querySelectorAll('[data-pay]').forEach(btn => {
      btn.onclick = () => {
        if (btn.disabled) return;
        payment = btn.dataset.pay;
        view.querySelectorAll('[data-pay]').forEach(b => b.classList.remove('is-on'));
        btn.classList.add('is-on');
        updatePayNote();
      };
    });

    /* place */
    view.querySelector('#place').onclick = async () => {
      if (!selectedAddress) {
        U.toast('Please add a service address first', 'error');
        return;
      }
      if (minAmount > 0 && cartTotal < minAmount) {
        U.toast(`Minimum order value is ${U.money(minAmount)}`, 'error');
        return;
      }
      if (maxAmount > 0 && cartTotal > maxAmount) {
        U.toast(`Maximum order value is ${U.money(maxAmount)}`, 'error');
        return;
      }

      let schedule;
      if (scheduleMode === 'schedule') {
        const date = view.querySelector('#sched-date').value;
        const time = view.querySelector('#sched-time').value;
        if (!date || !time) { U.toast('Choose a date and time', 'error'); return; }
        const chosen = new Date(date + 'T' + time);
        if (Number.isNaN(chosen.getTime())) { U.toast('That date is not valid', 'error'); return; }
        if (chosen.getTime() < earliest.getTime()) {
          U.toast('Please choose a slot after ' + U.fmtDate(earliest), 'error');
          return;
        }
        schedule = sqlDate(chosen);
      } else {
        schedule = sqlDate(new Date(Date.now() + 30 * 60000));
      }

      const addrModel = {
        id: selectedAddress.id || null,
        address_type: selectedAddress.address_type || 'service',
        address_label: selectedAddress.address_label || 'home',
        contact_person_name: selectedAddress.contact_person_name || '',
        contact_person_number: selectedAddress.contact_person_number || '',
        address: selectedAddress.address || '',
        lat: selectedAddress.lat || state.lat,
        lon: selectedAddress.lon || state.lng,
        city: selectedAddress.city || '',
        zip_code: selectedAddress.zip_code || '',
        country: selectedAddress.country || '',
        zone_id: selectedAddress.zone_id || state.zoneId,
        street: selectedAddress.street || '',
        house: selectedAddress.house || '',
        floor: selectedAddress.floor || '',
      };

      const common = {
        zone_id: state.zoneId || addrModel.zone_id,
        service_schedule: schedule,
        service_location: 'customer',
        is_partial: 0,
        service_type: 'regular',
        booking_type: 'daily',
        service_address: JSON.stringify(addrModel),
      };
      if (selectedAddress.id) common.service_address_id = selectedAddress.id;

      const btn = view.querySelector('#place');
      btn.disabled = true;
      btn.textContent = 'Confirming…';

      const isDigital = payment !== 'cash_after_service' && payment !== 'wallet_payment';

      if (isDigital) {
        if (!state.zoneId) { U.toast('Set your service location first', 'error'); btn.disabled = false; btn.textContent = 'Confirm booking'; return; }
        submitPaymentForm({
          access_token: state.token,
          zone_id: state.zoneId,
          service_schedule: schedule,
          service_address_id: selectedAddress.id || '',
          service_address: selectedAddress.id ? '' : common.service_address,
          payment_method: payment,
          service_location: 'customer',
          is_partial: 0,
          payment_platform: 'web',
          callback: location.origin + '/web-app/?pay=return',
        });
        return;
      }

      try {
        const payload = { ...common, payment_method: payment };
        const r = await API.placeOrder(payload);
        if (runtimeOk(r)) {
          await API.refreshCartCount();
          showSuccess(view, r);
        } else {
          U.toast((r && r.message) || 'The booking could not be placed', 'error');
          btn.disabled = false;
          btn.textContent = 'Confirm booking';
        }
      } catch (e) {
        U.toast(e.message, 'error');
        btn.disabled = false;
        btn.textContent = 'Confirm booking';
      }
    };

    function runtimeOk(r) {
      return API.ok(r) || (r && r.response_code === 'booking_place_success_200');
    }
  }

  function submitPaymentForm(fields) {
    const base = window.WEB_APP_API_BASE || '';
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = base + '/payment';
    form.style.display = 'none';
    Object.entries(fields).forEach(([k, v]) => {
      if (v === undefined || v === null) return;
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = k;
      input.value = v;
      form.appendChild(input);
    });
    document.body.appendChild(form);
    form.submit();
  }

  function showSuccess(view, res) {
    const content = (res && res.content) || {};
    if (content.token) {
      state.token = content.token;
      if (content.user) state.user = content.user;
    }
    const readable = content.readable_id || (Array.isArray(content.booking_id) ? content.booking_id[0] : content.booking_id) || content.id || '';
    view.innerHTML = `
      <div class="page">
        <div class="success">
          <div class="success__art">${U.icon('check', 30)}</div>
          <span class="eyebrow">Booking confirmed</span>
          <h1>You're all set!</h1>
          <p>${readable ? `Booking <b>#${U.esc(readable)}</b> is placed. ` : ''}We're finding the best professional for your job and will update you here.</p>
          <div class="success__actions">
            <a class="btn btn--primary" href="#/orders">View my bookings</a>
            <a class="btn btn--ghost" href="#/">Back to home</a>
          </div>
        </div>
      </div>`;
    App.syncBadges();
  }

  /* ---------------- address sheet ---------------- */
  function addressSheet(onSaved, existing) {
    const isEdit = !!(existing && existing.id);
    U.openSheet(`
      <div class="sheet__head">
        <div><span class="eyebrow">${isEdit ? 'Update details' : 'Where should we come?'}</span><h3>${isEdit ? 'Edit address' : 'Add a new address'}</h3></div>
        <button class="iconbtn" data-close aria-label="Close">${U.icon('close', 18)}</button>
      </div>
      <div class="sheet__body">
        <div class="grid2">
          ${U.field({ id: 'af-label', label: 'Label', placeholder: 'Home / Office', value: (existing && existing.address_label) || 'home' })}
          ${U.field({ id: 'af-house', label: 'House / flat', placeholder: 'Flat 4B', value: (existing && existing.house) || '' })}
        </div>
        ${U.field({ id: 'af-address', label: 'Full address', placeholder: 'Street, area, city', value: (existing && existing.address) || (state.address && state.address.address) || '', required: true })}
        <div class="grid2">
          ${U.field({ id: 'af-name', label: 'Contact name', placeholder: 'Who should we ask for?', value: (existing && existing.contact_person_name) || ((state.user && state.user.first_name) || ''), required: true })}
          ${U.field({ id: 'af-phone', label: 'Contact number', placeholder: 'Phone number', value: (existing && existing.contact_person_number) || ((state.user && state.user.phone) || ''), inputmode: 'tel', required: true })}
        </div>
        <div class="grid2">
          ${U.field({ id: 'af-city', label: 'City', placeholder: 'City', value: (existing && existing.city) || '' })}
          ${U.field({ id: 'af-zip', label: 'Pincode', placeholder: 'Pincode', value: (existing && existing.zip_code) || '', inputmode: 'numeric' })}
        </div>
        ${U.field({ id: 'af-street', label: 'Landmark / street', placeholder: 'Near…', value: (existing && existing.street) || '' })}
        <div class="gpsrow">
          <span id="gps-state">${state.lat && state.lng ? `${U.icon('pin', 14)} Using your saved location` : `${U.icon('pin', 14)} Location not set`}</span>
          <button class="btn btn--ghost btn--xs" id="af-gps" type="button">${U.icon('pin', 13)} Use current location</button>
        </div>
        <button class="btn btn--primary btn--block" id="af-save">${isEdit ? 'Save changes' : 'Save address'}</button>
      </div>`);

    document.querySelector('[data-close]').onclick = U.closeSheet;

    let coords = {
      lat: (existing && existing.lat) || state.lat || '',
      lon: (existing && existing.lon) || state.lng || '',
    };

    document.querySelector('#af-gps').onclick = () => {
      if (!navigator.geolocation) { U.toast('Location is not available in this browser', 'error'); return; }
      U.toast('Getting your location…');
      navigator.geolocation.getCurrentPosition(async (pos) => {
        coords = { lat: pos.coords.latitude, lon: pos.coords.longitude };
        document.querySelector('#gps-state').innerHTML = `${U.icon('pin', 14)} Location captured`;
        try {
          const zoneRes = await API.findZone(coords.lat, coords.lon);
          const zone = zoneRes && zoneRes.content && zoneRes.content.zone;
          if (zone) { state.zoneId = zone.id; state.zoneName = zone.name; }
        } catch (e) { /* zone check is best-effort */ }
      }, () => U.toast('Could not get your location. You can still type the address.', 'error'), { timeout: 15000 });
    };

    document.querySelector('#af-save').onclick = async () => {
      const address = document.querySelector('#af-address').value.trim();
      const name = document.querySelector('#af-name').value.trim();
      const phone = document.querySelector('#af-phone').value.trim();
      if (!address) { U.toast('Please enter the full address', 'error'); return; }
      if (!name) { U.toast('Please enter a contact name', 'error'); return; }
      if (!phone) { U.toast('Please enter a contact number', 'error'); return; }
      if (!coords.lat || !coords.lon) {
        U.toast('Please capture your location or set a service location first', 'error');
        return;
      }

      const model = {
        ...(existing ? {
          id: existing.id,
          address_type: existing.address_type || 'service',
        } : { address_type: 'service' }),
        address_label: document.querySelector('#af-label').value.trim() || 'home',
        contact_person_name: name,
        contact_person_number: phone,
        address,
        lat: coords.lat,
        lon: coords.lon,
        city: document.querySelector('#af-city').value.trim(),
        zip_code: document.querySelector('#af-zip').value.trim(),
        country: (existing && existing.country) || '',
        zone_id: state.zoneId || (existing && existing.zone_id) || '',
        street: document.querySelector('#af-street').value.trim(),
        house: document.querySelector('#af-house').value.trim(),
        floor: (existing && existing.floor) || '',
      };

      const btn = document.querySelector('#af-save');
      btn.disabled = true;
      btn.textContent = 'Saving…';
      try {
        const res = isEdit ? await API.updateAddress(existing.id, model) : await API.addAddress(model);
        if (ok(res)) {
          const saved = (res.content && res.content.id) ? res.content : { ...model, id: (res.content && res.content.id) || model.id };
          U.closeSheet();
          U.toast(isEdit ? 'Address updated' : 'Address saved', 'success');
          onSaved(saved);
        } else {
          U.toast((res && res.message) || 'Could not save the address', 'error');
          btn.disabled = false;
          btn.textContent = isEdit ? 'Save changes' : 'Save address';
        }
      } catch (e) {
        U.toast(e.message, 'error');
        btn.disabled = false;
        btn.textContent = isEdit ? 'Save changes' : 'Save address';
      }
    };
  }

  /* =========================================================
   * BOOKINGS LIST
   * ========================================================= */
  const STATUS_TABS = [
    { key: 'all', label: 'All' },
    { key: 'pending', label: 'Pending' },
    { key: 'accepted', label: 'Accepted' },
    { key: 'ongoing', label: 'Ongoing' },
    { key: 'completed', label: 'Completed' },
    { key: 'canceled', label: 'Canceled' },
  ];

  async function orders(view, query = {}) {
    if (!state.isLoggedIn()) {
      view.innerHTML = `<div class="page">${U.empty({
        icon: 'calendar', title: 'Sign in to see your bookings',
        text: 'Your bookings, invoices and reviews are all in one place.',
        action: `<a class="btn btn--primary" href="#/login?next=${encodeURIComponent('#/orders')}">Sign in</a>
                 <a class="btn btn--ghost" href="#/track">Track a booking</a>`,
      })}</div>`;
      return;
    }

    let status = query.status || 'all';
    let search = query.q || '';
    let page = 1;
    let lastPage = 1;
    let list = [];
    let type = query.type || 'all';

    view.innerHTML = `
      <div class="page">
        <header class="pagehead pagehead--inline">
          <div><span class="eyebrow">Your service history</span><h1>My bookings</h1></div>
          <a class="btn btn--ghost btn--sm" href="#/track">${U.icon('search', 15)} Track a booking</a>
        </header>
        <div class="toolbar">
          <div class="tabs tabs--scroll" id="status-tabs">
            ${STATUS_TABS.map(t => `<button class="tabs__btn ${t.key === status ? 'is-on' : ''}" data-status="${t.key}">${t.label}</button>`).join('')}
          </div>
          <form class="inline-search" id="order-search">
            ${U.icon('search', 15)}
            <input class="input" type="search" placeholder="Booking ID" value="${U.esc(search)}" aria-label="Search bookings">
          </form>
        </div>
        <div id="orders-body">${U.skeletonRows(3)}</div>
      </div>`;

    async function load(reset) {
      if (reset) { page = 1; list = []; }
      const host = view.querySelector('#orders-body');
      if (reset) host.innerHTML = U.skeletonRows(3);
      try {
        const res = await API.getOrders({ offset: page, limit: 10, status, type, search });
        const content = res && res.content;
        const paged = content && (content.data ? content : content.orders);
        const rows = (paged && (paged.data || [])) || [];
        lastPage = Number(paged && paged.last_page) || 1;
        list = reset ? rows : list.concat(rows);
        render();
      } catch (e) {
        host.innerHTML = U.errorState(e, 'orders-retry');
        const retry = host.querySelector('#orders-retry');
        if (retry) retry.onclick = () => load(true);
      }
    }

    function render() {
      const host = view.querySelector('#orders-body');
      if (!list.length) {
        host.innerHTML = U.empty({
          icon: 'calendar', title: search ? 'No matching bookings' : 'No bookings here yet',
          text: search ? `We couldn't find a booking with that ID.` : 'Book a service and it will show up here.',
          action: `<a class="btn btn--primary" href="#/categories">Book a service</a>`,
        });
        return;
      }
      host.innerHTML = `<div class="orderlist">${list.map(b => orderCard(b)).join('')}</div>
        ${page < lastPage ? `<div class="loadmore"><button class="btn btn--ghost" id="orders-more">Load more</button></div>` : ''}`;
      const more = host.querySelector('#orders-more');
      if (more) more.onclick = async () => { more.disabled = true; more.textContent = 'Loading…'; page += 1; await load(false); };
    }

    function orderCard(b) {
      const id = b.readable_id || b.id;
      const statusKey = String(b.booking_status || 'pending').toLowerCase();
      const amount = b.total_booking_amount ?? b.total_cost ?? 0;
      const when = b.service_schedule;
      const paymentLabel = U.titleCase(String(b.payment_method || '').replace(/_/g, ' '));
      return `<a class="ocard" href="#/order/${U.esc(b.id)}">
        <div class="ocard__top">
          <div>
            <span class="ocard__id">Booking #${U.esc(id)}</span>
            <span class="ocard__date">${U.esc(when ? U.fmtDate(when) : U.fmtDate(b.created_at))}</span>
          </div>
          ${U.statusPill(statusKey)}
        </div>
        <div class="ocard__mid">
          <div class="ocard__meta">
            ${paymentLabel ? `<span>${U.icon('wallet', 13)} ${U.esc(paymentLabel)}</span>` : ''}
            ${b.booking_type ? `<span>${U.icon('refresh', 13)} ${U.esc(U.titleCase(b.booking_type))}</span>` : ''}
          </div>
          <b class="ocard__amount">${U.money(amount)}</b>
        </div>
        <div class="ocard__foot">
          <span class="link">View details ${U.icon('chevronRight', 13)}</span>
        </div>
      </a>`;
    }

    view.querySelectorAll('#status-tabs [data-status]').forEach(btn => {
      btn.onclick = () => {
        status = btn.dataset.status;
        view.querySelectorAll('#status-tabs [data-status]').forEach(b => b.classList.remove('is-on'));
        btn.classList.add('is-on');
        load(true);
      };
    });
    view.querySelector('#order-search').onsubmit = (e) => {
      e.preventDefault();
      search = e.target.querySelector('input').value.trim();
      load(true);
    };

    await load(true);
  }

  /* =========================================================
   * BOOKING DETAIL
   * ========================================================= */
  async function order(view, id) {
    if (!state.isLoggedIn()) { location.hash = '#/login?next=' + encodeURIComponent('#/order/' + id); return; }
    view.innerHTML = `<div class="page">${U.skeletonRows(3)}</div>`;

    let b;
    try {
      const res = await API.getOrder(id);
      if (res && res.content && (res.content.id || res.content.readable_id)) b = res.content;
    } catch (e) { /* handled below */ }

    if (!b) {
      view.innerHTML = `<div class="page">${U.empty({ icon: 'file', title: 'Booking not found', text: 'It may belong to another account.', action: `<a class="btn btn--primary" href="#/orders">All bookings</a>` })}</div>`;
      return;
    }

    const statusKey = String(b.booking_status || 'pending').toLowerCase();
    const services = b.detail || [];
    const address = b.service_address;
    const provider = b.provider;
    const serviceman = b.serviceman;
    const providerUser = provider && provider.owner ? provider.owner : (provider && provider.user);
    const canCancel = statusKey === 'pending';
    const canReview = statusKey === 'completed';
    const canChat = provider && (providerUser || provider.user_id);

    const timeline = buildTimeline(b);

    view.innerHTML = `
      <div class="page">
        <nav class="crumbs"><a href="#/orders">My bookings</a>${U.icon('chevronRight', 12)}<span>#${U.esc(b.readable_id || b.id)}</span></nav>

        <header class="orderhead">
          <div>
            <span class="eyebrow">Booking #${U.esc(b.readable_id || b.id)}</span>
            <h1>${U.esc(services.length ? (services[0].service && services[0].service.name) || 'Service booking' : 'Service booking')}</h1>
            <p class="orderhead__meta">${services.length} service${services.length === 1 ? '' : 's'} · ${U.esc(U.fmtDate(b.service_schedule || b.created_at))}</p>
          </div>
          <div class="orderhead__side">
            ${U.statusPill(statusKey)}
            <b class="orderhead__amount">${U.money(b.total_booking_amount)}</b>
          </div>
        </header>

        <div class="orderlayout">
          <div class="orderlayout__main">
            <section class="card">
              <h3 class="card__title">${U.icon('clock', 16)} Progress</h3>
              <ol class="timeline">
                ${timeline.map(step => `<li class="${step.state}">
                  <i class="timeline__dot"></i>
                  <div><b>${U.esc(step.label)}</b>${step.when ? `<small>${U.esc(step.when)}</small>` : ''}</div>
                </li>`).join('')}
              </ol>
            </section>

            <section class="card">
              <h3 class="card__title">${U.icon('file', 16)} Services</h3>
              <div class="svclines">
                ${services.map(d => {
                  const svc = d.service || {};
                  return `<div class="svcline">
                    <img src="${U.esc(U.imgSrc(svc.thumbnail_full_path))}" alt="" onerror="this.style.display='none'">
                    <div class="svcline__body">
                      <b>${U.esc(svc.name || 'Service')}</b>
                      <small>${U.esc(U.titleCase((d.variant_key || '').replace(/-/g, ' ')))} × ${d.quantity || 1}</small>
                    </div>
                    <b class="svcline__price">${U.money(d.total_cost ?? d.service_cost)}</b>
                  </div>`;
                }).join('')}
                ${(b.extraServices || []).map(x => `<div class="svcline">
                  <span class="svcline__icon">${U.icon('plus', 16)}</span>
                  <div class="svcline__body"><b>${U.esc(x.service_name || 'Extra service')}</b><small>Added by your professional</small></div>
                  <b class="svcline__price">${U.money(x.total_cost)}</b>
                </div>`).join('')}
              </div>
            </section>

            ${address ? `<section class="card">
              <h3 class="card__title">${U.icon('pin', 16)} Service address</h3>
              <p class="addressblock"><b>${U.esc(address.contact_person_name || '')}</b>
                <span>${U.esc(address.address || '')}</span>
                ${address.contact_person_number ? `<a class="link" href="tel:${U.esc(address.contact_person_number)}">${U.icon('phone', 13)} ${U.esc(address.contact_person_number)}</a>` : ''}
              </p>
              ${address.lat && address.lon ? U.mapLink(address.lat, address.lon, 'Open in maps') : ''}
            </section>` : ''}

            ${b.schedule_histories && b.schedule_histories.length ? `<section class="card">
              <h3 class="card__title">${U.icon('refresh', 16)} Schedule history</h3>
              ${b.schedule_histories.map(h => `<div class="histline">
                <span>${U.esc(U.fmtDate(h.created_at))}</span>
                <b>${U.esc(U.fmtDate(h.schedule || h.service_schedule))}</b>
              </div>`).join('')}
            </section>` : ''}
          </div>

          <aside class="orderlayout__aside">
            <div class="card bill">
              <h3>Payment</h3>
              <div class="bill__row"><span>Service total</span><b>${U.money(Number(b.total_booking_amount) - Number(b.total_tax_amount || 0))}</b></div>
              ${Number(b.total_tax_amount) ? `<div class="bill__row"><span>Taxes</span><b>${U.money(b.total_tax_amount)}</b></div>` : ''}
              ${Number(b.total_discount_amount) ? `<div class="bill__row bill__row--green"><span>Discount</span><b>−${U.money(b.total_discount_amount)}</b></div>` : ''}
              ${b.coupon_code ? `<div class="bill__row bill__row--green"><span>Coupon ${U.esc(b.coupon_code)}</span><b></b></div>` : ''}
              <div class="bill__total"><span>Total</span><b>${U.money(b.total_booking_amount)}</b></div>
              <p class="bill__note">${U.icon('wallet', 14)} ${U.esc(U.titleCase(String(b.payment_method || '').replace(/_/g, ' ')))} · ${b.is_paid ? 'Paid' : 'Payment pending'}</p>
            </div>

            ${provider ? `<div class="card procard">
              <h3>Your professional</h3>
              <div class="procard__row">
                <span class="procard__avatar">${U.esc(U.initials(providerUser && providerUser.first_name, providerUser && providerUser.last_name))}</span>
                <div>
                  <b>${U.esc((providerUser && [providerUser.first_name, providerUser.last_name].filter(Boolean).join(' ')) || provider.company_name || 'Service partner')}</b>
                  <small>${U.esc(provider.company_name || '')}</small>
                </div>
              </div>
              <div class="procard__actions">
                ${canChat ? `<button class="btn btn--ghost btn--sm" id="chat-pro">${U.icon('chat', 15)} Message</button>` : ''}
                ${provider.contact_person_number || (providerUser && providerUser.phone) ? `<a class="btn btn--ghost btn--sm" href="tel:${U.esc(provider.contact_person_number || (providerUser && providerUser.phone))}">${U.icon('phone', 15)} Call</a>` : ''}
              </div>
            </div>` : ''}

            ${serviceman ? `<div class="card procard">
              <h3>Technician on the job</h3>
              <div class="procard__row">
                <span class="procard__avatar">${U.esc(U.initials(serviceman.user && serviceman.user.first_name, serviceman.user && serviceman.user.last_name))}</span>
                <div>
                  <b>${U.esc((serviceman.user && [serviceman.user.first_name, serviceman.user.last_name].filter(Boolean).join(' ')) || 'Assigned technician')}</b>
                  <small>${serviceman.user && serviceman.user.phone ? U.esc(serviceman.user.phone) : 'Assigned to your booking'}</small>
                </div>
              </div>
            </div>` : ''}

            <div class="card actions">
              ${canReview ? `<button class="btn btn--primary btn--block" id="review-btn">${U.icon('star', 16)} Rate this service</button>` : ''}
              <button class="btn btn--ghost btn--block" id="rebook-btn">${U.icon('refresh', 16)} Book these services again</button>
              ${canCancel ? `<button class="btn btn--danger-ghost btn--block" id="cancel-btn">Cancel booking</button>` : ''}
            </div>
          </aside>
        </div>
      </div>`;

    if (canCancel) {
      view.querySelector('#cancel-btn').onclick = async () => {
        const yes = await U.confirmDialog({
          title: 'Cancel this booking?', message: 'Your professional will be notified. This cannot be undone.',
          confirmLabel: 'Cancel booking', cancelLabel: 'Keep booking', danger: true,
        });
        if (!yes) return;
        try {
          const r = await API.cancelOrder(b.id);
          if (ok(r)) { U.toast('Booking canceled', 'success'); order(view, id); }
          else U.toast((r && r.message) || 'Could not cancel this booking', 'error');
        } catch (e) { U.toast(e.message, 'error'); }
      };
    }

    const chatBtn = view.querySelector('#chat-pro');
    if (chatBtn) {
      chatBtn.onclick = async () => {
        const toUser = (providerUser && providerUser.id) || (provider && provider.user_id);
        if (!toUser) { U.toast('Messaging is not available for this booking', 'error'); return; }
        chatBtn.disabled = true;
        try {
          const r = await API.openChat(toUser, b.id, 'booking_id');
          const channelId = r && r.content && (r.content.id || r.content.channel_id);
          if (channelId) location.hash = '#/chat/' + channelId;
          else U.toast((r && r.message) || 'Could not open the conversation', 'error');
        } catch (e) { U.toast(e.message, 'error'); }
        chatBtn.disabled = false;
      };
    }

    const reviewBtn = view.querySelector('#review-btn');
    if (reviewBtn) {
      reviewBtn.onclick = () => reviewSheet(b, () => order(view, id));
    }

    const rebookBtn = view.querySelector('#rebook-btn');
    if (rebookBtn) {
      rebookBtn.onclick = async () => {
        if (!state.zoneId) { U.toast('Set your service location first', 'info'); App.openLocationSheet(); return; }
        rebookBtn.disabled = true;
        rebookBtn.textContent = 'Adding…';
        try {
          const r = await API.rebook(b.id);
          if (ok(r) || (r && r.response_code === 'default_cart_already_added_200')) {
            await API.refreshCartCount();
            U.toast('Services added back to your cart', 'success');
            location.hash = '#/cart';
          } else {
            U.toast((r && r.message) || 'These services are not available right now', 'error');
            rebookBtn.disabled = false;
            rebookBtn.innerHTML = U.icon('refresh', 16) + ' Book these services again';
          }
        } catch (e) {
          U.toast(e.message, 'error');
          rebookBtn.disabled = false;
          rebookBtn.innerHTML = U.icon('refresh', 16) + ' Book these services again';
        }
      };
    }
  }

  function buildTimeline(b) {
    const steps = [
      { key: 'pending', label: 'Booking placed' },
      { key: 'accepted', label: 'Professional assigned' },
      { key: 'ongoing', label: 'Work in progress' },
      { key: 'completed', label: 'Completed' },
    ];
    const status = String(b.booking_status || 'pending').toLowerCase();
    const histories = b.status_histories || [];
    const rank = { pending: 0, accepted: 1, ongoing: 2, completed: 3, canceled: -1 };
    const currentRank = rank[status] ?? 0;

    if (status === 'canceled') {
      return [
        { label: 'Booking placed', state: 'done', when: U.fmtDate(b.created_at) },
        { label: 'Canceled', state: 'is-canceled', when: (histories.find(h => h.booking_status === 'canceled') || {}).created_at ? U.fmtDate(histories.find(h => h.booking_status === 'canceled').created_at) : '' },
      ];
    }

    return steps.map((s, i) => {
      const hist = histories.find(h => String(h.booking_status).toLowerCase() === s.key);
      let state = i < currentRank ? 'done' : i === currentRank ? 'current' : 'todo';
      return { label: s.label, state, when: hist ? U.fmtDate(hist.created_at) : '' };
    });
  }

  /* ---------------- review sheet ---------------- */
  function reviewSheet(booking, onDone) {
    const services = (booking.detail || []).map(d => d.service).filter(Boolean);
    if (!services.length) { U.toast('No service found on this booking', 'error'); return; }
    const svc = services[0];
    let rating = 5;

    U.openSheet(`
      <div class="sheet__head"><div><span class="eyebrow">Your feedback matters</span><h3>Rate ${U.esc(svc.name)}</h3></div>
        <button class="iconbtn" data-close>${U.icon('close', 18)}</button></div>
      <div class="sheet__body">
        <div class="ratingpick" id="ratingpick">
          ${[1, 2, 3, 4, 5].map(i => `<button data-star="${i}" aria-label="${i} star${i > 1 ? 's' : ''}" class="${i <= rating ? 'is-on' : ''}">${U.icon('star', 26)}</button>`).join('')}
        </div>
        <p class="ratingpick__label" id="rating-label">Excellent — 5/5</p>
        <textarea class="input textarea" id="review-comment" rows="4" placeholder="Tell others how it went (optional)"></textarea>
        <button class="btn btn--primary btn--block" id="review-submit">Submit review</button>
      </div>`);

    document.querySelector('[data-close]').onclick = U.closeSheet;
    const labels = { 1: 'Not great — 1/5', 2: 'Could be better — 2/5', 3: 'Okay — 3/5', 4: 'Good — 4/5', 5: 'Excellent — 5/5' };
    document.querySelectorAll('#ratingpick [data-star]').forEach(btn => {
      btn.onclick = () => {
        rating = Number(btn.dataset.star);
        document.querySelectorAll('#ratingpick [data-star]').forEach(b => b.classList.toggle('is-on', Number(b.dataset.star) <= rating));
        document.querySelector('#rating-label').textContent = labels[rating];
      };
    });

    document.querySelector('#review-submit').onclick = async () => {
      const comment = document.querySelector('#review-comment').value.trim();
      const btn = document.querySelector('#review-submit');
      btn.disabled = true;
      btn.textContent = 'Sending…';
      try {
        const payload = {
          booking_id: booking.id,
          service_id: svc.id,
          review_rating: rating,
          review_comment: comment,
          serviceman_id: booking.serviceman_id || (booking.serviceman && booking.serviceman.id) || '',
        };
        const res = await API.submitReview(payload);
        if (ok(res)) {
          U.closeSheet();
          U.toast('Thanks for your review!', 'success');
          if (onDone) onDone();
        } else {
          U.toast((res && res.message) || 'Could not submit your review', 'error');
          btn.disabled = false;
          btn.textContent = 'Submit review';
        }
      } catch (e) {
        U.toast(e.message, 'error');
        btn.disabled = false;
        btn.textContent = 'Submit review';
      }
    };
  }

  /* =========================================================
   * TRACK BOOKING (guest)
   * ========================================================= */
  async function track(view, query = {}) {
    view.innerHTML = `
      <div class="page page--narrow">
        <header class="pagehead">
          <span class="eyebrow">No account needed</span>
          <h1>Track your booking</h1>
          <p>Enter the booking number from your confirmation and the phone number used for the booking.</p>
        </header>
        <form class="card trackform" id="track-form">
          ${U.field({ id: 'track-id', label: 'Booking number', placeholder: 'e.g. 1024', value: query.id || '', required: true, inputmode: 'numeric' })}
          ${U.field({ id: 'track-phone', label: 'Phone number', placeholder: 'Phone used at booking', required: true, inputmode: 'tel' })}
          <button class="btn btn--primary btn--block" type="submit">Track booking</button>
        </form>
        <div id="track-result"></div>
      </div>`;

    const form = view.querySelector('#track-form');
    form.onsubmit = async (e) => {
      e.preventDefault();
      const id = view.querySelector('#track-id').value.trim();
      const phone = view.querySelector('#track-phone').value.trim();
      const host = view.querySelector('#track-result');
      if (!id || !phone) return;
      host.innerHTML = U.skeletonRows(2);
      try {
        const res = await API.traceOrder(id, phone);
        const b = res && res.content;
        if (!b || !b.id) {
          host.innerHTML = U.empty({ icon: 'search', title: 'Booking not found', text: 'Check the booking number and phone number and try again.' });
          return;
        }
        host.innerHTML = `<div class="card">
          <div class="orderhead">
            <div><span class="eyebrow">Booking #${U.esc(b.readable_id || b.id)}</span>
              <h2>${U.esc((b.detail && b.detail[0] && b.detail[0].service && b.detail[0].service.name) || 'Service booking')}</h2>
              <p class="muted">${U.esc(U.fmtDate(b.service_schedule || b.created_at))}</p></div>
            ${U.statusPill(b.booking_status)}
          </div>
          <ol class="timeline timeline--compact">
            ${buildTimeline(b).map(s => `<li class="${s.state}"><i class="timeline__dot"></i><div><b>${U.esc(s.label)}</b>${s.when ? `<small>${U.esc(s.when)}</small>` : ''}</div></li>`).join('')}
          </ol>
        </div>`;
      } catch (err) {
        host.innerHTML = U.empty({ icon: 'search', title: 'We could not find that booking', text: err.message });
      }
    };
  }

  /* =========================================================
   * PAYMENT RETURN
   * ========================================================= */
  async function paymentReturn(view, query = {}) {
    const flag = String(query.flag || '').toLowerCase();
    const success = ['success', 'paid', '1'].includes(flag) || query.pay === 'success';
    await API.refreshCartCount().catch(() => {});
    view.innerHTML = `
      <div class="page">
        <div class="success ${success ? '' : 'success--fail'}">
          <div class="success__art">${U.icon(success ? 'check' : 'info', 30)}</div>
          <span class="eyebrow">${success ? 'Payment received' : 'Payment not completed'}</span>
          <h1>${success ? 'Thank you — booking confirmed!' : 'That payment did not go through'}</h1>
          <p>${success
            ? 'Your payment was successful and your booking is confirmed. You can follow its progress in My bookings.'
            : 'No money has been taken. You can try again from your cart, or choose cash after service at checkout.'}</p>
          <div class="success__actions">
            <a class="btn btn--primary" href="#/orders">View my bookings</a>
            <a class="btn btn--ghost" href="#/cart">Back to cart</a>
          </div>
        </div>
      </div>`;
  }

  Object.assign(window.Views, { cart, checkout, orders, order, track, paymentReturn, addressSheet, reviewSheet });
})();
