#!/usr/bin/env bash

if command -v z &> /dev/null; then
  echo "Skip: zoxide is already installed"
  exit 0
fi

if [[ `uname` == 'Darwin' ]]; then
    brew install zoxide
elif [[ `uname` == 'Linux' ]]; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
else
    echo "Unsupported OS"
    exit 1
fi
