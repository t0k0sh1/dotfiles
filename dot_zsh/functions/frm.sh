frm() {
  local files
  files=$(fzf --multi --preview 'bat --style=numbers --color=always {} 2>/dev/null || ls -la {}')
  [[ -n "$files" ]] && echo "$files" | xargs rm -i
}
