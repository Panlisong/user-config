-- set key map and key map options
local keymap = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opt)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opt)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opt)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opt)
