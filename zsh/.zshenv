. "$HOME/.cargo/env"

if [[ -z "$XDG_CONFIG_HOME" ]]
then
        export XDG_CONFIG_HOME="$HOME/dotfiles/"
fi

export KITTY_CONFIG_DIRECTORY=$XDG_CONFIG_HOME
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"

# make CapsLock behave like Ctrl:
#setxkbmap -option ctrl:nocaps
# make short-pressed Ctrl behave like Escape:
#xcape -e 'Control_L=Escape'
