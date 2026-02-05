
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

    sources = { default = { "lsp", "path", "snippets", "buffer" } }
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
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		version = "main",
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
        "zig",
        "haskell",
        "typescript",
        "javascript",
        "tsx",
        "markdown",
        "bash",
        "commonlisp",
        "ocaml",
        "gitignore",
        "glsl",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "json",
        "yaml",
        "python",
        "racket",
        "scheme",
        "sql",
        "tmux"
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

local ts_select = require("nvim-treesitter-textobjects.select")
local ts_move = require("nvim-treesitter-textobjects.move")
local ts_swap = require("nvim-treesitter-textobjects.swap")

require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
	},
	move = {
		set_jumps = true,
	},
})

-- Select textobjects
vim.keymap.set({ "x", "o" }, "af", function() ts_select.select_textobject("@function.outer", "textobjects") end, { desc = "Around function" })
vim.keymap.set({ "x", "o" }, "if", function() ts_select.select_textobject("@function.inner", "textobjects") end, { desc = "Inside function" })
vim.keymap.set({ "x", "o" }, "ac", function() ts_select.select_textobject("@class.outer", "textobjects") end, { desc = "Around class" })
vim.keymap.set({ "x", "o" }, "ic", function() ts_select.select_textobject("@class.inner", "textobjects") end, { desc = "Inside class" })
vim.keymap.set({ "x", "o" }, "aa", function() ts_select.select_textobject("@parameter.outer", "textobjects") end, { desc = "Around parameter" })
vim.keymap.set({ "x", "o" }, "ia", function() ts_select.select_textobject("@parameter.inner", "textobjects") end, { desc = "Inside parameter" })
vim.keymap.set({ "x", "o" }, "al", function() ts_select.select_textobject("@call.outer", "textobjects") end, { desc = "Around call" })
vim.keymap.set({ "x", "o" }, "il", function() ts_select.select_textobject("@call.inner", "textobjects") end, { desc = "Inside call" })

-- Move to next/previous function
vim.keymap.set({ "n", "x", "o" }, "]m", function() ts_move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
vim.keymap.set({ "n", "x", "o" }, "]M", function() ts_move.goto_next_end("@function.outer", "textobjects") end, { desc = "Next function end" })
vim.keymap.set({ "n", "x", "o" }, "[m", function() ts_move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Previous function start" })
vim.keymap.set({ "n", "x", "o" }, "[M", function() ts_move.goto_previous_end("@function.outer", "textobjects") end, { desc = "Previous function end" })

-- Move to next/previous class
vim.keymap.set({ "n", "x", "o" }, "]c", function() ts_move.goto_next_start("@class.outer", "textobjects") end, { desc = "Next class start" })
vim.keymap.set({ "n", "x", "o" }, "[c", function() ts_move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Previous class start" })

-- Swap parameters
vim.keymap.set("n", "<leader>a", function() ts_swap.swap_next("@parameter.inner") end, { desc = "Swap parameter with next" })
vim.keymap.set("n", "<leader>A", function() ts_swap.swap_previous("@parameter.inner") end, { desc = "Swap parameter with previous" })

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
