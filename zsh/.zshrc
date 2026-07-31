export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

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

# TERM is left to the terminal: ghostty's xterm-ghostty terminfo declares Tc,
# which forcing xterm-256color would throw away. Remote hosts get the terminfo
# through ghostty's ssh-terminfo shell integration.
export COLORTERM="truecolor"

# Credentials and work-only settings live here, outside the repo
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
