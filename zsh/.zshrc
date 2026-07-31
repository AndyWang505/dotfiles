# fish is the interactive shell; zsh only has to serve scripts, tooling that
# spawns $SHELL, and the odd fallback session — so no prompt or plugin setup.

# /etc/zshrc sets SAVEHIST=1000, which would trim the existing history the first
# time a fallback session exits.
HISTSIZE=50000
SAVEHIST=50000

# oh-my-zsh used to do this; without it a fallback session has no completion.
autoload -Uz compinit && compinit

export PATH="$HOME/.local/bin:$PATH"

# nvm comes from Homebrew, so nvm.sh lives under the brew prefix rather than $NVM_DIR
export NVM_DIR="$HOME/.nvm"
[ -s "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/nvm/nvm.sh" ] && . "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/nvm/nvm.sh"

# pnpm — `pnpm setup` rewrites whatever sits between these two markers
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# TERM and COLORTERM are left to the terminal: ghostty sets both, and forcing
# xterm-256color would throw away the Tc its own terminfo declares.

# Credentials and work-only settings live here, outside the repo
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
