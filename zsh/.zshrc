# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
setopt auto_cd

## command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups  # ignore duplication command history list
setopt hist_ignore_space # ignore when commands starts with space
setopt share_history     # share command history data

EDITOR=nvim

# ZPlug
export ZPLUG_HOME=$HOME/.zplug

# Check if zplug is installed
if [[ ! -d $ZPLUG_HOME ]]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
  source $ZPLUG_HOME/init.zsh && zplug update --self
fi

ZSH_THEME="robbyrussell"

# FZF
export FZF_BASE=/user/bin/fzf
FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'


# User configuration
source $XDG_CONFIG_HOME/.aliases

# Zplug Plugins
source $ZPLUG_HOME/init.zsh

# zsh users
zplug "zsh-users/zsh-completions",              defer:0
zplug "zsh-users/zsh-autosuggestions",          defer:2, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting",      defer:3, on:"zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3, on:"zsh-users/zsh-syntax-highlighting"

# fzf plugins
zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*linux*amd64*"
zplug "sharkdp/fd", from:gh-r, as:command, rename-to:fd, use:"*x86_64-unknown-linux-gnu.tar.gz"

# Install plugins if there are plugins that have not been installed
#if ! zplug check; then
#   zplug install
#fi

zplug load

# Tmux session login
#if [[ "$TERM" != "screen" ]] && [[ "$SSH_CONNECTION" == "" ]]; then
#    # Attempt to discover a detached session and attach 
#    # it, else create a new session
#    WHOAMI="default"
#
#    if tmux has-session -t $WHOAMI 2>/dev/null; then
#        tmux -2 attach-session -t $WHOAMI
#    else
#        tmux -2 new-session -s $WHOAMI
#    fi
#fi

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

source $XDG_CONFIG_HOME/lf/lfcd.sh

[ -f ~/.cargo/env ] && source $HOME/.cargo/env

unsetopt beep
eval "$(fnm env --use-on-cd)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
