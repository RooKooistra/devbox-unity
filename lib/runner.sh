#!/usr/bin/env bash
set -Eeuo pipefail

dbu_run() {
  if dbu_is_true "${DBU_DRY_RUN:-false}"; then
    printf '\033[1;35m[DRY]\033[0m'
    printf ' %q' "$@"
    printf '\n'
    return 0
  fi

  "$@"
}

dbu_sudo() {
  if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
    dbu_run "$@"
  else
    dbu_run sudo "$@"
  fi
}
