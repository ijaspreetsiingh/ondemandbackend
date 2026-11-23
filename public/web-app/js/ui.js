/* ============================================================
 * Jass Booking — shared UI kit
 * Tiny templating helpers, icons, overlays and reusable widgets.
 * ============================================================ */
'use strict';

const UI = (() => {
  const $ = (sel, root = document) => root.querySelector(sel);
  const $$ = (sel, root = document) => Array.from(root.querySelectorAll(sel));

  const esc = (s) => String(s ?? '').replace(/[&<>"']/g, c => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;',
  }[c]));

  const el = (html) => {
    const t = document.createElement('template');
    t.innerHTML = String(html).trim();
    return t.content.firstElementChild;
  };

  const FALLBACK_IMG = '/landing/images/logo-black.png';

  const imgSrc = (src, fallback) => (!src || src === '/' || /^https?:\/\/[^/]+\/?$/.test(src))
    ? (fallback || FALLBACK_IMG)
    : src;

  /* ---------- formatting ---------- */
  const money = (n) => API.money(n);

  function fmtDate(value, withTime = true) {
    if (!value) return '';
    const d = new Date(String(value).replace(' ', 'T'));
    if (Number.isNaN(d.getTime())) return String(value);
    const opts = { day: 'numeric', month: 'short', year: 'numeric' };
    if (withTime) { opts.hour = 'numeric'; opts.minute = '2-digit'; }
    return d.toLocaleString(undefined, opts);
  }

  function fmtDay(value) {
    if (!value) return '';
    const d = new Date(String(value).replace(' ', 'T'));
    if (Number.isNaN(d.getTime())) return String(value);
    return d.toLocaleDateString(undefined, { weekday: 'short', day: 'numeric', month: 'short' });
  }

  function fmtTime(value) {
    if (!value) return '';
    const d = new Date(String(value).replace(' ', 'T'));
    if (Number.isNaN(d.getTime())) return '';
    return d.toLocaleTimeString(undefined, { hour: 'numeric', minute: '2-digit' });
  }

  const nl2br = (s) => esc(s).replace(/\n/g, '<br>');
  const titleCase = (s) => String(s || '').replace(/[_-]+/g, ' ').replace(/\b\w/g, c => c.toUpperCase());
  const initials = (first, last) => ((first || '').charAt(0) + (last || '').charAt(0) || 'U').toUpperCase();

  /* ---------- icons ---------- */
  const ICONS = {
    home: '<path d="M3 9.5 12 3l9 6.5V21a1 1 0 0 1-1 1h-5v-7H10v7H4a1 1 0 0 1-1-1z"/>',
    grid: '<rect x="3" y="3" width="7" height="7" rx="1.5"/><rect x="14" y="3" width="7" height="7" rx="1.5"/><rect x="3" y="14" width="7" height="7" rx="1.5"/><rect x="14" y="14" width="7" height="7" rx="1.5"/>',
    calendar: '<rect x="3" y="4" width="18" height="17" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/>',
    cart: '<circle cx="9" cy="20" r="1.4"/><circle cx="19" cy="20" r="1.4"/><path d="M2 3h3l2.6 12.4a2 2 0 0 0 2 1.6h8.8a2 2 0 0 0 2-1.6L22 7H6"/>',
    user: '<path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>',
    pin: '<path d="M21 10c0 6.5-9 12-9 12S3 16.5 3 10a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/>',
    search: '<circle cx="11" cy="11" r="7"/><path d="m20 20-3.6-3.6"/>',
    close: '<path d="M18 6 6 18M6 6l12 12"/>',
    check: '<path d="M20 6 9 17l-5-5"/>',
    chevronRight: '<path d="m9 18 6-6-6-6"/>',
    chevronLeft: '<path d="m15 18-6-6 6-6"/>',
    chevronDown: '<path d="m6 9 6 6 6-6"/>',
    star: '<path d="m12 2 3.1 6.3 6.9 1-5 4.9 1.2 6.8L12 17.8 5.8 21l1.2-6.8-5-4.9 6.9-1z"/>',
    heart: '<path d="M20.8 4.6a5.5 5.5 0 0 0-7.8 0L12 5.7l-1-1.1a5.5 5.5 0 0 0-7.8 7.8l1 1.1L12 21l7.8-7.5 1-1.1a5.5 5.5 0 0 0 0-7.8z"/>',
    clock: '<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>',
    phone: '<path d="M22 16.9v3a2 2 0 0 1-2.2 2 19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.1 4.2 2 2 0 0 1 4.1 2h3a2 2 0 0 1 2 1.7c.1 1 .4 1.9.7 2.8a2 2 0 0 1-.5 2.1L8.1 9.9a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.5c.9.3 1.8.6 2.8.7a2 2 0 0 1 1.7 2z"/>',
    chat: '<path d="M21 11.5a8.4 8.4 0 0 1-9 8.4 8.9 8.9 0 0 1-3.9-.9L3 20.5l1.5-4.6A8.4 8.4 0 1 1 21 11.5z"/>',
    bell: '<path d="M18 8a6 6 0 1 0-12 0c0 7-3 8-3 8h18s-3-1-3-8"/><path d="M13.7 21a2 2 0 0 1-3.4 0"/>',
    logout: '<path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><path d="m16 17 5-5-5-5M21 12H9"/>',
    wallet: '<path d="M20 12V8a2 2 0 0 0-2-2H5a2 2 0 0 1 0-4h13v4"/><path d="M3 6v12a2 2 0 0 0 2 2h15a1 1 0 0 0 1-1v-6a1 1 0 0 0-1-1H6a3 3 0 0 0 0 6"/>',
    gift: '<rect x="3" y="8" width="18" height="13" rx="2"/><path d="M12 8v13M3 12h18M7.5 8a2.5 2.5 0 1 1 0-5C11 3 12 8 12 8s1-5 4.5-5a2.5 2.5 0 1 1 0 5"/>',
    tag: '<path d="M20.6 13.4 12 22l-9-9V3h10l7.6 7.6a2 2 0 0 1 0 2.8z"/><circle cx="7.5" cy="7.5" r="1.2"/>',
    trash: '<path d="M3 6h18M8 6V4a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1v2m3 0v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"/>',
    plus: '<path d="M12 5v14M5 12h14"/>',
    minus: '<path d="M5 12h14"/>',
    edit: '<path d="M12 20h9"/><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4z"/>',
    shield: '<path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>',
    sparkle: '<path d="M12 3v4M12 17v4M3 12h4M17 12h4M5.6 5.6l2.8 2.8M15.6 15.6l2.8 2.8M18.4 5.6l-2.8 2.8M8.4 15.6l-2.8 2.8"/>',
    arrowRight: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    info: '<circle cx="12" cy="12" r="9"/><path d="M12 11v5M12 8h.01"/>',
    refresh: '<path d="M3 12a9 9 0 0 1 15.5-6.2L21 8"/><path d="M21 3v5h-5"/><path d="M21 12a9 9 0 0 1-15.5 6.2L3 16"/><path d="M3 21v-5h5"/>',
    truck: '<path d="M3 7h11v10H3z"/><path d="M14 10h4l3 3v4h-7z"/><circle cx="7" cy="18" r="1.6"/><circle cx="17.5" cy="18" r="1.6"/>',
    ticket: '<path d="M3 9a2 2 0 0 0 2-2V5h14v2a2 2 0 0 0 2 2v6a2 2 0 0 0-2 2v2H5v-2a2 2 0 0 0-2-2z"/><path d="M13 5v14"/>',
    mapPin: '<path d="M12 21s7-6.2 7-11a7 7 0 1 0-14 0c0 4.8 7 11 7 11z"/><circle cx="12" cy="10" r="2.6"/>',
    file: '<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><path d="M14 2v6h6"/>',
    eye: '<path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7-10-7-10-7z"/><circle cx="12" cy="12" r="3"/>',
    eyeOff: '<path d="M17.9 17.9A10.4 10.4 0 0 1 12 19c-6.5 0-10-7-10-7a18 18 0 0 1 4.2-4.9M9.9 4.2A10.4 10.4 0 0 1 12 5c6.5 0 10 7 10 7a18.5 18.5 0 0 1-2.2 3.1M2 2l20 20"/>',
  };

  function icon(name, size = 20, cls = '') {
    const path = ICONS[name] || ICONS.info;
    return `<svg class="ic ${cls}" width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">${path}</svg>`;
  }

  /* ---------- overlays ---------- */
  function toast(message, type = 'info', ms = 3200) {
    const host = $('#toasts');
    if (!host) return;
    const node = el(`<div class="toast toast--${type}" role="status">
      <span class="toast__dot"></span><span class="toast__msg">${esc(message)}</span>
    </div>`);
    host.appendChild(node);
    requestAnimationFrame(() => node.classList.add('is-in'));
    setTimeout(() => {
      node.classList.remove('is-in');
      setTimeout(() => node.remove(), 260);
    }, ms);
  }

  let sheetCloser = null;
  function openSheet(html, { size = '' } = {}) {
    const backdrop = $('#sheet');
    const body = $('#sheet-body');
    if (!backdrop || !body) return;
    body.className = 'sheet ' + (size ? 'sheet--' + size : '');
    body.innerHTML = html;
    backdrop.hidden = false;
    requestAnimationFrame(() => backdrop.classList.add('is-in'));
    document.body.classList.add('no-scroll');
    sheetCloser = () => closeSheet();
    return body;
  }

  function closeSheet() {
    const backdrop = $('#sheet');
    if (!backdrop || backdrop.hidden) return;
    backdrop.classList.remove('is-in');
    document.body.classList.remove('no-scroll');
    setTimeout(() => {
      backdrop.hidden = true;
      $('#sheet-body').innerHTML = '';
    }, 220);
    sheetCloser = null;
  }

  function confirmDialog({ title = 'Are you sure?', message = '', confirmLabel = 'Confirm', cancelLabel = 'Cancel', danger = false }) {
    return new Promise((resolve) => {
      const body = openSheet(`
        <div class="confirm">
          <div class="confirm__icon ${danger ? 'is-danger' : ''}">${icon(danger ? 'trash' : 'info', 22)}</div>
          <h3>${esc(title)}</h3>
          ${message ? `<p>${esc(message)}</p>` : ''}
          <div class="confirm__actions">
            <button class="btn btn--ghost" data-x="no">${esc(cancelLabel)}</button>
            <button class="btn ${danger ? 'btn--danger' : 'btn--primary'}" data-x="yes">${esc(confirmLabel)}</button>
          </div>
        </div>`);
      const finish = (val) => { closeSheet(); resolve(val); };
      $('[data-x="no"]', body).onclick = () => finish(false);
      $('[data-x="yes"]', body).onclick = () => finish(true);
      $('#sheet').addEventListener('click', (e) => { if (e.target.id === 'sheet') finish(false); }, { once: true });
    });
  }

  /* ---------- skeleton / states ---------- */
  function skeletonRows(n = 3, cls = '') {
    return `<div class="skeletons ${cls}">${'<div class="skel"></div>'.repeat(n)}</div>`;
  }

  function skeletonCards(n = 4) {
    return `<div class="cardgrid">${Array.from({ length: n }).map(() => `
      <div class="skelcard"><div class="skelcard__img"></div><div class="skelcard__line"></div><div class="skelcard__line skelcard__line--short"></div></div>
    `).join('')}</div>`;
  }

  function empty({ icon: ic = 'search', title = 'Nothing here yet', text = '', action = '' } = {}) {
    return `<div class="empty">
      <div class="empty__art">${icon(ic, 26)}</div>
      <h3>${esc(title)}</h3>
      ${text ? `<p>${esc(text)}</p>` : ''}
      ${action || ''}
    </div>`;
  }

  function errorState(err, retryId = '') {
    return `<div class="empty">
      <div class="empty__art empty__art--warn">${icon('info', 26)}</div>
      <h3>Something went wrong</h3>
      <p>${esc(err && err.message ? err.message : 'Please try again.')}</p>
      ${retryId ? `<button class="btn btn--primary" id="${retryId}">Try again</button>` : ''}
    </div>`;
  }

  /* ---------- price helpers ---------- */
  function variantsOf(service) {
    const raw = (service && service.variations_app_format && service.variations_app_format.zone_wise_variations) || [];
    const zone = API.state.zoneId;
    const map = new Map();
    raw.forEach(v => {
      const key = v.variant_key || v.variant_name || String(v.price);
      const existing = map.get(key);
      if (!existing) { map.set(key, v); return; }
      if (zone && v.zone_id === zone && existing.zone_id !== zone) map.set(key, v);
    });
    return Array.from(map.values());
  }

  function priceOf(service) {
    if (!service) return 0;
    const vars = variantsOf(service);
    const priced = vars.map(v => Number(v.price) || 0).filter(p => p > 0);
    if (priced.length) return Math.min(...priced);
    const raw = (service.variations || []).map(v => Number(v.price) || 0).filter(p => p > 0);
    if (raw.length) {
      const zone = API.state.zoneId;
      const inZone = (service.variations || []).filter(v => v.zone_id === zone && Number(v.price) > 0);
      if (inZone.length) return Math.min(...inZone.map(v => Number(v.price)));
      return Math.min(...raw);
    }
    return Number(service.min_bidding_price) || 0;
  }

  function oldPriceOf(service) {
    const d = service && (service.service_discount || (service.category && service.category.category_discount));
    if (!d) return 0;
    const base = priceOf(service);
    if (String(d.discount_type || '').includes('percent')) return base / (1 - Number(d.discount_amount || 0) / 100);
    return base + (Number(d.discount_amount) || 0);
  }

  function ratingOf(service) {
    const r = Number(service && service.avg_rating);
    return Number.isFinite(r) ? r : 0;
  }

  /* ---------- widgets ---------- */
  function stars(rating, size = 14) {
    const r = Math.round((Number(rating) || 0) * 2) / 2;
    let out = '<span class="stars" aria-hidden="true">';
    for (let i = 1; i <= 5; i++) {
      const fill = r >= i ? 1 : (r >= i - 0.5 ? 0.5 : 0);
      out += `<span class="star ${fill === 1 ? 'is-full' : fill === 0.5 ? 'is-half' : ''}">${icon('star', size)}</span>`;
    }
    return out + '</span>';
  }

  function ratingInline(service) {
    const r = ratingOf(service);
    const count = Number(service && service.rating_count) || 0;
    return `<span class="rate">${icon('star', 13)} <b>${r ? r.toFixed(1) : 'New'}</b>${count ? `<em>(${count})</em>` : ''}</span>`;
  }

  const STATUS_LABELS = {
    pending: 'Pending', accepted: 'Accepted', ongoing: 'Ongoing', completed: 'Completed', canceled: 'Canceled',
  };

  function statusPill(status) {
    const key = String(status || 'pending').toLowerCase();
    return `<span class="pill pill--${esc(key)}">${esc(STATUS_LABELS[key] || titleCase(key))}</span>`;
  }

  const compactNumber = (n) => {
    const v = Number(n) || 0;
    if (v >= 1000000) return (v / 1000000).toFixed(1).replace(/\.0$/, '') + 'M';
    if (v >= 1000) return (v / 1000).toFixed(1).replace(/\.0$/, '') + 'k';
    return String(v);
  };

  function durationOf(item) {
    const raw = (item && (item.duration || item.service_duration || item.time_required)) ||
      ((item && item.variations && item.variations[0]) || {}).duration;
    const mins = Number(raw) || 0;
    if (!mins) return '';
    if (mins >= 60) {
      const hrs = mins / 60;
      return (Number.isInteger(hrs) ? hrs : hrs.toFixed(1)) + ' hrs';
    }
    return mins + ' mins';
  }

  function serviceCard(s, { compact = false } = {}) {
    const price = priceOf(s);
    const old = oldPriceOf(s);
    const hasDiscount = old > price + 0.01;
    const pct = hasDiscount ? Math.round((1 - price / old) * 100) : 0;
    const rating = ratingOf(s);
    const count = Number(s.rating_count ?? s.total_rating ?? 0) || 0;
    const bookings = Number(s.order_count ?? s.bookings_count ?? 0) || 0;
    const minutes = durationOf(s);

    const meta = [];
    if (rating) {
      meta.push(`${icon('star', 11)} <b>${rating.toFixed(2)}</b>${count ? ` (${compactNumber(count)})` : ''}`);
    } else {
      meta.push('<span>New</span>');
    }
    if (bookings) meta.push(`${compactNumber(bookings)} bookings`);
    if (minutes) meta.push(minutes);

    return `<a class="scard ${compact ? 'scard--compact' : ''}" href="#/service/${esc(s.slug || s.id)}">
      <div class="scard__media">
        <img src="${esc(imgSrc(s.thumbnail_full_path || s.cover_image_full_path))}" alt="${esc(s.name)}" loading="lazy"
             onerror="this.onerror=null;this.src='${FALLBACK_IMG}'">
        ${hasDiscount ? `<span class="scard__badge">${pct}% off</span>` : ''}
        ${s.is_favorite ? `<span class="scard__fav">${icon('heart', 14)}</span>` : ''}
        <span class="scard__add">Book</span>
      </div>
      <div class="scard__body">
        <h4>${esc(s.name)}</h4>
        <div class="scard__meta">${meta.join('<span class="dot"></span>')}</div>
        <div class="scard__foot">
          ${price > 0
            ? `<span class="scard__from">Starts at</span><span class="price">${money(price)}</span>${hasDiscount ? `<s class="oldprice">${money(old)}</s>` : ''}`
            : `<span class="price">Get a quote</span>`}
        </div>
      </div>
    </a>`;
  }

  function categoryCard(c) {
    const img = c.image_full_path || c.thumbnailFullPath || c.image || '';
    const mins = durationOf(c);
    return `<a class="cat" href="#/category/${esc(c.slug)}">
      <span class="cat__img">
        <img src="${esc(imgSrc(img))}" alt="" loading="lazy"
          onerror="this.onerror=null;this.src='${FALLBACK_IMG}'">
        ${mins ? `<span class="cat__pill">${esc(mins)}</span>` : ''}
      </span>
      <span class="cat__name">${esc(c.name)}</span>
    </a>`;
  }

  function sectionHead(title, subtitle, moreHref, moreLabel = 'See all') {
    return `<div class="section__head">
      <div>
        ${subtitle ? `<span class="eyebrow">${esc(subtitle)}</span>` : ''}
        <h2>${esc(title)}</h2>
      </div>
      ${moreHref ? `<a class="section__more" href="${esc(moreHref)}">${esc(moreLabel)} ${icon('chevronRight', 14)}</a>` : ''}
    </div>`;
  }

  function hscrollSection(title, subtitle, items, moreHref, moreLabel) {
    if (!items || !items.length) return '';
    return `<section class="section">
      ${sectionHead(title, subtitle, moreHref, moreLabel)}
      <div class="hscroll">${items.map(s => serviceCard(s, { compact: true })).join('')}</div>
    </section>`;
  }

  function field({ id, label, type = 'text', placeholder = '', value = '', hint = '', required = false, autocomplete = 'off', inputmode = '', maxlength = '', min = '' }) {
    return `<label class="field" for="${id}">
      <span class="field__label">${esc(label)}${required ? ' <i>*</i>' : ''}</span>
      <input class="input" id="${id}" type="${type}" placeholder="${esc(placeholder)}" value="${esc(value)}"
        ${required ? 'required' : ''} autocomplete="${autocomplete}" ${inputmode ? `inputmode="${inputmode}"` : ''}
        ${maxlength ? `maxlength="${maxlength}"` : ''} ${min !== '' ? `min="${min}"` : ''}>
      ${hint ? `<span class="field__hint">${esc(hint)}</span>` : ''}
    </label>`;
  }

  function qtyStepper(value, { min = 1, max = 99 } = {}) {
    return `<div class="stepper" data-stepper>
      <button type="button" data-step="-1" aria-label="Decrease" ${value <= min ? 'disabled' : ''}>${icon('minus', 16)}</button>
      <span data-qty>${value}</span>
      <button type="button" data-step="1" aria-label="Increase" ${value >= max ? 'disabled' : ''}>${icon('plus', 16)}</button>
      <input type="hidden" data-qty-input value="${value}">
    </div>`;
  }

  function bindStepper(root, onChange) {
    const input = $('[data-qty-input]', root);
    const out = $('[data-qty]', root);
    if (!input) return;
    let value = Number(input.value) || 1;
    const min = Number(input.dataset.min || 1);
    const max = Number(input.dataset.max || 99);
    $$('[data-step]', root).forEach(btn => {
      btn.onclick = () => {
        value = Math.min(max, Math.max(min, value + Number(btn.dataset.step)));
        input.value = value;
        if (out) out.textContent = value;
        const dec = $('[data-step="-1"]', root);
        const inc = $('[data-step="1"]', root);
        if (dec) dec.disabled = value <= min;
        if (inc) inc.disabled = value >= max;
        if (onChange) onChange(value);
      };
    });
  }

  function pagination(list, onLoadMore, { label = 'Load more' } = {}) {
    const current = Number(list.current_page) || 1;
    const last = Number(list.last_page) || 1;
    if (current >= last) return '';
    return `<div class="loadmore"><button class="btn btn--ghost" data-more>${esc(label)}</button></div>`;
  }

  function mapLink(lat, lng, label = 'Open in maps') {
    if (!lat || !lng) return '';
    return `<a class="link" target="_blank" rel="noopener" href="https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(lat)},${encodeURIComponent(lng)}">${icon('pin', 14)} ${esc(label)}</a>`;
  }

  function copyText(text) {
    if (navigator.clipboard && navigator.clipboard.writeText) {
      return navigator.clipboard.writeText(text);
    }
    const ta = document.createElement('textarea');
    ta.value = text;
    document.body.appendChild(ta);
    ta.select();
    try { document.execCommand('copy'); } catch (e) {}
    ta.remove();
    return Promise.resolve();
  }

  function scrollToTop() {
    const view = $('#view');
    if (view) view.scrollTop = 0;
    window.scrollTo({ top: 0, behavior: 'instant' in window ? 'instant' : 'auto' });
  }

  return {
    $, $$, esc, el, icon, toast, openSheet, closeSheet, confirmDialog,
    skeletonRows, skeletonCards, empty, errorState,
    money, fmtDate, fmtDay, fmtTime, nl2br, titleCase, initials, imgSrc,
    variantsOf, priceOf, oldPriceOf, ratingOf, stars, ratingInline, statusPill, STATUS_LABELS,
    serviceCard, categoryCard, sectionHead, hscrollSection, field, qtyStepper, bindStepper,
    pagination, mapLink, copyText, scrollToTop, FALLBACK_IMG,
  };
})();

window.UI = UI;
