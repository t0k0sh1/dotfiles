export RCRC=$HOME/dotfiles/rcrc
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
# git
source ~/.zsh/completions/git-prompt.sh
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/completions/git-completion.bash
autoload -Uz compinit && compinit

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

setopt PROMPT_SUBST ; PS1='%F{green}%n@%m%f: %F{cyan}%~%f %F{red}$(__git_ps1 "(%s)")%f\$ '
# git-worktree-runner
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit
source ~/.zsh/completions/_git-gtr

# kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Added by Antigravity
export PATH="/Users/t0k0sh1/.antigravity/antigravity/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/t0k0sh1/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

alias claude-mem='bun "/Users/t0k0sh1/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'
