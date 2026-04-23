#! /usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_LIST="$SCRIPT_DIR/pkglist.txt"
AUR_LIST="$SCRIPT_DIR/aurlist.txt"

# Check prerequisites
if ! command -v sudo &> /dev/null; then
    echo "Error: sudo is not installed."
    exit 1
fi

# Install pacman packages
echo "Installing pacman packages..."
sudo pacman -S --needed --noconfirm $(cat "$PKG_LIST")

# Install AUR packages
if ! command -v paru &> /dev/null; then
    echo "Error: paru is not installed. Please install it first."
    exit 1
fi
echo "Installing AUR packages..."
paru -S --needed --noconfirm $(cat "$AUR_LIST")

echo "All packages installed successfully!"
