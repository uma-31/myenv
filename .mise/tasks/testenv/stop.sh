#!/usr/bin/env bash
#MISE description="テスト環境を停止します。"

set -euo pipefail

cd "${MYENV_TEST__ROOT}"

docker compose stop
