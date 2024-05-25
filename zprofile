# Homebrew
if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Rust
. $HOME/.cargo/env

# Golang
export PATH="$PATH:$HOME/go/bin"
export GOROOT=$(go1.22.3 env GOROOT)
export PATH=$GOROOT/bin:$PATH

# Flutter
export PATH="$PATH:$HOME/flutter/bin"

# Jetbrains Toolbox
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# .local/bin
export PATH="$PATH:$HOME/.local/bin"
