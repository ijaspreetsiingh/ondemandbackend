/* ============================================================
 * Jass Booking — web app API layer
 * Mirrors the customer APK's ApiClient contract:
 *   headers : Accept json · guest_id · zoneId · X-localization · Bearer token
 *   /client/* GETs carry latitude/longitude from the saved address
 * ============================================================ */

const API = (() => {
  const BASE = (window.WEB_APP_API_BASE || '').replace(/\/$/, '');

  /* ---------- storage ---------- */
  const store = {
    get(k) { try { return localStorage.getItem('jb.' + k); } catch (e) { return null; } },
    set(k, v) { try { localStorage.setItem('jb.' + k, v); } catch (e) {} },
    del(k) { try { localStorage.removeItem('jb.' + k); } catch (e) {} },
  };

  function uuid() {
    if (window.crypto && crypto.randomUUID) return crypto.randomUUID();
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, c => {
      const r = Math.random() * 16 | 0;
      return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
  }

  const readJson = (k, fallback) => {
    try { const v = store.get(k); return v ? JSON.parse(v) : fallback; } catch (e) { return fallback; }
  };

  /* ---------- session ---------- */
  const state = {
    get guestId() {
      let g = store.get('guest_id');
      if (!g) { g = uuid(); store.set('guest_id', g); }
      return g;
    },
    get token() { return store.get('token') || ''; },
    set token(v) { v ? store.set('token', v) : store.del('token'); },
    get user() { return readJson('user', null); },
    set user(v) { v ? store.set('user', JSON.stringify(v)) : store.del('user'); },
    get zoneId() { return store.get('zone_id') || ''; },
    set zoneId(v) { v ? store.set('zone_id', v) : store.del('zone_id'); },
    get zoneName() { return store.get('zone_name') || ''; },
    set zoneName(v) { v ? store.set('zone_name', v) : store.del('zone_name'); },
    get address() { return readJson('address', null); },
    set address(v) { v ? store.set('address', JSON.stringify(v)) : store.del('address'); },
    get lat() { const a = this.address; return store.get('lat') || (a && a.lat) || ''; },
    get lng() { const a = this.address; return store.get('lng') || (a && a.lon) || ''; },
    setCoords(lat, lng) { store.set('lat', String(lat)); store.set('lng', String(lng)); },
    get config() { return readJson('config', null); },
    set config(v) { v ? store.set('config', JSON.stringify(v)) : store.del('config'); },
    get cartCount() { return parseInt(store.get('cart_count') || '0', 10) || 0; },
    set cartCount(v) { store.set('cart_count', String(v || 0)); },
    get pendingCoupon() { return store.get('pending_coupon') || ''; },
    set pendingCoupon(v) { v ? store.set('pending_coupon', v) : store.del('pending_coupon'); },
    isLoggedIn() { return !!this.token; },
    clearSession() {
      this.token = '';
      this.user = null;
      this.cartCount = 0;
      this.pendingCoupon = '';
    },
  };

  const isGuestState = () => !state.token;

  /* ---------- request core ---------- */
  function headers(opts = {}) {
    const h = {
      'Accept': 'application/json',
      'guest_id': state.guestId,
      'zoneId': opts.configuration ? 'configuration' : (state.zoneId || ''),
      'X-localization': 'en',
    };
    if (!opts.form) h['Content-Type'] = 'application/json; charset=UTF-8';
    if (state.token) h['Authorization'] = 'Bearer ' + state.token;
    return h;
  }

  function buildUrl(uri, query = {}) {
    const url = new URL(BASE + uri, location.origin);
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

  async function request(method, uri, { query, body, form, configuration, timeout = 30000, silent } = {}) {
    const ctrl = new AbortController();
    const timer = setTimeout(() => ctrl.abort(), timeout);
    let res;
    try {
      res = await fetch(buildUrl(uri, query), {
        method,
        headers: headers({ configuration, form: !!form }),
        body: form || (body !== undefined ? JSON.stringify(body) : undefined),
        signal: ctrl.signal,
        credentials: 'omit',
      });
    } catch (e) {
      clearTimeout(timer);
      if (e.name === 'AbortError') throw new Error('The request timed out. Please check your connection and try again.');
      throw new Error('Could not reach the server. Please check your internet connection.');
    }
    clearTimeout(timer);

    let json = null;
    const text = await res.text().catch(() => '');
    if (text) { try { json = JSON.parse(text); } catch (e) { json = null; } }

    if (!res.ok) {
      if (res.status === 401 && state.token && !silent) {
        state.clearSession();
        window.dispatchEvent(new CustomEvent('jb:session-expired'));
      }
      const msg = pickError(json) || ('Request failed (' + res.status + ')');
      const err = new Error(msg);
      err.status = res.status;
      err.body = json;
      throw err;
    }
    return json;
  }

  function pickError(json) {
    if (!json) return '';
    if (json.errors) {
      if (Array.isArray(json.errors)) {
        const first = json.errors[0];
        if (typeof first === 'string') return first;
        if (first && first.message) return first.message;
      } else if (typeof json.errors === 'object') {
        const first = Object.values(json.errors)[0];
        if (Array.isArray(first) && first.length) return String(first[0]);
      }
    }
    return json.message || '';
  }

  const ok = (r) => !!(r && (r.response_code === 'default_200' || String(r.response_code || '').endsWith('_200')));

  /* ---------- endpoints (1:1 with the customer API routes) ---------- */
  const E = {
    config: '/api/v1/client/setup',
    paymentConfig: '/api/v1/client/setup/payment-config',
    pages: '/api/v1/client/setup/pages',
    pageFacts: '/api/v1/client/setup/page-facts/',
    zone: '/api/v1/client/setup/fetch-region-id',
    geoSuggest: '/api/v1/client/setup/geo-suggest',
    geoSpot: '/api/v1/client/setup/geo-spot-facts',
    geoCoder: '/api/v1/client/setup/geo-coder',
    categories: '/api/v1/client/group',
    subgroups: '/api/v1/client/group/subgroups',
    subCategories: '/api/v1/client/sub-categories',
    spotlight: '/api/v1/client/spotlight-groups',
    servicesBySub: '/api/v1/client/task/child-group/',
    popular: '/api/v1/client/task/hot',
    recommended: '/api/v1/client/task/suggested',
    trending: '/api/v1/client/task/rising',
    deals: '/api/v1/client/task/deals',
    recentlyViewed: '/api/v1/client/task/last-seen',
    serviceDetail: '/api/v1/client/task/info/',
    serviceReviews: '/api/v1/client/task/feedback/',
    search: '/api/v1/client/task/lookup',
    searchHints: '/api/v1/client/task/lookup-hints',
    favorites: '/api/v1/client/saved/task-index',
    favoriteAdd: '/api/v1/client/saved/task',
    favoriteRemove: '/api/v1/client/saved/task-remove/',
    cartInsert: '/api/v1/client/basket/insert',
    cartIndex: '/api/v1/client/basket/index',
    cartDelete: '/api/v1/client/basket/delete/',
    cartWipe: '/api/v1/client/basket/records/wipe',
    cartQty: '/api/v1/client/basket/modify-count/',
    rebook: '/api/v1/client/reorder/basket-attach',
    addresses: '/api/v1/client/place',
    placeOrder: '/api/v1/client/order/submission/transmit',
    orders: '/api/v1/client/order',
    orderTrace: '/api/v1/client/order/trace/',
    servicemanLocation: '/api/v1/client/order/serviceman-location/',
    orderRecheck: '/api/v1/client/order/recheck/',
    orderRecheckStatus: '/api/v1/client/order/recheck-status/',
    orderUnsatisfied: '/api/v1/client/order/unsatisfied/',
    orderUnsatisfiedStatus: '/api/v1/client/order/unsatisfied-status/',
    coupons: '/api/v1/client/promo',
    couponRedeem: '/api/v1/client/promo/redeem',
    couponDelete: '/api/v1/client/promo/delete',
    banners: '/api/v1/client/carousel',
    notifications: '/api/v1/client/alerts',
    showcase: '/api/v1/client/showcases/showcase-feed',
    reviews: '/api/v1/client/feedback',
    reviewStore: '/api/v1/client/feedback/dispatch',
    chats: '/api/v1/client/inbox/thread-index',
    chatOpen: '/api/v1/client/inbox/open-thread',
    chatSend: '/api/v1/client/inbox/transmit-note',
    chatThread: '/api/v1/client/inbox/thread',
    chatReferenced: '/api/v1/client/inbox/referenced-channel-list',
    login: '/api/v1/client/access/signin',
    signup: '/api/v1/client/access/signup',
    signout: '/api/v1/client/access/signout',
    accountProbe: '/api/v1/client/access/account-probe',
    forgotPin: '/api/v1/member/lost-secret/transmit-pin',
    verifyPin: '/api/v1/member/lost-secret/check-pin',
    resetPassword: '/api/v1/member/lost-secret/restore',
    profile: '/api/v1/client/dossier',
    profileUpdate: '/api/v1/client/modify/account',
    accountDelete: '/api/v1/client/account-delete',
    walletLedger: '/api/v1/client/purse-ledger',
    loyaltyLedger: '/api/v1/client/reward-points-ledger',
    loyaltyMove: '/api/v1/client/reward-points/purse-move',
    newsletter: '/api/v1/client/join-bulletin',
    localeSwitch: '/api/v1/client/locale-switch',
  };

  const q = (extra = {}) => ({ limit: 20, offset: 1, ...extra });

  /* ---------- helpers ---------- */
  const cfgNum = (key, fallback = 0) => {
    const cfg = state.config || {};
    const n = Number(cfg[key]);
    return Number.isFinite(n) ? n : fallback;
  };

  return {
    state, ok, E, pickError,

    /* ---------- setup ---------- */
    getConfig() {
      return request('GET', E.config, { configuration: true, query: { guest_id: state.guestId } });
    },
    getPaymentConfig(providerId = '') {
      return request('GET', E.paymentConfig, { query: { provider_id: providerId, guest_id: state.guestId } });
    },
    getPages() { return request('GET', E.pages); },
    getPage(key) { return request('GET', E.pageFacts + encodeURIComponent(key)); },
    newsletter(email) { return request('POST', E.newsletter, { body: { email } }); },

    /* ---------- location ---------- */
    findZone(lat, lng) { return request('GET', E.zone, { query: { lat, lng } }); },
    geoSuggest(text) { return request('GET', E.geoSuggest, { query: { search_text: text, guest_id: state.guestId } }); },
    geoSpot(placeId) { return request('GET', E.geoSpot, { query: { placeid: placeId } }); },
    geoCoder(lat, lng) { return request('GET', E.geoCoder, { query: { lat, lng, guest_id: state.guestId } }); },

    /* ---------- catalogue ---------- */
    getCategories(offset = 1, limit = 30) { return request('GET', E.categories, { query: q({ offset, limit }) }); },
    getSubgroups(slug) { return request('GET', E.subgroups, { query: q({ slug }) }); },
    getSpotlight() { return request('GET', E.spotlight, { query: q() }); },
    getServices(subSlug, offset = 1, limit = 12) { return request('GET', E.servicesBySub + subSlug, { query: { limit, offset } }); },
    getPopular(offset = 1, limit = 10) { return request('GET', E.popular, { query: { limit, offset } }); },
    getRecommended(offset = 1, limit = 10) { return request('GET', E.recommended, { query: { limit, offset } }); },
    getTrending(offset = 1, limit = 10) { return request('GET', E.trending, { query: { limit, offset } }); },
    getDeals(offset = 1, limit = 10) { return request('GET', E.deals, { query: { limit, offset } }); },
    getRecentlyViewed(offset = 1, limit = 10) { return request('GET', E.recentlyViewed, { query: { limit, offset } }); },
    getServiceDetail(slug) { return request('GET', E.serviceDetail + slug); },
    getServiceReviews(serviceId, offset = 1, limit = 10) {
      return request('GET', E.serviceReviews + serviceId, { query: { limit, offset } });
    },
    search(text, { offset = 1, limit = 20, sort_by, sort_by_type } = {}) {
      return request('POST', E.search, { query: { limit, offset, sort_by, sort_by_type }, body: { string: text } });
    },
    searchHints(text = '') { return request('GET', E.searchHints, { query: text ? { string: text } : {} }); },

    /* ---------- favorites ---------- */
    getFavorites(offset = 1, limit = 20) { return request('GET', E.favorites, { query: { limit, offset } }); },
    addFavorite(serviceId) { return request('POST', E.favoriteAdd, { body: { service_id: serviceId } }); },
    removeFavorite(serviceId) { return request('POST', E.favoriteRemove + serviceId); },

    /* ---------- cart ---------- */
    addToCart(payload) { return request('POST', E.cartInsert, { body: { ...payload, guest_id: state.guestId } }); },
    getCart() { return request('GET', E.cartIndex, { query: q({ limit: 100, guest_id: state.guestId }) }); },
    removeCartItem(id) { return request('DELETE', E.cartDelete + id, { query: { guest_id: state.guestId } }); },
    wipeCart() { return request('DELETE', E.cartWipe, { query: { guest_id: state.guestId } }); },
    updateQty(id, quantity) { return request('PUT', E.cartQty + id, { body: { quantity, guest_id: state.guestId } }); },
    rebook(bookingId) { return request('POST', E.rebook, { query: { guest_id: state.guestId }, body: { booking_id: bookingId, guest_id: state.guestId } }); },

    /* ---------- address book ---------- */
    getAddresses() { return request('GET', E.addresses, { query: { limit: 100, offset: 1, guest_id: state.guestId } }); },
    addAddress(model) { return request('POST', E.addresses, { query: { guest_id: state.guestId }, body: model }); },
    updateAddress(id, model) { return request('PUT', E.addresses + '/' + id, { query: { guest_id: state.guestId }, body: model }); },
    deleteAddress(id) { return request('DELETE', E.addresses + '/' + id, { query: { guest_id: state.guestId } }); },

    /* ---------- checkout ---------- */
    placeOrder(payload) {
      return request('POST', E.placeOrder, { body: { ...payload, guest_id: state.guestId }, timeout: 60000 });
    },

    /* ---------- booking list / detail ---------- */
    getOrders({ offset = 1, limit = 10, status = 'all', type = 'all', search = '' } = {}) {
      let encoded = '';
      if (search) {
        try { encoded = btoa(unescape(encodeURIComponent(search))); } catch (e) { encoded = search; }
      }
      return request('GET', E.orders, {
        query: { limit, offset, booking_status: status, service_type: type, string: encoded || undefined },
      });
    },
    getOrder(id) { return request('GET', E.orders + '/' + id); },
    cancelOrder(id) { return request('PUT', E.orders + '/state-change/' + id, { body: { booking_status: 'canceled' } }); },
    traceOrder(readableId, phone) { return request('POST', E.orderTrace + readableId, { body: { phone } }); },
    servicemanLocation(bookingId) { return request('GET', E.servicemanLocation + bookingId); },
    requestRecheck(bookingId) { return request('POST', E.orderRecheck + bookingId); },
    recheckStatus(bookingId) { return request('GET', E.orderRecheckStatus + bookingId); },
    requestUnsatisfied(bookingId) { return request('POST', E.orderUnsatisfied + bookingId); },
    unsatisfiedStatus(bookingId) { return request('GET', E.orderUnsatisfiedStatus + bookingId); },

    /* ---------- reviews ---------- */
    getMyReviews(offset = 1, limit = 20) { return request('GET', E.reviews, { query: { limit, offset } }); },
    submitReview(payload) {
      if (payload instanceof FormData) return request('POST', E.reviewStore, { form: payload });
      return request('POST', E.reviewStore, { body: payload });
    },

    /* ---------- promo ---------- */
    getCoupons(offset = 1, limit = 30) { return request('GET', E.coupons, { query: { limit, offset } }); },
    applyCoupon(code) { return request('POST', E.couponRedeem, { body: { coupon_code: code, guest_id: state.guestId } }); },
    removeCoupon() { return request('GET', E.couponDelete, { query: { guest_id: state.guestId } }); },

    /* ---------- content ---------- */
    getBanners(limit = 10) { return request('GET', E.banners, { query: q({ limit }) }); },
    getNotifications(offset = 1, limit = 20) { return request('GET', E.notifications, { query: { limit, offset } }); },
    getShowcase(offset = 1, limit = 10) { return request('GET', E.showcase, { query: { limit, offset } }); },

    /* ---------- chat ---------- */
    getChats(type = '', search = '', offset = 1, limit = 20) {
      return request('GET', E.chats, { query: { limit, offset, type: type || undefined, search: search || undefined } });
    },
    openChat(toUser, referenceId = '', referenceType = '') {
      const body = { to_user: toUser };
      if (referenceId) { body.reference_id = referenceId; body.reference_type = referenceType || 'booking_id'; }
      return request('POST', E.chatOpen, { body });
    },
    sendChat(channelId, message) { return request('POST', E.chatSend, { body: { channel_id: channelId, message } }); },
    getChatThread(channelId, offset = 1, limit = 50) {
      return request('GET', E.chatThread, { query: { channel_id: channelId, limit, offset } });
    },
    getChatsForBooking(bookingId, offset = 1, limit = 20) {
      return request('GET', E.chatReferenced, { query: { reference_id: bookingId, reference_type: 'booking_id', limit, offset } });
    },

    /* ---------- auth ---------- */
    signin(emailOrPhone, password, type = 'phone') {
      return request('POST', E.login, {
        body: { email_or_phone: emailOrPhone, password, type, guest_id: state.guestId },
      });
    },
    signup(body) {
      if (body instanceof FormData) {
        if (!body.has('guest_id')) body.append('guest_id', state.guestId);
        return request('POST', E.signup, { form: body });
      }
      return request('POST', E.signup, { body: { ...body, guest_id: state.guestId } });
    },
    signout() { return request('POST', E.signout, { body: { guest_id: state.guestId } }); },
    profile() { return request('GET', E.profile); },
    updateProfile(payload) {
      if (payload instanceof FormData) {
        if (!payload.has('_method')) payload.append('_method', 'PUT');
        return request('POST', E.profileUpdate, { form: payload });
      }
      return request('PUT', E.profileUpdate, { body: payload });
    },
    deleteAccount() { return request('DELETE', E.accountDelete); },

    /* ---------- wallet & loyalty ---------- */
    getWalletLedger(offset = 1, limit = 20) { return request('GET', E.walletLedger, { query: { limit, offset } }); },
    getLoyaltyLedger(offset = 1, limit = 20) { return request('GET', E.loyaltyLedger, { query: { limit, offset } }); },
    moveLoyaltyToWallet(points) { return request('POST', E.loyaltyMove, { body: { points } }); },

    /* ---------- password reset ---------- */
    forgotPassword(identity, identityType) {
      return request('POST', E.forgotPin, { body: { identity, identity_type: identityType } });
    },
    verifyResetPin(identity, identityType, otp) {
      return request('POST', E.verifyPin, { body: { identity, identity_type: identityType, otp } });
    },
    resetPassword(identity, identityType, otp, password, confirmPassword) {
      return request('PUT', E.resetPassword, {
        body: {
          identity, identity_type: identityType, otp,
          password, confirm_password: confirmPassword, is_firebase_otp: 0,
        },
      });
    },

    /* ---------- convenience ---------- */
    isGuest() { return isGuestState(); },
    money(num) {
      const cfg = state.config || {};
      const symbol = cfg.currency_symbol || '₹';
      const dec = parseInt(cfg.currency_decimal_point ?? '2', 10) || 0;
      const n = Number(num || 0).toFixed(dec);
      return cfg.currency_symbol_position === 'after' ? n + ' ' + symbol : symbol + n;
    },
    cfg(key, fallback = null) {
      const cfg = state.config || {};
      return cfg[key] === undefined || cfg[key] === null ? fallback : cfg[key];
    },
    flag(key) { return !!cfgNum(key, 0); },
    countCartItems(cartContent) {
      const items = (cartContent && cartContent.cart && cartContent.cart.data) || [];
      return items.reduce((sum, item) => sum + (Number(item.quantity) || 0), 0);
    },
    async refreshCartCount() {
      try {
        const res = await this.getCart();
        if (ok(res)) state.cartCount = this.countCartItems(res.content);
      } catch (e) { /* ignore */ }
      window.dispatchEvent(new CustomEvent('jb:cart', { detail: state.cartCount }));
      return state.cartCount;
    },
  };
})();

window.API = API;
