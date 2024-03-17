#!/bin/bash

# Define color codes
RED="\033[0;31m"
GREEN="\033[0;32m"
RESET="\033[0m" # Reset color to default

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
			echo -e "${RED}Your Linux distribution is not automatically supported. Please install Zsh manually.${RESET}"
			exit 1
		fi
	else
		echo -e "${RED}Your operating system is not recognized. Please install Zsh manually.${RESET}"
		exit 1
	fi
	;;
*)
	echo -e "${RED}Your operating system ($OS) is not supported. Please install Zsh manually.${RESET}"
	exit 1
	;;
esac

# Check if Zsh is already installed
if command -v zsh &>/dev/null; then
	echo -e "${GREEN}Zsh is already installed.${RESET}"
else
	# Install Zsh using package manager
	case $PACKAGE_MANAGER in
	"brew")
		echo -e "Installing Zsh with Homebrew..."
		brew install zsh
		;;
	"apt")
		echo -e "Installing Zsh with apt..."
		apt install zsh
		;;
	*)
		echo -e "${RED}Package manager '$PACKAGE_MANAGER' not supported. Please install Zsh manually.${RESET}"
		exit 1
		;;
	esac
	# Set Zsh as default shell (optional)
	echo -e "Do you want to set Zsh as your default shell? (y/N)"
	read -n 1 -r reply
	echo -e ""
	if [[ $reply =~ ^[Yy]$ ]]; then
		chsh -s $(which zsh)
	fi
	echo -e "${GREEN}Zsh installation complete!${RESET}"
fi

# OhMyZsh
if [ -d ~/.oh-my-zsh ]; then
	echo -e "${GREEN}Oh My Zsh is already installed. Update it with 'omz update'.${RESET}"
else
	# Install Oh My Zsh
	echo -e "Installing Oh My Zsh..."
	curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
	echo -e "${GREEN} OhMyZsh installation completed!${RESET}"
fi

# zsh-autosuggestions
grep -q 'zsh-autosuggestions' ~/.zshrc
if [[ $? -eq 0 ]]; then
	echo -e "${GREEN}zsh-autosuggestions plugin is installed.${RESET}"
else
	echo -e "Installing zsh-autosuggestions plugin..."
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	echo -e "${GREEN} zsh-autosuggestions plugin installation completed!${RESET}"
fi

# LazyVim
if [ -f ~/.config/nvim/lazyvim.json ]; then
	echo -e "${GREEN}LazyVim is already installed!${RESET}"
else
	# required
	mv $HOME/.config/nvim{,.bak}
	cp -r env_configs/nvim $HOME/.config
	echo -e "${GREEN} LazyVim installation completed!${RESET}"
fi

# tree
if command -v tree &>/dev/null; then
	echo -e "${GREEN}tree is already installed.${RESET}"
else
	if [[ $OS == "Linux" ]]; then
		apt install tree
	elif [[ $OS == "Darwin" ]]; then
		brew install tree
	fi
	echo -e "${GREEN} tree installation completed!${RESET}"
fi

# vim-gtk
if [[ $OS == "Linux" ]]; then
	# Check for Ubuntu/Debian-based system
	if [[ $(which apt-get) || $(which apt) ]]; then
		if command -v gvim >/dev/null 2>&1; then
			echo -e "${GREEN}vim-gtk3 is already installed.${RESET}"
		else
			echo "Installing vim-gtk3"
			apt-get install vim-gtk3 -y
			echo -e "${GREEN} vim-gtk3 installation completed!${RESET}"
		fi
	else
		echo -e "${RED}Error: Unsupported Linux distribution. Please install vim-gtk3 manually.${RESET}"
	fi
elif [[ $OS == "Darwin" ]]; then
	# Check for macOS using Homebrew
	if [[ $(which brew) ]]; then
		if brew list --formula vim-gtk >/dev/null 2>&1; then
			echo -e "${GREEN}vim-gtk3 (or vim-gtk) is already installed.${RESET}"
		else
			echo "Installing vim-gtk3"
			brew install vim-gtk
			echo -e "${GREEN} vim-gtk3 installation completed!${RESET}"
		fi
	else
		echo -e "${RED}Error: Homebrew not found. Please install Homebrew and try again.${RESET}"
	fi
else
	echo -e "${RED}Error: Unsupported operating system. Installation not available.${RESET}"
fi

# tmux
if [[ $OS == "Linux" ]]; then
	if [[ $(which apt-get) || $(which apt) ]]; then
		if command -v tmux >/dev/null 2>&1; then
			echo -e "${GREEN}tmux is already installed.${RESET}"
		else
			echo "Installing tmux"
			apt-get install tmux -y
			echo -e "${GREEN} tmux installation completed!${RESET}"
		fi
	else
		echo -e "${RED}Error: Unsupported Linux distribution. Please install tmux manually.${RESET}"
	fi
elif [[ $OS == "Darwin" ]]; then
	# Check for macOS using Homebrew
	if [[ $(which brew) ]]; then
		if brew list --formula tmux >/dev/null 2>&1; then
			echo -e "${GREEN}tmux is already installed.${RESET}"
		else
			echo "Installing tmux"
			brew install tmux
			echo -e "${GREEN} tmux installation completed!${RESET}"
		fi
	else
		echo -e "${RED}Error: Homebrew not found. Please install Homebrew and try again.${RESET}"
	fi
else
	echo -e "${RED}Error: Unsupported operating system. Installation not available.${RESET}"
fi

# ZOXIDE

# Check operating system and install zoxide
if command -v zoxide &>/dev/null; then
	echo -e "${GREEN}zoxide already installed.${RESET}"
else
	if [[ "$OS" == "Linux" ]]; then
		# Check if curl is installed
		if ! command -v curl &>/dev/null; then
			echo -e "Error: curl is not installed. Please install it first."
			exit 1
		fi

		curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
		echo -e "${GREEN}$ zoxide installation completed! ${RESET}"
	elif [[ "$OS" == "Darwin" ]]; then
		# Use Homebrew
		brew install zoxide
		echo -e "${GREEN}$ zoxide installation completed! ${RESET}"
	else
		echo -e "${RED}Error: Unsupported operating system.${RESET}"
		exit 1
	fi
fi

# fzf
if command -v fzf &>/dev/null; then
	echo -e "${GREEN}fzf already installed.${RESET}"
else
	# Install fzf
	if [[ "$(uname -s)" == "Linux" ]]; then
		apt install fzf
		echo -e "${GREEN}fzf installation completed!${RESET}"
	elif [[ "$(uname -s)" == "Darwin" ]]; then
		# Use Homebrew
		brew install fzf
		echo -e "${GREEN}fzf installation completed!${RESET}"
	else
		echo -e "${RED}Error: Unsupported operating system.${RESET}"
		exit 1
	fi
fi

# jq
if command -v jq &>/dev/null; then
	echo -e "${GREEN}jq already installed.${RESET}"
else
	# Install jq
	if [[ "$(uname -s)" == "Linux" ]]; then
		apt install jq
		echo -e "${GREEN}jq installation completed!${RESET}"
	elif [[ "$(uname -s)" == "Darwin" ]]; then
		# Use Homebrew
		brew install jq
		echo -e "${GREEN}jq installation completed!${RESET}"
	else
		echo -e "${RED}Error: Unsupported operating system.${RESET}"
		exit 1
	fi
fi

# Install Atuin

# Check for atuin using command -v
if command -v atuin &>/dev/null; then
	echo -e "${GREEN}Atuin is already installed.${RESET}"
else
	if [[ "$OS" == "Darwin" ]]; then
		# Install atuin on macOS using Homebrew
		echo -e "Detected macOS. Installing atuin using Homebrew..."
		if ! command -v brew &>/dev/null; then
			echo -e "${RED}Homebrew is not installed. Please install it from https://brew.sh/${RESET}"
		else
			brew install atuin
			echo -e "${GREEN} Atuin installation completed! ${RESET}"
		fi
	elif [[ "$OS" == "Linux" ]]; then
		bash <(curl https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh)
		echo -e "${GREEN} Atuin installation completed! ${RESET}"
	else
		echo -e "${RED}Unsupported operating system: $os_name. atuin installation not available.${RESET}"
	fi
fi

if ! command -v lazygit &>/dev/null; then
	if [[ "$OS" == "Linux" ]]; then
		# Install on Ubuntu and similar systems
		if [[ $(lsb_release -rs) =~ ^[0-9]+\.[0-9]+$ ]]; then # Check for Ubuntu/Debian format
			LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
			curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
			tar xf lazygit.tar.gz lazygit
			install lazygit /usr/local/bin
			rm -rf lazygit lazygit.tar.gz
			echo -e "${GREEN}LazyGit installation completed!${RESET}"
		else
			echo -e "${RED}Unsupported Linux distribution. Please refer to the lazygit installation guide for your system: https://github.com/jesseduffield/lazygit${RESET}"
		fi
	elif [[ "$OS" == "Darwin" ]]; then
		# Install on macOS using Homebrew
		if ! command -v brew &>/dev/null; then
			echo -e "${RED}Homebrew is not installed. Please install Homebrew and try again.${RESET}"
		else
			brew install lazygit
		fi
	else
		echo -e "${RED}Unsupported operating system. Please refer to the lazygit installation guide for your system: https://github.com/jesseduffield/lazygit${RESET}"
	fi
else
	echo -e "${GREEN}lazygit is already installed.${RESET}"
fi

# Source .zshrc to apply changes
echo -e "Sourcing .zshrc..."
zsh
