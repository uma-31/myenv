#!/usr/bin/bash

if command -v atuin &>/dev/null; then
    echo "Skip: atuin is already installed"
    exit 0
fi

bash <(
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh |
        sed 's/^.*eval "$(atuin init zsh)".*$/printf "Skipped zshrc change"/g'
)
