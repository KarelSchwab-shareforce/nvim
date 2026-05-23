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

require('nvim-treesitter').setup({
    local_parsers = {
        xonsh = {
            source = {
                type = 'self_contained',
                url = 'https://github.com/FoamScience/tree-sitter-xonsh',
                semver = false,
                queries_path = 'queries',
            },
            filetypes = { 'xonsh' },
        },
    },
})

vim.api.nvim_create_user_command('TSInstallXonsh', function()
    local cache_mod = require('nvim-treesitter.cache')
    local cache = cache_mod.load()
    cache.parsers = cache.parsers or {}
    cache.parsers.xonsh = {
        latest_parser = 'main',
        latest_queries = 'main',
        checked_at = os.time(),
    }
    cache_mod.save(cache)
    require('nvim-treesitter.install').install('xonsh', { force = true })
end, { desc = 'Install xonsh tree-sitter parser (workaround for local_parsers bug)' })
