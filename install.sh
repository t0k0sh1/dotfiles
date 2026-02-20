#!/usr/bin/env bash
# 新規マシンセットアップ用
set -euo pipefail

# Homebrew が未インストールの場合はインストール
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# chezmoi をインストールして dotfiles を適用
brew install chezmoi
chezmoi init --apply t0k0sh1

echo "Setup complete!"
