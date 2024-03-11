#!/usr/bin/env bash

if [ -f ~/.vim/colors/solarized.vim ]; then
    echo "Skip: solarized.vim is already installed"
    exit 0
fi

curl -fLo ~/.vim/colors/solarized.vim --create-dirs \
    https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim
