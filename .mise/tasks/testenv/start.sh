#!/usr/bin/env bash
#MISE description="テスト環境をリセットして立ち上げ、chezmoi も初期化します。"

set -euo pipefail

mise run testenv:reset
mise run testenv:up
mise run testenv:gitea:setup
mise run testenv:init
mise run testenv:apply
