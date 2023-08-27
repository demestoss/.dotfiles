#!/usr/bin/env bash

ln -s ~/dotfiles/.profile ~/.profile
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/.zshenv ~/.zshenv
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.bashrc ~/.bashrc

ln -s -T ~/dotfiles/kitty ~/.config/kitty
ln -s -T ~/dotfiles/i3 ~/.config/i3
ln -s -T ~/dotfiles/networkmanager-dmenu ~/.config/networkmanager-dmenu
ln -s -T ~/dotfiles/polybar ~/.config/polybar
ln -s -T ~/dotfiles/picom ~/.config/picom
