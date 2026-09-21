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

fail() {
    printf 'Smoke test failed: %s\n' "$1" >&2
    exit 1
}

"$ROOT_DIR/install.sh" --dry-run

[[ -f "$ROOT_DIR/container/install-base.sh" ]] \
    || fail "Missing install-base.sh"

[[ -f "$ROOT_DIR/container/install-firefox.sh" ]] \
    || fail "Missing install-firefox.sh"

grep -q "dbu_install_base" "$ROOT_DIR/container/install-base.sh" \
    || fail "Base installer missing."

grep -q "dbu_install_firefox" "$ROOT_DIR/container/install-firefox.sh" \
    || fail "Firefox installer missing."

grep -q "DBU_MOZILLA_FINGERPRINT" "$ROOT_DIR/container/install-firefox.sh" \
    || fail "Mozilla key verification missing."

printf 'Smoke test passed.\n'
