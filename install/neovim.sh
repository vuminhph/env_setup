#!/bin/bash

# Define color codes
RED="\033[0;31m"
YELLOW="\033[0;32m"
RESET="\033[0m" # Reset color to default

LOCAL_BIN="$HOME/local/bin"
INSTALL_DIR="$LOCAL_BIN/nvim"

# Define the download URL for Neovim based on the operating system
neovim_linux_url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
neovim_macos_url="https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz"

# Create the install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Check if Neovim is already installed
if command -v nvim &>/dev/null; then
	echo -e "${YELLOW}Neovim is already installed.${RESET}"
	exit 0
fi

# Function to download and install Neovim
install_neovim() {
	local url="$1"
	local tmpdir=$(mktemp -d)
	local filename=$(basename "$url")

	echo "Installing Neovim..."
	curl -sSL "$url" -o "$tmpdir/$filename"

	# Linux: Make the AppImage executable and move to install directory
	if [[ "$(uname -s)" == "Linux" ]]; then
		chmod +x "$tmpdir/$filename"
		mv "$tmpdir/$filename" "$INSTALL_DIR/nvim"
	fi

	# macOS: Extract and move Neovim to install directory
	if [[ "$(uname -s)" == "Darwin" ]]; then
		tar -xzf "$tmpdir/$filename" -C "$tmpdir"
		mv "$tmpdir/nvim-osx64" "$INSTALL_DIR/nvim"
	fi

	rm -rf "$tmpdir"
}

# Determine the current operating system and install Neovim accordingly
case "$(uname -s)" in
Linux*)
	install_neovim "$neovim_linux_url"
	;;
Darwin*)
	install_neovim "$neovim_macos_url"
	;;
*)
	echo -e "${RED}Unsupported operating system: $(uname -s)${RESET}"
	exit 1
	;;
esac