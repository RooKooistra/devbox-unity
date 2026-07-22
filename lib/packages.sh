#!/usr/bin/env bash
set -Eeuo pipefail

#
# Package management helpers
#

dbu_package_installed() {
    dpkg -s "$1" >/dev/null 2>&1
}

dbu_install_packages() {

    local missing=()

    for package in "$@"; do

        if dbu_package_installed "$package"; then
            dbu_info "Package already installed: $package"
        else
            missing+=("$package")
        fi

    done

    if [[ ${#missing[@]} -eq 0 ]]; then
        return 0
    fi

    dbu_info "Installing packages:"
    printf '  %s\n' "${missing[@]}"

    dbu_sudo env DEBIAN_FRONTEND=noninteractive \
    apt-get install -y "${missing[@]}"
}

dbu_update_packages() {

    dbu_info "Updating package lists..."

    dbu_sudo env DEBIAN_FRONTEND=noninteractive apt-get update

}

dbu_upgrade_packages() {

    dbu_info "Upgrading installed packages..."

    dbu_sudo env DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

}
