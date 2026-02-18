# yazi wrapper: 終了時に最後のディレクトリへ cd する
yy() {
  local tmp
  tmp=$(mktemp -t "yazi-cwd.XXXXX")
  yazi "$@" --cwd-file="$tmp"
  if cwd=$(cat -- "$tmp") && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
