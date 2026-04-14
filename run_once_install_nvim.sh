#!/bin/bash
# Install Neovim v0.12.1 (Linux x86_64) and clone nvim-mini config

set -e

OS="$(uname -s)"

if [ "$OS" != "Linux" ]; then
    echo "Neovim install script is Linux-only, skipping."
    exit 0
fi

NVIM_VERSION="v0.12.1"
NVIM_TARBALL="nvim-linux-x86_64.tar.gz"
NVIM_URL="https://github.com/neovim/neovim-releases/releases/download/${NVIM_VERSION}/${NVIM_TARBALL}"
NVIM_INSTALL_DIR="$HOME/nvim-linux-x86_64"

echo "Installing Neovim ${NVIM_VERSION}..."

# Download and extract
TMP_DIR=$(mktemp -d)
curl -fsSL "$NVIM_URL" -o "$TMP_DIR/$NVIM_TARBALL"
rm -rf "$NVIM_INSTALL_DIR"
tar xzvf "$TMP_DIR/$NVIM_TARBALL" -C "$HOME"
rm -rf "$TMP_DIR"

echo "Neovim ${NVIM_VERSION} installed to ${NVIM_INSTALL_DIR}"

# Clone nvim-mini config if not already present
NVIM_MINI_CONFIG="$HOME/.config/nvim-mini"
if [ ! -d "$NVIM_MINI_CONFIG" ]; then
    echo "Cloning nvim-mini config..."
    git clone https://github.com/jmtzt/nvim.git "$NVIM_MINI_CONFIG"
    echo "nvim-mini config cloned to ${NVIM_MINI_CONFIG}"
else
    echo "nvim-mini config already exists at ${NVIM_MINI_CONFIG}, skipping clone."
fi
