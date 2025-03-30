export RCRC=$HOME/dotfiles/rcrc

eval "$(starship init zsh)"
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

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

# kubernetes completion
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# mise
[[ -f ~/.local/bin/mise ]] && eval "$(~/.local/bin/mise activate zsh)"

# poetry
POETRY_VIRTUALENVS_PROMPT=" "

export TMUX_TMPDIR=/tmp
