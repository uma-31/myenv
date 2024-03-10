#!/usr/bin/env bash

if [ -f ~/.vim/autoload/plug.vim ]; then
    echo "Skip: vim-plug is already installed"
    exit 0
fi

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
