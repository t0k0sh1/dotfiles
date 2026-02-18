cdf() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null \
    | fzf --preview 'eza --tree --level=2 --color=always {}')
  [ -n "$dir" ] && cd "$dir"
}
