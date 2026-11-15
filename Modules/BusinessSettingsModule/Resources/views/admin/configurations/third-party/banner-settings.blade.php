@php
    $sliderBanners = $sliderBanners ?? collect();
    // Keep crop output below both PHP's configured upload size and a safe
    // browser-to-server payload size, including multipart request overhead.
    $sliderMaxUploadKb = max(1, min(900, (int) floor(uploadMaxFileSizeInKB('image') * 0.80)));
@endphp

{{-- =================== 1. AUTO SLIDE DURATION =================== --}}
@if(isset($bannerSettings))
<div class="card mb-4">
    <div class="p-20 border-bottom">
        <h4 class="page-title mb-1">{{ translate('Home banner slider settings') }}</h4>
        <p class="fz-12 mb-0">{{ translate('Manage the auto slide duration of the home screen banner slider') }}</p>
    </div>
    <div class="card-body p-20">
        <form action="{{ route('admin.configuration.set-banner-settings') }}" method="POST">
            @csrf
            @method('PUT')
            <div class="row g-3">
                <div class="col-md-4 col-12">
                    <label class="mb-2 text-dark d-flex align-items-center gap-1">
                        {{ translate('Auto slide duration (seconds)') }}
                        <i class="material-icons fz-14 text-muted" data-bs-toggle="tooltip"
                           title="{{ translate('Time in seconds after which the slider automatically moves to the next banner.') }}">info</i>
                    </label>
                    <input type="number" class="form-control" min="1" max="60" step="1"
                           name="banner_auto_slide_duration"
                           placeholder="{{ translate('e.g. 5') }}"
                           required
                           value="{{ $bannerSettings['banner_auto_slide_duration'] ?? 5 }}">
                </div>
            </div>
            @can('configuration_update')
                <div class="d-flex justify-content-end gap-2 mt-20">
                    <button type="reset" class="btn btn--secondary rounded">{{ translate('reset') }}</button>
                    <button type="submit" class="btn btn--primary demo_check rounded">{{ translate('update') }}</button>
                </div>
            @endcan
        </form>
    </div>
</div>
@endif

{{-- =================== 2. SLIDER BANNER UPLOAD =================== --}}
<div class="card mb-4">
    <div class="p-20 border-bottom d-flex align-items-center justify-content-between flex-wrap gap-2">
        <div>
            <h4 class="page-title mb-1">{{ translate('Home Screen Slider Banners') }}</h4>
            <p class="fz-12 mb-0">
                {{ translate('Upload images that will appear as the home screen carousel slider in the user app. You can add unlimited banners.') }}
            </p>
        </div>
        <span class="badge badge--primary px-3 py-2 fz-14">
            {{ $sliderBanners->count() }} {{ translate('banner(s)') }}
        </span>
    </div>

    {{-- Upload form --}}
    @can('configuration_update')
    <div class="card-body p-20 border-bottom bg-light">
        <form action="{{ route('admin.configuration.slider-banner.add') }}" method="POST" enctype="multipart/form-data" id="sliderUploadForm">
            @csrf
            <div class="row g-3 align-items-end">
                {{-- Title --}}
                <div class="col-md-3 col-12">
                    <label class="mb-2 text-dark">{{ translate('Banner Title') }} <span class="text-muted fz-11">({{ translate('optional') }})</span></label>
                    <input type="text" name="slider_title" class="form-control"
                           placeholder="{{ translate('e.g. Summer Offer') }}" maxlength="191">
                </div>

                {{-- Redirect link --}}
                <div class="col-md-3 col-12">
                    <label class="mb-2 text-dark">{{ translate('Redirect Link') }} <span class="text-muted fz-11">({{ translate('optional') }})</span></label>
                    <input type="url" name="redirect_link" class="form-control"
                           placeholder="https://example.com">
                </div>

                {{-- Image upload --}}
                <div class="col-md-4 col-12">
                    <label class="mb-2 text-dark">
                        {{ translate('Banner Image') }} <span class="text-danger">*</span>
                    </label>
                    <div class="small text-muted mb-2" id="sliderImageSpecs">
                        Customer app hero: full screen width × 400 dp. Crop ratio 1:1; saved image 1080 × 1080 px, compressed below {{ $sliderMaxUploadKb }} KB for reliable upload.
                    </div>
                    <input type="file" name="slider_image" id="sliderImageInput"
                           class="form-control" accept="image/jpeg,image/png,image/webp,image/gif"
                           required onchange="openSliderCropper(this)">
                </div>

                {{-- Preview + submit --}}
                <div class="col-md-2 col-12 d-flex align-items-center gap-2">
                    <div class="d-flex align-items-center gap-2 flex-grow-1">
                        <img id="sliderPreview" src="#" alt="Cropped banner preview"
                             class="rounded border d-none"
                             style="height:42px;width:70px;object-fit:cover;">
                        <button type="button" id="reopenSliderCrop" class="btn btn--secondary rounded text-nowrap" disabled>
                            Crop image
                        </button>
                    </div>
                    <button type="submit" class="btn btn--primary demo_check w-100">
                        <i class="material-icons fz-18 align-middle">add_photo_alternate</i>
                        {{ translate('Add') }}
                    </button>
                </div>
            </div>
        </form>
    </div>
    @endcan

    {{-- Crop banner to match the mobile home hero frame before upload. --}}
    <div class="modal fade" id="sliderCropModal" tabindex="-1" aria-labelledby="sliderCropModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <div>
                        <h5 class="modal-title mb-1" id="sliderCropModalLabel">Crop home banner</h5>
                        <p class="text-muted fz-12 mb-0">Adjust the image inside the 1:1 crop frame. The app displays this banner full width at 400 dp high.</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="slider-crop-stage">
                        <img id="sliderCropImage" src="" alt="Crop home banner">
                    </div>
                    <p class="text-muted fz-12 mt-2 mb-0">Output: 1080 × 1080 px (1:1), compressed below {{ $sliderMaxUploadKb }} KB based on the server upload limit. Customer app display: full screen width × 400 dp, using cover fit. Keep important content near the center.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn--secondary rounded" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn--primary rounded" id="applySliderCrop">Crop &amp; Use Image</button>
                </div>
            </div>
        </div>
    </div>

    {{-- Banners grid --}}
    <div class="card-body p-20">
        @if($sliderBanners->isEmpty())
            <div class="d-flex flex-column align-items-center justify-content-center py-5 text-center">
                <img src="{{ asset('public/assets/admin-module/img/media/banner-upload-file.png') }}"
                     alt="no banners" style="height:80px;opacity:.5;" class="mb-3"
                     onerror="this.style.display='none'">
                <p class="text-muted mb-0">{{ translate('No slider banners yet. Upload your first banner above.') }}</p>
            </div>
        @else
            <div class="row g-3" id="sliderBannerGrid">
                @foreach($sliderBanners as $banner)
                <div class="col-xl-3 col-lg-4 col-md-6 col-12" id="slider-card-{{ $banner->id }}">
                    <div class="card h-100 border shadow-sm">
                        {{-- Image --}}
                        <div style="height:160px;overflow:hidden;background:#f8f8f8;" class="rounded-top">
                            <img src="{{ $banner->banner_image_full_path }}"
                                 alt="{{ $banner->banner_title ?? 'Slider Banner' }}"
                                 style="width:100%;height:100%;object-fit:cover;"
                                 onerror="this.src='{{ asset('public/assets/admin-module/img/placeholder.png') }}'">
                        </div>

                        <div class="card-body p-12px">
                            {{-- Title --}}
                            <p class="fw-semibold mb-1 text-truncate fz-13" title="{{ $banner->banner_title ?? '' }}">
                                {{ $banner->banner_title ?: translate('Untitled Banner') }}
                            </p>

                            {{-- Redirect link --}}
                            @if($banner->redirect_link)
                                <a href="{{ $banner->redirect_link }}" target="_blank"
                                   class="d-block fz-11 text-muted text-truncate mb-2"
                                   title="{{ $banner->redirect_link }}">
                                    <i class="material-icons fz-12 align-middle">link</i>
                                    {{ $banner->redirect_link }}
                                </a>
                            @else
                                <p class="fz-11 text-muted mb-2">{{ translate('No redirect link') }}</p>
                            @endif

                            {{-- Active toggle + delete --}}
                            <div class="d-flex align-items-center justify-content-between mt-auto">
                                <div class="d-flex align-items-center gap-2">
                                    <label class="switcher mb-0" title="{{ translate('Toggle active status') }}">
                                        <input type="checkbox" class="switcher_input slider-toggle"
                                               data-id="{{ $banner->id }}"
                                               {{ $banner->is_active ? 'checked' : '' }}>
                                        <span class="switcher_control"></span>
                                    </label>
                                    <span class="fz-11 text-muted">
                                        {{ $banner->is_active ? translate('Active') : translate('Inactive') }}
                                    </span>
                                </div>

                                @can('configuration_update')
                                <form action="{{ route('admin.configuration.slider-banner.delete', $banner->id) }}"
                                      method="POST"
                                      onsubmit="return confirm('{{ translate('Delete this slider banner?') }}')">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-sm btn-outline-danger p-1"
                                            title="{{ translate('Delete') }}">
                                        <i class="material-icons fz-16">delete_outline</i>
                                    </button>
                                </form>
                                @endcan
                            </div>
                        </div>
                    </div>
                </div>
                @endforeach
            </div>
        @endif
    </div>
</div>

<link rel="stylesheet" href="{{ asset('public/assets/admin-module/plugins/cropper/cropper.min.css') }}">
<style>
    .slider-crop-stage { height: min(62vh, 620px); min-height: 280px; overflow: hidden; border-radius: 10px; background: #f3f4f6; }
    .slider-crop-stage > img { display: block; max-width: 100%; }
</style>

{{-- =================== JS =================== --}}
@push('script')
<script src="{{ asset('public/assets/admin-module/plugins/cropper/cropper.min.js') }}"></script>
<script>
    let sliderCropper = null;
    let sliderCropInput = null;
    let sliderPendingFile = null;
    let sliderCropSourceUrl = null;
    let sliderPreviewUrl = null;
    const sliderCropModalElement = document.getElementById('sliderCropModal');
    const sliderCropModal = bootstrap.Modal.getOrCreateInstance(sliderCropModalElement);
    const sliderCropImage = document.getElementById('sliderCropImage');
    const sliderPreview = document.getElementById('sliderPreview');
    const reopenSliderCrop = document.getElementById('reopenSliderCrop');

    function openSliderCropper(input) {
        if (!input.files || !input.files[0]) return;
        if (sliderCropper) {
            sliderCropper.destroy();
            sliderCropper = null;
        }
        if (sliderCropSourceUrl) URL.revokeObjectURL(sliderCropSourceUrl);
        sliderCropInput = input;
        sliderPendingFile = input.files[0];
        input.dataset.cropReady = 'false';
        reopenSliderCrop.disabled = false;
        reopenSliderCrop.textContent = 'Crop image';
        sliderCropSourceUrl = URL.createObjectURL(sliderPendingFile);
        sliderCropImage.src = sliderCropSourceUrl;
        sliderCropModal.show();
    }

    reopenSliderCrop.addEventListener('click', function () {
        openSliderCropper(document.getElementById('sliderImageInput'));
    });

    sliderCropModalElement.addEventListener('shown.bs.modal', function () {
        if (sliderCropper) sliderCropper.destroy();
        sliderCropper = new Cropper(sliderCropImage, {
            aspectRatio: 1,
            viewMode: 1,
            autoCropArea: 0.94,
            responsive: true,
            background: false,
            guides: true,
            center: true,
            movable: true,
            zoomable: true,
            cropBoxMovable: true,
            cropBoxResizable: true,
            minContainerWidth: 280,
            minContainerHeight: 280,
        });
    });

    async function createSliderUploadBlob(sourceCanvas) {
        const maxBytes = {{ $sliderMaxUploadKb * 1024 }};
        const encode = (canvas, quality) => new Promise(resolve =>
            canvas.toBlob(resolve, 'image/jpeg', quality)
        );

        // Keep the full 1080px crop whenever possible; reduce JPEG quality only
        // as much as required to stay below conservative PHP upload limits.
        for (const quality of [0.84, 0.78, 0.72, 0.66, 0.60, 0.54, 0.48]) {
            const blob = await encode(sourceCanvas, quality);
            if (blob && blob.size <= maxBytes) return blob;
        }

        // Very detailed photos can still exceed the limit. Downscale safely
        // while preserving the same square crop and composition.
        for (const size of [960, 900, 840, 720]) {
            const resized = document.createElement('canvas');
            resized.width = size;
            resized.height = size;
            resized.getContext('2d').drawImage(sourceCanvas, 0, 0, size, size);
            const blob = await encode(resized, 0.68);
            if (blob && blob.size <= maxBytes) return blob;
        }

        return null;
    }

    document.getElementById('applySliderCrop').addEventListener('click', async function () {
        if (!sliderCropper || !sliderCropInput || !sliderPendingFile) return;
        const applyButton = this;
        const canvas = sliderCropper.getCroppedCanvas({
            width: 1080,
            height: 1080,
            imageSmoothingEnabled: true,
            imageSmoothingQuality: 'high',
            fillColor: '#ffffff',
        });
        if (!canvas) {
            alert('Could not crop this image. Please choose another image.');
            return;
        }
        applyButton.disabled = true;
        try {
            const blob = await createSliderUploadBlob(canvas);
            if (!blob) {
                alert('Could not prepare this image for upload. Please choose another image.');
                return;
            }
            const baseName = sliderPendingFile.name.replace(/\.[^.]+$/, '') || 'home-banner';
            const croppedFile = new File([blob], baseName + '_cropped.jpg', {
                type: 'image/jpeg',
                lastModified: Date.now(),
            });
            const transfer = new DataTransfer();
            transfer.items.add(croppedFile);
            sliderCropInput.files = transfer.files;
            sliderCropInput.dataset.cropReady = 'true';
            if (sliderPreviewUrl) URL.revokeObjectURL(sliderPreviewUrl);
            sliderPreviewUrl = URL.createObjectURL(croppedFile);
            sliderPreview.src = sliderPreviewUrl;
            sliderPreview.classList.remove('d-none');
            reopenSliderCrop.disabled = false;
            reopenSliderCrop.textContent = 'Adjust crop';
            sliderCropModal.hide();
        } catch (error) {
            console.error('Slider image compression failed:', error);
            alert('Could not prepare this image for upload. Please try another image.');
        } finally {
            applyButton.disabled = false;
        }
    });

    sliderCropModalElement.addEventListener('hidden.bs.modal', function () {
        if (sliderCropper) {
            sliderCropper.destroy();
            sliderCropper = null;
        }
        if (sliderCropSourceUrl) {
            URL.revokeObjectURL(sliderCropSourceUrl);
            sliderCropSourceUrl = null;
        }
        if (sliderCropInput && sliderCropInput.dataset.cropReady !== 'true') {
            sliderCropInput.value = '';
            sliderPreview.classList.add('d-none');
            reopenSliderCrop.disabled = true;
            reopenSliderCrop.textContent = 'Crop image';
        }
        sliderCropInput = null;
        sliderPendingFile = null;
    });

    document.getElementById('sliderUploadForm').addEventListener('submit', function (event) {
        const input = document.getElementById('sliderImageInput');
        if (!input.files.length || input.dataset.cropReady !== 'true') {
            event.preventDefault();
            alert('Please crop the banner image before uploading.');
        }
    });

    // Active toggle via AJAX
    document.querySelectorAll('.slider-toggle').forEach(function(toggle) {
        toggle.addEventListener('change', function() {
            const id = this.dataset.id;
            const label = this.closest('.d-flex').querySelector('span.fz-11');
            const isActive = this.checked;

            fetch("{{ url('admin/configuration/slider-banner/toggle') }}/" + id, {
                method: 'PATCH',
                headers: {
                    'X-CSRF-TOKEN': '{{ csrf_token() }}',
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                },
            })
            .then(res => res.json())
            .then(data => {
                if (label) {
                    label.textContent = isActive ? '{{ translate('Active') }}' : '{{ translate('Inactive') }}';
                }
            })
            .catch(() => {
                // revert on error
                toggle.checked = !isActive;
            });
        });
    });
</script>
@endpush
