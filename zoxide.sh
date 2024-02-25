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

# Initialize zoxide in your shell
echo "Initializing zoxide in your shell..."
current_shell="$(basename "$SHELL")"

# Check if zsh or bash is supported
if [[ "$current_shell" == "bash" || "$current_shell" == "zsh" ]]; then
  config_file="${HOME}/.${current_shell}rc"

  # Check if the configuration file exists and is writable
  if [[ -f "$config_file" && -w "$config_file" ]]; then
    # Check if the line already exists (avoid duplicates)
    if ! grep -q 'eval \"\$(zoxide init --cmd cd' "$config_file"; then
      echo "eval \"\$(zoxide init --cmd cd $current_shell)\"" >> "$config_file"
      echo "Updated $config_file"
    else
      echo "zoxide init command already exists in $config_file"
    fi
  else
    echo "Error: $config_file not found or not writable."
  fi
else
  echo "Warning: Unsupported shell. Please add zoxide init command manually."
fi

echo "Installation complete. Please restart your terminal for changes to take effect."
