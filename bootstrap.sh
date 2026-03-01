#!/usr/bin/env bash
# bootstrap.sh — idempotent machine setup for macOS and Linux
#
# Flags:
#   --min        Install PACKAGES_MIN (defined in packages.sh)
#   --max        Install PACKAGES_MAX — default
#   --skip-stow  Install tools only, do not stow dotfiles
#   --dry-run    Print what would run, do nothing
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=packages.sh
source "$DOTFILES_DIR/packages.sh"

PROFILE="max"   # --min | --max
SKIP_STOW=false
DRY_RUN=false

for arg in "$@"; do
    case "$arg" in
        --min)       PROFILE="min" ;;
        --max)       PROFILE="max" ;;
        --skip-stow) SKIP_STOW=true ;;
        --dry-run)   DRY_RUN=true ;;
    esac
done

# Active package list — edit packages.sh to change what's included
if [[ "$PROFILE" == "min" ]]; then
    STOW_PACKAGES=("${PACKAGES_MIN[@]}")
else
    STOW_PACKAGES=("${PACKAGES_MAX[@]}")
fi

# ── helpers ───────────────────────────────────────────────────────────────────

has()       { command -v "$1" &>/dev/null; }
has_pkg()   { printf '%s\n' "${STOW_PACKAGES[@]}" | grep -qx "$1"; }
info()      { echo "==> $*"; }
skipped()   { echo "    (skipping, already installed)"; }
maybe_sudo(){ [[ "$EUID" -eq 0 ]] && "$@" || sudo "$@"; }

run() {
    if $DRY_RUN; then
        echo "    [dry-run] $*"
    else
        "$@"
    fi
}

# ── OS detection ──────────────────────────────────────────────────────────────

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ -f /etc/debian_version ]]; then
        OS="debian"
    elif [[ -f /etc/fedora-release ]]; then
        OS="fedora"
    else
        echo "Unsupported OS: $OSTYPE" && exit 1
    fi
    info "Detected OS: $OS"
}

# ── package manager ───────────────────────────────────────────────────────────

install_brew() {
    [[ "$OS" != "macos" ]] && return
    if ! has brew; then
        info "Installing Homebrew..."
        run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if [[ -f /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
}

_apt_updated=false
_apt_update() { $_apt_updated && return; maybe_sudo apt-get update -qq; _apt_updated=true; }

pkg_install() {
    local missing=()
    for p in "$@"; do has "$p" || missing+=("$p"); done
    [[ ${#missing[@]} -eq 0 ]] && return
    case "$OS" in
        macos)  for p in "${missing[@]}"; do run brew install "$p"; done ;;
        debian) _apt_update; run maybe_sudo apt-get install -y "${missing[@]}" ;;
        fedora) run maybe_sudo dnf install -y "${missing[@]}" ;;
    esac
}

# ── always-on infrastructure ──────────────────────────────────────────────────
# Tools that config.fish sources unconditionally — must always be present.

install_essentials() {
    info "Installing essentials (git curl stow direnv fzf ripgrep bat)..."
    pkg_install git curl stow direnv fzf ripgrep bat
}

# ── per-package install functions ─────────────────────────────────────────────

install_fish() {
    if has fish; then skipped; return; fi
    info "Installing fish..."
    case "$OS" in
        macos) run brew install fish ;;
        debian)
            run maybe_sudo apt-get install -y curl gpg
            if $DRY_RUN; then
                echo "    [dry-run] add fish opensuse repo + gpg key"
                echo "    [dry-run] apt-get install -y fish"
            else
                echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_12/ /' \
                    | maybe_sudo tee /etc/apt/sources.list.d/shells_fish.list > /dev/null
                curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_12/Release.key \
                    | gpg --dearmor \
                    | maybe_sudo tee /etc/apt/trusted.gpg.d/shells_fish.gpg > /dev/null
                maybe_sudo apt-get update -qq
                maybe_sudo apt-get install -y fish
            fi
            ;;
        fedora) run maybe_sudo dnf install -y fish ;;
    esac
}

install_neovim() {
    if has nvim; then skipped; return; fi
    info "Installing neovim..."
    case "$OS" in
        macos) run brew install neovim ;;
        debian|fedora)
            local arch nvim_arch
            arch=$(uname -m)
            case "$arch" in
                x86_64)        nvim_arch="x86_64" ;;
                aarch64|arm64) nvim_arch="arm64" ;;
                *) echo "Unsupported arch: $arch" && return 1 ;;
            esac
            local url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${nvim_arch}.tar.gz"
            mkdir -p "$HOME/.local"
            if $DRY_RUN; then
                echo "    [dry-run] curl $url | tar -xz -C ~/.local --strip-components=1"
            else
                curl -fsSL "$url" | tar -xz -C "$HOME/.local" --strip-components=1
            fi
            ;;
    esac
}

install_starship() {
    if has starship; then skipped; return; fi
    info "Installing starship..."
    if [[ "$OS" == "macos" ]]; then
        run brew install starship
    elif $DRY_RUN; then
        echo "    [dry-run] curl https://starship.rs/install.sh | sh -s -- -y"
    else
        curl -fsSL https://starship.rs/install.sh | sh -s -- -y
    fi
}

install_zoxide() {
    if has zoxide; then skipped; return; fi
    info "Installing zoxide..."
    if [[ "$OS" == "macos" ]]; then
        run brew install zoxide
    elif $DRY_RUN; then
        echo "    [dry-run] curl https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh"
    else
        curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    fi
}

install_rust() {
    if has cargo; then skipped; return; fi
    info "Installing Rust (rustup)..."
    if $DRY_RUN; then
        echo "    [dry-run] curl https://sh.rustup.rs | sh -s -- -y --no-modify-path"
        return
    fi
    curl -fsSL https://sh.rustup.rs | sh -s -- -y --no-modify-path
    # shellcheck disable=SC1091
    source "$HOME/.cargo/env"
}

install_tms() {
    if has tms; then skipped; return; fi
    info "Installing tmux-sessionizer (tms)..."
    if [[ "$OS" == "macos" ]] && has brew; then
        run brew install jrmoulton/tap/tmux-sessionizer
    else
        install_rust
        run cargo install tmux-sessionizer
    fi
}

# ── package → tool mapping ────────────────────────────────────────────────────
# Called for each entry in STOW_PACKAGES. Add a case here if a new package
# needs a system tool installed alongside its config.

install_for_package() {
    case "$1" in
        fish)     install_fish ;;
        nvim)     install_neovim ;;
        starship) install_starship ;;
        tmux)     pkg_install tmux ;;
        tms)      install_tms ;;
        # alacritty, tmate, ptpython, pudb, pypoetry, bash, git, nvim-max — config only
    esac
}

# ── fish plugins ──────────────────────────────────────────────────────────────

install_fish_plugins() {
    has_pkg fish || return
    if ! has fish; then echo "  fish not found, skipping plugins"; return; fi
    info "Installing fish plugins (fisher)..."
    if $DRY_RUN; then
        echo "    [dry-run] fisher install/update"
    else
        fish -c "
            if not functions -q fisher
                curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish \
                    | source && fisher install jorgebucaran/fisher
            end
            fisher update
        "
    fi
}

# ── default shell ─────────────────────────────────────────────────────────────

set_default_shell() {
    has_pkg fish || return
    local fish_path
    fish_path="$(command -v fish 2>/dev/null || true)"
    [[ -z "$fish_path" ]] && { echo "  fish not found, skipping"; return; }
    if [[ "$SHELL" == "$fish_path" ]]; then skipped; return; fi
    info "Setting fish as default shell..."
    if ! grep -qF "$fish_path" /etc/shells; then
        run maybe_sudo sh -c "echo '$fish_path' >> /etc/shells"
    fi
    run chsh -s "$fish_path"
}

# ── stow ──────────────────────────────────────────────────────────────────────

stow_dotfiles() {
    info "Stowing packages [${PROFILE}]: ${STOW_PACKAGES[*]}"
    run bash "$DOTFILES_DIR/install_dotfiles.sh" "${STOW_PACKAGES[@]}"
}

# ── main ──────────────────────────────────────────────────────────────────────

main() {
    info "Profile: $PROFILE  |  Packages: ${STOW_PACKAGES[*]}"

    detect_os
    install_brew
    install_essentials      # always: git curl stow direnv fzf ripgrep bat
    install_zoxide          # always: sourced unconditionally in config.fish

    # Install system tools for each selected package
    for pkg in "${STOW_PACKAGES[@]}"; do
        install_for_package "$pkg"
    done

    if ! $SKIP_STOW; then
        stow_dotfiles
    fi

    install_fish_plugins
    set_default_shell

    echo ""
    echo "Bootstrap complete. [$PROFILE]"
    echo "  Open a new terminal to start using fish."
}

main
