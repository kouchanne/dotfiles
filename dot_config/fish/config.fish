fish_config theme choose "ayu Dark"

# PATH
set -x PATH /opt/homebrew/bin $PATH

# fzf
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_COMPLETE 3
set -U GO_TASK_PROGNAME task
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'

# Go
set -gx PATH $HOME/go/bin $PATH

# Node.js
set -gx VOLTA_HOME $HOME/.volta
set -p PATH $VOLTA_HOME/bin

# eza (modern replacement of "ls")
if command -q eza
    abbr -a ls eza --icons
    abbr -a ll eza --icons -lhag --time-style long-iso
    abbr -a lt eza --icons --tree
end
