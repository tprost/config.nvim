
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
vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "master",
	},
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-context",
		version = "v1.0.0",
	},
})
require("treesitter-context").setup()

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"c",
		"cpp",
		"python",
		"rust",
        "javascript"
	},
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Handle nvim-treesitter updates",
	group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
	callback = function(event)
		if event.data.kind == "update" then
			vim.notify("nvim-treesitter updated, running TSUpdate...", vim.log.levels.INFO)
			---@diagnostic disable-next-line: param-type-mismatch
			local ok = pcall(vim.cmd, "TSUpdate")
			if ok then
				vim.notify("TSUpdate completed successfully!", vim.log.levels.INFO)
			else
				vim.notify("TSUpdate command not available yet, skipping", vim.log.levels.WARN)
			end
		end
	end,
})

-- Flash.nvim (quick navigation)
vim.pack.add({
    { src = "https://github.com/folke/flash.nvim" },
})

require('flash').setup({})

local keymap = vim.keymap.set
keymap({ "n", "x", "o" }, "gs", function() require("flash").jump() end, { desc = "Flash" })
keymap({ "n", "x", "o" }, "gS", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
keymap("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
keymap({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
keymap("c", "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })

-- Incremental selection (treesitter-based)
vim.pack.add({
    { src = "https://github.com/daliusd/incr.nvim" },
})

require('incr').setup({
    incr_key = '<CR>',
    decr_key = '<BS>',
})
