#!/usr/bin/env bash
# extras.sh — tools that need non-standard installs on Linux
# (macOS equivalents live in Brewfile — same tools, different install method)
# Sourced by bootstrap.sh inside install_linux().
# Helpers available: has(), info(), run(), DRY_RUN, HOME
#
# To add a tool: copy an existing block, swap in the tool name + install command.
# ─────────────────────────────────────────────────────────────────────────────

# Neovim (apt package too old)
if ! has nvim; then
    info "Installing neovim..."
    _nvim_arch=$(uname -m | sed 's/aarch64/arm64/')
    $DRY_RUN \
        && echo "    [dry-run] curl neovim tarball | tar -xz -C ~/.local" \
        || curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${_nvim_arch}.tar.gz" \
            | tar -xz -C "$HOME/.local" --strip-components=1
fi

# Starship (not in apt)
if ! has starship; then
    info "Installing starship..."
    $DRY_RUN \
        && echo "    [dry-run] curl https://starship.rs/install.sh | sh -s -- -y" \
        || curl -fsSL https://starship.rs/install.sh | sh -s -- -y
fi

# Zoxide (not in apt)
if ! has zoxide; then
    info "Installing zoxide..."
    $DRY_RUN \
        && echo "    [dry-run] curl https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh" \
        || curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

# Rust (canonical install, required for cargo tools below)
if ! has cargo; then
    info "Installing Rust (rustup)..."
    $DRY_RUN \
        && echo "    [dry-run] curl https://sh.rustup.rs | sh -s -- -y --no-modify-path" \
        || curl -fsSL https://sh.rustup.rs | sh -s -- -y --no-modify-path
    # shellcheck disable=SC1091
    $DRY_RUN || source "$HOME/.cargo/env"
fi

# tms — tmux sessionizer (requires cargo)
has tms || { info "Installing tms..."; run cargo install tmux-sessionizer; }
