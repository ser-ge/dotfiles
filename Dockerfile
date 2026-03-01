FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive

# ── 1. Core system packages ──────────────────────────────────────────────────
# All apt-based. Stable — only busted when you add/remove a package here.
RUN apt-get update && apt-get install -y --no-install-recommends \
        bat ca-certificates curl direnv fzf git gpg \
        ripgrep stow tmux \
    && rm -rf /var/lib/apt/lists/*

# ── 2. Fish shell ────────────────────────────────────────────────────────────
# Separate layer: third-party apt repo, different failure mode from core tools.
RUN echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_12/ /' \
        > /etc/apt/sources.list.d/shells_fish.list \
    && curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_12/Release.key \
        | gpg --dearmor > /etc/apt/trusted.gpg.d/shells_fish.gpg \
    && apt-get update && apt-get install -y fish \
    && rm -rf /var/lib/apt/lists/*

# ── 3. Neovim ────────────────────────────────────────────────────────────────
# Separate layer: GitHub releases, arch-aware. Busted only on neovim releases.
RUN arch=$(dpkg --print-architecture) \
    && case "$arch" in \
        amd64) nvim_arch=x86_64 ;; \
        arm64) nvim_arch=arm64 ;; \
        *) echo "Unsupported arch: $arch" && exit 1 ;; \
    esac \
    && curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${nvim_arch}.tar.gz" \
        | tar -xz -C /usr/local --strip-components=1

# ── 4. Starship ──────────────────────────────────────────────────────────────
# Separate layer: curl install, can fail independently.
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- -y

# ── 5. Zoxide ────────────────────────────────────────────────────────────────
# Separate layer: curl install.
RUN curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# ── 6. Dotfiles ──────────────────────────────────────────────────────────────
# Busted on any dotfile change — but layers 1-5 above stay cached.
COPY . /dotfiles
WORKDIR /dotfiles
# install_dotfiles.sh reads PACKAGES_MAX from packages.sh
RUN bash install_dotfiles.sh \
    && echo /usr/bin/fish >> /etc/shells \
    && chsh -s /usr/bin/fish

# ── 7. Fish plugins ──────────────────────────────────────────────────────────
# Separate from stow: isolates GitHub API failures from local stow failures.
# Busted when dotfiles change (unavoidable — fisher reads fish_plugins via symlink).
RUN fish -c " \
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish \
        | source && fisher install jorgebucaran/fisher && fisher update"

WORKDIR /root
CMD ["fish", "-l"]
