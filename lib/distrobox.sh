#!/usr/bin/env bash
set -Eeuo pipefail

dbu_has_distrobox() {
    command -v distrobox >/dev/null 2>&1
}

dbu_has_distrobox_export() {
    command -v distrobox-export >/dev/null 2>&1
}

dbu_check_distrobox() {
    if dbu_has_distrobox; then
        dbu_success "Distrobox found."
    else
        dbu_error "Distrobox is required on the host but was not found."
        return 1
    fi
}

dbu_container_exists() {
    distrobox list --no-color 2>/dev/null |
        awk 'NR > 1 { print $3 }' |
        grep -Fxq "$DBU_CONTAINER_NAME"
}

dbu_create_container() {
    dbu_info "Creating container: $DBU_CONTAINER_NAME"
    dbu_info "Image: $DBU_CONTAINER_IMAGE"

    dbu_detect_gpu_vendor

    local -a create_args=(
        create
        --name "$DBU_CONTAINER_NAME"
        --image "$DBU_CONTAINER_IMAGE"
        --yes
    )

    if [[ "$DBU_GPU_VENDOR" == "nvidia" ]]; then
        if dbu_is_true "$DBU_NVIDIA_CDI_AVAILABLE"; then
            dbu_info "Enabling NVIDIA GPU access through CDI."
            create_args+=(
                --additional-flags
                "--device nvidia.com/gpu=all"
            )
        else
            dbu_error "NVIDIA GPU detected, but NVIDIA CDI is unavailable."
            dbu_error "Cannot safely configure NVIDIA GPU access."
            return 1
        fi
    fi

    if dbu_is_true "${DBU_DRY_RUN:-false}"; then
        dbu_info "[DRY] distrobox ${create_args[*]}"
        return 0
    fi

    distrobox "${create_args[@]}"
}

dbu_ensure_container() {
    dbu_check_distrobox

    if dbu_container_exists; then
        dbu_success "Container already exists: $DBU_CONTAINER_NAME"
        return 0
    fi

    dbu_create_container
}

dbu_run_installer_in_container() {
    local installer_path="$1"
    local -a forwarded_args=("${@:2}")

    dbu_info "Starting container installation..."

    if dbu_is_true "${DBU_DRY_RUN:-false}"; then
        dbu_info \
            "[DRY] distrobox enter $DBU_CONTAINER_NAME -- $installer_path --mode container ${forwarded_args[*]}"
        return 0
    fi

    distrobox enter "$DBU_CONTAINER_NAME" -- \
        "$installer_path" \
        --mode container \
        "${forwarded_args[@]}"
}
