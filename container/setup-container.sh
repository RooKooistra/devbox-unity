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

dbu_info "Container setup placeholder."
dbu_detect_environment
dbu_success "Container framework check complete."
