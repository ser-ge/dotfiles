#!/usr/bin/env bash
# install_dotfiles.sh — backup conflicting files then stow packages.
# Usage: bash install_dotfiles.sh [package...]
#   With no args: reads PACKAGES_MAX from packages.sh
#   With args:    stows only the listed packages
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME"
BACKUP_SUFFIX=".before_stow"
BACKUPS_LOG="$DOTFILES_DIR/.backups.log"

# Package list: args override packages.sh
if [[ $# -gt 0 ]]; then
    STOW_PACKAGES=("$@")
else
    # shellcheck source=packages.sh
    source "$DOTFILES_DIR/packages.sh"
    STOW_PACKAGES=("${PACKAGES_MAX[@]}")
fi

backup_conflicting_files() {
    local package="$1"
    while IFS= read -r -d '' file; do
        local relative="${file#"$package"/}"
        local target="$TARGET_DIR/$relative"
        [[ ! -e "$target" ]] && continue
        if [[ -L "$target" && "$(readlink "$target")" == "$DOTFILES_DIR"* ]]; then
            continue
        fi
        local backup="${target}${BACKUP_SUFFIX}"
        if [[ -e "$backup" ]]; then
            echo "Backup already exists: $backup, skipping"
            continue
        fi
        echo "Backing up: $target -> $backup"
        mv -- "$target" "$backup"
        echo "$backup" >> "$BACKUPS_LOG"
    done < <(find "$package" -type f -print0)
}

[ -f "$BACKUPS_LOG" ] && rm "$BACKUPS_LOG"

for package in "${STOW_PACKAGES[@]}"; do
    [[ -d "$DOTFILES_DIR/$package" ]] || { echo "Skipping missing package: $package"; continue; }
    echo "Stowing: $package"
    backup_conflicting_files "$DOTFILES_DIR/$package"
    stow --target="$TARGET_DIR" --dir="$DOTFILES_DIR" "$package"
done

echo "Done."
