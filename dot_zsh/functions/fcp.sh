# Description: Copy a file to a fzf-selected destination
fcp() {
  local src dest
  src=$(fzf --preview 'bat --style=numbers --color=always {} 2>/dev/null || ls -la {}')
  [[ -z "$src" ]] && return
  dest=$(find . -type d 2>/dev/null \
    | fzf --preview 'eza --tree --level=2 --color=always {}' --prompt='Copy to: ')
  [[ -z "$dest" ]] && return
  cp -i "$src" "$dest/"
}
