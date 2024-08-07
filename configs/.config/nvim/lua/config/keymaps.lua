-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Util = require("lazyvim.util")
-- vim.keymap.set("n", "<C-\\>", function()
--   Util.terminal(nil, { border = "rounded" })
-- end, { desc = "Term with border" })
--
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a")

vim.keymap.set("x", "<leader>p", '"_dP')
