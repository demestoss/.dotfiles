#!/usr/bin/env bash

tmux rename-window "editor"
tmux send-keys "nvim" Enter

tmux new-window -n "runner" -d
