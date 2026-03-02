#!/usr/bin/env bash

# --- ROUTINE: Configure HTTPS (Access Token) ---
configure_https() {
    echo "Setting up HTTPS with Access Token..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        git config --global credential.helper osxkeychain
    else
        git config --global credential.helper store
    fi
    # Remove SSH rewrite if it exists to avoid conflicts
    git config --global --unset-all url."git@github.com:".insteadOf 2>/dev/null
    echo "Success: HTTPS (Credential Helper) configured."
}

# --- ROUTINE: Configure SSH ---
configure_ssh() {
    echo "Setting up SSH..."
    # Force GitHub to use SSH even if cloned via HTTPS
    git config --global url."git@github.com:".insteadOf "https://github.com/"
    # Unset credential helper to clean up
    git config --global --unset credential.helper 2>/dev/null
    echo "Success: SSH (URL Rewriting) configured."
}

# --- MAIN EXECUTION ---
case "$1" in
    "https")
        configure_https
        ;;
    "ssh")
        configure_ssh
        ;;
    *)
        # Interactive mode if no argument is provided
        echo "Git Configuration Utility"
        read -p "Enter Git User Name: " git_user
        read -p "Enter Git Email: " git_email

        git config --global user.name "$git_user"
        git config --global user.email "$git_email"

        echo "-------------------------------"
        echo "Select connection method:"
        echo "1) HTTPS (Token)"
        echo "2) SSH"
        read -p "Choice [1/2]: " choice

        [[ "$choice" == "1" ]] && configure_https
        [[ "$choice" == "2" ]] && configure_ssh
        ;;
esac

echo "-------------------------------"
git config --list --global | grep -E "user|credential|url"
