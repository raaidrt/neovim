-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps herehttps://github.com/LazyVim/LazyVim

vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
vim.keymap.set("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start or continue the debugger" })

-- Java tests
vim.keymap.set("n", "<leader>rjt", "<cmd>require('java').test.run_current_class()<CR>", { desc = "Run Java Test" })
vim.keymap.set("n", "<leader>djt", "<cmd>require('java').test.debug_current_class()<CR>", { desc = "Debug Java Test" })
