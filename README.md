# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

- **nvim** — Neovim config based on LazyVim (see [`nvim/.config/nvim/README.md`](nvim/.config/nvim/README.md))
- **tmux** — `C-a` prefix, vi-style copy mode with `pbcopy`, plugins managed by [TPM](https://github.com/tmux-plugins/tpm)
- **ghostty** — Ghostty terminal config (tokyonight-night theme, transparent background with blur)
- **fish** — fish shell config; plugins declared in `fish_plugins` ([Fisher](https://github.com/jorgebucaran/fisher) + [Tide](https://github.com/IlanCosman/tide) prompt)

## Install

```sh
git clone https://github.com/AndyWang-505/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow nvim tmux ghostty fish
```

Each package mirrors the target layout under `$HOME`, so `stow nvim` symlinks `nvim/.config/nvim/` → `~/.config/nvim/`.

After stowing `fish`, install Fisher (see its README) and run `fisher update` to pull the plugins listed in `fish_plugins`.

## Requirements

- GNU Stow
- Neovim ≥ 0.10
- [fzf](https://github.com/junegunn/fzf) > 0.36 — engine behind the fzf-lua picker
- [ripgrep](https://github.com/BurntSushi/ripgrep) — required by the grep pickers
- [fd](https://github.com/sharkdp/fd) — optional, used for file listing when present
- A Nerd Font (config assumes JetBrainsMono NF)
- tmux ≥ 3.0; on first launch hit `prefix + I` to install TPM plugins
