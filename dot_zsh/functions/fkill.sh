# fzf でプロセスを選択してkill（TABで複数選択可）
fkill() {
  local selected
  selected=$(ps aux \
    | fzf --multi --ansi \
        --header='Select process(es) to kill  [TAB: multi-select]' \
        --header-lines=1 \
        --preview='echo {}')
  [[ -z "$selected" ]] && return
  echo "$selected" | awk '{print $2}' | xargs kill "${1:--15}"
}
