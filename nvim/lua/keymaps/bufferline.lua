-- set key map and key map options
local keymap = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- bufferline
-- toggle tab
keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
keymap("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
