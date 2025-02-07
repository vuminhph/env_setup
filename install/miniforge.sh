#!/bin/bash

# Define color codes
RED="\033[0;31m"
YELLOW="\033[0;32m"
RESET="\033[0m" # Reset color to default

LOCAL_BIN="$HOME/local/bin"
install_dir="$HOME/local/miniforge"

# Create the install directory if it doesn't exist
mkdir -p "$LOCAL_BIN"

# Define the miniforge download URLs for Linux and macOS
miniforge_linux="https://github.com/conda-forge/miniforge/releases/download/24.11.3-0/Miniforge3-24.11.3-0-Linux-x86_64.sh"
miniforge_macos="https://github.com/conda-forge/miniforge/releases/download/24.11.3-0/Miniforge3-24.11.3-0-MacOSX-arm64.sh"

# Check if miniforge is already installed
if command -v conda &>/dev/null; then
  echo -e "${YELLOW}miniforge is already installed in $install_dir${RESET}"
  exit 0
fi

# Function to download and install miniforge
install_miniforge() {
  local url="$1"
  local tmpdir=$(mktemp -d)
  local installer="$tmpdir/miniforge.sh"

  echo "Downloading miniforge"
  if ! curl --progress-bar --fail -L "$url" -o "$installer"; then
    echo "Download failed. Check that the release/filename are correct."
  fi

  echo "Installing miniforge..."
  bash "$installer" -b -p "$install_dir"
  echo 'export PATH="'"$install_dir/bin"':$PATH"' >>~/.zshrc
  echo 'eval "$($install_dir/bin/conda shell.zsh hook)"' >>~/.zshrc
  source ~/.zshrc
  conda init

  rm -rf "$tmpdir"

  echo -e "${YELLOW}miniforge installed in $install_dir${RESET}"
}

# Determine the current operating system
case "$(uname -s)" in
Linux*)
  install_miniforge "$miniforge_linux"
  ;;
Darwin*)
  install_miniforge "$miniforge_macos"
  ;;
*)
  echo -e "${RED}Unsupported operating system: $(uname -s)${RESET}"
  exit 1
  ;;
esac
