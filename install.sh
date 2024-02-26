#!/bin/bash


# Define color codes
RED="\033[0;31m"
GREEN="\033[0;32m"
RESET="\033[0m"  # Reset color to default

# Check operating system
OS="$(uname -s)"

# Detect package manager based on OS
case $OS in
  "Darwin") # macOS
    PACKAGE_MANAGER="brew"
    ;;
  "Linux") # Linux
    if [ -f /etc/os-release ]; then
      # Debian/Ubuntu based
      if grep -q "ID=debian" /etc/os-release; then
        PACKAGE_MANAGER="apt"
      elif grep -q "ID=ubuntu" /etc/os-release; then
        PACKAGE_MANAGER="apt"
      # Other Linux distributions
      else
        echo "${RED}Your Linux distribution is not automatically supported. Please install Zsh manually.${RESET}"
        exit 1
      fi
    else
      echo "${RED}Your operating system is not recognized. Please install Zsh manually.${RESET}"
      exit 1
    fi
    ;;
  *)
    echo "${RED}Your operating system ($OS) is not supported. Please install Zsh manually.${RESET}"
    exit 1
    ;;
esac

# Check if Zsh is already installed
if command -v zsh &> /dev/null; then
  echo "${GREEN}Zsh is already installed.${RESET}"
else
  # Install Zsh using package manager
  case $PACKAGE_MANAGER in
    "brew")
      echo "Installing Zsh with Homebrew..."
      brew install zsh
      ;;
    "apt")
      echo "Installing Zsh with apt..."
      sudo apt install zsh
      ;;
    *)
      echo "${RED}Package manager '$PACKAGE_MANAGER' not supported. Please install Zsh manually.${RESET}"
      exit 1
      ;;
  esac
  # Set Zsh as default shell (optional)
  echo "Do you want to set Zsh as your default shell? (y/N)"
  read -n 1 -r reply
  echo ""
  if [[ $reply =~ ^[Yy]$ ]]; then
    chsh -s $(which zsh)
  fi
  echo "${GREEN}Zsh installation complete!${RESET}"
fi



# Check if Oh My Zsh is already installed
if [ -d ~/.oh-my-zsh ]; then
  echo "${GREEN}Oh My Zsh is already installed. Update it with 'omz update'.${RESET}"
else
  # Install Oh My Zsh
  echo "Installing Oh My Zsh..."
  curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
  echo "${GREEN} OhMyZsh installation completed!${RESET}"
fi


# Add zsh-autosuggestions plugin
grep -q 'zsh-autosuggestions' ~/.zshrc  
if [[ $? -eq 0 ]]; then
  echo "${GREEN}zsh-autosuggestions plugin is installed.${RESET}"
else
  echo "Installing zsh-autosuggestions plugin..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  echo "${GREEN} zsh-autosuggestions plugin installation completed!${RESET}"
fi


# ZOXIDE

# Check operating system and install zoxide
if command -v zoxide &> /dev/null; then
  echo "${GREEN}zoxide already installed.${RESET}"
else
  if [[ "$(uname -s)" == "Linux" ]]; then
    # Check if curl is installed
    if ! command -v curl &> /dev/null; then
      echo "Error: curl is not installed. Please install it first."
      exit 1
    fi

    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    echo "${GREEN}$ zoxide installation completed! ${RESET}"
  elif [[ "$(uname -s)" == "Darwin" ]]; then
    # Use Homebrew
    brew install zoxide
    echo "${GREEN}$ zoxide installation completed! ${RESET}"
  else
    echo "${RED}Error: Unsupported operating system.${RESET}"
    exit 1
  fi
fi

# Install fzf 

if command -v fzf &> /dev/null; then
  echo "${GREEN}fzf already installed.${RESET}"
else
  # Install fzf
  if [[ "$(uname -s)" == "Linux" ]]; then
    apt install fzf
    echo "${GREEN}fzf installation completed!${RESET}"
  elif [[ "$(uname -s)" == "Darwin" ]]; then
    # Use Homebrew
    brew install zoxide
    echo "${GREEN}fzf installation completed!${RESET}"
  else
    echo "${RED}Error: Unsupported operating system.${RESET}"
    exit 1
  fi
fi


# Install Atuin

# Check for atuin using command -v
if command -v atuin &> /dev/null; then
  echo "${GREEN}Atuin is already installed.${RESET}"
else
  if [[ "$OS" == "Darwin" ]]; then
    # Install atuin on macOS using Homebrew
    echo "Detected macOS. Installing atuin using Homebrew..."
    if ! command -v brew &> /dev/null; then
      echo "${RED}Homebrew is not installed. Please install it from https://brew.sh/${RESET}"
    else
      brew install atuin
      echo "${GREEN} Atuin installation completed! ${RESET}"
    fi
  elif [[ "$OS" == "Linux" ]]; then
    bash <(curl https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh)
    echo "${GREEN} Atuin installation completed! ${RESET}"
  else
    echo "${RED}Unsupported operating system: $os_name. atuin installation not available.${RESET}"
  fi
fi

# Install Vim Plug
# Check if the 'plug.vim' file exists in the default Vim autoload directory
if [[ -f ~/.vim/autoload/plug.vim ]]; then
  # VimPlug is installed, run PluginInstall
  echo "${GREEN}VimPlug plugins are already installed.${RESET}"
else
  # VimPlug is not installed, install it then run PlugInstall
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qquit
  echo "${GREEN}Vim plugin installation completed!${RESET}"
fi

# Source .zshrc to apply changes
echo "Sourcing .zshrc..."
zsh
