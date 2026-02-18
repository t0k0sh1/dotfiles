fcp() {
  local src=$(fzf)
  local dest
  read -p "Copy to: " dest
  cp -i "$src" "$dest"
}
