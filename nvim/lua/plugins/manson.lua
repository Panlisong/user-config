local servers = {
    clangd = require("plugins.lsp.clangd"),
    bashls = require("plugins.lsp.bashls"),
    lua_ls = require("plugins.lsp.lua_ls"),
    rust_analyzer = require("plugins.lsp.rust_analyzer")
}

return {
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp"
        },
        opts = {
            ensure_installed = {
                "clangd",
                "bashls",
                "lua_ls",
                "rust_analyzer"
            }
        },
        config = function()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local on_attach = function(_, bufnr)
                local function set_keymap(...)
                    vim.api.nvim_buf_set_keymap(bufnr, ...)
                end

                -- key maps
                require('keymaps').lsp_keymaps(set_keymap)
            end

            local opts = {
                on_attach = on_attach,
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities),
                flags = {
                    debounce_text_changes = 150,
                }
            }
            local lsp_config = require("lspconfig")
            for name, _ in pairs(servers) do
                local server_opts = servers[name]
                server_opts = vim.tbl_deep_extend("force", server_opts, opts)
                lsp_config[name].setup(server_opts)
            end
        end,
    }
}
