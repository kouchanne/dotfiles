set -x PATH /opt/homebrew/bin $PATH


# fish

# fzf
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_COMPLETE 0
set -U FZF_COMPLETE 1
set -U FZF_COMPLETE 2
set -U FZF_COMPLETE 3

# Go
set -gx PATH $HOME/go/bin $PATH

# Node.js
set -gx VOLTA_HOME $HOME/.volta
set -p PATH $VOLTA_HOME/bin
