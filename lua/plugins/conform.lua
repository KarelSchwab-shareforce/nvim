local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofmt" },
        python = { "black", "ruff_format", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
    },
    formatters = {
        black = { prepend_args = { "--line-length", "120" } },
    },
})

vim.keymap.set("n", "<leader>e", function() require("conform").format({ async = true, lsp_fallback = true }) end)

