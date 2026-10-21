------------------ Options ------------------
require("vim._core.ui2").enable({})

vim.g.mapleader = " "
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.errorbells = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "120"
vim.opt.mouse = "a"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.tags = { "./.tags;" }
vim.opt.splitbelow = true
vim.opt.splitright = true
------------------ Options ------------------

------------------ Keymaps ------------------
local opts = { noremap = true, silent = true }

-- Exit insert mode
vim.keymap.set("i", "jk", "<Esc>", opts)
vim.keymap.set("t", "jk", "<C-\\><C-n>", opts)

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y', opts)
vim.keymap.set("n", "<leader>Y", '"+yg_', opts)
vim.keymap.set("n", "<leader>y", '"+y', opts)
vim.keymap.set("n", "<leader>yy", '"+yy', opts)

-- Paste from clipboard
vim.keymap.set("n", "<leader>p", '"+p', opts)
vim.keymap.set("n", "<leader>P", '"+P', opts)
vim.keymap.set("v", "<leader>p", '"+p', opts)
vim.keymap.set("v", "<leader>P", '"+P', opts)

-- Navigating quickfix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>", opts)
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>", opts)

-- Navigating tabs
vim.keymap.set("n", "<C-l>", "<cmd>tabnext<CR>", opts)
vim.keymap.set("n", "<C-h>", "<cmd>tabprevious<CR>", opts)
vim.keymap.set("n", "<C-A-h>", "<cmd>tabmove -<CR>", opts)
vim.keymap.set("n", "<C-A-l>", "<cmd>tabmove +<CR>", opts)
------------------ Keymaps ------------------

------------------ Plugins ------------------
-- TODO: 'https://github.com/folke/lazydev.nvim',
vim.pack.add({ "https://github.com/navarasu/onedark.nvim" })
vim.pack.add({
    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.cmp'
})
vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })
vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

vim.pack.add({
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/williamboman/mason-lspconfig.nvim'
})
vim.pack.add({ 'https://github.com/tpope/vim-fugitive' })
vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } })

require("plugins.onedark")
require("plugins.blink")
require("plugins.conform")
require("plugins.snacks")
require("plugins.lsp")
require("plugins.xonsh")
------------------ Plugins ------------------

------------------ Auto Commands ------------------
-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

-- Fix underscore handling in LaTeX files
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.tex" },
    command = "syntax match texIgnoreUnderscore /_[^ ]*/ containedin=ALL ",
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].tagfunc = ""

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>]", function() vim.diagnostic.jump({ count = 1, float = true }) end,
            { buffer = ev.buf })
        vim.keymap.set("n", "<leader>[", function() vim.diagnostic.jump({ count = -1, float = true }) end,
            { buffer = ev.buf })

        local function smart_definition(cmd)
            vim.lsp.buf.definition({
                on_list = function(options)
                    local items = options.items or {}
                    if #items == 0 then
                        vim.notify("No definition found", vim.log.levels.WARN)
                        return
                    end
                    if #items > 1 then
                        Snacks.picker.lsp_definitions()
                        return
                    end

                    local item = items[1]
                    if cmd then
                        vim.cmd(cmd .. " " .. vim.fn.fnameescape(item.filename))
                    else
                        vim.cmd.edit(vim.fn.fnameescape(item.filename))
                    end

                    vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
                    vim.cmd("normal! zz")
                end,
            })
        end

        vim.keymap.set("n", "gt", function() smart_definition("tabnew") end,
            { buffer = ev.buf, desc = "Go to definition in new tab" })
        vim.keymap.set("n", "gv", function() smart_definition("vsplit") end,
            { buffer = ev.buf, desc = "Go to definition in vertical split" })
        vim.keymap.set("n", "gs", function() smart_definition("split") end,
            { buffer = ev.buf, desc = "Go to definition in split" })
    end,
})
------------------ Auto Commands ------------------
