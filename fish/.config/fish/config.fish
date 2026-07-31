# ghostty starts fish directly rather than through a login shell, so PATH is the
# bare launchd default here and brew has to be re-declared
if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv fish | source
end

set -gx PNPM_HOME $HOME/Library/pnpm
fish_add_path --global --path $HOME/.local/bin $PNPM_HOME

# nvm.fish reads $nvm_data/<version>/bin, the same layout the brew nvm that zsh
# sources writes — pointing it here shares one set of Node installs
set -gx nvm_data $HOME/.nvm/versions/node

# Credentials and work-only settings live here, outside the repo
set -l local_config (dirname (status --current-filename))/config-local.fish
test -f $local_config && source $local_config
