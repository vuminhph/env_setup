#!/bin/bash

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
        echo "Your Linux distribution is not automatically supported. Please install Zsh manually."
        exit 1
      fi
    else
      echo "Your operating system is not recognized. Please install Zsh manually."
      exit 1
    fi
    ;;
  *)
    echo "Your operating system ($OS) is not supported. Please install Zsh manually."
    exit 1
    ;;
esac

# Check if Zsh is already installed
if command -v zsh &> /dev/null; then
  echo "Zsh is already installed."
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
      echo "Package manager '$PACKAGE_MANAGER' not supported. Please install Zsh manually."
      exit 1
      ;;
  esac

  # Set Zsh as default shell (optional)
  echo "Do you want to set Zsh as your default shell? (y/N)"
  read -n 1 -r reply
  echo ""
  if [[ $reply =~ ^[Yy]$ ]]; then
    chsh -s $(which zsh)
    echo "Please restart your terminal for changes to take effect."
  fi

  echo "Zsh installation complete!"
fi


# Check if Oh My Zsh is already installed
if [ -d ~/.oh-my-zsh ]; then
  echo "Oh My Zsh is already installed. Update it with 'omz update'."
  exit 0
fi

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Add zsh-autosuggestions plugin
echo "Adding zsh-autosuggestions plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


# Optional: Set Zsh as the default shell
echo "Do you want to set Zsh as your default shell? (y/N)"
read -n 1 -r reply
echo ""
if [[ $reply =~ ^[Yy]$ ]]; then
  chsh -s $(which zsh)
  echo "Please restart your terminal for changes to take effect."
fi

# Source .zshrc to apply changes
echo "Sourcing .zshrc..."
zsh
