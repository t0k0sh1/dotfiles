fh() {
  eval "$(history | fzf | sed 's/ *[0-9]* *//')"
}
