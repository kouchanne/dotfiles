#!/bin/bash

set -u

BASEDIR=$(dirname $0)
cd $BASEDIR

echo "start dotfiles link..."
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    [ "$f" = ".gitmodules" ] && continue
    [ "$f" = ".DS_Store" ] && continue

    ln -snfv ~/dotfiles/"$f" ~/
    echo "$f linked"
done
echo "end dotfiles link"


cat << END

**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************

END