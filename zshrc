export RCRC=$HOME/dotfiles/rcrc

if [[ ! -n $TMUX ]]; then
    # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi

eval "$(starship init zsh)"

# autoload
autoload -Uz compinit
compinit

for function in ~/.zsh/functions/*; do
  source $function
done

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# kubernetes completion
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# AWS CLI completion
autoload bashcompinit && bashcompinit
complete -C '/opt/homebrew/bin/aws_completer' aws

# uv completion
eval "$(uv generate-shell-completion zsh)"

FPATH="$HOME/.docker/completions:$FPATH"
autoload -Uz compinit
compinit

# mise
[[ -f ~/.local/bin/mise ]] && eval "$(~/.local/bin/mise activate zsh)"

# poetry
POETRY_VIRTUALENVS_PROMPT=" "

# postgresql client
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

