-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "keymaps/windows"
require "keymaps/bufferline"
require "keymaps/nvim-tree"
require "keymaps/telescope"
require "keymaps/toggleterm"
require "keymaps/symbols-outline"
require "keymaps/user-define"

local pluginKeyMaps = {}

-- lsp hot key maps.
pluginKeyMaps.lsp_keymaps = function(mapfunc)
  local opt = { noremap = true, silent = true }
  -- rename
  mapfunc('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
  -- code action
  mapfunc('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
  -- go xx
  mapfunc('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  mapfunc('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  mapfunc('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
  mapfunc('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
  mapfunc('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
  -- diagnostic
  mapfunc('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
  mapfunc('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
  mapfunc('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
  -- mapfunc('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- leader + =
  mapfunc('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)
  -- mapfunc('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt)
  -- mapfunc('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapfunc('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapfunc('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapfunc('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

return pluginKeyMaps
