# Scoop
## Scoop 自体のインストール
if (Get-Command "scoop" -ErrorAction SilentlyContinue) {
    Write-Output "Scoop is already installed."
}
else {
    Write-Output "Installing Scoop..."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

    $env:Path = $env:USERPROFILE + "\scoop\shims;" + $env:Path
}

## パッケージ・バケットのインストール
scoop install chezmoi
scoop install git
scoop install neovim

scoop bucket add extras
scoop install extras/vscode
scoop install extras/wezterm

# SSH
$ssh_dir = "$env:USERPROFILE\.ssh"
$ssh_conf_dir = "$ssh_dir\config.d"
$github_id_path = "$ssh_dir\id_ed25519_github"

if (Test-Path -Path $ssh_dir) {
    Write-Output "'$ssh_dir' already exists."
}
else {
    Write-Output "Creating '$ssh_dir'..."
    New-Item -ItemType Directory -Path $ssh_dir
}

if (Test-Path -Path $ssh_conf_dir) {
    Write-Output "'$ssh_conf_dir' already exists."
}
else {
    Write-Output "Creating '$ssh_conf_dir'..."
    New-Item -ItemType Directory -Path $ssh_conf_dir
}

if (Test-Path -Path $github_id_path) {
    Write-Output "GitHub SSH key already exists."
}
else {
    Write-Output "Generating GitHub SSH key..."
    ssh-keygen -t ed25519 -f $github_id_path
}
