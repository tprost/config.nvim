-- ~/.config/nvim-new/lua/lsp.lua
vim.lsp.enable({
  "bashls",
  "gopls",
  "hls",
  "lua_ls",
  "ts_ls",
  "zls",
  -- "texlab",
  -- "helm_ls",
})
vim.diagnostic.config({ virtual_text = true })

