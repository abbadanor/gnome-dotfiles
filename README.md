# My dotfiles

## Todo
- Compare ~ with dotfiles root (check for files to delete after editing dotfiles)
- Select cmp with C-<return>

go into all non-hidden dirs

-> nvim

path = ~/.dotfiles/nvim
loop
    if directory contains files
    or
    if directory empty
    or
    if directory contains multiple dirs
    then
        print dirname: nvim // this should be colored
        // this should be indented
        save path as dotfiles_path: ~/.dotfiles/nvim/.config/nvim
        replace ~/.dotfiles with ~
        target_path = ~/nvim/.config/nvim
        diff -rq target_path dotfiles_path
        break
    else if directory contains one dir
    then
        path = ~/.dotfiles/nvim/.config
    else
        unreachable, panic
