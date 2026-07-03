#!/usr/bin/env bash
set -Eeuo pipefail

dbu_has_distrobox() {
  command -v distrobox >/dev/null 2>&1
}

dbu_check_distrobox() {
  if dbu_has_distrobox; then
    dbu_success "Distrobox found."
  else
    dbu_warn "Distrobox was not found in this environment."
  fi
}
