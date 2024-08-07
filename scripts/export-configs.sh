#!/bin/bash

backup_file() {
  local file="$1"
  if [[ -f "$file" ]]; then
    mv "$file" "$file.bak"
    echo "Renamed $file to $file.bak"
  else
    echo "File $file does not exist."
  fi
}

backup_dir() {
  local dir="$1"
  if [[ -d "$dir" ]]; then
    mv "$dir" "$dir.bak"
    echo "Renamed directory $dir to $dir.bak"
  else
    echo "Directory $dir does not exist."
  fi
}

files_to_backup=(
  "$HOME/.tmux.conf"
  "$HOME/.zshrc"
)
dirs_to_backup=(
  "$HOME/.config/nvim"
  "$HOME/.config/iterm2"
  "$HOME/.config/kitty"
  "$HOME/.config/skhd"
  "$HOME/.config/sketchybar"
  "$HOME/.config/yabai"
  "$HOME/.config/yazi"
  "$HOME/.tmux"
)

for file in "${files_to_backup[@]}"; do
  backup_file "$file"
done

for dir in "${dirs_to_backup[@]}"; do
  backup_dir "$dir"
done

# Export the configs files
cp -r ~/env_setup/configs/. ~/
