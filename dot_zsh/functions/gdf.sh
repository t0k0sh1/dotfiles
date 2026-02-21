# Description: Open changed files (git status) in nvim via fzf
gdf() {
  local selected file

  selected=$(git -c color.status=always status --short 2>/dev/null \
    | fzf --ansi \
        --preview='git diff --color=always HEAD -- {2} 2>/dev/null \
                   || bat --style=numbers --color=always {2} 2>/dev/null \
                   || cat {2}' \
        --header="Changed files (Enter to open in nvim)")

  [[ -z "$selected" ]] && return
  file=$(echo "$selected" | awk '{print $NF}')
  nvim "$file"
}
