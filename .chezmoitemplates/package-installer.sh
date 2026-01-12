#shellcheck shell=bash

set -euo pipefail

add_apt_third_party_repository() {
    local name="$1"
    local repository="$2"
    local components="$3"
    local gpg_key_url="$4"
    local gpg_key_dest="$5"
    local use_arch="$6"

    local list_file="/etc/apt/sources.list.d/${name}.list"

    if [ -f "$list_file" ] && [ -f "$gpg_key_dest" ]; then
        return 0
    fi

    myenv_log_info "apt リポジトリを追加します: $name"

    myenv_log_info "GPG 鍵を取得します: $gpg_key_url"
    sudo mkdir -p "$(dirname "$gpg_key_dest")"
    curl -fsSL "$gpg_key_url" |\
        sudo tee "$gpg_key_dest" >/dev/null

    local signed_by_option="signed-by=${gpg_key_dest}"
    local arch_option=""
    if [ "$use_arch" = "yes" ]; then
        arch_option=" arch=$(dpkg --print-architecture)"
    fi

    myenv_log_info "apt のソースリストにリポジトリを追加します: $list_file"
    echo "deb [${signed_by_option}${arch_option}] $repository $components" |\
        sudo tee "$list_file" >/dev/null
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
