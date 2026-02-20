# t0k0sh1/dotfiles

macOS 向け個人 dotfiles。[chezmoi](https://www.chezmoi.io/) で管理。

## セットアップ / Setup

### 新規マシン（1コマンド）

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/t0k0sh1/dotfiles/main/install.sh)"
```

`install.sh` の処理:
1. Homebrew が未インストールであればインストール
2. chezmoi をインストールして dotfiles を適用 (`chezmoi init --apply t0k0sh1`)

### chezmoi 導入済みの場合

```bash
chezmoi init --apply t0k0sh1
```

### dotfiles の更新

```bash
chezmoi apply            # 変更を適用
chezmoi diff             # 差分を確認
chezmoi apply --dry-run  # ドライランで確認
```

Brewfile に変更があると `run_onchange_install-packages.sh.tmpl` が自動実行され、`brew bundle` が走ります。

---

## リポジトリ構成 / Structure

```
dotfiles/
├── dot_zshrc                              # zsh メイン設定
├── dot_aliases                            # エイリアス集
├── dot_zsh/functions/*.sh                 # 自動ロードされる zsh 関数群
├── dot_gitconfig                          # Git 設定（delta, git-lfs 含む）
├── dot_tigrc                              # tig 設定
├── dot_editorconfig                       # EditorConfig
├── dot_config/nvim/                       # Neovim（LazyVim）設定
├── Brewfile                               # Homebrew パッケージ一覧
├── install.sh                             # 新規マシンセットアップ
└── run_onchange_install-packages.sh.tmpl  # chezmoi 自動 brew bundle
```

chezmoi は `dot_` プレフィックスを `.` に変換してホームディレクトリへ展開します。

---

## zsh 関数一覧 / Shell Functions

`~/.zsh/functions/` 以下のファイルが zsh 起動時に自動ソースされます。

### ファイル操作

| 関数 | 使い方 | 説明 |
|------|--------|------|
| `f` | `f` | fzf + bat でファイルを選択 → nvim で開く |
| `fcp` | `fcp` | fzf でファイルを選択してコピー先を指定しコピー |
| `frm` | `frm` | fzf でファイルを選択して削除（確認あり） |
| `cdf` | `cdf` | fzf でディレクトリを選択して cd |
| `yy` | `yy` | yazi を起動し、終了後に最後のディレクトリへ cd |

### Git

| 関数 | 使い方 | 説明 |
|------|--------|------|
| `gsb` | `gsb feature add login` | スペースをハイフンに変換してブランチ作成（重複チェック付き） |
| `gbs` | `gbs [query]` | fzf でブランチを選択して switch + pull |
| `gbd` | `gbd` | fzf でブランチを選択して削除 |
| `gdf` | `gdf` | fzf で変更ファイルを選択 → nvim で開く |
| `glo` | `glo` | fzf で git ログを選択して diff 表示 |
| `gi` | `gi node,python` | gitignore.io からテンプレートを生成 |

### システム・プロセス

| 関数 | 使い方 | 説明 |
|------|--------|------|
| `fkill` | `fkill` | fzf でプロセスを選択して kill（TAB で複数選択可） |
| `fport` | `fport 3000` | 指定ポートを使用しているプロセスを確認・kill |
| `wi` | `wi example.com` | ドメインの whois / dig / IP 情報を表示 |

### その他

| 関数 | 使い方 | 説明 |
|------|--------|------|
| `cls` | `cls` | `~/.zshrc` を再読み込みして画面クリア |
| `dcr` | `dcr` | `docker compose down -v && docker compose up -d`（compose ファイル存在チェック付き） |

---

## エイリアス一覧 / Aliases

### 基本コマンド

| エイリアス | 展開先 | 説明 |
|-----------|--------|------|
| `ls` | `eza` | モダンな ls |
| `ll` | `eza -al` | 詳細一覧 |
| `mkdir` | `mkdir -p` | 親ディレクトリも自動作成 |
| `xfind` | `fd` | 高速 find |
| `xgrep` | `rg` | 高速 grep |
| `n` | `nvim` | Neovim |
| `lets-coding` | `zellij --layout coding` | zellij コーディングレイアウト |

### Git

| エイリアス | 展開先 |
|-----------|--------|
| `g` | `git` |
| `gs` | `git status --short` |
| `gd` | `git diff` |
| `gu` | `git pull` |
| `gp` | `git push` |
| `gl` | `git log` |
| `t` | `tig` |
| `ts` | `tig status` |
| `ta` | `tig --all` |
| `gwr` | `git gtr` |

### Docker / Compose

| エイリアス | 展開先 |
|-----------|--------|
| `dc` | `docker compose` |
| `dcb` | `docker compose build` |
| `dcu` | `docker compose up -d` |
| `dcd` | `docker compose down` |
| `dcl` | `docker compose logs` |

### ツール

| エイリアス | 展開先 |
|-----------|--------|
| `k` | `kubectl` |
| `tf` | `terraform` |
| `sls` | `serverless` |
| `pytest` | `uv run pytest` |
| `streamlit` | `uv run streamlit` |
| `sail` | `./vendor/bin/sail` |
| `cc` | `claude` |
| `brewup` | `brew update && brew upgrade && brew cleanup` |

ローカル専用のエイリアスは `~/.aliases.local` に記述（`.gitignore` 対象推奨）。

---

## 依存ツール / Dependencies

`brew bundle` で一括インストールされます。

| ツール | 用途 |
|--------|------|
| [neovim](https://neovim.io/) | エディタ |
| [eza](https://github.com/eza-community/eza) | モダン ls |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | 高速 grep |
| [fd](https://github.com/sharkdp/fd) | 高速 find |
| [bat](https://github.com/sharkdp/bat) | シンタックスハイライト付き cat |
| [fzf](https://github.com/junegunn/fzf) | ファジーファインダー（多くの関数の核） |
| [delta](https://github.com/dandavison/delta) | git diff ビューア |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | スマート cd |
| [zellij](https://zellij.dev/) | ターミナルマルチプレクサ |
| [tig](https://jonas.github.io/tig/) | git TUI |
| [yazi](https://github.com/sxyazi/yazi) | ターミナルファイルマネージャ |
| [chezmoi](https://www.chezmoi.io/) | dotfiles 管理 |
| [mise](https://mise.jdx.dev/) | ランタイムバージョン管理 |
| [uv](https://github.com/astral-sh/uv) | Python パッケージ管理 |
| [git](https://git-scm.com/) / [git-lfs](https://git-lfs.com/) | バージョン管理 |

