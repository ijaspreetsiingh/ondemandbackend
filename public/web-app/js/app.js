/* ============================================================
 * Jass Booking — web app shell
 * Boot, chrome (header / footer / bottom nav), hash router, location picker.
 * ============================================================ */
'use strict';

const App = (() => {
  const { state } = API;
  const { $, $$, esc, icon, toast, openSheet, closeSheet } = UI;

  let booted = false;
  let currentRoute = '';

  /* ---------------- boot ---------------- */
  async function boot() {
    try {
      const res = await API.getConfig();
      if (!API.ok(res)) throw new Error((res && res.message) || 'Could not load app configuration');
      state.config = res.content;

      const maintenance = res.content && res.content.maintenance;
      const webDown = maintenance && Number(maintenance.maintenance_status) === 1 &&
        maintenance.selected_maintenance_system && Number(maintenance.selected_maintenance_system.web_app) === 1;
      if (webDown) {
        showMaintenance(maintenance);
        return;
      }
    } catch (e) {
      $('#boot').innerHTML = `<div class="boot-inner">
        <img class="boot-logo" src="/landing/images/logo-black.png" alt="">
        <h2 class="boot-title">We couldn't reach the server</h2>
        <p class="boot-err">${esc(e.message)}</p>
        <button class="btn btn--primary" onclick="location.reload()">Try again</button>
      </div>`;
      return;
    }

    $('#boot').remove();
    $('#app').hidden = false;
    renderChrome();
    bindGlobalEvents();
    if (state.token) API.refreshCartCount();
    else API.refreshCartCount();
    route();
    window.addEventListener('hashchange', route);
    booted = true;
  }

  function showMaintenance(maintenance) {
    const msg = (maintenance.maintenance_messages && maintenance.maintenance_messages.message_body) ||
      'We are performing scheduled maintenance. Please check back shortly.';
    const title = (maintenance.maintenance_messages && maintenance.maintenance_messages.maintenance_message) ||
      'Be back soon';
    document.getElementById('boot').innerHTML = `<div class="boot-inner maintenance">
      <img class="boot-logo" src="${esc((state.config && state.config.logo_full_path) || '/landing/images/logo-black.png')}" alt="">
      <h2 class="boot-title">${esc(title)}</h2>
      <p class="boot-err">${esc(msg)}</p>
      <button class="btn btn--ghost" onclick="location.reload()">Refresh</button>
    </div>`;
  }

  /* ---------------- chrome ---------------- */
  function logo() {
    const cfg = state.config || {};
    return `<img src="${esc(UI.imgSrc(cfg.logo_full_path))}" alt="${esc(cfg.business_name || 'Jass Booking')}" class="brand__img">`;
  }

  function renderChrome() {
    const cfg = state.config || {};
    const user = state.user;
    const addr = state.address;
    const locLabel = addr ? (addr.address || '').split(',')[0] || 'Your location' : 'Set location';
    const loggedIn = !!state.token;

    $('#topbar').innerHTML = `
      <div class="topbar__inner">
        <a class="brand" href="#/" aria-label="${esc(cfg.business_name || 'Jass Booking')} home">
          ${logo()}
          <span class="brand__name">${esc(cfg.business_name || 'Jass Booking')}</span>
        </a>

        <button class="locbtn" id="loc-chip" type="button">
          ${icon('pin', 15)}
          <span class="locbtn__text"><small>Service location</small><b>${esc(locLabel)}</b></span>
          ${icon('chevronDown', 13)}
        </button>

        <nav class="mainnav" aria-label="Primary">
          <a href="#/" data-nav="home">Explore</a>
          <a href="#/categories" data-nav="categories">Services</a>
          <a href="#/offers" data-nav="offers">Offers</a>
          <a href="#/orders" data-nav="orders">My bookings</a>
          <a href="#/support" data-nav="support">Support</a>
        </nav>

        <form class="searchbar" id="search-form" role="search">
          ${icon('search', 16)}
          <input type="search" name="q" placeholder="Search for a service…" aria-label="Search services" autocomplete="off">
        </form>

        <div class="topbar__actions">
          <a class="iconbtn iconbtn--badge" href="#/cart" aria-label="Cart">
            ${icon('cart', 20)}<span class="badge" id="cart-badge" ${state.cartCount ? '' : 'hidden'}>${state.cartCount}</span>
          </a>
          ${loggedIn
            ? `<a class="avatar" href="#/account" aria-label="Your account" title="${esc((user && user.first_name) || 'Account')}">${esc(UI.initials(user && user.first_name, user && user.last_name))}</a>`
            : `<a class="btn btn--ghost btn--sm" href="#/login">Sign in</a>`}
        </div>
      </div>`;

    $('#bottomnav').innerHTML = `
      <a href="#/" data-nav="home">${icon('home', 20)}<span>Home</span></a>
      <a href="#/categories" data-nav="categories">${icon('grid', 20)}<span>Services</span></a>
      <a href="#/cart" data-nav="cart" class="bottomnav__cart">${icon('cart', 20)}<span>Cart</span><i class="badge" id="cart-badge-m" ${state.cartCount ? '' : 'hidden'}>${state.cartCount}</i></a>
      <a href="#/orders" data-nav="orders">${icon('calendar', 20)}<span>Bookings</span></a>
      <a href="${loggedIn ? '#/account' : '#/login'}" data-nav="account">${icon('user', 20)}<span>Account</span></a>`;

    $('#loc-chip').onclick = openLocationSheet;
    const form = $('#search-form');
    form.onsubmit = (e) => {
      e.preventDefault();
      const q = form.querySelector('input').value.trim();
      if (q) location.hash = '#/search?q=' + encodeURIComponent(q);
    };
    const searchInput = form.querySelector('input');
    searchInput.onfocus = showSearchSuggestions;
    renderFooter();
    syncBadges();
  }

  function renderFooter() {
    const host = $('#sitefooter');
    if (!host) return;
    const cfg = state.config || {};
    const social = (cfg.social_media || []).filter(s => Number(s.status) === 1);
    host.innerHTML = `<div class="sitefooter__inner">
      <div class="sitefooter__brand">
        ${logo()}
        <p>Thoughtful help for a happier home. Verified professionals, upfront prices and service you can rely on.</p>
        ${social.length ? `<div class="socials">${social.map(s => `<a class="social" href="${esc(s.link)}" target="_blank" rel="noopener">${esc(UI.titleCase(s.media))}</a>`).join('')}</div>` : ''}
      </div>
      <div class="sitefooter__col">
        <h4>Explore</h4>
        <a href="#/">Home</a>
        <a href="#/categories">All services</a>
        <a href="#/offers">Offers &amp; coupons</a>
        <a href="#/track">Track a booking</a>
      </div>
      <div class="sitefooter__col">
        <h4>Your account</h4>
        <a href="#/orders">My bookings</a>
        <a href="#/favorites">Saved services</a>
        <a href="#/account/addresses">Saved addresses</a>
        <a href="#/notifications">Notifications</a>
      </div>
      <div class="sitefooter__col">
        <h4>Company</h4>
        <a href="#/pages/about_us">About us</a>
        <a href="#/pages/terms_and_conditions">Terms &amp; conditions</a>
        <a href="#/pages/privacy_policy">Privacy policy</a>
        <a href="#/pages/cancellation_policy">Cancellation policy</a>
        <a href="#/become-a-provider">Become a provider</a>
      </div>
      <div class="sitefooter__col">
        <h4>Contact</h4>
        ${cfg.business_phone ? `<a href="tel:${esc(cfg.business_phone)}">${esc(cfg.business_phone)}</a>` : ''}
        ${cfg.business_email ? `<a href="mailto:${esc(cfg.business_email)}">${esc(cfg.business_email)}</a>` : ''}
        ${cfg.business_address ? `<span>${esc(cfg.business_address)}</span>` : ''}
        <a href="#/support">Help &amp; support</a>
      </div>
    </div>
    <div class="sitefooter__base">
      <span>${esc(cfg.footer_text || ('© ' + new Date().getFullYear() + ' ' + (cfg.business_name || 'Jass Booking')))}</span>
      <span>Made for homes that deserve better.</span>
    </div>`;
  }

  function syncBadges() {
    $$('#cart-badge, #cart-badge-m').forEach(b => {
      b.textContent = state.cartCount;
      b.hidden = !state.cartCount;
    });
    $$('[data-nav]').forEach(a => {
      const key = a.dataset.nav;
      const path = routeKey();
      const active = key === 'home' ? (path === 'home')
        : key === 'categories' ? (path === 'categories' || path === 'category' || path === 'service')
        : key === 'cart' ? (path === 'cart' || path === 'checkout')
        : key === 'orders' ? (path === 'orders' || path === 'order')
        : key === 'account' ? (path.startsWith('account') || path === 'login' || path === 'signup')
        : path === key;
      a.classList.toggle('is-active', active);
    });
  }

  function refreshChrome() {
    renderChrome();
  }

  function onCartChanged() {
    syncBadges();
  }

  /* ---------------- search suggestions ---------------- */
  let suggestionBox = null;
  let hintTimer = null;
  async function showSearchSuggestions() {
    const form = $('#search-form');
    if (!form) return;
    if (!suggestionBox) {
      suggestionBox = UI.el(`<div class="searchpop" id="searchpop"></div>`);
      form.appendChild(suggestionBox);
      document.addEventListener('click', (e) => {
        if (suggestionBox && !form.contains(e.target)) suggestionBox.classList.remove('is-open');
      });
    }
    try {
      const res = await API.searchHints();
      const list = (res && res.content) || [];
      const base = Array.isArray(list) ? list : [];
      suggestionBox.innerHTML = base.slice(0, 8).map(item => `
        <button type="button" class="searchpop__item" data-q="${esc(item.name || item)}">
          ${icon('search', 14)} <span>${esc(item.name || item)}</span>
        </button>`).join('');
      $$('.searchpop__item', suggestionBox).forEach(btn => {
        btn.onclick = () => {
          location.hash = '#/search?q=' + encodeURIComponent(btn.dataset.q);
          suggestionBox.classList.remove('is-open');
          form.querySelector('input').value = btn.dataset.q;
        };
      });
      suggestionBox.classList.add('is-open');
    } catch (e) { /* hints are optional */ }
    form.querySelector('input').oninput = (e) => {
      clearTimeout(hintTimer);
      const q = e.target.value.trim();
      if (q.length < 2) return;
      hintTimer = setTimeout(async () => {
        try {
          const r = await API.searchHints(q);
          const items = ((r && r.content) || []).slice(0, 6);
          if (!items.length) return;
          suggestionBox.innerHTML = items.map(item => `
            <button type="button" class="searchpop__item" data-q="${esc(item.name || item)}">
              ${icon('search', 14)} <span>${esc(item.name || item)}</span>
            </button>`).join('');
          $$('.searchpop__item', suggestionBox).forEach(btn => {
            btn.onclick = () => {
              location.hash = '#/search?q=' + encodeURIComponent(btn.dataset.q);
              suggestionBox.classList.remove('is-open');
            };
          });
          suggestionBox.classList.add('is-open');
        } catch (err) { /* ignore */ }
      }, 280);
    };
  }

  /* ---------------- location ---------------- */
  let mapInstance = null;
  let mapMarker = null;
  let mapPicked = { lat: null, lng: null, label: '' };

  function openLocationSheet() {
    const body = openSheet(`
      <div class="sheet__head">
        <div><span class="eyebrow">Where do you need help?</span><h3>Set your location</h3></div>
        <button class="iconbtn" data-close aria-label="Close">${icon('close', 18)}</button>
      </div>
      <div class="sheet__body">
        <div class="locmap-wrap" id="locmap-wrap">
          <div id="locmap" class="locmap"></div>
        </div>
        <div class="locform">
          <button class="btn btn--primary btn--block" id="use-gps">${icon('pin', 16)} Use my current location</button>
          <div class="or-row"><span>or search your area</span></div>
          <label class="searchfield">
            ${icon('search', 16)}
            <input class="input" id="loc-search" type="search" placeholder="Area, city, pincode…" autocomplete="off">
          </label>
          <div class="suggestions" id="loc-suggestions"></div>
          ${state.isLoggedIn() ? `<div id="saved-locs" class="saved-locs"></div>` : ''}
          <div class="loc-actions" id="loc-actions" hidden>
            <p class="loc-hint">Tap anywhere on the map to pick your exact spot</p>
            <button class="btn btn--primary btn--block" id="use-map-pick">${icon('mapPin', 16)} Use this location</button>
          </div>
        </div>
      </div>`);
    body.querySelector('[data-close]').onclick = () => { cleanupMap(); closeSheet(); };
    body.querySelector('#use-gps').onclick = useGps;
    body.querySelector('#use-map-pick').onclick = useMapPick;

    /* initialise map once the sheet is in the DOM (Leaflet needs size) */
    setTimeout(() => initMap(), 50);

    const input = body.querySelector('#loc-search');
    let timer;
    input.oninput = () => {
      clearTimeout(timer);
      const q = input.value.trim();
      const box = body.querySelector('#loc-suggestions');
      if (q.length < 3) { box.innerHTML = ''; return; }
      box.innerHTML = `<div class="suggestion suggestion--muted">Searching…</div>`;
      timer = setTimeout(async () => {
        try {
          const res = await API.geoSuggest(q);
          const list = (res.content && res.content.suggestions) || [];
          if (!list.length) { box.innerHTML = `<div class="suggestion suggestion--muted">No places found</div>`; return; }
          box.innerHTML = list.map(s => {
            const p = s.placePrediction || s;
            const text = (p.text && p.text.text) || p.description || '';
            return `<button class="suggestion" data-place="${esc(p.placeId || p.place_id)}" data-text="${esc(text)}">
              ${icon('pin', 15)}<span>${esc(text)}</span></button>`;
          }).join('');
          $$('.suggestion[data-place]', box).forEach(btn => {
            btn.onclick = () => pickPlace(btn.dataset.place, btn.dataset.text);
          });
        } catch (e) {
          box.innerHTML = `<div class="suggestion suggestion--muted">${esc(e.message)}</div>`;
        }
      }, 320);
    };

    if (state.isLoggedIn()) {
      API.getAddresses().then(res => {
        const list = API.ok(res) ? ((res.content && res.content.data) || []) : [];
        const host = body.querySelector('#saved-locs');
        if (!host || !list.length) return;
        host.innerHTML = `<div class="or-row"><span>or pick a saved address</span></div>` +
          list.slice(0, 5).map(a => `<button class="suggestion" data-addr="${esc(a.id)}">
            ${icon('mapPin', 15)}<span><b>${esc(a.address_label || 'Address')}</b> — ${esc(a.address || '')}</span></button>`).join('');
        $$('[data-addr]', host).forEach(btn => {
          btn.onclick = () => {
            const addr = list.find(a => String(a.id) === String(btn.dataset.addr));
            if (addr) applyAddress(addr);
          };
        });
      }).catch(() => {});
    }
  }

  function initMap() {
    if (mapInstance) return;
    const el = $('#locmap');
    if (!el) return;
    mapInstance = L.map('locmap', { zoomControl: false, attributionControl: false }).setView([23.815, 77.201], 13);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
    }).addTo(mapInstance);
    mapMarker = L.marker([23.815, 77.201], { draggable: true }).addTo(mapInstance);
    mapInstance.on('click', (e) => {
      mapPicked = { lat: e.latlng.lat, lng: e.latlng.lng, label: '' };
      mapMarker.setLatLng([e.latlng.lat, e.latlng.lng]);
      const actions = $('#loc-actions');
      if (actions) actions.hidden = false;
    });
    mapMarker.on('dragend', (e) => {
      mapPicked = { lat: e.target.getLatLng().lat, lng: e.target.getLatLng().lng, label: '' };
      const actions = $('#loc-actions');
      if (actions) actions.hidden = false;
    });
  }

  function cleanupMap() {
    if (mapInstance) {
      try { mapInstance.remove(); } catch (e) { /* ignore */ }
      mapInstance = null;
      mapMarker = null;
    }
  }

  async function useMapPick() {
    if (!mapPicked.lat || !mapPicked.lng) return;
    try {
      const res = await API.findZone(mapPicked.lat, mapPicked.lng);
      const zone = res && res.content && res.content.zone;
      if (!zone) {
        toast('We are not serving this area yet. Try a nearby location.', 'error');
        return;
      }
      state.zoneId = zone.id;
      state.zoneName = zone.name;
      state.setCoords(mapPicked.lat, mapPicked.lng);
      state.address = {
        address: mapPicked.label || zone.name,
        lat: String(mapPicked.lat),
        lon: String(mapPicked.lng),
        zone_id: zone.id,
        address_label: 'home',
      };
      cleanupMap();
      closeSheet();
      toast('Location set to ' + (mapPicked.label || zone.name), 'success');
      refreshChrome();
      route(true);
    } catch (e) {
      toast(e.message || 'This area is not serviceable yet.', 'error');
    }
  }

  async function useGps() {
    toast('Getting your location…');
    try {
      const pos = await new Promise((resolve, reject) =>
        navigator.geolocation.getCurrentPosition(resolve, reject, { timeout: 15000, enableHighAccuracy: true }));
      await applyCoords(pos.coords.latitude, pos.coords.longitude);
    } catch (e) {
      toast('Location access was blocked. Please search your area instead.', 'error');
    }
  }

  async function pickPlace(placeId, text) {
    try {
      const res = await API.geoSpot(placeId);
      const loc = res.content && (res.content.location || res.content);
      const lat = loc && (loc.latitude || loc.lat);
      const lng = loc && (loc.longitude || loc.lng);
      if (!lat || !lng) throw new Error('We could not locate that place');
      if (mapInstance && mapMarker) {
        mapMarker.setLatLng([lat, lng]);
        mapInstance.setView([lat, lng], 15);
        mapPicked = { lat, lng, label: text || '' };
        const actions = $('#loc-actions');
        if (actions) actions.hidden = false;
      }
      await applyCoords(lat, lng, text);
    } catch (e) { toast(e.message, 'error'); }
  }

  async function applyCoords(lat, lng, label) {
    let zone = null;
    try {
      const res = await API.findZone(lat, lng);
      zone = res && res.content && res.content.zone;
      if (!zone) {
        toast('We are not serving this area yet. Try a nearby location.', 'error');
        return;
      }
    } catch (e) {
      toast(e.message || 'This area is not serviceable yet.', 'error');
      return;
    }
    state.zoneId = zone.id;
    state.zoneName = zone.name;
    state.setCoords(lat, lng);
    state.address = {
      address: label || zone.name,
      lat: String(lat),
      lon: String(lng),
      zone_id: zone.id,
      address_label: 'home',
    };
    cleanupMap();
    closeSheet();
    toast('Location set to ' + (label || zone.name), 'success');
    refreshChrome();
    route(true);
  }

  function applyAddress(addr) {
    state.zoneId = addr.zone_id || state.zoneId;
    state.setCoords(addr.lat, addr.lon);
    state.address = {
      id: addr.id,
      address: addr.address,
      lat: addr.lat,
      lon: addr.lon,
      zone_id: addr.zone_id,
      address_label: addr.address_label,
      contact_person_name: addr.contact_person_name,
      contact_person_number: addr.contact_person_number,
      city: addr.city,
      street: addr.street,
      house: addr.house,
      floor: addr.floor,
      zip_code: addr.zip_code,
      country: addr.country,
    };
    cleanupMap();
    closeSheet();
    toast('Delivering to ' + (addr.address || '').split(',')[0], 'success');
    refreshChrome();
    route(true);
  }

  /* ---------------- router ---------------- */
  function parseHash() {
    const raw = location.hash.replace(/^#\/?/, '');
    const [pathPart, queryPart] = raw.split('?');
    const parts = pathPart.split('/').filter(Boolean).map(decodeURIComponent);
    const query = {};
    if (queryPart) new URLSearchParams(queryPart).forEach((v, k) => { query[k] = v; });
    return { parts, query };
  }

  function routeKey() {
    const { parts } = parseHash();
    return parts[0] || 'home';
  }

  const TITLES = {
    home: 'Home', categories: 'Services', category: 'Category', service: 'Service', search: 'Search',
    offers: 'Offers', cart: 'Your cart', checkout: 'Checkout', orders: 'My bookings', order: 'Booking',
    favorites: 'Saved services', account: 'Account', login: 'Sign in', signup: 'Create account',
    forgot: 'Reset password', chat: 'Messages', notifications: 'Notifications', pages: 'Information',
    support: 'Support', track: 'Track booking', 'payment-return': 'Payment', about: 'About us',
    'become-a-provider': 'Become a provider',
  };

  async function route(force) {
    const { parts, query } = parseHash();
    const key = parts[0] || 'home';
    const view = $('#view');
    const signature = location.hash || '#/';
    if (!force && signature === currentRoute) return;
    currentRoute = signature;

    document.body.dataset.route = key;
    const base = (state.config && state.config.business_name) || 'Jass Booking';
    document.title = `${TITLES[key] || 'Home'} · ${base}`;
    syncBadges();
    view.setAttribute('aria-busy', 'true');

    try {
      switch (key) {
        case '': case 'home': await Views.home(view); break;
        case 'categories': await Views.categories(view); break;
        case 'category': await Views.category(view, parts[1]); break;
        case 'service': await Views.service(view, parts[1]); break;
        case 'search': await Views.search(view, query.q || '', query); break;
        case 'offers': await Views.offers(view); break;
        case 'cart': await Views.cart(view); break;
        case 'checkout': await Views.checkout(view); break;
        case 'orders': await Views.orders(view, query); break;
        case 'order': await Views.order(view, parts[1]); break;
        case 'favorites': await Views.favorites(view); break;
        case 'account':
          if (parts[1] === 'profile') await Views.profileEdit(view);
          else if (parts[1] === 'addresses') await Views.addresses(view);
          else if (parts[1] === 'wallet') await Views.wallet(view);
          else await Views.account(view);
          break;
        case 'login': await Views.login(view, query); break;
        case 'signup': await Views.signup(view, query); break;
        case 'forgot': await Views.forgot(view); break;
        case 'chat': await Views.chat(view, parts[1]); break;
        case 'notifications': await Views.notifications(view); break;
        case 'support': await Views.support(view); break;
        case 'become-a-provider': await Views.becomeProvider(view); break;
        case 'pages': await Views.page(view, parts[1]); break;
        case 'about': await Views.page(view, 'about_us'); break;
        case 'track': await Views.track(view, query); break;
        case 'payment-return': await Views.paymentReturn(view, query); break;
        default: Views.notFound(view);
      }
    } catch (e) {
      console.error(e);
      view.innerHTML = `<div class="page">${UI.errorState(e, 'route-retry')}</div>`;
      const retry = $('#route-retry');
      if (retry) retry.onclick = () => route(true);
    }

    view.removeAttribute('aria-busy');
    UI.scrollToTop();
  }

  /* ---------------- auth ---------------- */
  function requireAuth(nextHash) {
    if (state.isLoggedIn()) return true;
    const next = nextHash || (location.hash || '#/');
    location.hash = '#/login?next=' + encodeURIComponent(next);
    toast('Please sign in to continue', 'info');
    return false;
  }

  function go(hash) { location.hash = hash; }

  /* ---------------- global events ---------------- */
  function bindGlobalEvents() {
    window.addEventListener('jb:cart', syncBadges);
    window.addEventListener('jb:session-expired', () => {
      toast('Your session has expired. Please sign in again.', 'error');
      refreshChrome();
      location.hash = '#/login';
    });

    const sheet = $('#sheet');
    sheet.addEventListener('click', (e) => { if (e.target.id === 'sheet') { cleanupMap(); closeSheet(); } });
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') { cleanupMap(); closeSheet(); }
    });

    document.addEventListener('click', (e) => {
      const logout = e.target.closest('[data-logout]');
      if (logout) {
        e.preventDefault();
        doLogout();
      }
    });
  }

  async function doLogout() {
    const yes = await UI.confirmDialog({
      title: 'Sign out of Jass Booking?',
      message: 'You can sign back in any time with your phone number.',
      confirmLabel: 'Sign out',
    });
    if (!yes) return;
    try { await API.signout(); } catch (e) { /* token may already be gone */ }
    API.state.clearSession();
    state.cartCount = 0;
    refreshChrome();
    toast('Signed out', 'success');
    location.hash = '#/';
    route(true);
  }

  return {
    boot, route, go, requireAuth, refreshChrome, renderChrome, syncBadges,
    openLocationSheet, applyCoords, applyAddress, doLogout,
    get booted() { return booted; },
  };
})();

window.App = App;

App.boot();
