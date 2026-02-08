# myenv

[chezmoi](https://www.chezmoi.io/) による開発環境のセットアップ・更新自動化のためのリポジトリ。

## 前提条件

### Mac / Linux

- `git` コマンドが使用可能であること

### Windows

特になし

## 使い方

### セットアップ

#### MacOS / Linux

```bash
cd ~

# インストールして初期化
sh -c "$(curl -fsLS get.chezmoi.io)" -- init https://github.com/uma-31/myenv.git
# ./bin にインストールされるので、パスが通っている場所へ移動する
sudo mv ./bin/chezmoi /usr/local/bin
# 反映
chezmoi apply
```

#### Windows

```PowerShell
cd ~

# インストールして初期化
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -- init https://github.com/uma-31/myenv.git"
# 一時的にパスを通す
$env:Path = $env:USERPROFILE + "\bin;" + $env:Path
# 一時的に実行ポリシーを変更
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
# 反映
chezmoi apply
```
