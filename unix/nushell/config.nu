use std/util "path add"

$env.XDG_CONFIG_HOME = "$HOME/.config"
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.VIMCONFIG = "$XDG_CONFIG_HOME/nvim"
$env.VIMDATA = "$HOME/.local/share/nvim"

path add "~/.local/scripts"
path add "$XDG_CONFIG_HOME/bin"
path add "/opt/homebrew/bin"
path add "$HOME/.cargo/bin"

# bun
$env.BUN_INSTALL = "$HOME/.bun"
path add "$BUN_INSTALL/bin"

source ~/.config/nushell/aliases.nu

# Zoxide
zoxide init nushell | save -f ~/.zoxide.nu
source ~/.zoxide.nu

# Direnv
$env.config.hooks.env_change.PWD = (
     $env.config.hooks.env_change.PWD | append (source nu-hooks/direnv/config.nu)
)

# Fnm
use std "path add"
if not (which fnm | is-empty) {
  ^fnm env --json | from json | load-env
  let node_path = match $nu.os-info.name {
    "windows" => $"($env.FNM_MULTISHELL_PATH)",
    _ => $"($env.FNM_MULTISHELL_PATH)/bin",
  }
  path add $node_path
}

