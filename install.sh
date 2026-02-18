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

# nvim 設定を別途クローン
if [[ ! -d "$HOME/.config/nvim" ]]; then
  git clone git@github.com:t0k0sh1/nvim.git "$HOME/.config/nvim"
fi

echo "Setup complete!"
