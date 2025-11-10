export RCRC=$HOME/dotfiles/rcrc
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
# uv and uvx
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
# mise
[[ -f ~/.local/bin/mise ]] && eval "$(~/.local/bin/mise activate zsh)"
# poetry
POETRY_VIRTUALENVS_PROMPT=" "
# postgresql client
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
# golang
export PATH="$PATH:$(go env GOPATH)/bin"
# zoxide
eval "$(zoxide init zsh)"
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"