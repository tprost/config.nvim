-- ~/.config/nvim-new/lua/keymaps.lua

local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader = " "

keymap("n", "<space>", "<Nop>")

keymap("n", "j", function()
    return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "j" or "gj"
end, { expr = true, silent = true }) -- Move down, but use 'gj' if no count is given
keymap("n", "k", function()
    return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "k" or "gk"
end, { expr = true, silent = true }) -- Move up, but use 'gk' if no count is given
keymap("n", "<C-d>", "<C-d>zz") -- Scroll down and center the cursor
keymap("n", "<C-u>", "<C-u>zz") -- Scroll up and center the cursor
keymap("n", "<Leader>w", "<cmd>w!<CR>", s) -- Save the current file
keymap("n", "<Leader>q", "<cmd>q<CR>", s) -- Quit Neovim
keymap("n", "<Leader>te", "<cmd>tabnew<CR>", s) -- Open a new tab
keymap("n", "<Leader>_", "<cmd>vsplit<CR>", s) -- Split the window vertically
keymap("n", "<Leader>-", "<cmd>split<CR>", s) -- Split the window horizontally
-- keymap("n", "<Leader>fo", ":lua vim.lsp.buf.format()<CR>", s) -- Format the current buffer using LSP
keymap("v", "<Leader>p", '"_dP') -- Paste without overwriting the default register
keymap("x", "y", [["+y]], s) -- Yank to the system clipboard in visual mode
keymap("t", "<Esc>", "<C-\\><C-N>") -- Exit terminal mode
-- Change directory to the current file's directory
keymap("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')

local opts = { noremap = true, silent = true }
keymap("n", "grd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- Go to definition


	

-- ~/.config/nvim-new/lua/keymaps.lua
keymap("n", "<leader>ps", '<cmd>lua vim.pack.update()<CR>')

-- Neogit (magit-like interface)
keymap("n", "<leader>g", "<cmd>Neogit<CR>", { desc = "Open Neogit" })

-- Telescope file pickers
-- keymap("n", "<leader>f", function()
--     require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
-- end, { desc = "Find files in current file's directory" })
-- keymap("n", "<leader>F", "<cmd>Telescope find_files<CR>", { desc = "Find files in cwd" })
-- keymap("n", "<leader>pf", "<cmd>Telescope git_files<CR>", { desc = "Find files in project (git)" })
-- -- ~/.config/nvim-new/lua/keymaps.lua
-- 
-- Quick access (outside <leader>z namespace)
keymap("n", "<leader>.", '<cmd>FzfLua files<CR>')
keymap("n", "<leader>b", '<cmd>FzfLua buffers<CR>')
keymap("n", "<leader>/", '<cmd>FzfLua live_grep<CR>')
keymap("n", "<leader>pf", '<cmd>FzfLua git_files<CR>')

-- FzfLua keybindings with <leader>z prefix
-- Files and Buffers
keymap("n", "<leader>ff", '<cmd>FzfLua files<CR>', { desc = "FzfLua: Find files" })
keymap("n", "<leader>fb", '<cmd>FzfLua buffers<CR>', { desc = "FzfLua: Buffers" })
keymap("n", "<leader>fo", '<cmd>FzfLua oldfiles<CR>', { desc = "FzfLua: Old files" })
keymap("n", "<leader>fh", '<cmd>FzfLua history<CR>', { desc = "FzfLua: History" })
keymap("n", "<leader>fl", '<cmd>FzfLua lines<CR>', { desc = "FzfLua: Buffer lines" })
keymap("n", "<leader>fL", '<cmd>FzfLua blines<CR>', { desc = "FzfLua: Current buffer lines" })
keymap("n", "<leader>ft", '<cmd>FzfLua tabs<CR>', { desc = "FzfLua: Tabs" })
keymap("n", "<leader>fa", '<cmd>FzfLua args<CR>', { desc = "FzfLua: Args" })

-- Search
keymap("n", "<leader>fs", '<cmd>FzfLua live_grep<CR>', { desc = "FzfLua: Live grep" })
keymap("n", "<leader>f/", '<cmd>FzfLua grep<CR>', { desc = "FzfLua: Grep" })
keymap("n", "<leader>fS", '<cmd>FzfLua grep_curbuf<CR>', { desc = "FzfLua: Grep current buffer" })
keymap("n", "<leader>fw", '<cmd>FzfLua grep_cword<CR>', { desc = "FzfLua: Grep word under cursor" })
keymap("n", "<leader>fW", '<cmd>FzfLua grep_cWORD<CR>', { desc = "FzfLua: Grep WORD under cursor" })

-- Git
keymap("n", "<leader>fgf", '<cmd>FzfLua git_files<CR>', { desc = "FzfLua: Git files" })
keymap("n", "<leader>fgs", '<cmd>FzfLua git_status<CR>', { desc = "FzfLua: Git status" })
keymap("n", "<leader>fgc", '<cmd>FzfLua git_commits<CR>', { desc = "FzfLua: Git commits" })
keymap("n", "<leader>fgC", '<cmd>FzfLua git_bcommits<CR>', { desc = "FzfLua: Git buffer commits" })
keymap("n", "<leader>fgb", '<cmd>FzfLua git_branches<CR>', { desc = "FzfLua: Git branches" })
keymap("n", "<leader>fgt", '<cmd>FzfLua git_stash<CR>', { desc = "FzfLua: Git stash" })

-- LSP
keymap("n", "<leader>flr", '<cmd>FzfLua lsp_references<CR>', { desc = "FzfLua: LSP references" })
keymap("n", "<leader>fld", '<cmd>FzfLua lsp_definitions<CR>', { desc = "FzfLua: LSP definitions" })
keymap("n", "<leader>fli", '<cmd>FzfLua lsp_implementations<CR>', { desc = "FzfLua: LSP implementations" })
keymap("n", "<leader>fls", '<cmd>FzfLua lsp_document_symbols<CR>', { desc = "FzfLua: Document symbols" })
keymap("n", "<leader>flw", '<cmd>FzfLua lsp_workspace_symbols<CR>', { desc = "FzfLua: Workspace symbols" })
keymap("n", "<leader>fla", '<cmd>FzfLua lsp_code_actions<CR>', { desc = "FzfLua: Code actions" })
keymap("n", "<leader>flt", '<cmd>FzfLua lsp_typedefs<CR>', { desc = "FzfLua: Type definitions" })

-- Diagnostics
keymap("n", "<leader>fdd", '<cmd>FzfLua diagnostics_document<CR>', { desc = "FzfLua: Document diagnostics" })
keymap("n", "<leader>fdw", '<cmd>FzfLua diagnostics_workspace<CR>', { desc = "FzfLua: Workspace diagnostics" })

-- Misc/Utility
keymap("n", "<leader>fz", '<cmd>FzfLua resume<CR>', { desc = "FzfLua: Resume last picker" })
keymap("n", "<leader>f?", '<cmd>FzfLua builtin<CR>', { desc = "FzfLua: Builtin commands" })
keymap("n", "<leader>fc", '<cmd>FzfLua commands<CR>', { desc = "FzfLua: Commands" })
keymap("n", "<leader>f:", '<cmd>FzfLua command_history<CR>', { desc = "FzfLua: Command history" })
keymap("n", "<leader>fm", '<cmd>FzfLua marks<CR>', { desc = "FzfLua: Marks" })
keymap("n", "<leader>fr", '<cmd>FzfLua registers<CR>', { desc = "FzfLua: Registers" })
keymap("n", "<leader>fk", '<cmd>FzfLua keymaps<CR>', { desc = "FzfLua: Keymaps" })
keymap("n", "<leader>fH", '<cmd>FzfLua helptags<CR>', { desc = "FzfLua: Help tags" })
keymap("n", "<leader>fM", '<cmd>FzfLua man_pages<CR>', { desc = "FzfLua: Man pages" })
keymap("n", "<leader>fq", '<cmd>FzfLua quickfix<CR>', { desc = "FzfLua: Quickfix" })
keymap("n", "<leader>fQ", '<cmd>FzfLua loclist<CR>', { desc = "FzfLua: Location list" })

-- Harpoon
local harpoon = require('harpoon')
keymap('n', '<leader>m', function() harpoon:list():add() end, { desc = 'Harpoon: add file' })
keymap('n', '<M-n>',     function() harpoon:list():next() end, { desc = 'Harpoon: next file' })
keymap('n', '<M-p>',     function() harpoon:list():prev() end, { desc = 'Harpoon: prev file' })
keymap('n', '<leader>l', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon: list files' })
keymap('n', '<M-1>', function() harpoon:list():select(1) end, { desc = 'Harpoon: select 1' })
keymap('n', '<M-2>', function() harpoon:list():select(2) end, { desc = 'Harpoon: select 2' })
keymap('n', '<M-3>', function() harpoon:list():select(3) end, { desc = 'Harpoon: select 3' })
keymap('n', '<M-4>', function() harpoon:list():select(4) end, { desc = 'Harpoon: select 4' })

-- Flash
keymap({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
keymap({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
keymap("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
keymap({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
keymap("c", "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })


-- ~/.config/nvim-new/lua/keymaps.lua
keymap("n", "<Leader>d", "<cmd>Ex %:p:h<CR>") -- Open Netrw in the current file's directory

