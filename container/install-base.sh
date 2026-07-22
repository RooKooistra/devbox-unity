#!/usr/bin/env bash
set -Eeuo pipefail

dbu_install_base() {

    dbu_info "Preparing base development environment..."

    dbu_update_packages

    dbu_upgrade_packages

    dbu_install_packages \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        fd-find \
        git \
        git-lfs \
        gnupg \
        htop \
        jq \
        nano \
        ripgrep \
        software-properties-common \
        tar \
        tree \
        unzip \
        vim \
        wget \
        xz-utils \
        zip

    dbu_success "Base environment installed."

}
