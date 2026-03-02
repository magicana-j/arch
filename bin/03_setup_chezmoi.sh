#!/usr/bin/env bash
# chezmoi installation and setup script
# Target device: Panasonic CF-SZ6
# OS: Arch Linux (February 2026)

set -euo pipefail

# ─── Colors ───────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info()    { echo -e "${GREEN}[INFO]${NC}  $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC}  $*"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $*"; }

# ─── Check root ───────────────────────────────────────────────────────────────
if [[ $EUID -eq 0 ]]; then
    log_error "Do not run this script as root."
    exit 1
fi

# ─── Install chezmoi via pacman ───────────────────────────────────────────────
log_info "Installing chezmoi..."
if pacman -Qi chezmoi &>/dev/null; then
    log_warn "chezmoi is already installed. Skipping."
else
    sudo pacman -Sy --noconfirm chezmoi
    log_info "chezmoi installed successfully."
fi

# ─── Prompt for repository URL ────────────────────────────────────────────────
echo ""
read -rp "Enter your dotfiles repository URL: " REPO_URL

if [[ -z "$REPO_URL" ]]; then
    log_error "Repository URL cannot be empty."
    exit 1
fi

# ─── Initialize chezmoi with the given repository ─────────────────────────────
log_info "Initializing chezmoi with repository: ${REPO_URL}"
chezmoi init --apply "$REPO_URL"

log_info "chezmoi setup complete."
