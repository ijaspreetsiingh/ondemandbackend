<hr class="my-4">

<!-- STEP: SELECT PROVIDERS (list auto-filters by zone + category/service) -->
<div class="provider-selector mb-30">
    @isset($heading)
        <h5 class="mb-3">{{ $heading }}</h5>
    @endisset

    <label class="mb-2">{{ translate('Select Providers') }}</label>
    <select class="provider-select theme-input-style w-100" name="provider_ids[]"
            multiple="multiple" id="provider_selector__select"
            data-placeholder="{{ translate('Select Providers') }}"
            data-selected="{{ json_encode($selectedProviderIds ?? []) }}">
        <option value="all">{{ translate('Select All') }}</option>
    </select>

    <small class="text-muted d-block mt-2">
        {{ translate('Leave empty to apply for all providers. The list narrows down automatically when you pick zones or categories/services.') }}
    </small>
</div>

@push('script')
    <script>
        "use strict";

        (function () {
            if (window.__providerCascadeInitialized) return;
            window.__providerCascadeInitialized = true;

            var $select = $('#provider_selector__select');

            function escapeHtml(value) {
                return $('<div>').text(value == null ? '' : value).html();
            }

            function selectedProviderIds() {
                if (!$select.length) return [];

                var vals = ($select.val() || []).filter(function (v) {
                    return v !== 'loading' && v !== '0' && v !== 'hint' && v !== 'all';
                });
                if (vals.length) return vals;

                var raw = $select.data('selected');
                if (typeof raw === 'string') {
                    try { raw = JSON.parse(raw); } catch (e) { raw = []; }
                }
                return Array.isArray(raw) ? raw.map(String) : [];
            }

            function renderProviders(providers, keep) {
                if (!$select.length) return;

                keep = (keep || []).map(String);

                var html = '<option value="all">{{ translate("Select All") }}</option>';

                if (providers.length > 0) {
                    providers.forEach(function (provider) {
                        var selectedAttr = keep.indexOf(String(provider.id)) !== -1 ? 'selected' : '';
                        var label = escapeHtml(provider.name);
                        if (provider.categories && provider.categories.length > 0) {
                            label += ' (' + escapeHtml(provider.categories.join(', ')) + ')';
                        }
                        html += '<option value="' + escapeHtml(provider.id) + '" ' + selectedAttr + '>' +
                            label + '</option>';
                    });
                } else {
                    html += '<option value="" disabled>{{ translate("No providers found") }}</option>';
                }

                $select.html(html);
                $select.removeAttr('data-selected');

                if ($.fn.select2 && $select.data('select2')) {
                    $select.trigger('change.select2');
                }
            }

            var loadTimer = null;
            function loadProviders() {
                clearTimeout(loadTimer);
                loadTimer = setTimeout(function () {
                    if (!$select.length) return;

                    var keep = selectedProviderIds();
                    var discountType = $('input[name="discount_type"]:checked').val() || 'category';

                    // Koi zone/category/service select nahi kiya? Tab bhi list
                    // load hoti hai (saare providers). Backend empty filter par
                    // sab active providers return karta hai.
                    $.ajax({
                        url: '{{ $providerRoute }}',
                        type: 'POST',
                        data: {
                            _token: '{{ csrf_token() }}',
                            category_ids: $('#category_selector__select').val() || [],
                            service_ids: $('#service_selector__select').val() || [],
                            zone_ids: $('#zone_selector__select').val() || [],
                            discount_type: discountType
                        },
                        success: function (response) {
                            renderProviders((response && response.providers) ? response.providers : [], keep);
                        },
                        error: function () {
                            renderProviders([], keep);
                        }
                    });
                }, 120);
            }

            // "Select All" — select2 ka UI bhi refresh hona chahiye.
            $(document).on('change', '#provider_selector__select', function () {
                var $el = $(this);
                var values = $el.val() || [];

                if (values.indexOf('all') === -1) return;

                $el.find('option').each(function () {
                    var $option = $(this);
                    if ($option.val() === 'all' || $option.prop('disabled')) return;
                    $option.prop('selected', true);
                });
                $el.find('option[value="all"]').prop('selected', false);
                $el.trigger('change.select2');
            });

            $('#category_selector__select, #service_selector__select, #zone_selector__select').on('change', loadProviders);
            $('input[name="discount_type"]').on('change', loadProviders);

            if ($.fn.select2 && !$select.data('select2')) {
                $select.select2({
                    width: '100%',
                    closeOnSelect: false,
                    placeholder: '{{ translate("Select Providers") }}'
                });
            }

            // Page khulte hi list aa jati hai — user ko pehle zone/category
            // select karne ka intezaar nahi karna padta.
            loadProviders();
        })();
    </script>
@endpush
