#!/bin/sh

# Config är från chris@machine (https://www.youtube.com/watch?v=bTLYiNvRIVI)

setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef  # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

# Ensure history file exists
if [[ ! -f $HISTFILE ]]; then
	[ -d $(dirname $HISTFILE) ] || mkdir -p $(dirname $HISTFILE)
	touch $HISTFILE
	echo "ZSH: Created history file in $(dirname $HISTFILE)"
fi

# Gör så att zsh-autopair funkar tillsammans med zsh-vi-mode
ZVM_INIT_MODE=sourcing

# Plugins
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "jeffreytse/zsh-vi-mode"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "joshskidmore/zsh-fzf-history-search"
zsh_add_plugin "lukechilds/zsh-nvm"

[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh


# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions
bindkey -s '^o' 'ranger^M'
# "cd -" går till föregående directory. användbart efter fzf. 
bindkey -M viins -s '^b' 'cd -^M' # https://unix.stackexchange.com/a/373796
bindkey -M viins '^H' backward-kill-word 
bindkey -M viins '^[[1;5C' forward-word
bindkey -M viins '^[[1;5D' backward-word

# <Alt-d> to navigate to directory
bindkey -M emacs '^[d' fzf-cd-widget
bindkey -M vicmd '^[d' fzf-cd-widget
bindkey -M viins '^[d' fzf-cd-widget

# <Alt-f> to autocomplete file
bindkey -M emacs '^[f' fzf-file-widget
bindkey -M vicmd '^[f' fzf-file-widget
bindkey -M viins '^[f' fzf-file-widget

# Unbind old keybinds
bindkey -r '^[c'
bindkey -r '^T'

compinit
