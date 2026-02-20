# CONTRIBUTING.md — 自分向け作業覚書き

## zsh 関数を追加する

```bash
# 1. 関数ファイルを作成
touch dot_zsh/functions/<関数名>.sh
```

テンプレート:

```zsh
# 関数の1行説明
<関数名>() {
  if ! command -v <tool> &>/dev/null; then
    echo "Error: <tool> is not installed" >&2
    return 1
  fi
  # 本体
}
```

```bash
# 2. 即時テスト
source ~/.zsh/functions/<関数名>.sh && <関数名>

# 3. 適用
chezmoi apply
```

### 命名規則

- git 操作 → `g` プレフィックス（`gsb`, `gbs`, `gbd`, `gdf`, `glo`）
- fzf インタラクティブ系 → `f` プレフィックス（`fkill`, `fport`, `fcp`, `frm`）
- その他は短い動詞形（`cls`, `dcr`, `wi`, `yy`）

### fzf パターン

```zsh
myfunc() {
  local selected
  selected=$(some-list-command | fzf --preview='preview-command {}')
  [[ -z "$selected" ]] && return
  # selected を使った処理
}
```

---

## エイリアスを追加する

`dot_aliases` の適切なカテゴリブロックに追記するだけ。反映は `cls` で即時。

マシン固有のものは `~/.aliases.local` へ（リポジトリには含めない）。

---

## Homebrew パッケージを追加する

```bash
# 1. インストールして動作確認
brew install <package>

# 2. Brewfile に追記（カテゴリコメントを守る）
vim Brewfile

# 3. chezmoi apply で run_onchange が自動実行 → brew bundle が走る
chezmoi apply
```

---

## 変更のテスト

```bash
# zshrc 全体の再読み込み
cls

# chezmoi の差分確認
chezmoi diff

# ドライラン
chezmoi apply --dry-run --verbose

# zshrc 構文チェック
zsh -n ~/.zshrc
```

---

## Git コミット規則

```
add <対象> [for <理由>]
fix <対象> [for/by <理由>]
remove <対象>
```

例:
- `add dcr function for docker compose clean restart`
- `add gsb function for git branch creation with space normalization`
- `fix nvim config bugs: remove duplicates, deprecated APIs`

---

## chezmoi 日常操作

```bash
chezmoi cd              # ソースディレクトリへ cd
chezmoi diff            # ホームとの差分確認
chezmoi apply           # 変更適用
chezmoi add ~/.newfile  # 新ファイルを管理対象に追加
chezmoi merge ~/.zshrc  # 競合マージ
```
