#!/usr/bin/env bash
set -Eeuo pipefail

dbu_repo_root() {
  cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd
}

dbu_confirm() {
  local prompt="${1:-Continue?}"
  local answer

  read -r -p "$prompt [y/N] " answer
  case "$answer" in
    y|Y|yes|YES) return 0 ;;
    *) return 1 ;;
  esac
}
