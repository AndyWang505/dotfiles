# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

- **nvim** — Neovim config based on LazyVim (see [`nvim/.config/nvim/README.md`](nvim/.config/nvim/README.md))
- **tmux** — `C-a` prefix, vi-style copy mode with `pbcopy`, plugins managed by [TPM](https://github.com/tmux-plugins/tpm)

## Install

```sh
git clone https://github.com/AndyWang-505/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow nvim tmux
```

Each package mirrors the target layout under `$HOME`, so `stow nvim` symlinks `nvim/.config/nvim/` → `~/.config/nvim/`.

## Requirements

- GNU Stow
- Neovim ≥ 0.10
- A Nerd Font (config assumes JetBrainsMono NF)
- tmux ≥ 3.0; on first launch hit `prefix + I` to install TPM plugins
