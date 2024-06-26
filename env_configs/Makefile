export-configs:
	mv ~/.config/nvim{,.bak}
	mv ~/.tmux{,.bak}
	mv ~/.tmux.conf{./bak}
	mv ~/.zshrc{,.bak}

	cp -r .* ~

import-configs:
	cp -r ~/.config/nvim .config 
	cp ~/.zshrc .
	cp ~/.tmux.conf .
	cp -r ~/.tmux .

