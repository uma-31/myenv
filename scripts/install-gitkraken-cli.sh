#!/usr/bin/env bash

_check_command_exists() {
    if ! command -v $1 &> /dev/null; then
        echo "Error: $1 is not installed"
        exit 1
    fi

}

_install_to_mac() {
    brew install gitkraken-cli
}

_install_to_ubuntu() {
    _check_command_exists "curl"
    _check_command_exists "jq"
    _check_command_exists "wget"

    local latest_release=$(curl -s https://api.github.com/repos/gitkraken/gk-cli/releases/latest)
    local url=$(echo $latest_release | jq -r ".assets[] | select(.name | contains(\"Linux_$(arch).deb\")) | .browser_download_url")

    local tmp_dir="/tmp/myenv"

    mkdir -p $tmp_dir
    wget -qO $tmp_dir/gk.deb $url

    sudo apt-get install /tmp/myenv/gk.deb
}

if command -v gk &> /dev/null; then
    echo "Skip: gitkraken-cli is already installed"
    exit 0
fi

if [[ `uname` == 'Darwin' ]]; then
    brew install gitkraken-cli
elif [[ `uname` == 'Linux' ]]; then
    _install_to_ubuntu
else
    echo "Unsupported OS"
    exit 1
fi
