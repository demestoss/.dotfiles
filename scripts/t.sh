#!/usr/bin/env bash

if tmux list-sessions &>/dev/null; then
  TMUX_RUNNING=0
else
  TMUX_RUNNING=1
fi

# determine the user's current position relative tmux:
# serverless - there is no running tmux server
# attached   - the user is currently attached to the running tmux server
# detached   - the user is currently not attached to the running tmux server
T_RUNTYPE="serverless"
if [ "$TMUX_RUNNING" -eq 0 ]; then
  if [ "$TMUX" ]; then # inside tmux
    T_RUNTYPE="attached"
  else # outside tmux
    T_RUNTYPE="detached"
  fi
fi

HOME_REPLACER=""                                          # default to a noop
echo "$HOME" | grep -E "^[a-zA-Z0-9\-_/.@]+$" &>/dev/null # chars safe to use in sed
HOME_SED_SAFE=$?
if [ $HOME_SED_SAFE -eq 0 ]; then # $HOME should be safe to use in sed
	HOME_REPLACER="s|^$HOME/|~/|"
fi

# Return if args not provided
if [ $# -eq 0 ]; then
  exit 1
fi

zoxide query "$1" &>/dev/null
ZOXIDE_RESULT_EXIT_CODE=$?
if [ $ZOXIDE_RESULT_EXIT_CODE -eq 0 ]; then # zoxide result found
  RESULT=$(zoxide query "$1")
else # no zoxide result found
  ls "$1" &>/dev/null
  LS_EXIT_CODE=$?
  if [ $LS_EXIT_CODE -eq 0 ]; then # directory found
    RESULT=$1
  else # no directory found
    echo "No directory found."
    exit 1
  fi
fi


if [ "$RESULT" = "" ]; then # no result
  exit 0                     # exit silently
fi

if [ $HOME_SED_SAFE -eq 0 ]; then
  RESULT=$(echo "$RESULT" | sed -e "s|^~/|$HOME/|") # get real home path back
fi

FOLDER=$(basename "$RESULT")
SESSION_NAME=""
if [ "$2" = "" ]; then
  SESSION_NAME=$(echo "$FOLDER" | tr ' .:' '_')
else
  SESSION_NAME="$2"
fi

if [ "$T_RUNTYPE" != "serverless" ]; then
  SESSION=$(tmux list-sessions -F '#S' | grep "^$SESSION_NAME$") # find existing session
fi

if [ "$SESSION" = "" ]; then # session is missing
  SESSION="$SESSION_NAME"
  tmux new-session -d -s "$SESSION" -c "$RESULT" # create session
fi

case $T_RUNTYPE in # attach to session
attached)
	tmux switch-client -t "$SESSION"
	;;
detached) ;&
serverless)
	tmux attach -t "$SESSION"
	;;
esac
