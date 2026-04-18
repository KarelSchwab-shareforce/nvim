local capabilities = require('blink.cmp').get_lsp_capabilities()
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "basedpyright" },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
            })
        end,
    },
})

