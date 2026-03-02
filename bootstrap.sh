#!/usr/bin/env bash
# bootstrap.sh — idempotent machine setup for macOS and Linux
#
# Flags:
#   --skip-stow  Install tools only, do not stow dotfiles
#   --dry-run    Print what would run, do nothing
#
# To add/remove packages:
#   macOS  → edit Brewfile,        then: brew bundle
#   Linux  → edit packages.linux,  then: re-run bootstrap.sh
#   Stow   → edit packages.sh
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=packages.sh
source "$DOTFILES_DIR/packages.sh"

SKIP_STOW=false
DRY_RUN=false

for arg in "$@"; do
    case "$arg" in
        --skip-stow) SKIP_STOW=true ;;
        --dry-run)   DRY_RUN=true ;;
    esac
done

has()        { command -v "$1" &>/dev/null; }
info()       { echo "==> $*"; }
run()        { $DRY_RUN && echo "    [dry-run] $*" || "$@"; }
maybe_sudo() { [[ "$EUID" -eq 0 ]] && "$@" || sudo "$@"; }

# ── OS detection ──────────────────────────────────────────────────────────────

detect_os() {
    if   [[ "$OSTYPE" == "darwin"* ]];    then OS="macos"
    elif [[ -f /etc/debian_version ]];    then OS="debian"
    elif [[ -f /etc/fedora-release ]];    then OS="fedora"
    else echo "Unsupported OS: $OSTYPE" && exit 1
    fi
    info "Detected OS: $OS"
}

# ── macOS: Homebrew + Brewfile ─────────────────────────────────────────────────

install_macos() {
    if ! has brew; then
        info "Installing Homebrew..."
        run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    info "Installing packages (Brewfile)..."
    run brew bundle --file="$DOTFILES_DIR/Brewfile" --no-lock
}

# ── Linux: apt/dnf + curl installs ────────────────────────────────────────────

install_linux() {
    # ── package manager installs (edit packages.linux to add/remove) ──────────
    local pkgs
    pkgs=$(grep -v '^\s*[#;]' "$DOTFILES_DIR/packages.linux" | grep -v '^\s*$' | tr '\n' ' ')

    case "$OS" in
        debian)
            # Fish needs the openSUSE repo on Debian (distro package is outdated)
            if ! has fish; then
                run maybe_sudo apt-get install -y curl gpg
                $DRY_RUN || {
                    echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_12/ /' \
                        | maybe_sudo tee /etc/apt/sources.list.d/shells_fish.list > /dev/null
                    curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_12/Release.key \
                        | gpg --dearmor \
                        | maybe_sudo tee /etc/apt/trusted.gpg.d/shells_fish.gpg > /dev/null
                }
            fi
            info "Installing apt packages (packages.linux)..."
            $DRY_RUN && echo "    [dry-run] apt-get install -y $pkgs" || {
                maybe_sudo apt-get update -qq
                # shellcheck disable=SC2086
                maybe_sudo apt-get install -y $pkgs
            }
            ;;
        fedora)
            info "Installing dnf packages (packages.linux)..."
            # shellcheck disable=SC2086
            $DRY_RUN && echo "    [dry-run] dnf install -y $pkgs" || maybe_sudo dnf install -y $pkgs
            ;;
    esac

    # ── curl installs: tools where distro packages lag too far behind ─────────
    # Note: pipe commands are handled inline (run() helper doesn't work with pipes)

    # Neovim
    if ! has nvim; then
        info "Installing neovim..."
        local nvim_arch
        nvim_arch=$(uname -m | sed 's/aarch64/arm64/')
        $DRY_RUN \
            && echo "    [dry-run] curl neovim tarball | tar -xz -C ~/.local" \
            || curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${nvim_arch}.tar.gz" \
                | tar -xz -C "$HOME/.local" --strip-components=1
    fi

    # Starship
    if ! has starship; then
        info "Installing starship..."
        $DRY_RUN \
            && echo "    [dry-run] curl https://starship.rs/install.sh | sh -s -- -y" \
            || curl -fsSL https://starship.rs/install.sh | sh -s -- -y
    fi

    # Zoxide
    if ! has zoxide; then
        info "Installing zoxide..."
        $DRY_RUN \
            && echo "    [dry-run] curl https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh" \
            || curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    fi

    # Rust + tms (tmux-sessionizer)
    if ! has cargo; then
        info "Installing Rust (rustup)..."
        $DRY_RUN \
            && echo "    [dry-run] curl https://sh.rustup.rs | sh -s -- -y --no-modify-path" \
            || curl -fsSL https://sh.rustup.rs | sh -s -- -y --no-modify-path
        # shellcheck disable=SC1091
        $DRY_RUN || source "$HOME/.cargo/env"
    fi
    has tms || { info "Installing tms..."; run cargo install tmux-sessionizer; }
}

# ── fish plugins (fisher) ─────────────────────────────────────────────────────

install_fish_plugins() {
    has fish || return
    info "Installing fish plugins (fisher)..."
    $DRY_RUN && echo "    [dry-run] fisher install/update" || fish -c "
        if not functions -q fisher
            curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish \
                | source && fisher install jorgebucaran/fisher
        end
        fisher update
    "
}

# ── default shell ─────────────────────────────────────────────────────────────

set_default_shell() {
    local fish_path
    fish_path="$(command -v fish 2>/dev/null || true)"
    [[ -z "$fish_path" || "$SHELL" == "$fish_path" ]] && return
    info "Setting fish as default shell..."
    grep -qF "$fish_path" /etc/shells || run maybe_sudo sh -c "echo '$fish_path' >> /etc/shells"
    run chsh -s "$fish_path"
}

# ── stow ──────────────────────────────────────────────────────────────────────

stow_dotfiles() {
    info "Stowing: ${PACKAGES[*]}"
    run bash "$DOTFILES_DIR/install_dotfiles.sh" "${PACKAGES[@]}"
}

# ── main ──────────────────────────────────────────────────────────────────────

main() {
    detect_os
    case "$OS" in
        macos)         install_macos ;;
        debian|fedora) install_linux ;;
    esac
    $SKIP_STOW || stow_dotfiles
    install_fish_plugins
    set_default_shell
    echo ""
    echo "Bootstrap complete."
    echo "  Open a new terminal to start using fish."
}

main
