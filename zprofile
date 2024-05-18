if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

. /opt/homebrew/opt/asdf/libexec/asdf.sh
. $HOME/.cargo/env

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/miniforge3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "$HOME/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "$HOME/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/flutter/bin"
