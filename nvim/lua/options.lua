vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.incsearch = true
vim.o.hlsearch = false

vim.o.signcolumn = 'yes'
vim.o.scrolloff = 8

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = 'a'
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false

-- for undotree
vim.o.undodir = os.getenv('HOME') .. '/.local/share/nvim/undodir'
vim.o.undofile = true

vim.keymap.set('i', '<C-H>', '<C-W>')
vim.keymap.set('n', '<leader>.', vim.cmd.Ex)
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', 'Y', "yg$")
vim.keymap.set('n', 'J', "mzJ`z")
vim.keymap.set('n', '<C-u>', "<C-u>zz")
vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")
vim.keymap.set('x', '<leader>p', "\"_dP")
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+Y")
vim.keymap.set('n', '<leader>d', "\"_d")
vim.keymap.set('v', '<leader>y', "\"_d")
vim.keymap.set('v', 'Q', "<nop>")

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
    end,
})
