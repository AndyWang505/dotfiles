# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

- **fish** — the interactive shell; plugins declared in `fish_plugins` ([Fisher](https://github.com/jorgebucaran/fisher), [Tide](https://github.com/IlanCosman/tide) prompt, [nvm.fish](https://github.com/jorgebucaran/nvm.fish))
- **zsh** — stays the login shell, so it only sets up PATH, nvm and pnpm for scripts and fallback sessions; machine-local values come from `~/.zshrc.local`
- **nvim** — Neovim config based on LazyVim
- **tmux** — `C-a` prefix, vi-style copy mode with `pbcopy`, plugins managed by [TPM](https://github.com/tmux-plugins/tpm)
- **ghostty** — Ghostty terminal config (tokyonight-night theme, transparent background with blur), and where fish is launched from

There is deliberately no **git** package: identity and URL rewrites differ per machine, so `install.sh` writes `~/.gitconfig` once and never tracks it.

## Install

On a fresh macOS machine:

```sh
git clone https://github.com/AndyWang-505/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` is idempotent — re-run it any time. It will:

1. install Homebrew if missing, then everything in [`Brewfile`](Brewfile)
2. create `~/.gitconfig` and a `~/.zshrc.local` stub for values that must not be committed
3. move any pre-existing `.zshrc` / `.zprofile` to `*.pre-dotfiles`, then stow every package
4. clone TPM and install the tmux plugins
5. bootstrap Fisher, install the fish plugins, and create the `config-local.fish` stub
6. install the LTS Node under `~/.nvm/versions/node`, which both nvm.sh and nvm.fish read
7. run `nvim --headless "+Lazy! restore"`, which installs plugins at the commits pinned in `lazy-lock.json`

Then fill in your real values:

```sh
$EDITOR ~/.gitconfig                     # user.name, user.email
$EDITOR ~/.zshrc.local                   # JIRA_USER_EMAIL, JIRA_API_TOKEN, ...
$EDITOR ~/.config/fish/config-local.fish # the same, for fish
```

Each package mirrors the target layout under `$HOME`, so `stow nvim` symlinks `nvim/.config/nvim/` → `~/.config/nvim/`.

Ghostty runs fish through its `command` setting, so the login shell can stay zsh. To change that too:

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
- gh, pnpm — referenced by the shell configs and the day-to-day workflow

## Machine-local files

Untracked on purpose, because this repo is public:

| File | Holds |
|---|---|
| `~/.gitconfig` | `user.name` / `user.email`, and URL rewrites that only exist because a given work repo cannot be cloned over SSH here |
| `~/.zshrc.local` | credentials and work-only environment (sourced at the end of `.zshrc`) |
| `~/.config/fish/config-local.fish` | the same escape hatch for fish |
| `nvim/.../lua/config/local.lua`, `nvim/.../lua/plugins/local/` | editor config tied to one employer's repos (Nx keymaps, oxlint formatter) |
