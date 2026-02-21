# Description: Show all custom commands (aliases + functions) with fzf
cmds() {
  local func_dir="$HOME/.zsh/functions"
  local aliases_file="$HOME/.aliases"

  _cmds_list() {
    local f name desc line name_ exp_

    # --- Functions ---
    for f in "$func_dir"/*.sh; do
      [[ -e "$f" ]] || continue
      name=$(grep -m1 -oE '(^function [a-zA-Z_][a-zA-Z0-9_]*|^[a-zA-Z_][a-zA-Z0-9_]*\(\))' "$f" \
        | sed 's/^function //; s/()$//')
      [[ -z "$name" ]] && name="${${f##*/}%.sh}"
      desc=$(grep -m1 '^# Description:' "$f" | sed 's/^# Description: *//')
      [[ -z "$desc" ]] && desc="(no description)"
      printf "fn  %-14s  %s\n" "$name" "$desc"
    done

    # --- Aliases ---
    [[ -f "$aliases_file" ]] || return
    while IFS= read -r line; do
      [[ "$line" =~ ^alias[[:space:]] ]] || continue
      name_=$(printf '%s' "$line" | sed "s/^alias \([^=]*\)=.*/\1/")
      exp_=$(printf '%s' "$line" | sed "s/^alias [^=]*=//; s/^['\"]//; s/['\"].*//")
      printf "al  %-14s  %s\n" "$name_" "$exp_"
    done < "$aliases_file"
  }

  # Fallback: plain list
  if ! command -v fzf >/dev/null 2>&1; then
    printf "%-4s  %-14s  %s\n" "TYPE" "NAME" "DESCRIPTION/EXPANSION"
    printf '%.0s-' {1..60}; echo
    _cmds_list | sort -k2
    return
  fi

  # fzf interactive
  _cmds_list | sort -k2 \
    | fzf \
        --header='fn=function  al=alias  |  Esc: quit' \
        --preview='
          entry_type={1}
          entry_name={2}
          if [[ "$entry_type" == "fn" ]]; then
            src=$(grep -rlE "^${entry_name}\(\)|^function ${entry_name}[[:space:](]" '"$func_dir"'/*.sh 2>/dev/null | head -1)
            if [[ -n "$src" ]]; then
              bat --style=numbers --color=always "$src" 2>/dev/null || cat "$src"
            fi
          else
            grep "^alias ${entry_name}=" '"$aliases_file"'
          fi
        ' \
        --preview-window='right:60%'
}
