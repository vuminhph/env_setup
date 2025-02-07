#!/bin/bash

# Set local bin directory
LOCAL_BIN="$HOME/local/bin"
mkdir -p "$LOCAL_BIN"

# Define color codes
RED="\033[0;31m"
YELLOW="\033[0;32m"
RESET="\033[0m" # Reset color to default

# Tmux
echo "Tmux installation"
bash ./tmux.sh

# CLI tools
echo "CLI tools instalation"
bash ./cli-tools.sh

# Neovim
echo "Neovim instalation"
bash ./nvim.sh

# # Miniconda
# echo "Miniconda installation"
# bash ./miniconda.sh
# MiniForge
echo "MiniForge installation"
bash ./miniforge.sh

# ZSH
echo "ZSH installation"
bash ./zsh.sh

# Add the local bin to PATH if not already added
if ! echo $PATH | grep -q "$HOME/local/bin"; then
  echo 'export PATH=$HOME/local/bin:$PATH' >>~/.zshrc
  export PATH=$LOCAL_BIN:$PATH
  echo -e "\n${YELLOW}Added $LOCAL_BIN to PATH.${RESET}"
fi
