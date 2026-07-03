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
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$ROOT_DIR/lib/logging.sh"
source "$ROOT_DIR/lib/validation.sh"
source "$ROOT_DIR/lib/distrobox.sh"

dbu_info "Host setup placeholder."
dbu_check_distrobox
dbu_success "Host framework check complete."
