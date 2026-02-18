# t0k0sh1's dotfiles

## セットアップ

新しいマシンでは以下の1コマンドを実行：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/t0k0sh1/dotfiles/main/install.sh)"
```

または、リポジトリをクローン済みの場合：

```bash
./install.sh
```

### install.sh の処理内容

1. Homebrew が未インストールの場合はインストール
2. chezmoi をインストールして dotfiles を適用
3. nvim 設定を `~/.config/nvim` にクローン

## 手動セットアップ

chezmoi がインストール済みの場合：

```bash
chezmoi init --apply t0k0sh1
```

## 管理ツール

- **chezmoi** - dotfiles の管理・適用
- **Brewfile** - Homebrew パッケージの管理（`brew bundle` で一括インストール）

## dotfiles の更新

```bash
# ファイルを編集後、適用
chezmoi apply

# 差分を確認
chezmoi diff

# ドライランで確認
chezmoi apply --dry-run
```

## 関連リポジトリ

- [nvim config](https://github.com/t0k0sh1/nvim) - Neovim 設定（独立したリポジトリ）
