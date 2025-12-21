#!/usr/bin/env bash
#MISE description="テスト環境で chezmoi apply を実行します。"

set -euo pipefail

cd "${MYENV_TEST__ROOT}"

docker compose exec ubuntu chezmoi apply
