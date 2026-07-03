#!/usr/bin/env bash

#
# DevBox Unity
#
# A professional Unity development environment for immutable Linux.
#
# Licensed under the MIT License.
#

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/logging.sh"
source "$SCRIPT_DIR/lib/ui.sh"
source "$SCRIPT_DIR/lib/helpers.sh"
source "$SCRIPT_DIR/lib/config.sh"
source "$SCRIPT_DIR/lib/validation.sh"
source "$SCRIPT_DIR/lib/distrobox.sh"
source "$SCRIPT_DIR/lib/runner.sh"

DBU_MODE="auto"
DBU_DRY_RUN="false"
DBU_ASSUME_YES="false"

usage() {
  cat <<EOF
DevBox Unity installer

Usage:
  ./install.sh [options]

Options:
  --mode MODE       auto, host, or container. Default: auto
  --dry-run         Show actions without changing the system
  -y, --yes         Assume yes for confirmations
  -h, --help        Show this help

Milestone 2 only validates the installer framework.
It does not install Unity or development tools yet.
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --mode)
        DBU_MODE="${2:-}"
        shift 2
        ;;
      --dry-run)
        DBU_DRY_RUN="true"
        shift
        ;;
      -y|--yes)
        DBU_ASSUME_YES="true"
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        dbu_error "Unknown argument: $1"
        usage
        exit 1
        ;;
    esac
  done

  case "$DBU_MODE" in
    auto|host|container) ;;
    *)
      dbu_error "Invalid mode: $DBU_MODE"
      exit 1
      ;;
  esac
}

main() {
  parse_args "$@"

  dbu_banner
  dbu_info "Milestone 2: installer framework"

  dbu_load_config "$SCRIPT_DIR/config.env"

  export DBU_DRY_RUN
  export DBU_ASSUME_YES

  dbu_require_command bash
  dbu_require_command uname

  dbu_detect_environment
  dbu_validate_mode "$DBU_MODE"

  dbu_info "Configuration:"
  dbu_info "  Container: $DBU_CONTAINER_NAME"
  dbu_info "  Image:     $DBU_CONTAINER_IMAGE"
  dbu_info "  Unity:     $DBU_UNITY_ROOT"
  dbu_info "  Mode:      $DBU_MODE"
  dbu_info "  Dry run:   $DBU_DRY_RUN"

  dbu_create_unity_directories

  dbu_success "Milestone 2 framework completed successfully."
}

main "$@"
