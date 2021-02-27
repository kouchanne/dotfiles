#!/bin/bash

function command_exists {
  command -v "$1" > /dev/null;
}


if ! command_exists brew ; then
    echo "Installing homebrew..."
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

if command_exists brew ; then
    echo "run homebrew doctor"
    brew doctor
    echo "run homebrew update"
    brew update
    echo "run bundle update"
    brew bundle --file=$(pwd)/.Brewfile

cat << END

**************************************************
HOMEBREW INSTALLED!
**************************************************

END