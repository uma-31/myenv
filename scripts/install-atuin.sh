#!/usr/bin/bash

if command -v atuin &>/dev/null; then
    echo "Skip: atuin is already installed"
    exit 0
fi

bash <(
    curl --proto '=https' --tlsv1.2 -LsSf https://github.com/atuinsh/atuin/releases/latest/download/atuin-installer.sh |
        sed 's/^.*echo.*>>.*$/echo "Skipping file write operation."/g'
)

cat >"${HOME}/.zsh/rc/atuin.zplug" <<'EOF'
source "${HOME}/.atuin/bin/env"

eval "$(atuin init zsh)"

EOF
