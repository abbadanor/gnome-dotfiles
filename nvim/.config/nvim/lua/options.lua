-- [[ Setting options ]]
-- See `:help vim.o`


-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- enable scrolloff
vim.o.scrolloff = 8

vim.o.wrap = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true
vim.o.linebreak = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.o.conceallevel = 2 -- TODO: for neorg, maybe adjust?
vim.o.foldlevelstart = 99

vim.keymap.set('n', '<leader>w', ':set wrap!<CR>', { desc = 'Toggle Word [W]rap'})


-- vim: ts=2 sts=2 sw=2 et
