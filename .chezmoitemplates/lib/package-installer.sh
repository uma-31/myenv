#shellcheck shell=bash

set -euo pipefail

add_apt_ppa_repository() {
    local ppa="$1"

    myenv_log_info "PPA を追加します: $ppa"
    sudo add-apt-repository -y "$ppa"
}

install_apt_packages() {
    myenv_log_info "apt のパッケージリストを更新します"
    sudo apt update
    myenv_log_info "apt のパッケージをインストールします: $*"
    sudo apt install -y "$@"
}

install_brew_packages() {
    myenv_log_info "Homebrew のパッケージをインストールします: $*"
    brew install "$@"
}

install_brew_cask_packages() {
    myenv_log_info "Homebrew Cask のパッケージをインストールします: $*"
    brew install --cask "$@"
}
