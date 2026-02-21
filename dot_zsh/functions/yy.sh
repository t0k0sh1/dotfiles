# Description: Yazi wrapper that cd's to last visited directory on exit
yy() {
  local tmp
  tmp=$(mktemp -t "yazi-cwd.XXXXX")
  yazi "$@" --cwd-file="$tmp"
  if cwd=$(cat -- "$tmp") && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
