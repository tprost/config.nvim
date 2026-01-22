-- ~/.config/nvim-new/lua/plugins.lua
vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require('gitsigns').setup({ signcolumn = false })
vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
})

require("mason").setup({})

-- Add plenary.nvim (required by both telescope and neogit)
vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})

-- Add telescope.nvim (optional dependency for neogit, provides better UI)
vim.pack.add({
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
})

-- Add which-key for displaying keybindings
vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim" },
})

vim.pack.add({
    { src = "https://github.com/NeogitOrg/neogit" },
})

-- Add Monokai Pro theme
vim.pack.add({
    { src = "https://github.com/loctvl842/monokai-pro.nvim" },
})


require("monokai-pro").setup({
  transparent_background = true,
  terminal_colors = true,
  devicons = true,
  styles = {
    comment = { italic = true },
    keyword = { italic = true },
    type = { italic = true },
    storageclass = { italic = true },
    structure = { italic = true },
    parameter = { italic = true },
    annotation = { italic = true },
    tag_attribute = { italic = true },
  },
  filter = "octagon",
  day_night = {
    enable = false,
    day_filter = "pro",
    night_filter = "spectrum",
  },
  inc_search = "background", -- underline | background
  background_clear = {
    "toggleterm",
    "telescope",
    "renamer",
    "notify",
  },
  plugins = {
    bufferline = {
      underline_selected = false,
      underline_visible = false,
      underline_fill = false,
      bold = true,
    },
    indent_blankline = {
      context_highlight = "default", -- default | pro
      context_start_underline = false,
    },
  },
  override = function(scheme)
    return {}
  end,
  override_palette = function(filter)
    return {}
  end,
  override_scheme = function(scheme, palette, colors)
    return {}
  end,
})

vim.cmd.colorscheme("monokai-pro")
