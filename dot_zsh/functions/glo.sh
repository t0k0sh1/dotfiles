glo() {
  local commit hash

  commit=$(git log --oneline --decorate --color=always "$@" 2>/dev/null \
    | fzf --ansi \
        --preview='git show --stat --color=always {1}' \
        --header="Git log (Enter to show full diff)")

  [[ -z "$commit" ]] && return
  hash=$(echo "$commit" | awk '{print $1}')
  git show --color=always "$hash" | ${PAGER:-less} -R
}
