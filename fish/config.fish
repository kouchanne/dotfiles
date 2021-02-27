export LSCOLORS=gxfxcxdxbxegedabagacad

## M1 MAC cannot be installed traditional file path
set PATH /opt/homebrew/bin $PATH

set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)