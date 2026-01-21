	

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


