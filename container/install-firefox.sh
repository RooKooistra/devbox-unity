#!/usr/bin/env bash
set -Eeuo pipefail

readonly DBU_MOZILLA_KEY_URL="https://packages.mozilla.org/apt/repo-signing-key.gpg"
readonly DBU_MOZILLA_KEYRING="/etc/apt/keyrings/packages.mozilla.org.asc"
readonly DBU_MOZILLA_SOURCE="/etc/apt/sources.list.d/mozilla.sources"
readonly DBU_MOZILLA_PREFERENCES="/etc/apt/preferences.d/mozilla"
readonly DBU_MOZILLA_FINGERPRINT="35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3"

dbu_install_firefox() {
    dbu_info "Installing Firefox..."

    if dbu_package_installed firefox && dbu_mozilla_repository_configured; then
        dbu_success "Firefox is already installed from the Mozilla repository."
        return 0
    fi

    dbu_install_mozilla_key
    dbu_verify_mozilla_key
    dbu_configure_mozilla_repository
    dbu_configure_mozilla_priority

    dbu_update_packages
    dbu_install_packages firefox

    if ! dbu_is_true "${DBU_DRY_RUN:-false}"; then
        dbu_verify_firefox_installation
    fi

    dbu_success "Firefox installed."
}

dbu_install_mozilla_key() {
    dbu_info "Installing Mozilla repository signing key..."

    dbu_sudo install -d -m 0755 /etc/apt/keyrings

    if dbu_is_true "${DBU_DRY_RUN:-false}"; then
        dbu_info "[DRY] Download Mozilla signing key to $DBU_MOZILLA_KEYRING"
        return 0
    fi

    local temporary_key
    temporary_key="$(mktemp)"

    if ! wget -q "$DBU_MOZILLA_KEY_URL" -O "$temporary_key"; then
        rm -f "$temporary_key"
        dbu_error "Failed to download Mozilla repository signing key."
        return 1
    fi

    sudo install -m 0644 "$temporary_key" "$DBU_MOZILLA_KEYRING"
    rm -f "$temporary_key"
}

dbu_verify_mozilla_key() {
    if dbu_is_true "${DBU_DRY_RUN:-false}"; then
        dbu_info "[DRY] Verify Mozilla signing key fingerprint."
        return 0
    fi

    local fingerprint

    fingerprint="$(
        gpg \
            --batch \
            --quiet \
            --show-keys \
            --with-colons \
            "$DBU_MOZILLA_KEYRING" |
            awk -F: '$1 == "fpr" { print $10; exit }'
    )"

    if [[ "$fingerprint" != "$DBU_MOZILLA_FINGERPRINT" ]]; then
        dbu_error "Mozilla signing key fingerprint verification failed."
        dbu_error "Expected: $DBU_MOZILLA_FINGERPRINT"
        dbu_error "Received: ${fingerprint:-unknown}"
        return 1
    fi

    dbu_success "Mozilla signing key verified."
}

dbu_configure_mozilla_repository() {
    dbu_info "Configuring Mozilla APT repository..."

    local source_content
    source_content="Types: deb
URIs: https://packages.mozilla.org/apt
Suites: mozilla
Components: main
Signed-By: $DBU_MOZILLA_KEYRING"

    dbu_write_root_file "$DBU_MOZILLA_SOURCE" "$source_content"
}

dbu_configure_mozilla_priority() {
    dbu_info "Prioritising Mozilla packages..."

    local preference_content
    preference_content="Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000"

    dbu_write_root_file "$DBU_MOZILLA_PREFERENCES" "$preference_content"
}

dbu_write_root_file() {
    local destination="$1"
    local content="$2"

    if dbu_is_true "${DBU_DRY_RUN:-false}"; then
        dbu_info "[DRY] Write $destination"
        return 0
    fi

    printf '%s\n' "$content" | sudo tee "$destination" >/dev/null
}

dbu_mozilla_repository_configured() {
    [[ -f "$DBU_MOZILLA_SOURCE" ]] &&
        grep -qF "https://packages.mozilla.org/apt" "$DBU_MOZILLA_SOURCE"
}

dbu_verify_firefox_installation() {
    if ! dbu_package_installed firefox; then
        dbu_error "Firefox package installation could not be verified."
        return 1
    fi

    if ! command -v firefox >/dev/null 2>&1; then
        dbu_error "Firefox executable was not found after installation."
        return 1
    fi

    dbu_success "Firefox installation verified."
}
