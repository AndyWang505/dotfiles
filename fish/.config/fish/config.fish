if status is-interactive
# Commands to run in interactive sessions can go here
end

# Credentials and work-only settings live here, outside the repo
set -l local_config (dirname (status --current-filename))/config-local.fish
test -f $local_config && source $local_config
