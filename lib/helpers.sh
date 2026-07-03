#!/usr/bin/env bash
set -Eeuo pipefail

dbu_repo_root() {
  cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd
}

dbu_is_true() {
  case "${1:-}" in
    true|TRUE|yes|YES|1) return 0 ;;
    *) return 1 ;;
  esac
}

dbu_confirm() {
  local prompt="${1:-Continue?}"
  local answer

  if dbu_is_true "${DBU_ASSUME_YES:-false}"; then
    return 0
  fi

  read -r -p "$prompt [y/N] " answer
  case "$answer" in
    y|Y|yes|YES) return 0 ;;
    *) return 1 ;;
  esac
}
