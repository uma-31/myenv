#!/usr/bin/env bash

if command -v lazydocker &> /dev/null; then
  echo "Skip: lazydocker is already installed"
  exit 0
fi

if [[ `uname` == 'Darwin' ]]; then
    brew install lazydocker
elif [[ `uname` == 'Linux' ]]; then
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
else
    echo "Unsupported OS"
    exit 1
fi
