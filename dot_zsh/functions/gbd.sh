gbd() {
  local current branches selected

  current=$(git branch --show-current 2>/dev/null) || return

  branches=$(git branch --format='%(refname:short)' \
    | grep -v -E "^(main|master|develop)$|^${current}$")

  [[ -z "$branches" ]] && echo "No deletable branches." && return

  selected=$(echo "$branches" \
    | fzf --multi --ansi \
        --preview='git log --oneline --decorate --color=always --graph {}' \
        --header="TAB: multi-select | current: $current")

  [[ -z "$selected" ]] && return

  echo "$selected" | xargs git branch -d
}
