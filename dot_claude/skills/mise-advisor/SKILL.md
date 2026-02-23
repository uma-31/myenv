---
name: mise-advisor
description: "Mise configuration advisor for dev environment setup, tool management, task definitions, and environment variables. Use when setting up dev environments, configuring tools, or creating tasks with Mise."
argument-hint: "[what you want to achieve]"
allowed-tools: WebFetch(domain:mise.jdx.dev)
---

# Mise アドバイザー

Mise による開発環境のセットアップやツール管理、タスク定義、環境変数の設定に関するアドバイスを提供するスキル。

$ARGUMENTS

## 設定ファイル

Mise では設定ファイルの配置場所が複数存在し、優先順位に従って適切にマージされる。

主な配置場所は以下の通り：

- `mise.toml`（`.mise.toml`）
- `mise/config.toml`（`.mise/config.toml`）

既に `.config` ディレクトリが存在する場合、`.config` 配下にも有効な配置場所がある。
また、対象環境（`development`、`production` など）ごとに設定を分けることも可能。
アドバイスを提供する際には、必要に応じて下記のドキュメントを参照すること。

- [mise.toml](https://mise.jdx.dev/configuration.html)
  - 有効な設定ファイルのパスや優先順位、環境変数等に関するドキュメント
- [Settings](https://mise.jdx.dev/configuration/settings.html)
  - 全ての設定項目に関するドキュメント
- [Configuration Environments](https://mise.jdx.dev/configuration/environments.html)
  - 環境ごとの設定に関するドキュメント

## 主要機能

Mise の設定ファイルは `[tools]`、`[env]`、`[tasks]` の 3 つのセクションで構成される。
タスクは設定ファイル内のインライン定義と、`.mise/tasks/` 配下のスクリプトファイルの 2 通りで実装できる。

アドバイスを提供する際には、必要に応じて下記のドキュメントを参照すること。

- [Dev Tools](https://mise.jdx.dev/dev-tools/)
  - `[tools]` によるツールのバージョン管理に関するドキュメント
- [Environments](https://mise.jdx.dev/environments.html)
  - `[env]` による環境変数・`.env` 読み込み・PATH 操作に関するドキュメント
- [TOML Tasks](https://mise.jdx.dev/tasks/toml-tasks.html)
  - 設定ファイル内のインラインタスク定義に関するドキュメント
- [File Tasks](https://mise.jdx.dev/tasks/file-tasks.html)
  - `.mise/tasks/` へのスクリプト実装に関するドキュメント
- [Running Tasks](https://mise.jdx.dev/tasks/running-tasks.html)
  - `mise run` によるタスク実行・引数・並列実行に関するドキュメント

## 推奨事項

既存の Mise 設定ファイルがプロジェクトに存在しない場合、設定ファイルやファイルタスクが同じディレクトリに集約されるようにするため、`.mise/config.toml` を優先して使用するよう提案すること。

## アドバイスのポイント

ユーザーのタスク定義を見て、より良い書き方があれば提案すること。

- `cd subdir && cmd` パターンには `dir` オプションを提案する
- `&&` 連結には `run = [...]` 配列を提案する
- 環境変数のベタ書きにはタスクレベルの `env = { KEY = "value" }` を提案する
- `.env` の手動読み込みには `[env]` セクションの `_.file = ".env"` を提案する
- `node_modules/.bin` などのフルパス指定には `_.path` による PATH 追加を提案する
- 毎回フルビルドしている場合は `sources`/`outputs` による増分ビルドを提案する
- タスクのロジックが複雑な場合は `.mise/tasks/` スクリプトへの切り出しを提案する
