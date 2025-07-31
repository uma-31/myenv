#!/usr/bin/env bash

if command -v mise &> /dev/null; then
  echo "Skip: mise is already installed"
  exit 0
fi

UNAME="$(uname)"

if [[ "${UNAME}" == 'Darwin' ]]; then
    brew install mise
elif [[ "${UNAME}" == 'Linux' ]]; then
    sudo apt update -y && sudo apt install -y gpg sudo wget curl
    sudo install -dm 755 /etc/apt/keyrings
    wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
    sudo apt update
    sudo apt install -y mise
else
    echo "Unsupported OS"
    exit 1
fi

cat >~/.zsh/rc/mise.zsh <<'EOS'
eval "$(mise activate zsh)"
eval "$(mise activate zsh --shims)"
EOS
