---@type vim.lsp.Config
return {
    cmd = { 'haskell-language-server-wrapper', '--lsp' },
    filetypes = { 'haskell', 'lhaskell' },
    root_markers = {
        'hie.yaml',
        'stack.yaml',
        'cabal.project',
        '*.cabal',
        'package.yaml',
        '.git',
    },
    settings = {
        haskell = {
            formattingProvider = 'ormolu',
            checkProject = true,
            plugin = {
                hlint = { globalOn = true },
                eval = { globalOn = true },
                ['ghcide-completions'] = { globalOn = true },
                ['ghcide-hover-and-symbols'] = { globalOn = true },
                ['ghcide-type-lenses'] = { globalOn = true },
                ['ghcide-code-actions-type-signatures'] = { globalOn = true },
            },
        },
    },
}
