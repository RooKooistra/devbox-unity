#!/usr/bin/env bash
set -Eeuo pipefail

dbu_require_command() {
  local command_name="$1"

  if ! command -v "$command_name" >/dev/null 2>&1; then
    dbu_error "Required command not found: $command_name"
    return 1
  fi
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

  if [[ -f /.dockerenv ]]; then
    dbu_info "Container-like environment detected."
  fi
}
