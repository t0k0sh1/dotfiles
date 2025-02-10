export RCRC=$HOME/dotfiles/rcrc

eval "$(starship init zsh)"
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

for function in ~/.zsh/functions/*; do
  source $function
done

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
