#!/usr/bin/env bash
set -Eeuo pipefail

dbu_require_command() {
    local command_name="$1"

    if ! command -v "$command_name" >/dev/null 2>&1; then
        dbu_error "Required command not found: $command_name"
        return 1
    fi
}

dbu_in_container() {
    [[ -f /.dockerenv ]] ||
        [[ -n "${container:-}" ]] ||
        grep -qaE \
            '(docker|podman|toolbox|distrobox)' \
            /proc/1/environ 2>/dev/null
}

dbu_distribution_id() {
    if [[ ! -f /etc/os-release ]]; then
        return 1
    fi

    (
        # shellcheck disable=SC1091
        source /etc/os-release
        printf '%s\n' "${ID:-unknown}"
    )
}

dbu_detect_environment() {
    dbu_info "Detecting environment..."

    if [[ -f /etc/os-release ]]; then
        # shellcheck disable=SC1091
        source /etc/os-release
        dbu_info "Distribution: ${PRETTY_NAME:-unknown}"
    else
        dbu_warn "Could not read /etc/os-release"
    fi

    if dbu_in_container; then
        dbu_info "Container environment detected."
    else
        dbu_info "Host environment detected."
    fi
}

dbu_validate_container_environment() {
    if ! dbu_in_container; then
        dbu_error "Container installation requested outside a container."
        return 1
    fi

    local distribution
    distribution="$(dbu_distribution_id)"

    if [[ "$distribution" != "ubuntu" ]]; then
        dbu_error \
            "Container installation requires Ubuntu. Detected: $distribution"
        return 1
    fi

    dbu_require_command apt-get
}

dbu_validate_host_environment() {
    if dbu_in_container; then
        dbu_error "Host installation requested from inside a container."
        return 1
    fi

    dbu_require_command distrobox
}

dbu_validate_mode() {
    local mode="$1"

    case "$mode" in
        auto)
            return 0
            ;;
        host)
            dbu_validate_host_environment
            ;;
        container)
            dbu_validate_container_environment
            ;;
        *)
            dbu_error "Invalid mode: $mode"
            return 1
            ;;
    esac
}
