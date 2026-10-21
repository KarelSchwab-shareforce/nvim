vim.filetype.add({
    extension = { xsh = 'xonsh', xonshrc = 'xonsh' },
    filename  = { ['.xonshrc'] = 'xonsh', ['xonshrc'] = 'xonsh' },
})

vim.lsp.config('xonsh_lsp', {
    cmd = { 'uvx', '-n', 'xonsh-lsp' },
    filetypes = { 'xonsh' },
    root_markers = { '.xonshrc', 'xonshrc', '.git' },
    init_options = {
        pythonBackend = 'pyright',
    },
    settings = {
        python = {
            pythonPath = vim.fn.exepath('python3'),
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
})

vim.lsp.enable('xonsh_lsp')
