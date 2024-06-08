#!/bin/bash

# Define the array of dotfile packages
dotfile_packages=(nvim tmux tms fish ptpython pudb starship)

# Directory where stow packages are located
stow_dir="$HOME/projects/dotfiles"
# Stow target directory
target_dir="$HOME"

# Backup suffix for existing files
backup_suffix=".before_stow"

# Function to restore the original files from backup
restore_original_files() {
  local package="$1"

  if [ -e "$stow_dir/.backups.log" ]; then
      while IFS= read -r backup_file; do
        local original_file="${backup_file%$backup_suffix}"
        echo "Restoring original file: $original_file from $backup_file"

        if [ -e "$original_file" ]; then
          echo "Original file already exists: $original_file.  skipping."
        else
          mv -- "$backup_file" "$original_file"
        fi
      done < "$stow_dir/.backups.log"
   fi
}
# Function to unstow the packages
unstow_packages() {
  # Unstow each package
  for package in "${dotfile_packages[@]}"; do
    echo "Unstowing package: $package"
    stow --delete --target="$target_dir" --dir="$stow_dir" "$package"
  done

  # Restore original files
  for package in "${dotfile_packages[@]}"; do
    restore_original_files "$package"
  done
}

unstow_packages
echo "All packages have been successfully unstowed and original files restored."

