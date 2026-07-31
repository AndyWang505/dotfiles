# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

- **zsh** — login shell config (oh-my-zsh, `robbyrussell` theme); machine-local values come from `~/.zshrc.local`
- **git** — aliases and URL rewriting; identity comes from `~/.gitconfig.local`
- **nvim** — Neovim config based on LazyVim (see [`nvim/.config/nvim/README.md`](nvim/.config/nvim/README.md))
- **tmux** — `C-a` prefix, vi-style copy mode with `pbcopy`, plugins managed by [TPM](https://github.com/tmux-plugins/tpm)
- **ghostty** — Ghostty terminal config (tokyonight-night theme, transparent background with blur)
- **fish** — fish shell config; plugins declared in `fish_plugins` ([Fisher](https://github.com/jorgebucaran/fisher) + [Tide](https://github.com/IlanCosman/tide) prompt)

## Install

On a fresh macOS machine:

```sh
git clone https://github.com/AndyWang-505/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` is idempotent — re-run it any time. It will:

1. install Homebrew if missing, then everything in [`Brewfile`](Brewfile)
2. create `~/.zshrc.local` and `~/.gitconfig.local` stubs for values that must not be committed
3. move any pre-existing `.zshrc` / `.zprofile` / `.gitconfig` to `*.pre-dotfiles`, then stow every package
4. install oh-my-zsh — after stow, so `KEEP_ZSHRC=yes` sees the symlink and leaves it alone
5. clone TPM and install the tmux plugins
6. bootstrap Fisher and install the fish plugins
7. run `nvim --headless "+Lazy! restore"`, which installs plugins at the commits pinned in `lazy-lock.json`

Then fill in your real values:

```sh
$EDITOR ~/.zshrc.local     # JIRA_USER_EMAIL, JIRA_API_TOKEN, ...
$EDITOR ~/.gitconfig.local # user.name, user.email
```

Each package mirrors the target layout under `$HOME`, so `stow nvim` symlinks `nvim/.config/nvim/` → `~/.config/nvim/`.

To make fish the login shell (optional — the default stays zsh):

```sh
echo $(brew --prefix)/bin/fish | sudo tee -a /etc/shells
chsh -s $(brew --prefix)/bin/fish
```

## Requirements

Everything is in the [`Brewfile`](Brewfile) and installed by `install.sh`. Listed here for reference:

- GNU Stow, git
- Neovim ≥ 0.10, plus [fzf](https://github.com/junegunn/fzf) > 0.36, [ripgrep](https://github.com/BurntSushi/ripgrep) and [fd](https://github.com/sharkdp/fd) for its pickers
- tmux ≥ 3.2 (`terminal-features` is used to declare truecolor)
- fish
- JetBrainsMono Nerd Font, Ghostty
- gh, pnpm — referenced by the zsh config and the day-to-day workflow

## Machine-local files

Two files are deliberately untracked, because this repo is public:

| File | Holds |
|---|---|
| `~/.zshrc.local` | credentials and work-only environment (sourced at the end of `.zshrc`) |
| `~/.gitconfig.local` | `user.name` / `user.email` (pulled in via `[include]`) |
| `~/.config/fish/config-local.fish` | the same escape hatch for fish, sourced at the end of `config.fish` |
