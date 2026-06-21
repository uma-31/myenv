#!/usr/bin/env bash
set -eu

dir="$HOME/.cache/helix-custom-actions"
mkdir -p "$dir"

docker run --rm \
  -u "$(id -u):$(id -g)" \
  -v "$dir:/data" \
  -i minlag/mermaid-cli \
  -i - \
  -o chart.png 2>/dev/null

wezterm cli spawn --new-window -- \
  zsh -lc "cd ~; wezterm imgcat '$dir/chart.png'; echo; echo 'Press any key to close...'; read -k1"
