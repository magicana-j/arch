#!/usr/bin/env bash
# setup_all.sh
# Master script: runs CJK/IME setup (as root) then fontconfig setup (as user).
# Target: Arch Linux / KDE Plasma 6 (Wayland) / Panasonic CF-SZ6

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
info()    { echo "[INFO]  $*"; }
success() { echo "[OK]    $*"; }
err()     { echo "[ERROR] $*" >&2; }
separator() { echo ""; echo "================================================================"; echo "  $*"; echo "================================================================"; }

# ---------------------------------------------------------------------------
# Dependency check
# ---------------------------------------------------------------------------
check_scripts() {
    local missing=0
    for f in setup_cjk_ime.sh setup_fontconfig.sh; do
        if [[ ! -f "${SCRIPT_DIR}/${f}" ]]; then
            err "Missing: ${SCRIPT_DIR}/${f}"
            missing=1
        fi
    done
    if [[ ! -f "${SCRIPT_DIR}/49-jp-font-priority.conf" ]]; then
        err "Missing: ${SCRIPT_DIR}/49-jp-font-priority.conf"
        missing=1
    fi
    [[ $missing -eq 0 ]] || exit 1
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    if [[ $EUID -ne 0 ]]; then
        err "Run this script as root (sudo ./setup_all.sh)."
        err "The fontconfig step will be delegated back to the invoking user."
        exit 1
    fi

    # Identify the user who invoked sudo
    local real_user="${SUDO_USER:-}"
    if [[ -z "${real_user}" ]]; then
        err "SUDO_USER is not set. Run via: sudo ./setup_all.sh"
        exit 1
    fi

    check_scripts

    # ------------------------------------------------------------------
    separator "Step 1/2: CJK fonts + fcitx5-mozc (requires root)"
    # ------------------------------------------------------------------
    bash "${SCRIPT_DIR}/setup_cjk_ime.sh"
    success "setup_cjk_ime.sh finished."

    # ------------------------------------------------------------------
    separator "Step 2/2: fontconfig Japanese priority (runs as ${real_user})"
    # ------------------------------------------------------------------
    # Drop privileges back to the real user for fontconfig user config
    sudo -u "${real_user}" bash "${SCRIPT_DIR}/setup_fontconfig.sh"
    success "setup_fontconfig.sh finished."

    echo ""
    echo "================================================================"
    echo "  All steps complete. Reboot to apply all changes."
    echo "================================================================"
}

main "$@"
