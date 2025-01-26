export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="dracula-pro"

setopt auto_cd

export VISUAL=nvim

## command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups  # ignore duplication command history list
setopt hist_ignore_space # ignore when commands starts with space
setopt share_history     # share command history data

# Which plugins would you like to load?
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
  fzf
)

# FZF
export FZF_BASE=/user/bin/fzf
FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'


# User configuration
source $ZDOTDIR/.aliases

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

unsetopt beep

[ -f ~/.cargo/env ] && source $HOME/.cargo/env

eval "$(fnm env --use-on-cd)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"

# bun completions
[ -s "/Users/dmitriy/.bun/_bun" ] && source "/Users/dmitriy/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

if [[ -z "$ZELLIJ" ]] && [[ -z "$SSH_CONNECTION"  ]]; then
  zs
fi

# pnpm
export PNPM_HOME="/Users/dmitriy/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
