require('snacks').setup({
    indent = { enabled = true },
    words = { enabled = true },
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    scroll = { enabled = false },
    scope = { enabled = true },
    input = { enabled = true },
    picker = {
        enabled = true,
        sources = {
            explorer = {
                layout = { layout = { position = "left" } },
            },
        },
    },
    zen = { enabled = false },
    terminal = { enabled = false },
})

vim.keymap.set("n", "<leader>ff", function() Snacks.picker.smart({ filter = { cwd = true }, cwd = vim.fn.getcwd() }) end,
    { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>ft", function() Snacks.picker.tags() end, { desc = "Search Tags" })
vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>fe", function() Snacks.explorer() end, { desc = "File Explorer" })

vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })

vim.keymap.set("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })

vim.keymap.set("n", "<leader>gq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
