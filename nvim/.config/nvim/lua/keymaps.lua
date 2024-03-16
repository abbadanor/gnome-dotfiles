-- [[ basic Keymaps ]]

-- keymaps for better default experience
-- see `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- TODO: specific prose mode, that enables when norg, md or txt file is opened, and with toggle keybind

-- diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- see `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- end of Kickstart 

-- netrw
vim.keymap.set('n', '<leader>.', vim.cmd.Ex, { desc = '[.] Open netrw' })

local function bDeleteOther()
  vim.cmd [[ %bd|e#|bd# ]]
end

-- buffer management
vim.keymap.set('n', '<leader>bp', vim.cmd.bprevious, { desc = '[P]revious buffer' })
vim.keymap.set('n', '<leader>bn', vim.cmd.bnext, { desc = '[N]ext buffer' })
vim.keymap.set('n', '<leader>bk', vim.cmd.bdelete, { desc = '[D]elete buffer' })
vim.keymap.set('n', '<leader><tab>x', bDeleteOther, { desc = '[D]elete buffer' })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- [[ nice-to-haves ]]

-- allow Ctrl-Backspace
vim.keymap.set('i', '<C-H>', '<C-W>')

-- move visual lines with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- shift to start of line after J
vim.keymap.set("n", "J", "mzJ`z")

-- keep centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- disable Q
vim.keymap.set("n", "Q", "<nop>")

-- source lua file
vim.keymap.set('n', '<leader>s', vim.cmd.so, { desc = 'Source Lua file' })

-- [[ clipboard ]]
-- manipulate system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { silent = true, desc = 'which_key_ignore' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { silent = true, desc = 'which_key_ignore' })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = 'which_key_ignore' })
vim.keymap.set("x", "<leader>p", [["_dP]])

-- vim: ts=2 sts=2 sw=2 et
