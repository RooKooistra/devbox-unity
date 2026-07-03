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
source "$SCRIPT_DIR/lib/helpers.sh"
source "$SCRIPT_DIR/lib/validation.sh"
source "$SCRIPT_DIR/lib/ui.sh"
source "$SCRIPT_DIR/lib/distrobox.sh"

main() {
  dbu_banner

  dbu_info "Milestone 1 installer framework"
  dbu_info "Full installation logic will be added in Milestone 2."

  dbu_require_command bash
  dbu_require_command uname

  dbu_detect_environment

  dbu_success "Repository foundation is working."
}

main "$@"
