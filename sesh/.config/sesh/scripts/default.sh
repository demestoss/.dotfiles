#!/usr/bin/env bash

tmux new-window -n "runner" -d
tmux rename-window "editor"
tmux send-keys "nvim" Enter

