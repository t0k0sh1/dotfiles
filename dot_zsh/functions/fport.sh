# Description: Manage listening ports/processes with fzf
fport() {
  local port="$1"
  if [[ -n "$port" ]]; then
    local pids
    pids=$(lsof -ti:"$port" 2>/dev/null)
    if [[ -z "$pids" ]]; then
      echo "No process on port $port"
      return
    fi
    echo "Process(es) on port $port:"
    echo "$pids" | xargs -I{} ps -p {} -o pid,user,command= 2>/dev/null
    read -r "reply?Kill? [y/N] "
    [[ "$reply" =~ ^[Yy]$ ]] && echo "$pids" | xargs kill && echo "Killed"
  else
    local selected
    selected=$(lsof -nP -iTCP -sTCP:LISTEN 2>/dev/null \
      | tail -n +2 \
      | fzf --multi --ansi \
          --header='Listening ports  [TAB: multi-select]' \
          --preview='echo {}')
    [[ -z "$selected" ]] && return
    echo "$selected" | awk '{print $2}' | sort -u | xargs kill
  fi
}
