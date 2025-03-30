cdf() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null | fzf)
  [ -n "$dir" ] && cd "$dir"
}
