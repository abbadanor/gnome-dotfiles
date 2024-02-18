export ZDOTDIR=$HOME/.config/zsh
export NVM_DIR="$HOME/.local/share/nvm"
export XDG_CONFIG_HOME=$HOME/.config
export HISTFILE=$HOME/.local/share/zsh/history
export HISTSIZE=1000000
export SAVEHIST=1000000
export PATH="$HOME/.local/bin:$HOME/.local/share/nvm/versions/node/v18.19.0/bin/:$HOME/go/bin:$PATH"
export PNPM_HOME="$HOME/.local/share/pnpm"
export MANWIDTH=999
export EDITOR="nvim"
export BROWSER="firefox"
export PAGER="bat --paging always"
export FZF_DEFAULT_COMMAND="fd --hidden . $HOME"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND # Go to file?
export FZF_ALT_C_COMMAND="fd -t d --hidden . $HOME" # cd into directory
export MOZ_ENABLE_WAYLAND=1