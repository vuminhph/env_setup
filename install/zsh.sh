#!/bin/bash

# Define color codes
RED="\033[0;31m"
YELLOW="\033[0;32m"
RESET="\033[0m" # Reset color to default

OS="$(uname -s)"

# Install functions
install_zsh() {
  if [[ "$OS" == "Linux" ]]; then
    echo -e "Installing Zsh on Linux..."
    mkdir -p ~/local/bin
    wget -O ~/local/bin/zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download
    tar -xf ~/local/bin/zsh.tar.xz -C ~/local/bin
    cd ~/local/bin/zsh-* && ./configure --prefix=$HOME/local && make && make install
    cd - >/dev/null
    echo -e "${YELLOW}Zsh installed at $HOME/local/bin/zsh.${RESET}"
  elif [[ "$OS" == "Darwin" ]]; then
    echo "Installing Zsh on macOS..."
    mkdir -p ~/local/bin
    brew install --prefix=$HOME/local zsh
    echo -e "${YELLOW}Zsh installed at $HOME/local/bin/zsh${RESET}"
  else
    echo -e "${RED}Unsupported OS type: $OS.${RESET}"
    exit 1
  fi
}

install_oh_my_zsh() {
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo -e "${YELLOW}Oh My Zsh installed.${RESET}"
}

install_zsh_autosuggestions() {
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  sed -i.bak 's/plugins=(git)/plugins=(git zsh-autosuggestions)/' ~/.zshrc
  echo -e "${YELLOW}zsh-autosuggestions installed.${RESET}"
}

install_p10k() {
  echo "Installing powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  echo -e "${YELLOW}powerlevel10k installed.${RESET}"
}

# Install Zsh
if command -v zsh >/dev/null 2>&1; then
  echo -e "${YELLOW}Zsh is already installed.${RESET}"
else
  echo "${RED}Zsh is not installed.${RESET}"
  install_zsh
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  install_oh_my_zsh
else
  echo -e "${YELLOW}OhMyZsh is already installed. ${RESET}"
fi

# Install zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  install_zsh_autosuggestions
else
  echo -e "${YELLOW}zsh-autosuggestions is already installed. ${RESET}"
fi

# Install powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  install_p10k
else
  echo -e "${YELLOW}powerlevel10k is already installed. ${RESET}"
fi

# Switch to Zsh shell
if [[ "$SHELL" != "$(which zsh)" ]]; then
  chsh -s $(which zsh)
  echo -e "${YELLOW}Default shell changed to Zsh. Please restart your terminal.${RESET}"
fi
