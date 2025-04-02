gbs() {
  local branch
  branch=$(git branch --all --color=always | grep -v HEAD | sed 's|remotes/[^/]*/||' | sort -u | fzf --ansi --preview "git log --oneline --graph --color=always {}" | sed 's/.* //' )
  [ -n "$branch" ] && git switch "$branch" 2>/dev/null || git switch -c "$branch" --track origin/"$branch"
}
