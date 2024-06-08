#!/bin/bash
dotfile_packages=(nvim tmux tms fish ptpython pudb starship)
# Directory where stow packages are located
stow_dir="$HOME/projects/dotfiles"

# Stow target directory
target_dir="$HOME"

# Backup suffix for existing files
backup_suffix=".before_stow"

[ -e .backups.log ] &&  rm "$stow_dir/.backups.log"
# Define the array of dotfile packages
# Get a list of folders in the stow_dir that are tracked by git

# Function to handle existing files and directories before stowing
backup_conflicting_files() {
  local package="$1"
  local conflicts
  # conflicts=$(stow --no --verbose --target="$target_dir" --dir="$stow_dir" "$package" 2>&1 | grep 'existing target' | awk -F '=> ' '{print $2}' | sed 's/^\s*//;s/\s*$//')

  conflicts=$(stow --no --verbose --target="$target_dir" --dir="$stow_dir" "$package" 2>&1 | \
    grep 'existing target' | \
    awk -F 'over existing target ' '{print $2}' | \
    awk -F ' since neither a link nor a directory and --adopt not specified' '{print $1}')

  echo $conflicts

  # Loop through the conflicts and backup each one
  for file in $conflicts; do
    local target_file="$target_dir/$file"
    local backup_file="$target_file$backup_suffix"

    echo "Backing up existing file: $target_file to $backup_file"
    if [ -e "$backup_file" ]; then
      echo "Backup file already exists: $backup_file"
    else
      # Backup the file or directory
      mv -- "$target_file" "$backup_file"
      echo "$backup_file" >> "$stow_dir/.backups.log"
    fi
  done
}

# Main loop to stow each package
for package in "${dotfile_packages[@]}"; do
  echo "Processing package: $package"

  # Backup any conflicting files before stowing
  backup_conflicting_files "$package"

  # Stow the package
  stow --target="$target_dir" --dir="$stow_dir" "$package"
done

echo "All packages have been successfully stowed."

