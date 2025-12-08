
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

# docker compose alias
function docker
    # 引数があり、かつ最初の引数が "compose" の場合
    if test (count $argv) -gt 0; and test "$argv[1]" = "compose"
        # "docker-compose" コマンドを実行（残りの引数を渡す）
        command docker-compose $argv[2..-1]
    else
        # それ以外は通常の "docker" コマンドを実行
        command docker $argv
    end
end

# git alias
abbr -a g git
abbr -a gs git status
abbr -a ga git add .
abbr -a gc git commit -v
abbr -a gcm git commit -m 
abbr -a gp git push
abbr -a gl git pull

abbr -a gb git branch
abbr -a gco git checkout
abbr -a gcb git checkout -b

abbr -a gd git diff
abbr -a glog "git log --oneline --graph --decorate"

abbr -a gca git commit --amend
abbr -a gsta git stash
abbr -a gstp git stash pop
