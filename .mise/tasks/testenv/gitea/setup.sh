#!/usr/bin/env bash
#MISE description="テスト用の Gitea をセットアップします。"

set -euo pipefail

REMOTE_NAME="local-gitea"

cd "${MYENV_TEST__ROOT}"

_gitea() {
    docker compose exec --user git gitea gitea "$@"
}

# ユーザー作成
set +e
output=$(_gitea admin user create \
    --username "${MYENV_TEST__GITEA_USER}" \
    --password "${MYENV_TEST__GITEA_PASS}" \
    --email "${MYENV_TEST__GITEA_USER}@localhost" \
    --admin \
    --must-change-password=false 2>&1)
status=$?
set -e

if [ $status -ne 0 ] && ! echo "$output" | grep -q "already exists"; then
    echo "$output" >&2
    exit 1
fi

# リモートの追加とリポジトリ作成
if ! git remote get-url "${REMOTE_NAME}" &>/dev/null; then
    git remote add "${REMOTE_NAME}" \
        "http://${MYENV_TEST__GITEA_USER}:${MYENV_TEST__GITEA_PASS}@localhost:${MYENV_TEST__GITEA_PORT}/${MYENV_TEST__GITEA_USER}/${MYENV_TEST__REPO_NAME}.git"
fi

git push "${REMOTE_NAME}" main

echo
echo "テスト用の Gitea をセットアップしました！"
echo
echo "Web UI: http://localhost:${MYENV_TEST__GITEA_PORT}/"
echo "User:   ${MYENV_TEST__GITEA_USER}"
echo "Pass:   ${MYENV_TEST__GITEA_PASS}"
echo
