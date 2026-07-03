#!/usr/bin/env bash
set -Eeuo pipefail

dbu_info() {
  printf '\033[1;34m[INFO]\033[0m %s\n' "$*"
}

dbu_success() {
  printf '\033[1;32m[ OK ]\033[0m %s\n' "$*"
}

dbu_warn() {
  printf '\033[1;33m[WARN]\033[0m %s\n' "$*"
}

dbu_error() {
  printf '\033[1;31m[ERR ]\033[0m %s\n' "$*" >&2
}
