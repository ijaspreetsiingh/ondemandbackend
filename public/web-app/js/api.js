/* ============================================================
 * Jass Booking — web app API layer
 * Mirror of the customer APK's ApiClient contract:
 *   headers : Accept json · guest_id · zoneId · X-localization · Bearer token
 *   /client/* GETs get latitude/longitude appended from the saved address
 * ============================================================ */

const API = (() => {
  const BASE = window.WEB_APP_API_BASE || '';

  /* ---------- storage ---------- */
  const store = {
    get(k) { try { return localStorage.getItem('web.' + k); } catch (e) { return null; } },
    set(k, v) { try { localStorage.setItem('web.' + k, v); } catch (e) {} },
    del(k) { try { localStorage.removeItem('web.' + k); } catch (e) {} },
  };

  function uuid() {
    if (crypto.randomUUID) return crypto.randomUUID();
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, c => {
      const r = Math.random() * 16 | 0;
      return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
  }

  /* ---------- session ---------- */
  const state = {
    get guestId() { let g = store.get('guest_id'); if (!g) { g = uuid(); store.set('guest_id', g); } return g; },
    get token() { return store.get('token') || ''; },
    set token(v) { v ? store.set('token', v) : store.del('token'); },
    get user() { try { return JSON.parse(store.get('user') || 'null'); } catch (e) { return null; } },
    set user(v) { v ? store.set('user', JSON.stringify(v)) : store.del('user'); },
    get zoneId() { return store.get('zone_id') || ''; },
    set zoneId(v) { v ? store.set('zone_id', v) : store.del('zone_id'); },
    get address() { try { return JSON.parse(store.get('address') || 'null'); } catch (e) { return null; } },
    set address(v) { v ? store.set('address', JSON.stringify(v)) : store.del('address'); },
    get lat() { return store.get('lat') || ''; },
    get lng() { return store.get('lng') || ''; },
    setCoords(lat, lng) { store.set('lat', String(lat)); store.set('lng', String(lng)); },
    get config() { try { return JSON.parse(store.get('config') || 'null'); } catch (e) { return null; } },
    set config(v) { v ? store.set('config', JSON.stringify(v)) : store.del('config'); },
    get cartCount() { return parseInt(store.get('cart_count') || '0', 10); },
    set cartCount(v) { store.set('cart_count', String(v || 0)); },
  };

  /* ---------- request core ---------- */
  function headers(opts = {}) {
    const h = {
      'Accept': 'application/json',
      'guest_id': state.guestId,
      'zoneId': opts.configuration ? 'configuration' : (state.zoneId || ''),
      'X-localization': 'en',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (state.token) h['Authorization'] = 'Bearer ' + state.token;
    return h;
  }

  function buildUrl(uri, query = {}) {
    const url = new URL(BASE + uri, location.origin);
    // /client/* calls carry geo context like the APK's ZoneAdder expects
    const path = url.pathname;
    if ((path.includes('/client/') || path.includes('/customer/')) &&
        !query.latitude && !query.longitude && state.lat && state.lng) {
      query.latitude = state.lat;
      query.longitude = state.lng;
    }
    Object.entries(query).forEach(([k, v]) => {
      if (v !== undefined && v !== null && v !== '') url.searchParams.set(k, v);
    });
    return url.toString();
  }

  async function request(method, uri, { query, body, configuration, timeout = 30000 } = {}) {
    const ctrl = new AbortController();
    const timer = setTimeout(() => ctrl.abort(), timeout);
    try {
      const res = await fetch(buildUrl(uri, query), {
        method,
        headers: headers({ configuration }),
        body: body ? JSON.stringify(body) : undefined,
        signal: ctrl.signal,
      });
      let json = null;
      try { json = await res.json(); } catch (e) { /* non-JSON */ }
      if (!res.ok) {
        const msg = (json && (json.message || (json.errors && json.errors[0] && json.errors[0].message)))
          || ('Request failed (' + res.status + ')');
        const err = new Error(msg);
        err.status = res.status;
        err.body = json;
        throw err;
      }
      return json;
    } finally {
      clearTimeout(timer);
    }
  }

  const ok = (r) => r && (r.response_code === 'default_200' || String(r.response_code || '').endsWith('_200'));

  /* ---------- endpoints (1:1 with the APK's AppConstants) ---------- */
  const E = {
    config: '/api/v1/client/setup',
    zone: '/api/v1/client/setup/fetch-region-id',
    geoSuggest: '/api/v1/client/setup/geo-suggest',
    categories: '/api/v1/client/group',
    subgroups: '/api/v1/client/group/subgroups',
    servicesBySub: '/api/v1/client/task/child-group/',
    popular: '/api/v1/client/task/hot',
    recommended: '/api/v1/client/task/suggested',
    deals: '/api/v1/client/task/deals',
    serviceDetail: '/api/v1/client/task/info/',
    search: '/api/v1/client/task/lookup',
    cartInsert: '/api/v1/client/basket/insert',
    cartIndex: '/api/v1/client/basket/index',
    cartDelete: '/api/v1/client/basket/delete/',
    cartWipe: '/api/v1/client/basket/records/wipe',
    cartQty: '/api/v1/client/basket/modify-count/',
    addresses: '/api/v1/client/place',
    zoneList: '/api/v1/client/task/zone-availability',
    paymentConfig: '/api/v1/client/setup/payment-config',
    placeOrder: '/api/v1/client/order/submission/transmit',
    orders: '/api/v1/client/order',
    orderDetails: '/api/v1/client/purchase/breakdown',
    coupons: '/api/v1/client/promo',
    couponRedeem: '/api/v1/client/promo/redeem',
    couponDelete: '/api/v1/client/promo/delete',
    login: '/api/v1/client/access/signin',
    signup: '/api/v1/client/access/signup',
    signout: '/api/v1/client/access/signout',
    profile: '/api/v1/client/dossier',
  };

  return {
    state, ok, E,

    /* config — special header zoneId=configuration */
    getConfig() {
      return request('GET', E.config, { configuration: true, query: { guest_id: state.guestId } });
    },

    /* location */
    findZone(lat, lng) { return request('GET', E.zone, { query: { lat, lng } }); },
    geoSuggest(q) { return request('GET', E.geoSuggest, { query: { search_text: q, guest_id: state.guestId } }); },
    geoSpot(placeId) { return request('GET', '/api/v1/client/setup/geo-spot-facts', { query: { placeid: placeId } }); },

    /* catalogue */
    getCategories() { return request('GET', E.categories, { query: { limit: 20, offset: 1 } }); },
    getSubgroups(slug) { return request('GET', E.subgroups, { query: { limit: 20, offset: 1, slug } }); },
    getServices(subSlug, offset = 1, limit = 12) {
      return request('GET', E.servicesBySub + subSlug, { query: { limit, offset } });
    },
    getPopular(offset = 1, limit = 10) { return request('GET', E.popular, { query: { limit, offset } }); },
    getRecommended(offset = 1, limit = 10) { return request('GET', E.recommended, { query: { limit, offset } }); },
    getDeals(offset = 1, limit = 10) { return request('GET', E.deals, { query: { limit, offset } }); },
    getServiceDetail(slug) { return request('GET', E.serviceDetail + slug); },
    search(q, offset = 1) {
      return request('POST', E.search, { query: { limit: 10, offset }, body: { string: q } });
    },

    /* cart */
    addToCart(payload) { return request('POST', E.cartInsert, { body: { ...payload, guest_id: state.guestId } }); },
    getCart() { return request('GET', E.cartIndex, { query: { limit: 100, offset: 1, guest_id: state.guestId } }); },
    removeCartItem(id) { return request('DELETE', E.cartDelete + id, { query: { guest_id: state.guestId } }); },
    wipeCart() { return request('POST', E.cartWipe, { query: { guest_id: state.guestId } }); },
    updateQty(id, quantity) { return request('POST', E.cartQty + id, { body: { quantity, guest_id: state.guestId } }); },

    /* address book */
    getAddresses() { return request('GET', E.addresses, { query: { limit: 100, offset: 1, guest_id: state.guestId } }); },
    addAddress(model) { return request('POST', E.addresses, { query: { guest_id: state.guestId }, body: model }); },
    deleteAddress(id) { return request('DELETE', E.addresses + '/' + id, { query: { guest_id: state.guestId } }); },

    /* checkout */
    paymentConfig(providerId = '') {
      return request('GET', E.paymentConfig, { query: { provider_id: providerId, guest_id: state.guestId } });
    },
    placeOrder(payload) { return request('POST', E.placeOrder, { body: { ...payload, guest_id: state.guestId }, timeout: 45000 }); },
    getOrders(offset = 1, limit = 10) { return request('GET', E.orders, { query: { limit, offset, guest_id: state.guestId } }); },
    getOrderDetails(orderId) { return request('GET', E.orderDetails, { query: { order_id: orderId, guest_id: state.guestId } }); },

    /* coupons */
    getCoupons() { return request('GET', E.coupons, { query: { limit: 100, offset: 1 } }); },
    applyCoupon(code) { return request('POST', E.couponRedeem, { body: { coupon_code: code, guest_id: state.guestId } }); },
    removeCoupon() { return request('POST', E.couponDelete, { body: { guest_id: state.guestId } }); },

    /* auth */
    signin(email_or_phone, password, type = 'phone') {
      return request('POST', E.login, { body: { email_or_phone, password, type, guest_id: state.guestId } });
    },
    signup(body) { return request('POST', E.signup, { body }); },
    signout() { return request('POST', E.signout, { body: { guest_id: state.guestId } }); },
    profile() { return request('GET', E.profile); },

    /* helpers used across views */
    money(num) {
      const cfg = state.config || {};
      const symbol = cfg.currency_symbol || '₹';
      const dec = parseInt(cfg.currency_decimal_point ?? '2', 10) || 0;
      const n = Number(num || 0).toFixed(dec);
      return cfg.currency_symbol_position === 'after' ? n + ' ' + symbol : symbol + n;
    },
  };
})();
