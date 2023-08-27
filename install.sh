#!/bin/bash

cd $HOME

# base
sudo apt-get install curl neofetch

# zsh
sudo apt install zsh
chsh -s $(which zsh)

# fnm
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#source "$HOME/.cargo/env"
cargo install fnm

# direnv
curl -sfL https://direnv.net/install.sh | bash

# zoxide
sudo apt-get install zoxide

# starship
curl -sS https://starship.rs/install.sh | sh

# exa
cargo install exa

# bat
curl cht.sh/golang/slice | bat

# fzf
sudo apt install fzf

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# zplug
zplug install
