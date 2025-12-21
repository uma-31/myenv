#!/usr/bin/env bash
#MISE description="テスト環境を立ち上げます。"

set -euo pipefail

cd "${MYENV_TEST__ROOT}"

docker compose up --build -d --wait
