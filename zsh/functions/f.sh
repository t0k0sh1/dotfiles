f() {
  local file
  file=$(fzf --height 40% --reverse --preview 'bat --style=numbers --color=always {} || cat {}' < <(ls -t))
  [ -n "$file" ] && $EDITOR "$file"
}
