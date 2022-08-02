local keymap = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- shell-like cursor move
keymap("i", "<C-a>", "<Esc>I", opt)
keymap("i", "<C-e>", "<Esc>A", opt)
