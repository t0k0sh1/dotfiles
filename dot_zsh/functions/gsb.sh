gsb() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: gsb <branch-name>" >&2
    return 1
  fi

  local branch="${*// /-}"

  # ローカルブランチの重複チェック
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    echo "Error: Branch '$branch' already exists locally." >&2
    return 1
  fi

  # リモートブランチの重複チェック
  if git ls-remote --exit-code --heads origin "$branch" &>/dev/null; then
    echo "Error: Branch '$branch' already exists on remote." >&2
    return 1
  fi

  git switch -c "$branch"
}
