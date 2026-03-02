#!/usr/bin/env bash
# uninstall_dotfiles.sh — unstow packages and restore any backed-up originals

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=packages.sh
source "$DOTFILES_DIR/packages.sh"

stow_dir="$DOTFILES_DIR"
target_dir="$HOME"
backup_suffix=".before_stow"

restore_original_files() {
    [[ -f "$stow_dir/.backups.log" ]] || return
    while IFS= read -r backup_file; do
        local original_file="${backup_file%$backup_suffix}"
        if [[ -e "$original_file" ]]; then
            echo "Original already exists: $original_file — skipping"
        else
            echo "Restoring: $original_file"
            mv -- "$backup_file" "$original_file"
        fi
    done < "$stow_dir/.backups.log"
}

for package in "${PACKAGES[@]}"; do
    [[ -d "$stow_dir/$package" ]] || { echo "Skipping missing package: $package"; continue; }
    echo "Unstowing: $package"
    stow --delete --target="$target_dir" --dir="$stow_dir" "$package"
done

restore_original_files
echo "Done."
