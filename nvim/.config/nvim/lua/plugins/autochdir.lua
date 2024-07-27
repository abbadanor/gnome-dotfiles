require('autochdir').setup {
    -- Useful for not accidentally jumping to other projects and staying in the first project found
    keep_dir = false,

    -- Define generic flags for all files
    generic_flags = {'README.md', '.git'},
}
