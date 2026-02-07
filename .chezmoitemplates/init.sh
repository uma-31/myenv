#shellcheck shell=bash

set -euo pipefail

__remove_bootstrap_chezmoi() {
    if mise which chezmoi &>/dev/null; then
        return 0
    fi

    local chezmoi_bin
    chezmoi_bin="$(command -v chezmoi 2>/dev/null || true)"

    if [ -z "$chezmoi_bin" ]; then
        return 0
    fi

    myenv_log_info "ブートストラップ版の chezmoi を削除します: $chezmoi_bin"
    sudo rm -f "$chezmoi_bin"
}

__install_mise_tools() {
    myenv_log_info "mise によるツールのインストールを行います"
    mise install
}

__setup_zsh_as_login_shell() {
    local zsh_path
    zsh_path="$(command -v zsh)"

    if [ "$SHELL" = "$zsh_path" ]; then
        return 0
    fi

    myenv_log_info "デフォルトシェルを zsh に変更します (パスワードが必要です)"
    chsh -s "$zsh_path"
}

__setup_ssh_config() {
    local ssh_conf_dir="$HOME/.ssh/conf.d"

    myenv_log_info "SSH 設定用のディレクトリを作成します: $ssh_conf_dir"
    mkdir -p ~/.ssh/conf.d

    myenv_log_info "GitHub 用の SSH 設定を生成します。"
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_github
}

myenv_init() {
    myenv_log_info "初期セットアップを開始します"

    __remove_bootstrap_chezmoi
    __install_mise_tools
    __setup_zsh_as_login_shell
    __setup_ssh_config
    myenv_log_info "セットアップが完了しました！${LF}シェルを再起動してください。"
}
