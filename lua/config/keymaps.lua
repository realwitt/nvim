-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Format SQL strings in Go code (visual selection)
vim.keymap.set("v", "<leader>fs", ":FormatSQLString<CR>", { desc = "Format SQL string" })
