# Description: Search and switch Git branches with fzf
gbs() {
  local query="$1"
  local branches target

  branches=$(git for-each-ref --format='%(refname:short)' refs/heads/ refs/remotes/ 2>/dev/null \
    | grep -v 'HEAD$' \
    | sed 's|^origin/||' \
    | sort -u)

  if [[ -z "$query" ]]; then
    target=$(echo "$branches" | fzf --preview='git log --oneline --decorate --color=always --graph {}' --ansi)
  else
    local matched
    matched=($(echo "$branches" | grep -- "$query"))

    if [[ ${#matched[@]} -eq 0 ]]; then
      echo "No matching branches."
      target=$(echo "$branches" | fzf --preview='git log --oneline --decorate --color=always --graph {}' --ansi)
    elif [[ ${#matched[@]} -eq 1 ]]; then
      target="${matched[1]}"
    else
      target=$(printf "%s\n" "${matched[@]}" | fzf --preview='git log --oneline --decorate --color=always --graph {}' --ansi --query="$query")
    fi
  fi

  if [[ -n "$target" ]] && git switch "$target"; then
    git pull
  fi
}
