f() {
  local file
  file=$(fzf --height 40% --reverse \
    --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {}' \
    < <(rg --files --hidden --glob '!.git' 2>/dev/null || find . -type f -not -path '*/.git/*'))
  [ -n "$file" ] && nvim "$file"
}
