-- set key map and key map options
local keymap = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- windows operations
keymap("n", "<leader>wv", ":vsp<CR>", opt)
keymap("n", "<leader>ws", ":sp<CR>", opt)
keymap("n", "<leader>wc", "<C-w>c", opt)
keymap("n", "<leader>wo", "<C-w>o", opt) -- close others

-- resize windows
keymap("n", "<leader>wl", ":vertical resize +20<CR>", opt)
keymap("n", "<leader>wh", ":vertical resize -20<CR>", opt)
keymap("n", "<leader>wk", ":resize +10<CR>", opt)
keymap("n", "<leader>wj", ":resize -10<CR>", opt)
keymap("n", "<leader>w=", "<C-w>=", opt)
