#!/usr/bin/env bash

if command -v atuin &> /dev/null; then
    echo "Skip: atuin is already installed"
    exit 0
fi

bash <(curl https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh)
