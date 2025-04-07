-- set key map and key map options
local keymap = vim.api.nvim_set_keymap

local normal_opt = { noremap = true, silent = true }

keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", normal_opt)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", normal_opt)
keymap("n", "<leader>fb", "<cmd>Telescope live_grep grep_open_files=true<CR>", normal_opt)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", normal_opt)
