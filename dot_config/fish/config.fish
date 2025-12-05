set -x PATH /opt/homebrew/bin $PATH


# fish

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

# docker compose
if status is-interactive
    # 基本のエイリアス
    abbr -a dc 'docker compose'

    # よく使うサブコマンドのエイリアス
    abbr -a dcu 'docker compose up -d'
    abbr -a dcd 'docker compose down'
    abbr -a dcl 'docker compose logs -f'
    abbr -a dcex 'docker compose exec'
end
