#!/bin/bash

# Check if Zsh is already installed
if ! command -v zsh &> /dev/null; then
  echo "Zsh is not installed. Please install Zsh before proceeding."
  exit 1
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

# Add plugin to .zshrc
echo "Adding plugin to .zshrc..."
sed -i '/plugins=( /s/)$/\n zsh-autosuggestions)/' ~/.zshrc

echo "Oh My Zsh and zsh-autosuggestions installed successfully!"

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
