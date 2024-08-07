#!/bin/bash

# cp -r ~/.config/nvim configs/.config
# cp -r ~/.config/fastfetch configs/.config
# cp -r ~/.config/yazi configs/.config
# cp -r ~/.tmux configs/.tmux
# cp ~/.tmux.conf configs/
# cp ~/.zshrc configs/
# cp ~/.p10k.zsh configs/

rsync -a --ignore-errors ~/.config/nvim configs/.config/
rsync -a --ignore-errors ~/.config/fastfetch configs/.config/
rsync -a --ignore-errors ~/.config/skhd configs/.config/
rsync -a --ignore-errors ~/.config/sketchybar configs/.config/
rsync -a --ignore-errors ~/.config/yazi configs/.config/
rsync -a --ignore-errors ~/.config/yabai configs/.config/
rsync -a --ignore-errors ~/.config/iterm2 configs/.config/
rsync -a --ignore-errors ~/.config/kitty configs/.config/
rsync -a --ignore-errors ~/.tmux configs/.tmux/

rsync -a --ignore-errors ~/.tmux.conf configs/
rsync -a --ignore-errors ~/.zshrc configs/
rsync -a --ignore-errors ~/.p10k.zsh configs/
