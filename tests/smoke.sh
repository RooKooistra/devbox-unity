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

"$ROOT_DIR/install.sh" --dry-run

[[ -f container/install-base.sh ]] \
    || dbu_die "Missing install-base.sh"  

grep -q "dbu_install_base" container/install-base.sh \
    || dbu_die "Base installer missing."
