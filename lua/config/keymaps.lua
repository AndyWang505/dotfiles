-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Nx monorepo shortcuts
map("n", "<leader>nl", "<cmd>!pnpm nx affected -t=lint<cr>", { desc = "Nx affected lint" })
map("n", "<leader>nt", "<cmd>!pnpm nx affected -t=typecheck<cr>", { desc = "Nx affected typecheck" })
map("n", "<leader>nq", "<cmd>!pnpm nx run-many -t=typecheck,lint<cr>", { desc = "Typecheck + lint all" })
map("n", "<leader>nf", "<cmd>!pnpm nx run-many -t=lint --fix<cr>", { desc = "Lint --fix all" })
