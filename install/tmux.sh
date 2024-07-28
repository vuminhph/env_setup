#!/bin/bash

# Set local bin directory
LOCAL_BIN="$HOME/local/bin"
mkdir -p "$LOCAL_BIN"

# Define color codes
RED="\033[0;31m"
YELLOW="\033[0;32m"
RESET="\033[0m" # Reset color to default

# Function to check and install tmux
install_tmux() {
	echo "Installing tmux..."
	cd /tmp
	TMUX_VERSION=3.4 # You can change the version as needed
	curl -LO https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz
	tar -xvzf tmux-$TMUX_VERSION.tar.gz
	cd tmux-$TMUX_VERSION
	./configure --prefix=$LOCAL_BIN
	make
	make install
	echo "tmux installed successfully."
}

# Function to check and install tpm
install_tpm() {
	echo "Installing tpm..."
	mkdir -p $HOME/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
	echo -e "${YELLOW}tpm installed successfully.${RESET}"
}

# Check for tmux
if command -v tmux &>/dev/null; then
	echo -e "${YELLOW}tmux is already installed.${RESET}"
else
	install_tmux
fi

# Check for tpm
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
	echo -e "${YELLOW}tpm is already installed.${RESET}"
else
	install_tpm
fi
