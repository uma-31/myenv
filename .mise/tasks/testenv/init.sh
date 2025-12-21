#!/usr/bin/env bash
#MISE description="テスト環境で chezmoi init を実行します。"

set -euo pipefail

cd "${MYENV_TEST__ROOT}"

docker compose exec ubuntu \
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin init "http://gitea:${MYENV_TEST__GITEA_PORT}/${MYENV_TEST__GITEA_USER}/${MYENV_TEST__REPO_NAME}.git"
