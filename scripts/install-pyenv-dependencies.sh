#!/usr/bin/env bash

# see: https://github.com/pyenv/pyenv/wiki#suggested-build-environment

_check_command_exists() {
    if ! command -v $1 &> /dev/null; then
        echo "Error: $1 is not installed"
        exit 1
    fi
}

_install_to_mac() {
    brew install openssl readline sqlite3 xz zlib tcl-tk
}

_install_to_ubuntu() {
    sudo apt-get -y update
    sudo apt-get -y install build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev curl \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
}

if [[ `uname` == 'Darwin' ]]; then
    _install_to_mac
elif [[ `uname` == 'Linux' ]]; then
    _install_to_ubuntu
else
    echo "Unsupported OS"
    exit 1
fi
