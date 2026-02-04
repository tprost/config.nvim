
vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require('gitsigns').setup({ signcolumn = false })
vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
})

vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})

require("mason").setup({})

-- ~/.config/nvim-new/lua/plugins.lua
vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

require('blink.cmp').setup({
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
    keymap = {
        preset = "default",
        ["<C-space>"] = {},
        ["<C-p>"] = {},
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
        ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-n>"] = { "select_and_accept" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_down", "fallback" },
        ["<C-f>"] = { "scroll_documentation_up", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        -- ["<C-e>"] = { "hide" },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        }
    },

    cmdline = {
        keymap = {
            preset = 'inherit',
            ['<CR>'] = { 'accept_and_enter', 'fallback' },
        },
    },

    sources = { default = { "lsp" } }
})

-- ~/.config/nvim-new/lua/plugins.lua
vim.pack.add({
    { src = "https://github.com/ibhagwan/fzf-lua" },
})

local actions = require('fzf-lua.actions')
require('fzf-lua').setup({
    winopts = { backdrop = 85 },
    keymap = {
        builtin = {
            ["<C-f>"] = "preview-page-down",
            ["<C-b>"] = "preview-page-up",
            ["<C-p>"] = "toggle-preview",
        },
        fzf = {
            ["ctrl-a"] = "toggle-all",
            ["ctrl-t"] = "first",
            ["ctrl-g"] = "last",
            ["ctrl-d"] = "half-page-down",
            ["ctrl-u"] = "half-page-up",
        }
    },
    actions = {
        files = {
            ["ctrl-q"] = actions.file_sel_to_qf,
            ["ctrl-n"] = actions.toggle_ignore,
            ["ctrl-h"] = actions.toggle_hidden,
            ["enter"]  = actions.file_edit_or_qf,
        }
    }
})
vim.pack.add({
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' }
})

local harpoon = require('harpoon')
harpoon:setup()

-- Add which-key for displaying keybindings
vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim" },
})

vim.pack.add({
    { src = "https://github.com/NeogitOrg/neogit" },
})
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
        "javascript",
        "zig",
        "haskell",
        "typescript",
        "javascript",
        "tsx"
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

-- Techbase theme
vim.pack.add({
    { src = "https://github.com/mcauley-penney/techbase.nvim" },
})

require("techbase").setup({
    italic_comments = true,
    transparent = false,
})
vim.cmd.colorscheme("techbase")

-- Flash.nvim (quick navigation)
vim.pack.add({
    { src = "https://github.com/folke/flash.nvim" },
})

require('flash').setup({})

-- Incremental selection (treesitter-based)
vim.pack.add({
    { src = "https://github.com/daliusd/incr.nvim" },
})

require('incr').setup({
    incr_key = '<CR>',
    decr_key = '<BS>',
})
