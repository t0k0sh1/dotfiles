fh() {
  eval $(history | fzf | sed 's/ *[0-9]* *//')
}
zle -N fh
bindkey '^R' fh
