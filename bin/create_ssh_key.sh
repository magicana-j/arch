#!/usr/bin/env bash

# Configuration: Key path and comment
# Uses Ed25519 (Modern, secure, and compact)
KEY_PATH="$HOME/.ssh/id_ed25519"
COMMENT="$(whoami)@$(hostname)-$(date +%Y%m%d)"

# Ensure the .ssh directory exists with correct permissions
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# Check if the key already exists to prevent overwriting
if [ -f "$KEY_PATH" ]; then
    echo "Error: $KEY_PATH already exists. Aborting."
    exit 1
fi

# Generate SSH Key
# -t: algorithm (ed25519)
# -C: comment for identification
# -f: output file path
# -N: passphrase (empty string for no passphrase)
ssh-keygen -t ed25519 -C "$COMMENT" -f "$KEY_PATH" -N ""

# Set appropriate permissions for the keys
chmod 600 "$KEY_PATH"
chmod 644 "${KEY_PATH}.pub"

echo "---------------------------------------"
echo "SSH Key generation completed successfully."
echo "Private Key: $KEY_PATH"
echo "Public Key:  ${KEY_PATH}.pub"
echo "---------------------------------------"
echo "To copy your public key to a server, use:"
echo "ssh-copy-id -i ${KEY_PATH}.pub user@hostname"
