local status_ok, onedark = pcall(require, "onedark")
if not status_ok then
  vim.notify("onedark theme not found!")
  return
end

vim.o.background = "dark"
onedark.setup {
  -- Main options --
  style = "dark", -- Default theme style. Choose between "dark", "darker", "cool", "deep", "warm", "warmer" and "light"
  transparent = false, -- Show/hide background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  -- toggle theme style ---
  toggle_style_list = { "light", "dark", "darker", "cool", "deep", "warm", "warmer" }, -- List of styles to toggle between
  toggle_style_key = "<leader>ts", -- Default keybinding to toggle

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma seperated, For e.g., keywords = "italic,bold"
  code_style = {
    comments = "italic",
    keywords = "none",
    functions = "bold",
    strings = "none",
    variables = "none"
  },

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {} -- Override highlight groups
}

onedark.load()
