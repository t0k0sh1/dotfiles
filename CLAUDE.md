# CLAUDE.md — Claude Code Project Configuration

このファイルは Claude Code がこのリポジトリで作業するときの設定です。

## プロジェクト概要

chezmoi 管理の個人 dotfiles（macOS 向け）。
`dot_` プレフィックスは chezmoi によって `.` に変換され、`$HOME` へ展開されます。

## ファイル命名規則（重要）

| chezmoi ソースファイル | 展開先（実際のパス） |
|----------------------|-------------------|
| `dot_zshrc` | `~/.zshrc` |
| `dot_aliases` | `~/.aliases` |
| `dot_zsh/functions/foo.sh` | `~/.zsh/functions/foo.sh` |
| `dot_gitconfig` | `~/.gitconfig` |
| `dot_config/nvim/` | `~/.config/nvim/` |

**編集・参照するときは常にリポジトリ内の `dot_` パスを使うこと。**
`~/.zshrc` などのホームディレクトリパスを直接編集しない。

## リポジトリ構造

```
dotfiles/
├── dot_zshrc                              # zsh 設定（PATH, 初期化, 関数ロード）
├── dot_aliases                            # エイリアス（カテゴリ別コメントで分類）
├── dot_zsh/
│   └── functions/                         # 自動ロードされる zsh 関数（1ファイル1関数）
├── dot_gitconfig                          # Git 設定
├── dot_tigrc                              # tig 設定
├── dot_editorconfig                       # EditorConfig
├── dot_config/nvim/                       # Neovim 設定（別リポジトリからクローン）
├── Brewfile                               # brew bundle 用パッケージリスト
├── install.sh                             # 新規マシン用セットアップスクリプト
└── run_onchange_install-packages.sh.tmpl  # Brewfile 変更時に chezmoi が自動実行
```

## コーディング規約

### zsh 関数（dot_zsh/functions/）

- **1ファイル1関数**。ファイル名 ≈ 関数名（例: `gsb.sh` → `gsb()` 関数）
  - 例外: `fcd.sh` は `cdf()` 関数を含む（ファイル名と関数名が不一致）
- **エラーハンドリング必須**: 依存コマンドの存在チェック、不正な引数の早期 return
- **stderr への出力**: エラーメッセージは `echo "..." >&2`
- fzf を使う場合はグローバル設定 (`FZF_DEFAULT_OPTS`) を継承した形で書く
- 関数が依存するツールは Brewfile に含まれているか確認すること

### エイリアス（dot_aliases）

- カテゴリ別に `# aliases for XXX` コメントで区切る
- マシン固有のエイリアスは `~/.aliases.local` へ（リポジトリに含めない）

### Brewfile

- カテゴリコメント（`# CLI utilities`, `# Development tools`, `# Git`）を維持する

## 注意事項

- Neovim 設定（`~/.config/nvim`）は[別リポジトリ](https://github.com/t0k0sh1/nvim)で管理されており、このリポジトリには含まれない
- `dot_zshrc` の末尾に `~/.zshrc.local` のソースがある。マシン固有設定はそちらへ
- `dot_gitconfig` にはユーザー名・メールアドレスがハードコードされている（fork する場合は要修正）
