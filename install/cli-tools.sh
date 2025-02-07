#!/bin/bash

# Set the local bin directory
LOCAL_BIN="$HOME/local/bin"
mkdir -p "$LOCAL_BIN"

# Define color codes
RED="\033[0;31m"
YELLOW="\033[0;32m"
RESET="\033[0m" # Reset color to default

# Define the list of required commands and their download URLs for Linux
binaries_linux=(
  "fzf=https://github.com/junegunn/fzf/releases/download/0.53.0/fzf-0.53.0-linux_amd64.tar.gz"
  "zoxide=https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.4/zoxide-0.9.4-x86_64-unknown-linux-musl.tar.gz"
  "jq=https://github.com/stedolan/jq/releases/latest/download/jq-linux64"
  "atuin=https://github.com/atuinsh/atuin/releases/latest/download/atuin-x86_64-unknown-linux-gnu.tar.gz"
  "bat=https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-i686-unknown-linux-musl.tar.gz"
  "lazygit=https://github.com/jesseduffield/lazygit/releases/download/v0.42.0/lazygit_0.42.0_Linux_x86_64.tar.gz"
  "fastfetch=https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-aarch64.tar.gz"
  "eza=https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-musl.tar.gz"
  "yazi=https://github.com/sxyazi/yazi/releases/latest/yazi-x86_64-unknown-linux-musl.zip"
)

# Define the list of required commands and their download URLs for macOS
binaries_macos=(
  "fzf=https://github.com/junegunn/fzf/releases/download/0.53.0/fzf-0.53.0-darwin_arm64.zip"
  "zoxide=https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.4/zoxide-0.9.4-aarch64-apple-darwin.tar.gz"
  "jq=https://github.com/jqlang/jq/releases/latest/download/jq-macos-arm64"
  "atuin=https://github.com/atuinsh/atuin/releases/latest/download/atuin-aarch64-apple-darwin.tar.gz"
  "bat=https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-x86_64-apple-darwin.tar.gz"
  "lazygit=https://github.com/jesseduffield/lazygit/releases/download/v0.42.0/lazygit_0.42.0_Darwin_arm64.tar.gz"
  "fastfetch=https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-macos-universal.tar.gz"
  "eza=https://github.com/eza-community/eza/releases/latest/download/eza_arm-unknown-linux-gnueabihf.tar.gz"
  "yazi=https://github.com/sxyazi/yazi/releases/latest/yazi-aarch64-apple-darwin.zip"
)

# Define the list of required commands
commands=($(echo "${binaries_macos[@]}" | cut -d'=' -f1))

# Check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to download and install binary.
install_binary() {
  local cmd="$1"
  local url="$2"
  local tmpdir=$(mktemp -d)
  local filename=$(basename "$url")
  local extension="${filename##*.}"

  echo "Installing $cmd..."
  if ! curl --progress-bar --fail -L "$url" -o "$tmpdir/$filename"; then
    echo "Download failed. Check that the release/filename are correct."
  fi

  case "$extension" in
  gz)
    tar -xzf "$tmpdir/$filename" -C "$tmpdir"
    ;;
  zip)
    unzip -q "$tmpdir/$filename" -d "$tmpdir"
    ;;
  *)
    echo -e "${RED}Unsupported file format: $extension${RESET}"
    ;;
  esac

  case "$cmd" in
  fzf | zoxide | jq | lazygit | eza)
    mv $tmpdir/${cmd%-*} "$LOCAL_BIN"
    ;;
  bat | atuin | yazi)
    mv $tmpdir/${cmd}*/${cmd} "$LOCAL_BIN"
    ;;
  fastfetch)
    mv $tmpdir/${cmd}*/usr/bin/${cmd} "$LOCAL_BIN"
    ;;
  esac

  rm -rf "$tmpdir"
}

# Install the binaries based on OS.
case "$(uname -s)" in
Linux*)
  for binary in "${binaries_linux[@]}"; do
    cmd="${binary%=*}"
    url="${binary#*=}"
    if ! command_exists "$cmd"; then
      install_binary "$cmd" "$url"
    else
      echo -e "${YELLOW}$cmd is already installed${RESET}"
    fi
  done
  ;;
Darwin*)
  for binary in "${binaries_macos[@]}"; do
    cmd="${binary%=*}"
    url="${binary#*=}"
    if ! command_exists "$cmd"; then
      install_binary "$cmd" "$url"
    else
      echo -e "${YELLOW}$cmd is already installed${RESET}"
    fi
  done
  ;;
*)
  echo -e "${RED}Unsupported operating system: $(uname -s)${RESET}"
  exit 1
  ;;
esac
