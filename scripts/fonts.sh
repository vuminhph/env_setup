#!/bin/bash

declare -a fonts=(
	JetBrainsMono
)

version='3.1.1'

# Check operating system
OS="$(uname -s)"
if [[ $OS == "Linux" ]]; then
	fonts_dir="$HOME/.local/share/fonts"
elif [[ $OS == "Darwin" ]]; then
	fonts_dir="$HOME/Library/Fonts"
fi

if [[ ! -d "$fonts_dir" ]]; then
	mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
	zip_file="${font}.zip"
	download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
	echo "Downloading $download_url"
	wget "$download_url"
	unzip "$zip_file" -d "$fonts_dir" -x "*.txt/*" -x "*.md/*"
	rm "$zip_file"
done

find "$fonts_dir" -name '*Windows Compatible*' -delete

if [[ $OS == "Linux" ]]; then
	fc-cache -fv
fi
