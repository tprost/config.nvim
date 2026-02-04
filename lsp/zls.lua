---@type vim.lsp.Config
return {
    cmd = { 'zls' },
    filetypes = { 'zig', 'zir' },
    root_markers = {
        'build.zig',
        'build.zig.zon',
        'zls.json',
        '.git',
    },
    settings = {
        zls = {
            enable_snippets = true,
            enable_argument_placeholders = true,
            enable_ast_check_diagnostics = true,
            enable_build_on_save = false,
            enable_autofix = true,
            enable_inlay_hints = true,
            inlay_hints_hide_redundant_param_names = true,
            inlay_hints_hide_redundant_param_names_last_token = true,
            warn_style = true,
            highlight_global_var_declarations = true,
        },
    },
}
