#!/usr/bin/env bash
#MISE description="テスト環境をリセットします。"

set -euo pipefail

cd "${MYENV_TEST__ROOT}"

docker compose down -v
