#!/usr/bin/env bash
# install.sh — curl entry point for a fresh machine
# Usage: curl -fsSL https://raw.githubusercontent.com/serg-e/dotfiles/master/install.sh | bash
# Or with flags: curl ... | bash -s -- --extras
set -euo pipefail

REPO="https://github.com/serg-e/dotfiles.git"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

# Ensure git is available (absolute minimum dependency)
if ! command -v git &>/dev/null; then
    echo "Installing git..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Please install Xcode Command Line Tools (or Homebrew), then re-run:"
        echo "  xcode-select --install"
        exit 1
    elif [[ -f /etc/debian_version ]]; then
        sudo apt-get update -qq && sudo apt-get install -y git
    elif [[ -f /etc/fedora-release ]]; then
        sudo dnf install -y git
    else
        echo "Cannot install git automatically. Please install it and re-run." && exit 1
    fi
fi

# Clone or update the repo
if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "Cloning dotfiles to $DOTFILES_DIR..."
    git clone "$REPO" "$DOTFILES_DIR"
else
    echo "Dotfiles already at $DOTFILES_DIR, updating..."
    git -C "$DOTFILES_DIR" pull --ff-only
fi

# Hand off to bootstrap.sh, passing any flags through
bash "$DOTFILES_DIR/bootstrap.sh" "$@"
