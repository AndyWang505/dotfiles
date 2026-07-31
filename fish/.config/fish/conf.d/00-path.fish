# PATH is built here rather than in config.fish because conf.d runs first: nvm.fish
# activates a Node version from conf.d with `set --prepend PATH`, and anything that
# rebuilds or reorders PATH afterwards would bury it behind brew's node.

# ghostty starts fish directly rather than through a login shell, so nothing has
# run path_helper and PATH is the bare launchd default: no /usr/local/bin, no
# cryptex paths, no /Library/Apple/usr/bin. Has to stay above the additions below,
# because path_helper moves whatever is already on PATH to the end.
if test -x /usr/libexec/path_helper
    set -gx PATH (/usr/libexec/path_helper -s | string match -rg '^PATH="(.*)";' | string split ":")
end

if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv fish | source
end

set -gx PNPM_HOME $HOME/Library/pnpm
# --move because brew shellenv emits `fish_add_path --move`, so in a fish started
# from fish these entries are already on PATH and would otherwise keep brew's
# position ahead of them — putting brew's node and claude back in front.
fish_add_path --global --move --path $HOME/.local/bin $PNPM_HOME

# nvm.fish reads $nvm_data/<version>/bin, the layout the brew nvm that zsh sources
# already writes, so pointing it here gives both shells one set of Node installs.
# Not `set -U` — the plugin's own update handler erases the universal one.
#
# The trade-off: the plugin's uninstall event runs `rm -rf $nvm_data`, so removing
# nvm.fish takes zsh's Node installs with it.
set -gx nvm_data $HOME/.nvm/versions/node
