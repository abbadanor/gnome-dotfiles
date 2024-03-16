-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
--
--
-- Custom ripgrep configuration:

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

-- I want to follow symbolic links
table.insert(vimgrep_arguments, "-L")

require("telescope").setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<Esc>'] = require('telescope.actions').close,
      },
    },
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "-L" },
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

local function live_grep_notes()
    require('telescope.builtin').live_grep {
      search_dirs = { '~/notes/home/' },
    }
end

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = 'Find [r]ecently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

local function telescope_find_config_files()
  require('telescope.builtin').find_files {
    search_dirs = {"~/.config/nvim"},
    follow = true
  }
end

local function telescope_find_home_notes()
  require('telescope.builtin').find_files {
    search_dirs = {"~/notes/home"},
  }
end

local function telescope_find_work_notes()
  require('telescope.builtin').find_files {
    search_dirs = {"~/notes/work"},
  }
end

vim.keymap.set('n', '<leader>,', require('telescope.builtin').buffers, { desc = '[,] Buffers' })
vim.keymap.set('n', '<leader>f/', telescope_live_grep_open_files, { desc = '[/] Live Grep open files' })
vim.keymap.set('n', '<leader>ft', require('telescope.builtin').builtin, { desc = '[F]ind [T]elescope picker' })
vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').git_files, { desc = '[ ] Find in project' })
vim.keymap.set('n', '<leader>ff', require("telescope.builtin").find_files, { desc = '[F]ind in cwd' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fg', require("telescope.builtin").live_grep, { desc = '[F]earch with [G]rep' })
vim.keymap.set('n', '<leader>fG', live_grep_git_root, { desc = '[F]ind with [G]rep on Git Root' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>fc', telescope_find_config_files, { desc = '[F]ind [C]onfig files' })
vim.keymap.set('n', '<leader>fn', telescope_find_home_notes, { desc = '[F]ind home [N]otes' })
vim.keymap.set('n', '<leader>fN', live_grep_notes, { desc = 'Live grep [N]otes' })
vim.keymap.set('n', '<leader>fw', telescope_find_work_notes, { desc = '[F]ind [W]ork notes' })

-- vim: ts=2 sts=2 sw=2 et
