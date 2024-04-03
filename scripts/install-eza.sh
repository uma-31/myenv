#!/usr/bin/env bash
_check_command_exists() {
    if ! command -v $1 &> /dev/null; then
        echo "Error: $1 is not installed"
        exit 1
    fi

}

_install_to_mac() {
    brew install eza
}

_install_to_ubuntu() {
    _check_command_exists "gpg"
    _check_command_exists "wget"

   sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt-get update
    sudo apt-get install -y eza
}

if command -v eza &> /dev/null; then
    echo "Skip: eza is already installed"
    exit 0
fi

if [[ `uname` == 'Darwin' ]]; then
    _install_to_mac
elif [[ `uname` == 'Linux' ]]; then
    _install_to_ubuntu
else
    echo "Unsupported OS"
    exit 1
fi
