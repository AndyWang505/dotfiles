#!/usr/bin/env bash
# Bootstrap a fresh macOS machine from this repo. Safe to re-run.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(zsh git nvim tmux ghostty fish)

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
skip() { printf '    %s\n' "$*"; }

# ---------------------------------------------------------------- Homebrew ---
if command -v brew >/dev/null 2>&1; then
  skip "Homebrew already installed"
else
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# The installer does not touch the current shell's PATH.
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

log "Installing packages from Brewfile"
# --no-upgrade so re-running does not silently bump everything already installed;
# HOMEBREW_NO_INSTALL_CLEANUP so it does not garbage-collect other formulae.
HOMEBREW_NO_INSTALL_CLEANUP=1 brew bundle install --no-upgrade --file="$DOTFILES_DIR/Brewfile"

# --------------------------------------------------------------- oh-my-zsh ---
if [ -d "$HOME/.oh-my-zsh" ]; then
  skip "oh-my-zsh already installed"
else
  log "Installing oh-my-zsh"
  # KEEP_ZSHRC stops the installer from replacing the .zshrc this repo stows.
  RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ------------------------------------------------------- machine-local files --
# Values that must not live in a public repo. Sourced by the stowed configs.
if [ -f "$HOME/.zshrc.local" ]; then
  skip "~/.zshrc.local exists"
else
  log "Creating ~/.zshrc.local"
  cat >"$HOME/.zshrc.local" <<'EOF'
# Machine-local zsh config. Not tracked by the dotfiles repo.
# export JIRA_USER_EMAIL="you@example.com"
# export JIRA_API_TOKEN="$(security find-generic-password -a "$USER" -s jira_api_token -w)"
EOF
fi

if [ -f "$HOME/.gitconfig.local" ]; then
  skip "~/.gitconfig.local exists"
else
  log "Creating ~/.gitconfig.local"
  cat >"$HOME/.gitconfig.local" <<'EOF'
# Machine-local git identity. Not tracked by the dotfiles repo.
[user]
	name = your-name
	email = you@example.com
EOF
fi

# --------------------------------------------------------------------- stow --
# stow refuses to overwrite regular files, so move anything pre-existing aside.
for file in .zshrc .zprofile .gitconfig; do
  target="$HOME/$file"
  if [ -f "$target" ] && [ ! -L "$target" ]; then
    log "Backing up $target -> $target.pre-dotfiles"
    mv "$target" "$target.pre-dotfiles"
  fi
done

# Simulate first: stow's own failure output is hard to act on mid-script.
if ! conflicts=$(stow --dir="$DOTFILES_DIR" --target="$HOME" --no --restow "${PACKAGES[@]}" 2>&1); then
  printf '%s\n' "$conflicts" >&2
  cat >&2 <<'EOF'

Files already exist where stow wants to put symlinks (see above). Move or delete
them, then re-run this script.
EOF
  exit 1
fi

log "Stowing packages: ${PACKAGES[*]}"
stow --dir="$DOTFILES_DIR" --target="$HOME" --restow "${PACKAGES[@]}"

# ---------------------------------------------------------------------- tmux --
# TPM has to exist before `prefix + I` does anything.
TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [ -d "$TPM_DIR" ]; then
  skip "TPM already cloned"
else
  log "Cloning TPM"
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

log "Installing tmux plugins"
"$TPM_DIR/bin/install_plugins"

# ---------------------------------------------------------------------- fish --
# fisher lists itself in fish_plugins, so bootstrapping it is enough.
if fish -c 'functions -q fisher' 2>/dev/null; then
  skip "fisher already installed"
else
  log "Installing fisher"
  fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
fi

log "Installing fish plugins from fish_plugins"
fish -c 'fisher update'

# ---------------------------------------------------------------------- nvim --
# restore, not sync: install at the commits pinned in lazy-lock.json
log "Installing Neovim plugins"
nvim --headless "+Lazy! restore" +qa

# --------------------------------------------------------------------- done ---
log "Done"
cat <<EOF

Left for you to do by hand:
  - Put your real values in ~/.zshrc.local and ~/.gitconfig.local
  - To make fish the login shell:
      echo \$(brew --prefix)/bin/fish | sudo tee -a /etc/shells
      chsh -s \$(brew --prefix)/bin/fish
EOF
