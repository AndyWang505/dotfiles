-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keymaps that only make sense inside one employer's repos live in
-- config/local.lua, which this repo does not track.
pcall(require, "config.local")
