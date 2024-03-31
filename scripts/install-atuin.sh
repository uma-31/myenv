#!/usr/bin/env bash


SCRIPT_URL="https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh"

if command -v atuin &> /dev/null; then
    echo "Skip: atuin is already installed"
    exit 0
fi

bash <(curl $SCRIPT_URL | sed 's/^.*eval "$(atuin init zsh)".*$/printf "Skipped zshrc change"/g')
