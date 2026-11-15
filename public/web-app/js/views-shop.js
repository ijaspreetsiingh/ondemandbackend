/* ============================================================
 * Jass Booking — storefront views
 * Home · categories · category · service detail · search · offers
 * ============================================================ */
'use strict';

window.Views = window.Views || {};

(() => {
  const { state, ok } = API;
  const U = UI;

  const listOf = (res) => {
    if (!ok(res)) return [];
    const c = res.content || {};
    return c.data || c.serviceList || c.services || [];
  };

  const pagedOf = (res) => {
    if (!ok(res)) return null;
    const c = res.content || {};
    if (c.services && (c.services.data || Array.isArray(c.services))) return c.services;
    return c;
  };

  /* =========================================================
   * HOME
   * ========================================================= */
  async function home(view) {
    const cfg = state.config || {};
    view.innerHTML = `<div class="page page--home">
      ${U.skeletonRows(1, 'hero-skel')}
      <section class="section">${U.skeletonCards(4)}</section>
    </div>`;

    const [catsRes, bannerRes, popularRes, trendingRes, recommendedRes, dealsRes, recentRes] = await Promise.allSettled([
      API.getCategories(),
      API.getBanners(8),
      API.getPopular(1, 10),
      API.getTrending(1, 10),
      API.getRecommended(1, 10),
      API.getDeals(1, 10),
      state.isLoggedIn() ? API.getRecentlyViewed(1, 10) : Promise.resolve(null),
    ]);

    const val = (r) => (r.status === 'fulfilled' ? r.value : null);
    const cats = listOf(val(catsRes));
    const banners = listOf(val(bannerRes));
    const popular = listOf(val(popularRes));
    const trending = listOf(val(trendingRes));
    const recommended = listOf(val(recommendedRes));
    const deals = listOf(val(dealsRes));
    const recent = listOf(val(recentRes));

    const quickCats = cats.slice(0, 8);
    const heroImage = (popular[0] && (popular[0].cover_image_full_path || popular[0].thumbnail_full_path)) || '';

    view.innerHTML = `
      <div class="page page--home">
        <section class="hero">
          <div class="hero__inner">
            <div class="hero__copy">
              <span class="hero__eyebrow"><i></i> Verified home-service professionals</span>
              <h1>Good help,<br><em>right at home.</em></h1>
              <p>Book trusted experts for repairs, cleaning and everything in between — with upfront pricing and a professional you can rely on.</p>

              <form class="hero__search" id="hero-search" role="search">
                ${U.icon('search', 18)}
                <input type="search" name="q" placeholder="What do you need help with today?" aria-label="Search services">
                <button class="btn btn--primary" type="submit">Find help</button>
              </form>

              <div class="hero__chips">
                ${quickCats.map(c => `<a class="pill-chip" href="#/category/${U.esc(c.slug)}">${U.esc(c.name)}</a>`).join('')}
              </div>

              <ul class="hero__proof">
                <li>${U.icon('shield', 16)} Verified &amp; background-checked</li>
                <li>${U.icon('tag', 16)} Upfront, fixed pricing</li>
                <li>${U.icon('clock', 16)} Same-day slots available</li>
              </ul>
            </div>

            <div class="hero__visual" aria-hidden="true">
              <div class="hero__blob"></div>
              ${heroImage ? `<div class="hero__photo"><img src="${U.esc(heroImage)}" alt="" onerror="this.remove()"></div>` : ''}
              <div class="hero__card hero__card--top">
                <span class="hero__card-ic">${U.icon('check', 16)}</span>
                <div><b>Professional assigned</b><small>Your expert is on the way</small></div>
              </div>
              <div class="hero__card hero__card--bottom">
                <span class="hero__card-ic hero__card-ic--gold">${U.icon('star', 15)}</span>
                <div><b>4.8 average rating</b><small>From happy homes near you</small></div>
              </div>
            </div>
          </div>
        </section>

        ${banners.length ? `
        <section class="section section--tight">
          <div class="carousel" id="banners">
            <div class="carousel__track">
              ${banners.map(b => {
                const link = bannerLink(b);
                return `<div class="carousel__slide">
                  <a class="banner" href="${U.esc(link)}">
                    <img src="${U.esc(b.banner_image_full_path)}" alt="${U.esc(b.banner_title || 'Offer')}" loading="lazy"
                      onerror="this.parentElement.classList.add('banner--fallback');this.remove()">
                    ${b.banner_title ? `<span class="banner__caption">${U.esc(b.banner_title)}</span>` : ''}
                  </a>
                </div>`;
              }).join('')}
            </div>
            ${banners.length > 1 ? `<div class="carousel__dots">${banners.map((_, i) => `<button data-slide="${i}" aria-label="Slide ${i + 1}" class="${i === 0 ? 'is-on' : ''}"></button>`).join('')}</div>` : ''}
          </div>
        </section>` : ''}

        <section class="section">
          ${U.sectionHead('What can we help with?', 'Explore services', '#/categories', 'All categories')}
          ${cats.length ? `<div class="catrow">
            ${cats.slice(0, 12).map(U.categoryCard).join('')}
          </div>` : U.empty({ icon: 'grid', title: 'Services are being prepared', text: 'Please check back shortly.' })}
        </section>

        ${(popular.length || trending.length || recommended.length) ? `
        <section class="section">
          <div class="tabs" id="home-tabs" role="tablist">
            ${popular.length ? `<button class="tabs__btn is-on" data-tab="popular" role="tab">Popular</button>` : ''}
            ${trending.length ? `<button class="tabs__btn ${!popular.length ? 'is-on' : ''}" data-tab="trending" role="tab">Trending</button>` : ''}
            ${recommended.length ? `<button class="tabs__btn ${!popular.length && !trending.length ? 'is-on' : ''}" data-tab="recommended" role="tab">Recommended</button>` : ''}
          </div>
          <div id="home-tab-panel"></div>
        </section>` : ''}

        ${deals.length ? `<section class="section">
          ${U.sectionHead('Deals for your home', 'Save more', '#/offers', 'All offers')}
          <div class="hscroll">${deals.map(s => U.serviceCard(s, { compact: true })).join('')}</div>
        </section>` : ''}

        ${recent.length ? `<section class="section">
          ${U.sectionHead('Pick up where you left off', 'Recently viewed')}
          <div class="hscroll">${recent.map(s => U.serviceCard(s, { compact: true })).join('')}</div>
        </section>` : ''}

        <section class="section how">
          <div class="how__head">
            <span class="eyebrow">Simple by design</span>
            <h2>Three steps to a sorted home</h2>
          </div>
          <div class="how__grid">
            <div class="how__step"><span class="how__num">01</span><h3>Tell us what's needed</h3><p>Pick a service, choose your variant and add it to the cart in seconds.</p></div>
            <div class="how__step"><span class="how__num">02</span><h3>Choose a time</h3><p>Book instantly or schedule for later — you decide when help arrives.</p></div>
            <div class="how__step"><span class="how__num">03</span><h3>Relax, it's handled</h3><p>Track your professional, pay securely and rate the work when it's done.</p></div>
          </div>
        </section>

        <section class="section providerband">
          <div>
            <span class="eyebrow">For professionals</span>
            <h2>Turn your skill into steady work</h2>
            <p>Join as a service provider, choose the zone and services you cover, and start receiving bookings from customers near you.</p>
          </div>
          <a class="btn btn--primary btn--lg" href="#/become-a-provider">Become a provider</a>
        </section>

        <section class="section newsletter">
          <div class="newsletter__copy">
            <span class="eyebrow">${U.esc(cfg.newsletter_title || 'Stay in the loop')}</span>
            <h2>Home care tips, offers and early access</h2>
            <p>One short email a month. No spam, ever.</p>
          </div>
          <form class="newsletter__form" id="newsletter-form">
            <input class="input" type="email" name="email" placeholder="you@email.com" required aria-label="Email address">
            <button class="btn btn--primary" type="submit">Subscribe</button>
          </form>
        </section>
      </div>`;

    /* hero search */
    const heroSearch = view.querySelector('#hero-search');
    heroSearch.onsubmit = (e) => {
      e.preventDefault();
      const q = heroSearch.querySelector('input').value.trim();
      if (q) location.hash = '#/search?q=' + encodeURIComponent(q);
    };

    /* tabs */
    const data = { popular, trending, recommended };
    const panel = view.querySelector('#home-tab-panel');
    const renderTab = (key) => { panel.innerHTML = `<div class="hscroll">${(data[key] || []).map(s => U.serviceCard(s, { compact: true })).join('')}</div>`; };
    view.querySelectorAll('#home-tabs .tabs__btn').forEach(btn => {
      btn.onclick = () => {
        view.querySelectorAll('#home-tabs .tabs__btn').forEach(b => b.classList.remove('is-on'));
        btn.classList.add('is-on');
        renderTab(btn.dataset.tab);
      };
    });
    const firstTab = view.querySelector('#home-tabs .tabs__btn');
    if (firstTab) renderTab(firstTab.dataset.tab);

    /* banner carousel */
    const carousel = view.querySelector('#banners');
    if (carousel) initCarousel(carousel, Number(cfg.banner_auto_slide_duration) || 5);

    /* newsletter */
    const news = view.querySelector('#newsletter-form');
    news.onsubmit = async (e) => {
      e.preventDefault();
      const email = news.querySelector('input').value.trim();
      if (!email) return;
      const btn = news.querySelector('button');
      btn.disabled = true;
      try {
        const res = await API.newsletter(email);
        if (ok(res)) { U.toast('You are subscribed — welcome!', 'success'); news.reset(); }
        else U.toast(res.message || 'Could not subscribe', 'error');
      } catch (err) { U.toast(err.message, 'error'); }
      btn.disabled = false;
    };
  }

  function bannerLink(b) {
    if (b.redirect_link && /^#?\//.test(b.redirect_link)) return b.redirect_link.startsWith('#') ? b.redirect_link : '#' + b.redirect_link;
    if (b.service && b.service.slug) return '#/service/' + b.service.slug;
    if (b.category && b.category.slug) return '#/category/' + b.category.slug;
    if (b.resource_type === 'category' && b.resource_id) return '#/category/' + b.resource_id;
    if (b.resource_type === 'service' && b.service && b.service.slug) return '#/service/' + b.service.slug;
    return '#/categories';
  }

  function initCarousel(root, seconds) {
    const track = root.querySelector('.carousel__track');
    const slides = Array.from(root.querySelectorAll('.carousel__slide'));
    const dots = Array.from(root.querySelectorAll('.carousel__dots button'));
    if (slides.length < 2) return;
    let index = 0;
    let timer = null;
    const go = (i) => {
      index = (i + slides.length) % slides.length;
      track.style.transform = `translateX(-${index * 100}%)`;
      dots.forEach((d, di) => d.classList.toggle('is-on', di === index));
    };
    dots.forEach((dot, i) => { dot.onclick = () => { go(i); restart(); }; });
    const restart = () => {
      clearInterval(timer);
      timer = setInterval(() => go(index + 1), Math.max(2, seconds) * 1000);
    };
    restart();
    root.addEventListener('mouseenter', () => clearInterval(timer));
    root.addEventListener('mouseleave', restart);
  }

  /* =========================================================
   * CATEGORIES
   * ========================================================= */
  async function categories(view) {
    view.innerHTML = `<div class="page">${U.skeletonCards(8)}</div>`;
    let cats = [];
    try { cats = listOf(await API.getCategories(1, 60)); } catch (e) { /* handled below */ }

    view.innerHTML = `
      <div class="page">
        <header class="pagehead">
          <span class="eyebrow">Everything for your home</span>
          <h1>All services</h1>
          <p>Choose a category to see the professionals and fixed prices available near you.</p>
        </header>
        ${cats.length ? `<div class="catgrid">${cats.map(U.categoryCard).join('')}</div>`
          : U.empty({ icon: 'grid', title: 'No services in your area yet', text: 'Try setting a different service location.', action: `<button class="btn btn--primary" onclick="App.openLocationSheet()">Set location</button>` })}
      </div>`;
  }

  /* =========================================================
   * CATEGORY
   * ========================================================= */
  async function category(view, slug) {
    if (!slug) { location.hash = '#/categories'; return; }
    view.innerHTML = `<div class="page">${U.skeletonRows(2)}${U.skeletonCards(4)}</div>`;

    let subs = [];
    try {
      const res = await API.getSubgroups(slug);
      subs = listOf(res);
    } catch (e) {
      view.innerHTML = `<div class="page">${U.errorState(e)}</div>`;
      return;
    }

    if (!subs.length) {
      view.innerHTML = `<div class="page">
        <header class="pagehead"><h1>Nothing here yet</h1></header>
        ${U.empty({ icon: 'grid', title: 'No services in this category', text: 'This category is still being prepared.', action: `<a class="btn btn--primary" href="#/categories">Browse categories</a>` })}
      </div>`;
      return;
    }

    let active = subs[0];
    let page = 1;
    let all = [];
    let lastPage = 1;

    async function load() {
      const res = await API.getServices(active.slug, page, 12);
      const paged = pagedOf(res);
      const list = paged ? (paged.data || []) : [];
      all = page === 1 ? list : all.concat(list);
      lastPage = paged ? (Number(paged.last_page) || 1) : 1;
      return list;
    }

    function render() {
      view.innerHTML = `
        <div class="page">
          <nav class="crumbs"><a href="#/">Home</a>${U.icon('chevronRight', 12)}<a href="#/categories">Services</a>${U.icon('chevronRight', 12)}<span>${U.esc(subs[0] && subs[0].name || 'Category')}</span></nav>
          <header class="pagehead pagehead--inline">
            <div><span class="eyebrow">Pick a service</span><h1>${U.esc(active.name || 'Services')}</h1></div>
            <span class="count">${all.length} service${all.length === 1 ? '' : 's'}</span>
          </header>
          ${subs.length > 1 ? `<div class="chips chips--scroll">${subs.map(s => `
            <button class="chip ${s.slug === active.slug ? 'is-on' : ''}" data-slug="${U.esc(s.slug)}">
              ${U.esc(s.name)}${s.services_count ? `<i>${s.services_count}</i>` : ''}
            </button>`).join('')}</div>` : ''}
          ${active.description ? `<p class="leadtxt">${U.esc(active.description)}</p>` : ''}
          <div id="svc-grid">${all.length ? `<div class="cardgrid">${all.map(U.serviceCard).join('')}</div>`
            : U.empty({ icon: 'search', title: 'No services yet', text: 'Try another subcategory.' })}</div>
          <div class="loadmore" id="loadmore-wrap">${page < lastPage ? `<button class="btn btn--ghost" id="more">Show more services</button>` : ''}</div>
        </div>`;

      view.querySelectorAll('.chip[data-slug]').forEach(chip => {
        chip.onclick = async () => {
          active = subs.find(s => s.slug === chip.dataset.slug) || active;
          page = 1; all = [];
          view.querySelector('#svc-grid').innerHTML = U.skeletonCards(4);
          try { await load(); } catch (e) { U.toast(e.message, 'error'); }
          render();
        };
      });

      const more = view.querySelector('#more');
      if (more) more.onclick = async () => {
        more.disabled = true;
        more.textContent = 'Loading…';
        try {
          page += 1;
          const list = await load();
          if (list.length) view.querySelector('#svc-grid .cardgrid').insertAdjacentHTML('beforeend', list.map(U.serviceCard).join(''));
          more.disabled = false;
          more.textContent = 'Show more services';
          if (page >= lastPage) more.remove();
        } catch (e) {
          U.toast(e.message, 'error');
          page -= 1;
          more.disabled = false;
          more.textContent = 'Show more services';
        }
      };
    }

    try { await load(); } catch (e) { /* show empty grid with toast */ U.toast(e.message, 'error'); }
    render();
  }

  /* =========================================================
   * SERVICE DETAIL
   * ========================================================= */
  async function service(view, slug) {
    if (!slug) { location.hash = '#/categories'; return; }
    view.innerHTML = `<div class="page">${U.skeletonRows(2)}${U.skeletonCards(3)}</div>`;

    let s;
    try {
      const res = await API.getServiceDetail(slug);
      if (!ok(res) || !res.content) {
        view.innerHTML = `<div class="page">${U.empty({ icon: 'search', title: 'Service not available', text: 'It may have been removed or is not offered in your area.', action: `<a class="btn btn--primary" href="#/categories">Browse services</a>` })}</div>`;
        return;
      }
      s = res.content;
    } catch (e) {
      view.innerHTML = `<div class="page">${U.errorState(e, 'svc-retry')}</div>`;
      const retry = view.querySelector('#svc-retry');
      if (retry) retry.onclick = () => service(view, slug);
      return;
    }

    const variants = U.variantsOf(s);
    const hasVariants = variants.length > 0;
    const gallery = [s.cover_image_full_path, ...(s.gallery_full_paths || [])].filter(Boolean);
    const price = U.priceOf(s);
    let vIndex = 0;
    let qty = 1;

    view.innerHTML = `
      <div class="page page--detail">
        <nav class="crumbs">
          <a href="#/">Home</a>${U.icon('chevronRight', 12)}
          ${s.category ? `<a href="#/category/${U.esc(s.category.slug)}">${U.esc(s.category.name)}</a>${U.icon('chevronRight', 12)}` : ''}
          <span>${U.esc(s.name)}</span>
        </nav>

        <div class="detail">
          <div class="detail__media">
            <div class="gallery" id="gallery">
              <img id="gallery-main" src="${U.esc(U.imgSrc(gallery[0] || s.thumbnail_full_path))}" alt="${U.esc(s.name)}"
                onerror="this.onerror=null;this.src='${U.FALLBACK_IMG}'">
              ${gallery.length > 1 ? `<div class="gallery__thumbs">${gallery.map((g, i) => `
                <button class="${i === 0 ? 'is-on' : ''}" data-i="${i}" aria-label="View image ${i + 1}">
                  <img src="${U.esc(g)}" alt="" onerror="this.parentElement.remove()">
                </button>`).join('')}</div>` : ''}
            </div>
          </div>

          <div class="detail__info">
            <div class="detail__top">
              <div>
                ${s.category ? `<a class="eyebrow eyebrow--link" href="#/category/${U.esc(s.category.slug)}">${U.esc(s.category.name)}</a>` : ''}
                <h1>${U.esc(s.name)}</h1>
              </div>
              ${/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(String(s.id))
                ? `<button class="iconbtn iconbtn--round ${s.is_favorite ? 'is-fav' : ''}" id="fav-btn" aria-label="${s.is_favorite ? 'Remove from saved' : 'Save service'}">${U.icon('heart', 20)}</button>`
                : ''}
            </div>

            <div class="detail__meta">
              ${U.ratingInline(s)}
              ${s.order_count || s.bookings_count ? `<span class="dotmeta">${U.esc(s.bookings_count || s.order_count)} bookings</span>` : ''}
              ${Number(s.tax) ? `<span class="dotmeta">${U.esc(s.tax)}% GST applied</span>` : ''}
            </div>

            ${s.short_description ? `<p class="detail__lede">${U.esc(s.short_description)}</p>` : ''}

            <div class="pricebox">
              <div>
                <span class="pricebox__label">${hasVariants ? 'Starting from' : 'Price'}</span>
                <span class="pricebox__value">${price > 0 ? U.money(price) : 'Get a quote'}</span>
              </div>
              ${price > 0 ? `<span class="pricebox__note">Final price shown at checkout</span>` : ''}
            </div>

            ${hasVariants ? `
            <div class="block">
              <h3 class="block__title">Choose an option</h3>
              <div class="variants" id="variants">
                ${variants.map((v, i) => `
                  <button class="variant ${i === 0 ? 'is-on' : ''}" data-i="${i}" type="button">
                    <span class="variant__radio"></span>
                    <span class="variant__name">${U.esc(v.variant_name || v.variant_key)}</span>
                    <span class="variant__price">${U.money(v.price)}</span>
                  </button>`).join('')}
              </div>
            </div>` : ''}

            ${price > 0 ? `
            <div class="block block--row">
              <h3 class="block__title">Quantity</h3>
              ${U.qtyStepper(1)}
            </div>

            <div class="detail__actions">
              <button class="btn btn--primary btn--block" id="add-cart">
                ${U.icon('cart', 17)} Add to cart
              </button>
              <button class="btn btn--dark btn--block" id="buy-now">Book now</button>
            </div>
            <p class="hint hint--center">No payment needed to add to cart. Pay after your service.</p>
            ` : `
            <div class="notice notice--soft">
              ${U.icon('info', 16)}
              <div><b>This service is quoted after a quick check.</b><span>Message our team and we'll confirm the price and a slot for your home.</span></div>
            </div>
            <button class="btn btn--primary btn--block" id="request-service">${U.icon('chat', 17)} Request this service</button>`}
          </div>
        </div>

        <div class="detail__body">
          <div class="detail__main">
            ${s.description ? `<section class="block prose">
              <h2 class="block__title">About this service</h2>
              <div class="prose__body">${s.description}</div>
            </section>` : ''}

            ${(s.faqs && s.faqs.length) ? `<section class="block">
              <h2 class="block__title">Frequently asked</h2>
              <div class="faqs">
                ${s.faqs.filter(f => f.is_active !== 0).map(f => `
                  <details class="faq">
                    <summary>${U.esc(f.question || '')} ${U.icon('chevronDown', 16)}</summary>
                    <p>${U.esc(f.answer || '')}</p>
                  </details>`).join('')}
              </div>
            </section>` : ''}

            <section class="block" id="reviews-block">
              <div class="block__head">
                <h2 class="block__title">Ratings &amp; reviews</h2>
              </div>
              <div id="reviews-body">${U.skeletonRows(2)}</div>
            </section>
          </div>

          <aside class="detail__side">
            <div class="trustcard">
              <h3>Why book with us</h3>
              <ul>
                <li>${U.icon('shield', 16)} Verified professionals</li>
                <li>${U.icon('tag', 16)} Transparent fixed prices</li>
                <li>${U.icon('clock', 16)} On-time arrival promise</li>
                <li>${U.icon('refresh', 16)} Re-service if you're not happy</li>
              </ul>
            </div>
            ${s.category && s.category.children && s.category.children.length ? `
            <div class="sidecard">
              <h3>More in ${U.esc(s.category.name)}</h3>
              ${s.category.children.slice(0, 6).map(c => `<a class="menurow" href="#/category/${U.esc(c.slug)}"><span>${U.esc(c.name)}</span>${U.icon('chevronRight', 14)}</a>`).join('')}
            </div>` : ''}
          </aside>
        </div>

        <div class="stickybuy" id="stickybuy">
          <div><small>${hasVariants ? 'Selected' : 'Starting at'}</small><b id="sticky-price">${price > 0 ? U.money(price) : 'Get a quote'}</b></div>
          ${price > 0 ? `<button class="btn btn--primary" id="sticky-add">Add to cart</button>` : `<button class="btn btn--primary" id="sticky-req">Request</button>`}
        </div>
      </div>`;

    /* gallery */
    const main = view.querySelector('#gallery-main');
    view.querySelectorAll('.gallery__thumbs button').forEach(btn => {
      btn.onclick = () => {
        main.src = gallery[Number(btn.dataset.i)];
        view.querySelectorAll('.gallery__thumbs button').forEach(b => b.classList.remove('is-on'));
        btn.classList.add('is-on');
      };
    });

    /* favourite */
    const favBtn = view.querySelector('#fav-btn');
    if (favBtn) favBtn.onclick = async () => {
      if (!App.requireAuth(location.hash)) return;
      const isFav = favBtn.classList.contains('is-fav');
      favBtn.disabled = true;
      try {
        const res = isFav ? await API.removeFavorite(s.id) : await API.addFavorite(s.id);
        if (ok(res)) {
          favBtn.classList.toggle('is-fav', !isFav);
          U.toast(isFav ? 'Removed from saved services' : 'Saved for later', 'success');
        } else U.toast(res.message || 'Could not update saved services', 'error');
      } catch (e) { U.toast(e.message, 'error'); }
      favBtn.disabled = false;
    };

    /* variants + qty */
    const priceOfSelection = () => {
      const v = variants[vIndex];
      const base = v ? Number(v.price) : price;
      return base * qty;
    };
    const renderPrice = () => {
      const text = U.money(priceOfSelection());
      const sticky = view.querySelector('#sticky-price');
      if (sticky) sticky.textContent = text;
    };
    view.querySelectorAll('.variant').forEach(btn => {
      btn.onclick = () => {
        vIndex = Number(btn.dataset.i);
        view.querySelectorAll('.variant').forEach(b => b.classList.remove('is-on'));
        btn.classList.add('is-on');
        renderPrice();
      };
    });
    const stepper = view.querySelector('[data-stepper]');
    if (stepper) U.bindStepper(stepper, (value) => { qty = value; renderPrice(); });

    /* add to cart */
    const addToCart = async (btn) => {
      const v = variants[vIndex] || {};
      if (!v.variant_key) { U.toast('Please choose an option first', 'error'); return; }
      if (!state.zoneId) {
        U.toast('Set your service location so we can price this correctly', 'info');
        App.openLocationSheet();
        return;
      }
      const original = btn.innerHTML;
      btn.disabled = true;
      btn.textContent = 'Adding…';
      try {
        const res = await API.addToCart({
          service_id: s.id,
          category_id: s.category_id,
          sub_category_id: s.sub_category_id,
          variant_key: v.variant_key,
          quantity: String(qty),
        });
        if (ok(res)) {
          await API.refreshCartCount();
          U.toast('Added to cart', 'success');
          if (btn.id === 'buy-now' || btn.id === 'sticky-add') location.hash = '#/cart';
        } else {
          U.toast(res.message || 'Could not add to cart', 'error');
        }
      } catch (e) { U.toast(e.message, 'error'); }
      btn.disabled = false;
      btn.innerHTML = original;
    };
    const addBtn = view.querySelector('#add-cart');
    if (addBtn) addBtn.onclick = () => addToCart(addBtn);
    const buyBtn = view.querySelector('#buy-now');
    if (buyBtn) buyBtn.onclick = () => addToCart(buyBtn);
    const stickyAdd = view.querySelector('#sticky-add');
    if (stickyAdd) stickyAdd.onclick = () => addToCart(stickyAdd);

    /* quote request */
    const askForQuote = async () => {
      if (!App.requireAuth(location.hash)) return;
      U.openSheet(`
        <div class="sheet__head"><div><span class="eyebrow">Custom quote</span><h3>${U.esc(s.name)}</h3></div>
          <button class="iconbtn" data-close>${U.icon('close', 18)}</button></div>
        <div class="sheet__body">
          <p class="sheet__text">Tell our team what you need. We'll confirm the price and the earliest available slot.</p>
          <textarea class="input textarea" id="quote-note" rows="4" placeholder="Describe the job, size of your home, preferred timing…"></textarea>
          <button class="btn btn--primary btn--block" id="quote-send">${U.icon('chat', 16)} Start a chat with our team</button>
        </div>`);
      document.querySelector('[data-close]').onclick = U.closeSheet;
      document.querySelector('#quote-send').onclick = async () => {
        const note = document.querySelector('#quote-note').value.trim();
        try {
          const admins = await API.getChats();
          let channelId = admins && admins.content && admins.content.adminChannel && admins.content.adminChannel.id;
          if (channelId) {
            if (note) await API.sendChat(channelId, `${s.name}: ${note}`);
            U.closeSheet();
            location.hash = '#/chat/' + channelId;
          } else {
            U.closeSheet();
            location.hash = '#/support';
          }
        } catch (e) {
          U.closeSheet();
          location.hash = '#/support';
        }
      };
    };
    const reqBtn = view.querySelector('#request-service');
    if (reqBtn) reqBtn.onclick = askForQuote;
    const stickyReq = view.querySelector('#sticky-req');
    if (stickyReq) stickyReq.onclick = askForQuote;

    loadReviews(view, s);
    renderPrice();
  }

  async function loadReviews(view, s, page = 1) {
    const host = view.querySelector('#reviews-body');
    if (!host) return;
    try {
      const res = await API.getServiceReviews(s.id, page, 5);
      if (!ok(res)) { host.innerHTML = U.empty({ icon: 'star', title: 'No reviews yet', text: 'Be the first to review this service after your booking.' }); return; }
      const content = res.content || {};
      const reviews = (content.reviews && content.reviews.data) || [];
      const rating = content.rating || {};
      const groups = rating.rating_group_count || [];
      const total = Number(rating.rating_count) || 0;
      const avg = Number(rating.average_rating) || 0;

      const breakdown = [5, 4, 3, 2, 1].map(star => {
        const g = groups.find(x => Number(x.review_rating) === star);
        const count = g ? Number(g.total) : 0;
        const pct = total ? Math.round((count / total) * 100) : 0;
        return `<div class="rbar"><span>${star}★</span><div class="rbar__track"><i style="width:${pct}%"></i></div><b>${count}</b></div>`;
      }).join('');

      host.innerHTML = `
        <div class="rating-summary">
          <div class="rating-summary__score">
            <b>${avg ? avg.toFixed(1) : '—'}</b>
            ${U.stars(avg, 15)}
            <small>${total} rating${total === 1 ? '' : 's'}</small>
          </div>
          <div class="rating-summary__bars">${breakdown}</div>
        </div>
        ${reviews.length ? `<div class="reviewlist">${reviews.map(r => {
          const c = r.customer || {};
          const name = [c.first_name, c.last_name].filter(Boolean).join(' ') || 'Verified customer';
          return `<article class="review">
            <header>
              <span class="review__avatar">${U.esc(U.initials(c.first_name, c.last_name))}</span>
              <div><b>${U.esc(name)}</b><small>${U.esc(U.fmtDate(r.booking_date || r.created_at, false))}</small></div>
              ${U.stars(r.review_rating, 13)}
            </header>
            ${r.review_comment ? `<p>${U.esc(r.review_comment)}</p>` : `<p class="muted">No comment left.</p>`}
            ${(r.review_images && r.review_images.length) ? `<div class="review__imgs">${r.review_images.map(i => `<img src="${U.esc(i)}" alt="" loading="lazy">`).join('')}</div>` : ''}
            ${r.review_reply && r.review_reply.reply ? `<div class="review__reply"><b>Response from the team</b><p>${U.esc(r.review_reply.reply)}</p></div>` : ''}
          </article>`;
        }).join('')}</div>` : U.empty({ icon: 'star', title: 'No written reviews yet', text: 'Ratings will appear here as customers book this service.' })}
        ${content.reviews && Number(content.reviews.current_page) < Number(content.reviews.last_page)
          ? `<div class="loadmore"><button class="btn btn--ghost" id="more-reviews">More reviews</button></div>` : ''}`;

      const more = host.querySelector('#more-reviews');
      if (more) more.onclick = () => loadReviews(view, s, page + 1);
    } catch (e) {
      host.innerHTML = U.empty({ icon: 'star', title: 'Reviews unavailable', text: 'Please try again in a moment.' });
    }
  }

  /* =========================================================
   * SEARCH
   * ========================================================= */
  async function search(view, query, params) {
    let term = query || '';
    let sort = (params && params.sort) || 'default';
    let page = 1;
    let lastPage = 1;
    let results = [];

    view.innerHTML = `
      <div class="page">
        <header class="pagehead">
          <span class="eyebrow">Search</span>
          <h1>Find the right help</h1>
        </header>
        <form class="bigsearch" id="bigsearch">
          ${U.icon('search', 18)}
          <input class="input" type="search" name="q" value="${U.esc(term)}" placeholder="Search for cleaning, plumbing, AC repair…" aria-label="Search services" autocomplete="off">
          <button class="btn btn--primary" type="submit">Search</button>
        </form>
        <div class="searchbar-row">
          ${term ? `<p class="resultline" id="resultline">Searching for “${U.esc(term)}”…</p>` : `<div class="hintchips" id="hintchips"></div>`}
          <label class="select">
            <span>Sort</span>
            <select id="sort-select">
              <option value="default">Recommended</option>
              <option value="top_rated">Top rated</option>
              <option value="most_loved">Most loved</option>
              <option value="popular">Popular</option>
              <option value="newest">Newest</option>
              <option value="trending">Trending</option>
            </select>
          </label>
        </div>
        <div id="search-results"></div>
      </div>`;

    const form = view.querySelector('#bigsearch');
    form.onsubmit = (e) => {
      e.preventDefault();
      const q = form.querySelector('input').value.trim();
      location.hash = '#/search?q=' + encodeURIComponent(q);
    };
    const select = view.querySelector('#sort-select');
    select.value = sort;
    select.onchange = () => { sort = select.value; run(true); };

    async function run(reset) {
      const host = view.querySelector('#search-results');
      if (reset) { page = 1; results = []; host.innerHTML = U.skeletonCards(4); }
      const line = view.querySelector('#resultline');
      if (line) line.textContent = `Searching for “${term}”…`;
      try {
        const res = await API.search(term, { offset: page, sort_by_type: sort === 'default' ? undefined : sort });
        const content = res && res.content;
        const paged = content && (content.services || content);
        const list = (paged && (paged.data || paged.serviceList)) || [];
        results = reset ? list : results.concat(list);
        lastPage = Number(paged && paged.last_page) || 1;
        render();
      } catch (e) {
        host.innerHTML = U.errorState(e, 'search-retry');
        const retry = host.querySelector('#search-retry');
        if (retry) retry.onclick = () => run(true);
      }
    }

    function render() {
      const host = view.querySelector('#search-results');
      const line = view.querySelector('#resultline');
      if (line) line.textContent = results.length
        ? `${results.length} service${results.length === 1 ? '' : 's'} for “${term}”`
        : `No services found for “${term}”`;
      if (!results.length) {
        host.innerHTML = U.empty({
          icon: 'search',
          title: 'No matches yet',
          text: 'Try a shorter phrase, or browse categories to find what you need.',
          action: `<a class="btn btn--primary" href="#/categories">Browse services</a>`,
        });
        return;
      }
      host.innerHTML = `<div class="cardgrid">${results.map(U.serviceCard).join('')}</div>
        ${page < lastPage ? `<div class="loadmore"><button class="btn btn--ghost" id="search-more">Show more</button></div>` : ''}`;
      const more = host.querySelector('#search-more');
      if (more) more.onclick = async () => {
        more.disabled = true; more.textContent = 'Loading…';
        page += 1;
        try {
          const res = await API.search(term, { offset: page, sort_by_type: sort === 'default' ? undefined : sort });
          const paged = res && res.content && (res.content.services || res.content);
          const list = (paged && paged.data) || [];
          results = results.concat(list);
          render();
        } catch (e) { U.toast(e.message, 'error'); more.disabled = false; more.textContent = 'Show more'; }
      };
    }

    if (!term) {
      try {
        const res = await API.searchHints();
        const hints = (res && res.content) || [];
        const host = view.querySelector('#hintchips');
        if (host && hints.length) {
          host.innerHTML = `<span class="hintchips__label">Popular searches</span>` +
            hints.slice(0, 12).map(h => `<button class="pill-chip" data-q="${U.esc(h.name || h)}">${U.esc(h.name || h)}</button>`).join('');
          host.querySelectorAll('[data-q]').forEach(b => {
            b.onclick = () => { location.hash = '#/search?q=' + encodeURIComponent(b.dataset.q); };
          });
        }
      } catch (e) { /* hints optional */ }
      view.querySelector('#search-results').innerHTML = '';
      return;
    }

    await run(true);
  }

  /* =========================================================
   * OFFERS
   * ========================================================= */
  async function offers(view) {
    view.innerHTML = `<div class="page">${U.skeletonRows(3)}</div>`;
    let data = {};
    try {
      const res = await API.getCoupons();
      data = (res && res.content) || {};
    } catch (e) {
      view.innerHTML = `<div class="page">${U.errorState(e, 'offers-retry')}</div>`;
      const retry = view.querySelector('#offers-retry');
      if (retry) retry.onclick = () => offers(view);
      return;
    }

    const active = (data.active_coupons && data.active_coupons.data) || [];
    const expired = (data.expired_coupons && data.expired_coupons.data) ||
      (data.exptred_coupons && data.exptred_coupons.data) || [];

    const card = (c, isExpired) => {
      const d = c.discount || {};
      const code = c.coupon_code || c.code || '';
      const value = d.discount_amount != null
        ? (String(d.discount_type || '').includes('percent') ? `${Number(d.discount_amount)}% off` : `${U.money(d.discount_amount)} off`)
        : 'Special offer';
      const min = Number(d.min_purchase) > 0 ? `Min. order ${U.money(d.min_purchase)}` : '';
      const max = Number(d.max_discount) > 0 ? `Up to ${U.money(d.max_discount)}` : '';
      const till = d.end_date ? `Valid till ${U.fmtDate(d.end_date, false)}` : '';
      return `<article class="coupon ${isExpired ? 'coupon--off' : ''}">
        <div class="coupon__stub">
          ${U.icon('ticket', 20)}
          <b>${U.esc(value)}</b>
        </div>
        <div class="coupon__body">
          <div class="coupon__head">
            <span class="coupon__code">${U.esc(code)}</span>
            ${isExpired ? `<span class="pill pill--canceled">Expired</span>` : `<button class="btn btn--ghost btn--xs" data-copy="${U.esc(code)}">Copy</button>`}
          </div>
          ${c.title || c.coupon_title ? `<h3>${U.esc(c.title || c.coupon_title)}</h3>` : ''}
          <p>${U.esc(min || max || 'Applies to eligible services at checkout.')}${min && max ? ' · ' + U.esc(max) : ''}</p>
          <div class="coupon__foot">
            <small>${U.esc(till)}</small>
            ${!isExpired ? `<a class="link" href="#/cart">Use in cart ${U.icon('arrowRight', 13)}</a>` : ''}
          </div>
        </div>
      </article>`;
    };

    view.innerHTML = `
      <div class="page">
        <header class="pagehead">
          <span class="eyebrow">Save on your next booking</span>
          <h1>Offers &amp; coupons</h1>
          <p>Apply a code in your cart — the discount is calculated before you pay.</p>
        </header>
        ${active.length ? `<div class="couponlist">${active.map(c => card(c, false)).join('')}</div>`
          : U.empty({ icon: 'ticket', title: 'No live offers right now', text: 'New offers land here first — keep an eye out.' })}
        ${expired.length ? `<section class="section"><h2 class="section__plain">Expired offers</h2>
          <div class="couponlist">${expired.map(c => card(c, true)).join('')}</div></section>` : ''}
      </div>`;

    view.querySelectorAll('[data-copy]').forEach(btn => {
      btn.onclick = async () => {
        await U.copyText(btn.dataset.copy);
        U.toast('Code copied', 'success');
      };
    });
  }

  Object.assign(window.Views, { home, categories, category, service, search, offers });
})();
