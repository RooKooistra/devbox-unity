#!/usr/bin/env bash
set -Eeuo pipefail

DBU_GPU_VENDOR="unknown"
DBU_NVIDIA_CDI_AVAILABLE="false"

dbu_detect_gpu_vendor() {
    dbu_info "Detecting graphics hardware..."

    DBU_GPU_VENDOR="unknown"
    DBU_NVIDIA_CDI_AVAILABLE="false"

    if ! command -v lspci >/dev/null 2>&1; then
        dbu_warn "lspci is not available; GPU vendor could not be detected."
        dbu_warn "Continuing without vendor-specific GPU integration."
        return 0
    fi

    local gpu_info
    gpu_info="$(
        lspci 2>/dev/null |
        grep -Ei 'VGA compatible controller|3D controller|Display controller' ||
        true
    )"

    if [[ -z "$gpu_info" ]]; then
        dbu_warn "No graphics adapter was detected."
        dbu_warn "Continuing without vendor-specific GPU integration."
        return 0
    fi

    if grep -Eqi 'NVIDIA' <<< "$gpu_info"; then
        DBU_GPU_VENDOR="nvidia"
    elif grep -Eqi 'AMD|ATI|Advanced Micro Devices' <<< "$gpu_info"; then
        DBU_GPU_VENDOR="amd"
    elif grep -Eqi 'Intel' <<< "$gpu_info"; then
        DBU_GPU_VENDOR="intel"
    fi

    case "$DBU_GPU_VENDOR" in
        nvidia)
            dbu_info "GPU vendor: NVIDIA"
            dbu_detect_nvidia_cdi
            ;;
        amd)
            dbu_info "GPU vendor: AMD"
            dbu_info "Using standard Distrobox GPU integration."
            ;;
        intel)
            dbu_info "GPU vendor: Intel"
            dbu_info "Using standard Distrobox GPU integration."
            ;;
        unknown)
            dbu_warn "GPU vendor could not be identified."
            dbu_warn "Continuing without vendor-specific GPU integration."
            ;;
    esac
}

dbu_detect_nvidia_cdi() {
    dbu_info "Checking NVIDIA CDI support..."

    if ! command -v nvidia-ctk >/dev/null 2>&1; then
        dbu_warn "NVIDIA Container Toolkit was not found."
        dbu_warn "NVIDIA CDI integration is unavailable."
        return 0
    fi

    local cdi_devices
    cdi_devices="$(nvidia-ctk cdi list 2>/dev/null || true)"

    if grep -Fxq 'nvidia.com/gpu=all' <<< "$cdi_devices"; then
        DBU_NVIDIA_CDI_AVAILABLE="true"
        dbu_success "NVIDIA CDI support detected."
        return 0
    fi

    dbu_warn "NVIDIA CDI device nvidia.com/gpu=all was not found."
    dbu_warn "NVIDIA CDI integration is unavailable."
}
