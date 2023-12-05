#!/usr/bin/env bash

set -g mode-style "fg=#82aaff,bg=#3b4261"

set -g message-style "fg=#82aaff,bg=#3b4261"
set -g message-command-style "fg=#82aaff,bg=#3b4261"

set -g pane-border-style "fg=#3b4261"
set -g pane-active-border-style "fg=#82aaff"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#82aaff,bg=#282727"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#1b1d2b,bg=#8ba4b0,bold] #S #[fg=#82aaff,bg=#1e2030,nobold,nounderscore,noitalics]"

set -g status-right "#[fg=#8ba4b0,bg=#252535] #{b:pane_current_path} #[fg=#{?client_prefix,#16161D,#1b1d2b},bg=#{?client_prefix,#E46876,#6A9589}]  "

setw -g window-status-activity-style "underscore,fg=#828bb8,bg=#1e2030"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#737c73,bg=#252535"
setw -g window-status-format "#[default] #I  #W #F #[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#7E9CD8,bg=#223249,bold] #I  #W #F #[fg=#3b4261,bg=#1e2030,nobold,nounderscore,noitalics]"

# tmux-plugins/tmux-prefix-highlight support
set -g @prefix_highlight_output_prefix "#[fg=#ffc777]#[bg=#1e2030]#[fg=#1e2030]#[bg=#ffc777]"
set -g @prefix_highlight_output_suffix ""
