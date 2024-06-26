#!/bin/bash

# Define color codes
RED="\033[0;31m"
YELLOW="\033[0;32m"
RESET="\033[0m" # Reset color to default

LOCAL_BIN="$HOME/local/bin"
MINICONDA_DIR="$HOME/local/miniconda"

# Create the install directory if it doesn't exist
mkdir -p "$LOCAL_BIN"

# Define the Miniconda download URLs for Linux and macOS
miniconda_linux="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
miniconda_macos="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh"

# Check if Miniconda is already installed
if command -v conda &>/dev/null; then
	echo -e "${YELLOW}Miniconda is already installed in $MINICONDA_DIR${RESET}"
	exit 0
fi

# Function to download and install Miniconda
install_miniconda() {
	local url="$1"
	local tmpdir=$(mktemp -d)
	local installer="$tmpdir/miniconda.sh"

	echo "Downloading Miniconda"
	if ! curl --progress-bar --fail -L "$url" -o "$installer"; then
		echo "Download failed. Check that the release/filename are correct."
	fi

	echo "Installing Miniconda..."
	bash "$installer" -b -p "$MINICONDA_DIR"
	echo 'export PATH="'"$MINICONDA_DIR/bin"':$PATH"' >>~/.zshrc
	echo 'eval "$($MINICONDA_DIR/bin/conda shell.zsh hook)"' >>~/.zshrc
	source ~/.zshrc
	conda init

	rm -rf "$tmpdir"

	echo -e "${YELLOW}Miniconda installed in $MINICONDA_DIR${RESET}"
}

# Determine the current operating system
case "$(uname -s)" in
Linux*)
	install_miniconda "$miniconda_linux"
	;;
Darwin*)
	install_miniconda "$miniconda_macos"
	;;
*)
	echo -e "${RED}Unsupported operating system: $(uname -s)${RESET}"
	exit 1
	;;
esac
