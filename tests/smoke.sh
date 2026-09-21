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
    
[[ -f "$ROOT_DIR/lib/hardware.sh" ]] \
    || fail "Missing hardware.sh"

grep -q "dbu_detect_gpu_vendor" "$ROOT_DIR/lib/hardware.sh" \
    || fail "GPU detection logic missing."

grep -q 'DBU_GPU_VENDOR="amd"' "$ROOT_DIR/lib/hardware.sh" \
    || fail "AMD GPU detection missing."

grep -q 'DBU_GPU_VENDOR="intel"' "$ROOT_DIR/lib/hardware.sh" \
    || fail "Intel GPU detection missing."
    
grep -q "dbu_detect_nvidia_cdi" "$ROOT_DIR/lib/hardware.sh" \
    || fail "NVIDIA CDI detection missing."

grep -q "nvidia.com/gpu=all" "$ROOT_DIR/lib/hardware.sh" \
    || fail "NVIDIA CDI device detection missing."

grep -q "DBU_NVIDIA_CDI_AVAILABLE" "$ROOT_DIR/lib/hardware.sh" \
    || fail "NVIDIA CDI state missing."

grep -q "nvidia.com/gpu=all" "$ROOT_DIR/lib/distrobox.sh" \
    || fail "NVIDIA CDI container integration missing."

if grep -q 'create_args+=(--nvidia)' "$ROOT_DIR/lib/distrobox.sh"; then
    fail "Legacy Distrobox --nvidia integration is still present."
fi

grep -q "dbu_install_base" "$ROOT_DIR/container/install-base.sh" \
    || fail "Base installer missing."

grep -q "dbu_install_firefox" "$ROOT_DIR/container/install-firefox.sh" \
    || fail "Firefox installer missing."

grep -q "DBU_MOZILLA_FINGERPRINT" "$ROOT_DIR/container/install-firefox.sh" \
    || fail "Mozilla key verification missing."
    
grep -q "dbu_run_host_installation" "$ROOT_DIR/install.sh" \
    || fail "Host execution path missing."

grep -q "dbu_run_container_modules" "$ROOT_DIR/install.sh" \
    || fail "Container execution path missing."

grep -q "dbu_ensure_container" "$ROOT_DIR/lib/distrobox.sh" \
    || fail "Container creation logic missing."

grep -q "dbu_validate_container_environment" "$ROOT_DIR/lib/validation.sh" \
    || fail "Container validation missing."

printf 'Smoke test passed.\n'
