#!/bin/bash

# Install Script for Tawssl
# Repo: https://github.com/tawanamohammadi/Tawssl

REPO_URL="https://github.com/tawanamohammadi/Tawssl.git"
INSTALL_DIR="/usr/local/tawssl"
BIN_DIR="/usr/local/bin"

# Colors
GREEN='\033[0;32m'
PC='\033[0m'

echo -e "${GREEN}Installing Tawssl...${PC}"

# Install git if missing
if ! command -v git &> /dev/null; then
    echo "Installing git..."
    if command -v apt-get &>/dev/null; then apt-get update && apt-get install -y git
    elif command -v yum &>/dev/null; then yum install -y git; fi
fi

# Clone or Update
if [ -d "$INSTALL_DIR" ]; then
    echo "Updating existing installation..."
    cd "$INSTALL_DIR" && git pull
else
    echo "Cloning repository..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Set permissions
chmod +x "$INSTALL_DIR/tawssl"

# Create symlink
rm -f "$BIN_DIR/tawssl"
ln -s "$INSTALL_DIR/tawssl" "$BIN_DIR/tawssl"

# Refresh hash to ensure command is found immediately
hash -r 2>/dev/null || true

echo -e "${GREEN}Installation Complete!${PC}"
echo -e "Type '${GREEN}tawssl${PC}' to start."
