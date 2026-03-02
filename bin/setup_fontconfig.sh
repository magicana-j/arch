#!/usr/bin/env bash
# setup_fontconfig.sh
# Deploy Japanese font priority configuration to user fontconfig directory.
# Target: Arch Linux / KDE Plasma 6

set -euo pipefail

# ---------------------------------------------------------------------------
# Config
# ---------------------------------------------------------------------------
CONF_FILENAME="49-jp-font-priority.conf"
CONF_DEST="${XDG_CONFIG_HOME:-${HOME}/.config}/fontconfig/conf.d/${CONF_FILENAME}"

# Path to the bundled conf file (same directory as this script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONF_SRC="${SCRIPT_DIR}/${CONF_FILENAME}"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
info()    { echo "[INFO]  $*"; }
success() { echo "[OK]    $*"; }
warn()    { echo "[WARN]  $*"; }
err()     { echo "[ERROR] $*" >&2; }

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    # Must NOT run as root; fontconfig user config belongs to the real user
    if [[ $EUID -eq 0 ]]; then
        err "Do not run this script as root. Run as the target user."
        exit 1
    fi

    if [[ ! -f "${CONF_SRC}" ]]; then
        err "Source config not found: ${CONF_SRC}"
        err "Make sure ${CONF_FILENAME} is in the same directory as this script."
        exit 1
    fi

    info "=== Step 1: Create fontconfig conf.d directory ==="
    mkdir -p "$(dirname "${CONF_DEST}")"
    success "Directory ready: $(dirname "${CONF_DEST}")"

    info "=== Step 2: Install ${CONF_FILENAME} ==="
    if [[ -f "${CONF_DEST}" ]]; then
        warn "Existing config found -- backing up to ${CONF_DEST}.bak"
        cp "${CONF_DEST}" "${CONF_DEST}.bak"
    fi
    cp "${CONF_SRC}" "${CONF_DEST}"
    success "Installed: ${CONF_DEST}"

    info "=== Step 3: Rebuild font cache ==="
    fc-cache -fv > /dev/null
    success "Font cache updated."

    echo ""
    echo "================================================================"
    echo "  Fontconfig setup complete."
    echo "  Verify with: fc-match --verbose serif :lang=ja"
    echo "               fc-match --verbose sans-serif :lang=ja"
    echo "================================================================"
}

main "$@"
