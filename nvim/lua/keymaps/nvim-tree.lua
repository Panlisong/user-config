-- set key map and key map options
local keymap = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- nvim-tree
keymap('n', '<F3>', ':NvimTreeToggle<CR>', opt)
