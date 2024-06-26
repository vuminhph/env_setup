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
	"jq=https://github.com/stedolan/jq/releases/download/jq-1.7.1/jq-linux64"
	"atuin=https://github.com/atuinsh/atuin/releases/download/v18.3.0/atuin-x86_64-unknown-linux-gnu.tar.gz"
	"bat=https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-i686-unknown-linux-musl.tar.gz"
)

# Define the list of required commands and their download URLs for macOS
binaries_macos=(
	"fzf=https://github.com/junegunn/fzf/releases/download/0.53.0/fzf-0.53.0-darwin_arm64.zip"
	"zoxide=https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.4/zoxide-0.9.4-aarch64-apple-darwin.tar.gz"
	"jq=https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-macos-arm64"
	"atuin=https://github.com/atuinsh/atuin/releases/download/v18.3.0/atuin-aarch64-apple-darwin.tar.gz"
	"bat=https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-x86_64-apple-darwin.tar.gz"
)

# Define the list of required commands
commands=("fzf" "zoxide" "jq" "atuin" "bat")

# Check if a command exists
command_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Function to download and install binary
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
	fzf | zoxide | jq)
		mv $tmpdir/${cmd%-*} "$LOCAL_BIN"
		;;
	bat | atuin)
		mv $tmpdir/${cmd}*/${cmd} "$LOCAL_BIN"
		;;
	esac

	rm -rf "$tmpdir"
}

# Determine the current operating system
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
