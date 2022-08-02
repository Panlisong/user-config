local lsp_installer = require "nvim-lsp-installer"

local servers = {
  sumneko_lua = require "lsp/settings/sumneko_lua",
  gopls = require "lsp/settings/gopls",
  rust_analyzer = require "lsp/settings/rust_analyzer",
  clangd = require "lsp/settings/clangd",
  --bashls = require "lsp/settings/bashls"
}

-- install LanguageServers
for name, _ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

-- configure lsp installer status
lsp_installer.setup({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

-- configure LanguageServers
local on_attach = function(_, bufnr)
  local function set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- key maps
  require('keymaps').lsp_keymaps(set_keymap)
end


local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local opts = {
  on_attach = on_attach,
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities),
  flags = {
    debounce_text_changes = 150,
  }
}

local lspconfig = require("lspconfig")

for name, _ in pairs(servers) do
  local server_opts = servers[name]

  server_opts = vim.tbl_deep_extend("force", server_opts, opts)
  lspconfig[name].setup(server_opts)
end
