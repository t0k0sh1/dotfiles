# Homebrew
if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Rust
. $HOME/.cargo/env

# Golang
export PATH="$PATH:$HOME/go/bin"
export GOROOT=$(go1.24.2 env GOROOT)
export PATH=$GOROOT/bin:$PATH

# Jetbrains Toolbox
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# .local/bin
export PATH="$PATH:$HOME/.local/bin"

