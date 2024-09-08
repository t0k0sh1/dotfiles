git-diff() {
  while true; do
    local diff_command="git diff"

    # 引数を追加する
    if [[ "$#" -gt 0 ]]; then
      diff_command="$diff_command $@"
    fi

    # 端末の幅を取得
    local term_width=$(stty size | cut -d ' ' -f 2)

    # fzf を使ってファイルを選択し、そのファイルに対して git diff を実行
    files=$(git diff --name-only "$@" | fzf --multi --preview "$diff_command --color=always {}" --preview-window=right:60%:wrap)

    if [[ -n "$files" ]]; then
      clear
      eval "$diff_command $files | delta --syntax-theme Dracula --side-by-side --line-numbers"
      echo
      echo "Press Enter to return to file selection, or Ctrl+C to exit."
      read -r
    else
      break
    fi
  done
}
