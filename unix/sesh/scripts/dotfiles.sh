#!/usr/bin/env bash

tmux rename-session "config"

tmux rename-window "nvim"
tmux send-keys "cd ~/.config/nvim" Enter
tmux send-keys "nvim" Enter

tmux new-window -n "dotfiles"
tmux send-keys "nvim" Enter

tmux new-window -n "neovim"
tmux send-keys "z neovim" Enter
tmux send-keys "clear" Enter

tmux new-window -n "term"
