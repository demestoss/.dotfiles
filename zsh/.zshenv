. "$HOME/.cargo/env"

export XDG_CONFIG_HOME="$HOME/.config"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"

export EDITOR=nvim
export VISUAL=nvim
export VIMCONFIG="$XDG_CONFIG_HOME/nvim"
export VIMDATA="$HOME/.local/share/nvim"

export PATH="$HOME/.local/scripts/zellij-smart-sessionizer:$HOME/.local/scripts:$PATH"

# make CapsLock behave like Ctrl:
setxkbmap -option ctrl:nocaps
# make short-pressed Ctrl behave like Escape:
xcape -e 'Control_L=Escape'
