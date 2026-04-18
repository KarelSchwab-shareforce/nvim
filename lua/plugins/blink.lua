require('blink.cmp').setup({
    fuzzy = { implementation = "lua" },
    keymap = { preset = "enter" },
    cmdline = {
        completion = {
            menu = {
                auto_show = true
            }
        }
    },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = { enabled = true }
})
