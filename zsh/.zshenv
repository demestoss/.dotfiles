. "$HOME/.cargo/env"

export XDG_CONFIG_HOME="$HOME/.config"
export KITTY_CONFIG_DIRECTORY=$XDG_CONFIG_HOME
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"

export EDITOR=nvim
export VISUAL=nvim
export VIMCONFIG="$XDG_CONFIG_HOME/nvim"
export VIMDATA="$HOME/.local/share/nvim"

# make CapsLock behave like Ctrl:
#setxkbmap -option ctrl:nocaps
# make short-pressed Ctrl behave like Escape:
#xcape -e 'Control_L=Escape'
