# nvim

Personal Neovim config built on top of [LazyVim](https://github.com/LazyVim/LazyVim).

## Highlights

- Font: JetBrainsMono Nerd Font
- Colorscheme: tokyonight (with habamax fallback)
- Format-on-save disabled (`vim.g.autoformat = false`) — format explicitly via `<leader>cf`
- Snacks explorer shows hidden files by default

## LazyVim extras enabled

`formatting.prettier`, `lang.json`, `lang.markdown`, `lang.typescript`, `lang.yaml`, `linting.eslint`, `test.core`

## Custom plugins

- **img-clip.nvim** — `<leader>p` pastes image from clipboard
- **conform.nvim** — prefers project-local `node_modules/.bin`; TS/JS files run through `prettier` then `oxlint --fix` (only when an `.oxlintrc.json` is found upward)

## Nx workflow shortcuts

| Keymap | Action |
|---|---|
| `<leader>nl` | `pnpm nx affected -t=lint` |
| `<leader>nt` | `pnpm nx affected -t=typecheck` |
| `<leader>nq` | `pnpm nx run-many -t=typecheck,lint` |
| `<leader>nf` | `pnpm nx run-many -t=lint --fix` |
