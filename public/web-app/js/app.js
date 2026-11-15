/* ============================================================
 * Jass Booking — web app (SPA, hash router)
 * Same APIs as the customer APK, built for phone + laptop browsers.
 * ============================================================ */
'use strict';

const App = (() => {
  const { state, ok, money, E } = API;

  /* ---------------- tiny helpers ---------------- */
  const $ = (sel, root = document) => root.querySelector(sel);
  const el = (html) => { const t = document.createElement('template'); t.innerHTML = html.trim(); return t.content.firstElementChild; };
  const esc = (s) => String(s ?? '').replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
  const img = (src) => src ? esc(src) : '/landing/images/logo-black.png';

  function toast(msg, type = 'info') {
    const t = el(`<div class="toast toast--${type}">${esc(msg)}</div>`);
    $('#toasts').appendChild(t);
    setTimeout(() => t.classList.add('show'), 10);
    setTimeout(() => { t.classList.remove('show'); setTimeout(() => t.remove(), 300); }, 2800);
  }

  function openSheet(html) { $('#sheet-body').innerHTML = html; $('#sheet').hidden = false; }
  function closeSheet() { $('#sheet').hidden = true; $('#sheet-body').innerHTML = ''; }
  document.addEventListener('click', (e) => { if (e.target.id === 'sheet') closeSheet(); });

  /* ---------------- boot ---------------- */
  async function boot() {
    try {
      const res = await API.getConfig();
      if (res && ok(res)) state.config = res.content;
      else throw new Error((res && res.message) || 'Could not load app config');
    } catch (e) {
      $('#boot').innerHTML = `<div class="boot-inner"><img class="boot-logo" src="/landing/images/logo-black.png" alt=""><p class="boot-err">Server se connect nahi ho paya.<br><small>${esc(e.message)}</small></p><button class="btn btn--primary" onclick="location.reload()">Retry</button></div>`;
      return;
    }
    $('#boot').remove();
    $('#app').hidden = false;
    renderChrome();
    route();
    window.addEventListener('hashchange', route);
  }

  /* ---------------- chrome (topbar + bottom nav) ---------------- */
  function renderChrome() {
    const cfg = state.config || {};
    const addr = state.address;
    const locLabel = addr ? (addr.address || '').split(',')[0] || 'Location' : 'Set location';
    const loggedIn = !!state.token;

    $('#topbar').innerHTML = `
      <div class="topbar__inner">
        <a class="topbar__logo" href="#/"><img src="${esc(cfg.logo_full_path || '/landing/images/logo-black.png')}" alt="${esc(cfg.business_name || 'Jass Booking')}"><span>${esc(cfg.business_name || 'Jass Booking')}</span></a>
        <button class="chip chip--loc" id="loc-chip" title="${esc(addr ? addr.address : 'Set your location')}">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
          <span>${esc(locLabel)}</span>
        </button>
        <form class="topbar__search" id="search-form">
          <input type="search" placeholder="Search services…" aria-label="Search services">
        </form>
        <div class="topbar__actions">
          <a class="iconbtn" href="#/cart" aria-label="Cart">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
            <span class="badge" id="cart-badge" ${state.cartCount ? '' : 'hidden'}>${state.cartCount}</span>
          </a>
          <a class="btn btn--ghost btn--sm" href="${loggedIn ? '#/account' : '#/login'}">${loggedIn ? esc((state.user && (state.user.first_name || state.user.phone)) || 'Account') : 'Login'}</a>
        </div>
      </div>`;

    $('#bottomnav').innerHTML = `
      <a href="#/" data-nav="home"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg><span>Home</span></a>
      <a href="#/orders" data-nav="orders"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><path d="M14 2v6h6"/></svg><span>Bookings</span></a>
      <a href="#/cart" data-nav="cart"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg><span>Cart</span></a>
      <a href="${loggedIn ? '#/account' : '#/login'}" data-nav="account"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg><span>Account</span></a>`;

    const desktopNav = el(`<nav class="topbar__nav" aria-label="Main navigation">
      <a href="#/" data-desktop-nav="home">Explore</a>
      <a href="#/orders" data-desktop-nav="orders">My bookings</a>
    </nav>`);
    $('#search-form').before(desktopNav);

    $('#loc-chip').onclick = openLocationSheet;
    $('#search-form').onsubmit = (e) => {
      e.preventDefault();
      const q = e.target.querySelector('input').value.trim();
      if (q) location.hash = '#/search?q=' + encodeURIComponent(q);
    };
    refreshBadge();
  }

  function refreshBadge() {
    const b = $('#cart-badge');
    if (b) { b.textContent = state.cartCount; b.hidden = !state.cartCount; }
  }

  /* ---------------- location ---------------- */
  function openLocationSheet() {
    openSheet(`
      <div class="sheet__head"><h3>Set your location</h3><button class="iconbtn" id="sheet-close" aria-label="Close">✕</button></div>
      <div class="sheet__body">
        <button class="btn btn--primary btn--block" id="use-gps">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="2"/><path d="M16.24 7.76a6 6 0 0 1 1.76 4.24 6 6 0 0 1-1.76 4.24M19.07 4.93a10 10 0 0 1 0 14.14M4.93 19.07a10 10 0 0 1 0-14.14M7.76 16.24A6 6 0 0 1 6 12a6 6 0 0 1 1.76-4.24"/></svg>
          Use my current location
        </button>
        <div class="or-row"><span>or search your area</span></div>
        <input class="input" id="loc-search" type="search" placeholder="Search area, city…" autocomplete="off">
        <div class="suggestions" id="loc-suggestions"></div>
      </div>`);
    $('#sheet-close').onclick = closeSheet;
    $('#use-gps').onclick = () => useGps();
    const input = $('#loc-search');
    let timer;
    input.oninput = () => {
      clearTimeout(timer);
      const q = input.value.trim();
      if (q.length < 3) { $('#loc-suggestions').innerHTML = ''; return; }
      timer = setTimeout(async () => {
        try {
          const res = await API.geoSuggest(q);
          const list = (res.content && res.content.suggestions) || [];
          $('#loc-suggestions').innerHTML = list.map(s => `
            <button class="suggestion" data-place="${esc(s.placePrediction.placeId)}" data-text="${esc(s.placePrediction.text.text)}">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
              ${esc(s.placePrediction.text.text)}
            </button>`).join('');
          $('#loc-suggestions').querySelectorAll('.suggestion').forEach(btn => {
            btn.onclick = () => pickPlace(btn.dataset.place, btn.dataset.text);
          });
        } catch (e) { toast(e.message, 'error'); }
      }, 350);
    };
  }

  async function useGps() {
    toast('Getting your location…');
    try {
      const pos = await new Promise((res, rej) => navigator.geolocation.getCurrentPosition(res, rej, { timeout: 15000 }));
      await applyCoords(pos.coords.latitude, pos.coords.longitude, 'Current location');
    } catch (e) {
      toast('Location permission denied. Please search your area instead.', 'error');
    }
  }

  async function pickPlace(placeId, text) {
    try {
      const res = await API.geoSpot(placeId);
      const loc = res.content && res.content.location;
      if (!loc) throw new Error('Could not find that place');
      await applyCoords(loc.latitude, loc.longitude, text);
    } catch (e) { toast(e.message, 'error'); }
  }

  async function applyCoords(lat, lng, label) {
    const res = await API.findZone(lat, lng);
    if (!ok(res) || !res.content || !res.content.zone) {
      toast('Service not available at this location yet.', 'error');
      return;
    }
    state.zoneId = res.content.zone.id;
    state.setCoords(lat, lng);
    state.address = {
      address: label || res.content.zone.name,
      lat: String(lat), lon: String(lng),
      zone_id: res.content.zone.id,
      available_service_count: res.content.available_services_count,
    };
    closeSheet();
    toast('Location set: ' + state.address.address);
    renderChrome();
    route();
  }

  /* ---------------- router ---------------- */
  function parseHash() {
    const raw = location.hash.replace(/^#\/?/, '');
    const [path, qs] = raw.split('?');
    const parts = path.split('/').filter(Boolean);
    const params = {};
    if (qs) new URLSearchParams(qs).forEach((v, k) => params[k] = v);
    return { parts, params };
  }

  async function route() {
    const { parts, params } = parseHash();
    const [p0, p1] = parts;
    const view = $('#view');
    document.querySelectorAll('[data-nav]').forEach(a => a.classList.toggle('active', a.dataset.nav === (p0 || 'home')));
    document.querySelectorAll('[data-desktop-nav]').forEach(a => a.classList.toggle('active', a.dataset.desktopNav === (p0 || 'home')));

    try {
      if (!p0) await vHome(view);
      else if (p0 === 'category' && p1) await vCategory(view, p1);
      else if (p0 === 'service' && p1) await vService(view, p1);
      else if (p0 === 'cart') await vCart(view);
      else if (p0 === 'checkout') await vCheckout(view);
      else if (p0 === 'orders') await vOrders(view);
      else if (p0 === 'order' && p1) await vOrderDetail(view, p1);
      else if (p0 === 'login') vLogin(view);
      else if (p0 === 'signup') vSignup(view);
      else if (p0 === 'account') await vAccount(view);
      else if (p0 === 'search') await vSearch(view, params.q || '');
      else vNotFound(view);
    } catch (e) {
      view.innerHTML = `<div class="page"><div class="empty"><p>Something went wrong.</p><small>${esc(e.message)}</small></div></div>`;
    }
    window.scrollTo({ top: 0 });
  }

  /* ---------------- shared widgets ---------------- */
  function serviceCard(s) {
    const v = s.variations_app_format && s.variations_app_format.zone_wise_variations || [];
    const price = v.length ? Math.min(...v.map(x => Number(x.price) || 0)) : Number(s.min_bidding_price || 0);
    const priceLabel = price > 0 ? money(price) : 'Get a quote';
    const rate = Number(s.avg_rating || 0);
    return `
      <a class="scard" href="#/service/${esc(s.slug)}">
        <div class="scard__img"><img src="${img(s.thumbnail_full_path)}" alt="${esc(s.name)}" loading="lazy" onerror="this.onerror=null;this.src='/landing/images/logo-black.png'"></div>
        <div class="scard__body">
          <h4>${esc(s.name)}</h4>
          <p>${esc(s.short_description || '')}</p>
          <div class="scard__foot">
            <span class="price">${priceLabel}</span>
            ${rate ? `<span class="rate">★ ${rate.toFixed(1)}</span>` : ''}
          </div>
        </div>
      </a>`;
  }

  function section(title, items, more) {
    if (!items || !items.length) return '';
    return `
      <section class="section">
        <div class="section__head"><h2>${esc(title)}</h2>${more ? `<a href="${esc(more)}">See all ›</a>` : ''}</div>
        <div class="hscroll">${items.map(serviceCard).join('')}</div>
      </section>`;
  }

  /* ---------------- views ---------------- */
  async function vHome(view) {
    view.innerHTML = `<div class="page"><div class="skeletons">${'<div class="skel"></div>'.repeat(3)}</div></div>`;
    const cfg = state.config || {};
    let cats = [], popular = [], deals = [];
    try { const r = await API.getCategories(); if (ok(r)) cats = (r.content && r.content.data) || []; } catch (e) {}
    try { const r = await API.getPopular(); if (ok(r)) popular = (r.content && (r.content.data || r.content.serviceList)) || []; } catch (e) {}
    try { const r = await API.getDeals(); if (ok(r)) deals = (r.content && (r.content.data || r.content.serviceList)) || []; } catch (e) {}

    view.innerHTML = `
      <div class="page">
        <section class="hero">
          <div class="hero__copy">
            <span class="hero__eyebrow"><span class="hero__dot"></span> HOME SERVICES, MADE SIMPLE</span>
            <h1>Good help.<br><em>Right at home.</em></h1>
            <p>Book trusted professionals for the jobs that make your home feel like yours.</p>
            <a class="btn btn--primary" href="#categories">Explore services <span aria-hidden="true">→</span></a>
            <div class="hero__proof"><span class="hero__proof-icon">✓</span> Reliable local professionals <span class="hero__proof-sep">·</span> Clear, upfront pricing</div>
          </div>
          <div class="hero__visual" aria-hidden="true">
            <div class="hero__orb hero__orb--one"></div><div class="hero__orb hero__orb--two"></div>
            <div class="hero__home"><span class="hero__home-roof"></span><span class="hero__home-body"><i></i><i></i><b></b></span></div>
            <div class="hero__float hero__float--top"><span>✦</span><div><strong>Home, sorted.</strong><small>One booking away</small></div></div>
            <div class="hero__float hero__float--bottom"><span class="hero__check">✓</span><div><strong>Trusted service</strong><small>Made for your home</small></div></div>
          </div>
        </section>

        <section class="section" id="categories">
          <div class="section__head"><div><span class="section__eyebrow">WHAT CAN WE HELP WITH?</span><h2>Services for every corner</h2></div></div>
          ${cats.length ? `<div class="catgrid">
            ${cats.map(c => `
              <a class="cat" href="#/category/${esc(c.slug)}">
                <span class="cat__img"><img src="${img(c.image_full_path || c.thumbnailFullPath)}" alt="${esc(c.name)}" loading="lazy" onerror="this.onerror=null;this.src='/landing/images/logo-black.png'"></span>
                <span class="cat__name">${esc(c.name)}</span>
                <span class="cat__arrow" aria-hidden="true">↗</span>
              </a>`).join('')}
          </div>` : `<div class="empty empty--compact"><p>Services are getting ready</p><span>Try again in a little while, or explore our popular services below.</span></div>`}
        </section>

        ${section('Popular services', popular)}
        ${section('Deals for you', deals)}

        <section class="trustbar">
          <div><span class="trustbar__icon">✓</span><span><strong>Trusted professionals</strong><small>People you can feel good about inviting in</small></span></div>
          <div><span class="trustbar__icon">₹</span><span><strong>Clear pricing</strong><small>Know what to expect before you book</small></span></div>
          <div><span class="trustbar__icon">↻</span><span><strong>Booking made easy</strong><small>Get the help you need, on your schedule</small></span></div>
        </section>
        <footer class="site-footer"><span>Jass Booking</span><span>Thoughtful help for a happier home.</span></footer>
      </div>`;

    const hero = view.querySelector('.hero a');
    if (hero) hero.onclick = (e) => { e.preventDefault(); view.querySelector('#categories').scrollIntoView({ behavior: 'smooth' }); };
  }

  async function vCategory(view, slug) {
    view.innerHTML = `<div class="page"><div class="skeletons">${'<div class="skel"></div>'.repeat(3)}</div></div>`;
    let subs = [], active = null, page = 1, all = [];

    const r = await API.getSubgroups(slug);
    subs = ok(r) ? ((r.content && r.content.data) || []) : [];
    if (!subs.length) { view.innerHTML = `<div class="page"><div class="empty">No services in this category yet.</div></div>`; return; }
    active = subs[0].slug;

    async function load() {
      const res = await API.getServices(active, page);
      const list = ok(res) ? ((res.content && (res.content.data || res.content.serviceList)) || []) : [];
      all = page === 1 ? list : all.concat(list);
      return list;
    }

    function render() {
      view.innerHTML = `
        <div class="page">
          <div class="chips">${subs.map(s => `<button class="chip ${s.slug === active ? 'chip--on' : ''}" data-slug="${esc(s.slug)}">${esc(s.name)}</button>`).join('')}</div>
          <div class="grid" id="svc-grid">${all.map(serviceCard).join('')}</div>
          <div class="loadmore"><button class="btn btn--ghost" id="more">Load more</button></div>
        </div>`;
      view.querySelectorAll('.chip').forEach(c => c.onclick = async () => {
        active = c.dataset.slug; page = 1; await load(); render();
      });
      $('#more').onclick = async () => {
        page += 1;
        const list = await load();
        if (!list.length) { toast('No more services'); $('#more').disabled = true; return; }
        $('#svc-grid').insertAdjacentHTML('beforeend', list.map(serviceCard).join(''));
      };
    }

    await load();
    render();
  }

  async function vService(view, slug) {
    view.innerHTML = `<div class="page"><div class="skeletons">${'<div class="skel"></div>'.repeat(3)}</div></div>`;
    const res = await API.getServiceDetail(slug);
    if (!ok(res) || !res.content) { view.innerHTML = `<div class="page"><div class="empty">Service not found.</div></div>`; return; }
    const s = res.content;
    const variants = (s.variations_app_format && s.variations_app_format.zone_wise_variations) || [];
    let vIndex = 0, qty = 1;

    view.innerHTML = `
      <div class="page sd">
        <div class="sd__media"><img src="${img(s.cover_image_full_path || s.thumbnail_full_path)}" alt="${esc(s.name)}" onerror="this.onerror=null;this.src='/landing/images/logo-black.png'"></div>
        <div class="sd__head">
          <h1>${esc(s.name)}</h1>
          <p>${esc(s.short_description || '')}</p>
          ${Number(s.avg_rating) ? `<span class="rate rate--lg">★ ${Number(s.avg_rating).toFixed(1)} (${s.rating_count || 0})</span>` : ''}
        </div>
        ${variants.length ? `
        <div class="block">
          <h3>Choose what you need</h3>
          <div class="variants">${variants.map((v, i) => `
            <label class="variant ${i === 0 ? 'on' : ''}" data-i="${i}">
              <input type="radio" name="variant" ${i === 0 ? 'checked' : ''}>
              <span class="variant__name">${esc(v.variant_name || v.variant_key)}</span>
              <span class="variant__price">${money(v.price)}</span>
            </label>`).join('')}</div>
        </div>` : ''}
        <div class="block">
          <h3>Quantity</h3>
          <div class="stepper">
            <button id="q-dec">−</button><span id="q-val">1</span><button id="q-inc">+</button>
          </div>
        </div>
        ${s.description ? `<div class="block"><h3>Details</h3><div class="prose">${s.description}</div></div>` : ''}
        ${(s.faqs && s.faqs.length) ? `<div class="block"><h3>FAQs</h3>${s.faqs.map(f => `
          <details class="faq"><summary>${esc(f.question || '')}</summary><p>${esc(f.answer || '')}</p></details>`).join('')}</div>` : ''}
        <div class="buybar">
          <div class="buybar__price" id="total-price"></div>
          <button class="btn btn--primary" id="add-cart">Add to cart</button>
        </div>
      </div>`;

    const currentPrice = () => variants.length ? Number(variants[vIndex].price || 0) : Number(s.min_bidding_price || 0);
    const renderPrice = () => { $('#total-price').textContent = money(currentPrice() * qty) + (qty > 1 ? ` (${money(currentPrice())} × ${qty})` : ''); };
    renderPrice();

    view.querySelectorAll('.variant').forEach(l => l.onclick = () => {
      vIndex = Number(l.dataset.i);
      view.querySelectorAll('.variant').forEach(x => x.classList.remove('on'));
      l.classList.add('on');
      renderPrice();
    });
    $('#q-dec').onclick = () => { if (qty > 1) { qty--; $('#q-val').textContent = qty; renderPrice(); } };
    $('#q-inc').onclick = () => { qty++; $('#q-val').textContent = qty; renderPrice(); };

    $('#add-cart').onclick = async () => {
      const v = variants[vIndex] || {};
      try {
        const res2 = await API.addToCart({
          service_id: s.id,
          category_id: s.category_id,
          sub_category_id: s.sub_category_id,
          variant_key: v.variant_key || '',
          quantity: String(qty),
        });
        if (ok(res2)) {
          const added = await API.getCart().catch(() => null);
          const cartItems = added && added.content && added.content.cart && added.content.cart.data;
          state.cartCount = Array.isArray(cartItems)
            ? cartItems.reduce((sum, item) => sum + (Number(item.quantity) || 0), 0)
            : state.cartCount + qty;
          refreshBadge();
          toast('Added to cart', 'success');
        } else {
          toast(res2.message || 'Could not add to cart', 'error');
        }
      } catch (e) { toast(e.message, 'error'); }
    };
  }

  async function vCart(view) {
    view.innerHTML = `<div class="page"><div class="skeletons">${'<div class="skel"></div>'.repeat(3)}</div></div>`;
    const res = await API.getCart();
    if (!ok(res)) { view.innerHTML = `<div class="page"><div class="empty">Cart nahi load hui — ${esc(res.message || 'try again')}</div></div>`; return; }
    const items = (res.content && res.content.cart && res.content.cart.data) || [];
    if (!items.length) {
      view.innerHTML = `<div class="page"><div class="empty"><p>Your cart is empty.</p><a class="btn btn--primary" href="#/">Browse services</a></div></div>`;
      return;
    }
    const bill = res.content || {};

    view.innerHTML = `
      <div class="page">
        <h1 class="pagetitle">Your cart</h1>
        <div class="cartlist">
          ${items.map(i => `
            <div class="citem" data-id="${esc(i.id)}">
              <img class="citem__img" src="${img(i.service && i.service.thumbnail_full_path)}" alt="" onerror="this.onerror=null;this.src='/landing/images/logo-black.png'">
              <div class="citem__body">
                <h4>${esc(i.service && i.service.name || '')}</h4>
                <p>${esc((i.variant_key || '').replaceAll('-', ' '))}</p>
                <div class="citem__row">
                  <span class="price">${money(i.total_cost)}</span>
                  <div class="stepper stepper--sm">
                    <button data-act="dec" data-id="${esc(i.id)}" data-q="${Math.max(1, (i.quantity || 1) - 1)}">−</button>
                    <span>${i.quantity || 1}</span>
                    <button data-act="inc" data-id="${esc(i.id)}" data-q="${(i.quantity || 1) + 1}">+</button>
                  </div>
                </div>
              </div>
              <button class="citem__del" data-act="del" data-id="${esc(i.id)}" aria-label="Remove">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 6h18M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2m3 0v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"/></svg>
              </button>
            </div>`).join('')}
        </div>
        <div class="bill">
          <div><span>Total</span><strong>${money(bill.total_cost)}</strong></div>
        </div>
        <div class="page__cta">
          <button class="btn btn--ghost" id="wipe">Clear cart</button>
          <button class="btn btn--primary btn--block" id="to-checkout">Continue to checkout</button>
        </div>
      </div>`;

    view.querySelectorAll('[data-act]').forEach(b => b.onclick = async () => {
      const { act, id, q } = b.dataset;
      try {
        if (act === 'del') await API.removeCartItem(id);
        else if (act === 'wipe') await API.wipeCart();
        else await API.updateQty(id, Number(q));
        await vCart(view);
        const cnt = await API.getCart();
        const n = ((cnt.content && cnt.content.cart && cnt.content.cart.data) || []).reduce((s, x) => s + (Number(x.quantity) || 0), 0);
        state.cartCount = n; refreshBadge();
      } catch (e) { toast(e.message, 'error'); }
    });
    $('#to-checkout').onclick = () => location.hash = '#/checkout';
    $('#wipe').onclick = async () => { try { await API.wipeCart(); state.cartCount = 0; refreshBadge(); vCart(view); } catch (e) { toast(e.message, 'error'); } };
  }

  async function vCheckout(view) {
    view.innerHTML = `<div class="page"><div class="skeletons">${'<div class="skel"></div>'.repeat(3)}</div></div>`;

    /* cart must exist */
    const cartRes = await API.getCart();
    const items = (cartRes.content && cartRes.content.cart && cartRes.content.cart.data) || [];
    if (!items.length) { location.hash = '#/cart'; return; }

    /* saved addresses */
    let addresses = [];
    try { const r = await API.getAddresses(); if (ok(r)) addresses = (r.content && (r.content.data || r.content.addresses)) || []; } catch (e) {}
    let selected = addresses[0] || null;

    /* payment config */
    let payCfg = {};
    try { const r = await API.paymentConfig(''); if (ok(r)) payCfg = r.content || {}; } catch (e) {}
    const codOk = payCfg.cash_after_service === undefined ? true : !!Number(payCfg.cash_after_service);

    let schedule = null; // null = ASAP

    view.innerHTML = `
      <div class="page">
        <h1 class="pagetitle">Checkout</h1>

        <div class="block">
          <h3>Service address</h3>
          <div id="addr-list">${addresses.map((a, i) => `
            <label class="sel ${i === 0 ? 'on' : ''}" data-i="${i}">
              <input type="radio" name="addr" ${i === 0 ? 'checked' : ''}>
              <div><strong>${esc(a.contact_person_name || a.address_label || 'Address')}</strong><p>${esc(a.address || '')}</p></div>
            </label>`).join('')}</div>
          <button class="btn btn--ghost btn--block" id="add-addr">+ Add new address</button>
        </div>

        <div class="block">
          <h3>Schedule</h3>
          <div class="chips" id="sched-chips">
            <button class="chip chip--on" data-s="asap">As soon as possible</button>
            <button class="chip" data-s="custom">Schedule for later</button>
          </div>
          <div id="sched-custom" hidden>
            <label class="field-label" for="sched-date">Choose a date</label>
            <input class="input" type="date" id="sched-date">
            <label class="field-label" for="sched-time">Choose a time</label>
            <input class="input" type="time" id="sched-time">
          </div>
        </div>

        <div class="block">
          <h3>Coupon</h3>
          <div class="inline-form">
            <input class="input" id="coupon-code" placeholder="Coupon code">
            <button class="btn btn--ghost" id="apply-coupon">Apply</button>
          </div>
          <p class="hint" id="coupon-msg"></p>
        </div>

        <div class="block">
          <h3>Payment</h3>
          <label class="sel on"><input type="radio" name="pay" checked><div><strong>Cash after service</strong><p>Pay when the job is done</p></div></label>
          <p class="hint">Pay your professional after the service is complete.</p>
        </div>

        <div class="bill">
          <div><span>To pay</span><strong>${money(cartRes.content && cartRes.content.total_cost)}</strong></div>
        </div>
        <div class="page__cta">
          <button class="btn btn--primary btn--block" id="place" ${codOk ? '' : 'disabled'}>Place booking</button>
        </div>
      </div>`;

    $('#sched-date').min = new Date().toISOString().slice(0, 10);

    /* address selection */
    view.querySelectorAll('.sel[data-i]').forEach(l => l.onclick = () => {
      view.querySelectorAll('.sel[data-i]').forEach(x => x.classList.remove('on'));
      l.classList.add('on');
      selected = addresses[Number(l.dataset.i)];
    });
    $('#add-addr').onclick = () => addressForm(async (model) => {
      const res = await API.addAddress(model);
      if (ok(res)) { closeSheet(); toast('Address saved', 'success'); await vCheckout(view); }
      else toast(res.message || 'Could not save address', 'error');
    });

    /* schedule */
    view.querySelectorAll('#sched-chips .chip').forEach(c => c.onclick = () => {
      view.querySelectorAll('#sched-chips .chip').forEach(x => x.classList.remove('chip--on'));
      c.classList.add('chip--on');
      if (c.dataset.s === 'asap') { schedule = null; $('#sched-custom').hidden = true; }
      else { $('#sched-custom').hidden = false; }
    });

    /* coupon */
    $('#apply-coupon').onclick = async () => {
      const code = $('#coupon-code').value.trim();
      if (!code) return;
      try {
        const r = await API.applyCoupon(code);
        if (ok(r)) { $('#coupon-msg').textContent = 'Coupon applied ✓'; $('#coupon-msg').className = 'hint hint--ok'; }
        else { $('#coupon-msg').textContent = r.message || 'Invalid coupon'; $('#coupon-msg').className = 'hint hint--err'; }
      } catch (e) { $('#coupon-msg').textContent = e.message; $('#coupon-msg').className = 'hint hint--err'; }
    };

    /* place order */
    $('#place').onclick = async () => {
      if (!selected && addresses.length === 0 && !state.address) {
        toast('Please add a service address', 'error');
        return;
      }
      let sched = null;
      if ($('#sched-custom').hidden === false) {
        const d = $('#sched-date').value, t = $('#sched-time').value;
        if (!d || !t) { toast('Pick date and time', 'error'); return; }
        const chosen = new Date(d + 'T' + t);
        if (Number.isNaN(chosen.getTime()) || chosen.getTime() <= Date.now()) { toast('Choose a future date and time', 'error'); return; }
        sched = d + ' ' + (t.length === 5 ? t + ':00' : t);
      } else {
        // ASAP — backend requires a schedule for regular service; send now + 30 min
        const now = new Date(Date.now() + 30 * 60000);
        const pad = (n) => String(n).padStart(2, '0');
        sched = now.getFullYear() + '-' + pad(now.getMonth() + 1) + '-' + pad(now.getDate()) + ' ' + pad(now.getHours()) + ':' + pad(now.getMinutes()) + ':00';
      }

      const addr = selected || state.address;
      const addressModel = {
        id: addr && addr.id || null,
        address_type: addr && addr.address_type || 'service',
        address_label: addr && (addr.address_label || 'home') || 'home',
        contact_person_name: addr && addr.contact_person_name || '',
        contact_person_number: addr && addr.contact_person_number || '',
        address: addr && addr.address || '',
        lat: addr && (addr.lat || addr.latitude) || state.lat,
        lon: addr && (addr.lon || addr.longitude) || state.lng,
        city: addr && addr.city || '',
        zip_code: addr && addr.zip_code || '',
        country: addr && addr.country || '',
        zone_id: state.zoneId,
        street: addr && addr.street || '',
        house: addr && addr.house || '',
        floor: addr && addr.floor || '',
        available_service_count: addr && addr.available_service_count || null,
      };

      const btn = $('#place');
      btn.disabled = true; btn.textContent = 'Placing…';
      try {
        const res = await API.placeOrder({
          payment_method: 'cash_after_service',
          zone_id: state.zoneId,
          service_schedule: sched,
          service_address_id: (addr && addr.id && addr.id !== 'null') ? addr.id : null,
          service_address: JSON.stringify(addressModel),
          is_partial: 0,
          service_type: 'regular',
          booking_type: 'daily',
          dates: null,
          service_location: 'customer',
        });
        if (ok(res) || res.response_code === 'booking_place_success_200') {
          if (res.content && res.content.token) { state.token = res.content.token; state.user = res.content.user || null; }
          const n = await API.getCart();
          state.cartCount = ((n.content && n.content.cart && n.content.cart.data) || []).reduce((s, x) => s + (Number(x.quantity) || 0), 0);
          refreshBadge();
          const rid = res.content && (res.content.readable_id || (res.content.booking_id && res.content.booking_id[0]));
          view.innerHTML = `<div class="page"><div class="success">
            <div class="success__icon">✓</div>
            <h1>Booking placed!</h1>
            <p>Your booking ID is <strong>${esc(rid || '—')}</strong>.<br>We're assigning a professional to your job.</p>
            <a class="btn btn--primary" href="#/orders">View my bookings</a>
            <a class="btn btn--ghost" href="#/">Keep browsing</a>
          </div></div>`;
        } else {
          toast(res.message || 'Booking failed', 'error');
          btn.disabled = false; btn.textContent = 'Place booking';
        }
      } catch (e) {
        toast(e.message, 'error');
        btn.disabled = false; btn.textContent = 'Place booking';
      }
    };

    if (!codOk) { /* config says COD off — still show but warn */
      const p = view.querySelector('.block:last-of-type p.hint');
      if (p) p.textContent = 'Cash payment is unavailable right now. Please choose a different payment option in the customer app.';
    }
  }

  function addressForm(onSave) {
    openSheet(`
      <div class="sheet__head"><h3>Add address</h3><button class="iconbtn" id="sheet-close">✕</button></div>
      <div class="sheet__body">
        <input class="input" id="af-name" placeholder="Contact name">
        <input class="input" id="af-phone" placeholder="Phone number" inputmode="tel">
        <input class="input" id="af-house" placeholder="House / flat no.">
        <input class="input" id="af-street" placeholder="Street / area">
        <input class="input" id="af-address" placeholder="Full address" required>
        <input class="input" id="af-city" placeholder="City">
        <input class="input" id="af-zip" placeholder="Pincode" inputmode="numeric">
        <button class="btn btn--primary btn--block" id="af-save">Save address</button>
      </div>`);
    $('#sheet-close').onclick = closeSheet;
    $('#af-save').onclick = () => {
      const address = $('#af-address').value.trim();
      if (!address) { toast('Address is required', 'error'); return; }
      onSave({
        address_type: 'service',
        address_label: 'home',
        contact_person_name: $('#af-name').value.trim(),
        contact_person_number: $('#af-phone').value.trim(),
        address,
        lat: state.lat || '',
        lon: state.lng || '',
        city: $('#af-city').value.trim(),
        zip_code: $('#af-zip').value.trim(),
        country: '',
        zone_id: state.zoneId,
        street: $('#af-street').value.trim(),
        house: $('#af-house').value.trim(),
        floor: '',
      });
    };
  }

  async function vOrders(view) {
    view.innerHTML = `<div class="page"><div class="skeletons">${'<div class="skel"></div>'.repeat(2)}</div></div>`;
    let list = [];
    try {
      const r = await API.getOrders();
      list = ok(r) ? ((r.content && (r.content.data || r.content.orders)) || []) : [];
    } catch (e) { /* guest without bookings */ }
    if (!list.length) {
      view.innerHTML = `<div class="page"><div class="empty"><p>No bookings yet.</p><a class="btn btn--primary" href="#/">Book a service</a></div></div>`;
      return;
    }
    view.innerHTML = `
      <div class="page">
        <h1 class="pagetitle">My bookings</h1>
        <div class="orderlist">
          ${list.map(b => `
            <a class="ocard" href="#/order/${esc(b.id)}">
              <div><strong>#${esc(b.readable_id || b.id)}</strong><p>${esc((b.service_name || (b.services && b.services.map(s => s.service_name).join(', ')) || b.booking_type || ''))}</p></div>
              <div class="ocard__side">
                <span class="ostatus">${esc((b.booking_status || b.status || '').replaceAll('_', ' '))}</span>
                <span class="price">${money(b.total_amount || b.total_cost)}</span>
              </div>
            </a>`).join('')}
        </div>
      </div>`;
  }

  async function vOrderDetail(view, id) {
    view.innerHTML = `<div class="page"><div class="skeletons">${'<div class="skel"></div>'.repeat(2)}</div></div>`;
    let b = null;
    try {
      const r = await API.getOrderDetails(id);
      if (ok(r)) b = r.content;
    } catch (e) {}
    if (!b) { view.innerHTML = `<div class="page"><div class="empty">Booking details nahi mile.</div></div>`; return; }
    const main = b.booking || b;
    view.innerHTML = `
      <div class="page">
        <h1 class="pagetitle">Booking #${esc(main.readable_id || main.id)}</h1>
        <div class="block"><h3>Status</h3><span class="ostatus">${esc((main.booking_status || main.status || '').replaceAll('_', ' '))}</span></div>
        <div class="block"><h3>Amount</h3><span class="price price--lg">${money(main.total_amount || main.total_cost)}</span></div>
        ${(main.service_address || main.address) ? `<div class="block"><h3>Address</h3><p>${esc(typeof (main.service_address || main.address) === 'string' ? (main.service_address || main.address) : (main.service_address || main.address).address || '')}</p></div>` : ''}
        ${(main.services || []).length ? `<div class="block"><h3>Services</h3>${main.services.map(s => `<p>${esc(s.service_name || s.name || '')} × ${esc(s.quantity || 1)} — ${money(s.total_cost || s.service_cost)}</p>`).join('')}</div>` : ''}
        <div class="page__cta"><a class="btn btn--ghost" href="#/orders">← All bookings</a></div>
      </div>`;
  }

  /* ---------------- auth ---------------- */
  function vLogin(view) {
    view.innerHTML = `
      <div class="page page--narrow">
        <h1 class="pagetitle">Welcome back</h1>
        <div class="block">
          <input class="input" id="lg-phone" placeholder="Phone number" inputmode="tel">
          <input class="input" id="lg-pass" type="password" placeholder="Password">
          <button class="btn btn--primary btn--block" id="lg-go">Log in</button>
          <p class="hint">New here? <a href="#/signup">Create an account</a></p>
        </div>
      </div>`;
    $('#lg-go').onclick = async () => {
      const phone = $('#lg-phone').value.trim(), pass = $('#lg-pass').value;
      if (!phone || !pass) { toast('Phone and password required', 'error'); return; }
      try {
        const r = await API.signin(phone, pass, 'phone');
        if (ok(r) && r.content) {
          state.token = r.content.token || '';
          state.user = r.content.user || null;
          toast('Welcome, ' + ((r.content.user && r.content.user.first_name) || '') , 'success');
          renderChrome();
          location.hash = '#/';
        } else toast(r.message || 'Login failed', 'error');
      } catch (e) { toast(e.message, 'error'); }
    };
  }

  function vSignup(view) {
    view.innerHTML = `
      <div class="page page--narrow">
        <h1 class="pagetitle">Create account</h1>
        <div class="block">
          <input class="input" id="su-fn" placeholder="First name">
          <input class="input" id="su-ln" placeholder="Last name">
          <input class="input" id="su-phone" placeholder="Phone number" inputmode="tel">
          <input class="input" id="su-email" placeholder="Email (optional)">
          <input class="input" id="su-pass" type="password" placeholder="Password">
          <input class="input" id="su-pass2" type="password" placeholder="Confirm password">
          <button class="btn btn--primary btn--block" id="su-go">Sign up</button>
          <p class="hint">Already have an account? <a href="#/login">Log in</a></p>
        </div>
      </div>`;
    $('#su-go').onclick = async () => {
      const body = {
        first_name: $('#su-fn').value.trim(),
        last_name: $('#su-ln').value.trim(),
        phone: $('#su-phone').value.trim(),
        email: $('#su-email').value.trim(),
        password: $('#su-pass').value,
        confirm_password: $('#su-pass2').value,
      };
      if (!body.first_name || !body.phone || !body.password) { toast('Name, phone and password required', 'error'); return; }
      if (body.password !== body.confirm_password) { toast('Passwords do not match', 'error'); return; }
      try {
        const r = await API.signup(body);
        if (ok(r) && r.content) {
          state.token = r.content.token || '';
          state.user = r.content.user || null;
          toast('Account created', 'success');
          renderChrome();
          location.hash = '#/';
        } else toast(r.message || 'Signup failed', 'error');
      } catch (e) { toast(e.message, 'error'); }
    };
  }

  async function vAccount(view) {
    if (!state.token) { location.hash = '#/login'; return; }
    let user = state.user;
    try { const r = await API.profile(); if (ok(r)) user = r.content || user; } catch (e) {}
    view.innerHTML = `
      <div class="page page--narrow">
        <h1 class="pagetitle">Account</h1>
        <div class="block">
          <div class="profile">
            <div class="profile__avatar">${esc(((user && user.first_name) || 'U').charAt(0).toUpperCase())}</div>
            <div><strong>${esc((user && user.first_name) || '')} ${esc((user && user.last_name) || '')}</strong><p>${esc((user && user.phone) || '')}</p></div>
          </div>
        </div>
        <div class="block">
          <a class="menurow" href="#/orders"><span>My bookings</span>›</a>
          <a class="menurow" href="#/cart"><span>Cart</span>›</a>
        </div>
        <button class="btn btn--ghost btn--block" id="signout">Log out</button>
      </div>`;
    $('#signout').onclick = async () => {
      try { await API.signout(); } catch (e) {}
      state.token = ''; state.user = null;
      renderChrome();
      location.hash = '#/';
    };
  }

  async function vSearch(view, q) {
    if (!q) { location.hash = '#/'; return; }
    view.innerHTML = `<div class="page"><div class="skeletons">${'<div class="skel"></div>'.repeat(2)}</div></div>`;
    let list = [];
    try { const r = await API.search(q); if (ok(r)) list = (r.content && (r.content.data || r.content.serviceList)) || []; } catch (e) {}
    view.innerHTML = `
      <div class="page">
        <h1 class="pagetitle">Results for “${esc(q)}”</h1>
        ${list.length ? `<div class="grid">${list.map(serviceCard).join('')}</div>` : `<div class="empty">Kuch nahi mila. Try a different search.</div>`}
      </div>`;
  }

  function vNotFound(view) {
    view.innerHTML = `<div class="page"><div class="empty"><p>Page not found.</p><a class="btn btn--primary" href="#/">Go home</a></div></div>`;
  }

  return { boot };
})();

App.boot();
