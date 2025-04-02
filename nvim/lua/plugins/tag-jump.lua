local self_nvim_plugins_path = os.getenv("SELF_NVIM_PLUGINS")

if self_nvim_plugins_path == nil or self_nvim_plugins_path == "" then
    vim.notify("Enviroment variable SELF_NVIM_PLUGINS not set!")
    return {}
else
    return {
        dir = self_nvim_plugins_path .. "/tag-jump",
        name = "nvim-tag-jump",
        opts = {},
    }
end
