#!/bin/bash

# Install zoxide
echo "Installing zoxide..."

# Check operating system and install zoxide
if command -v zoxide &> /dev/null; then
  echo "zoxide already installed."
else
  if [[ "$(uname -s)" == "Linux" ]]; then
    # Check if curl is installed
    if ! command -v curl &> /dev/null; then
      echo "Error: curl is not installed. Please install it first."
      exit 1
    fi

    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
  elif [[ "$(uname -s)" == "Darwin" ]]; then
    # Use Homebrew
    brew install zoxide
  else
    echo "Error: Unsupported operating system."
    exit 1
  fi
fi

# Install fzf (optional)
echo "Installing fzf (optional)..."

if command -v fzf &> /dev/null; then
  echo "fzf already installed."
else
  # Install fzf
  if [[ "$(uname -s)" == "Linux" ]]; then
    apt install fzf
  elif [[ "$(uname -s)" == "Darwin" ]]; then
    # Use Homebrew
    brew install zoxide
  else
    echo "Error: Unsupported operating system."
    exit 1
  fi
fi

echo "Installation complete. Please restart your terminal for changes to take effect."
