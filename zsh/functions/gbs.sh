gbs() {
  local query="$1"
  local branches
  local target

  branches=$(git for-each-ref --format='%(refname:short)' refs/heads/)

  if [[ -z "$query" ]]; then
    # no parameter
    target=$(echo "$branches" | fzf --preview='git log --oneline --decorate --color=always --graph {}' --ansi)
    [[ -n "$target" ]] && git switch "$target"
    git pull
  else
    # exist parameter
    local matched
    matched=($(echo "$branches" | grep -- "$query"))

    if [[ ${#matched[@]} -eq 0 ]]; then
      # no match
      echo "No matching branches."
      target=$(echo "$branches" | fzf --preview='git log --oneline --decorate --color=always --graph {}' --ansi)
      [[ -n "$target" ]] && git switch "$target"
      git pull
    elif [[ ${#matched[@]} -eq 1 ]]; then
      # if match only one branch
      git switch "${matched[1]}"
      git pull
    else
      # if match multiple branches
      target=$(printf "%s\n" "${matched[@]}" | fzf --preview='git log --oneline --decorate --color=always --graph {}' --ansi --query="$query")
      [[ -n "$target" ]] && git switch "$target"
      git pull
    fi
  fi
}
