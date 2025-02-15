# Homebrew
if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Rust
. $HOME/.cargo/env

# Golang
export PATH="$PATH:$HOME/go/bin"
export GOROOT=$(go1.24.0 env GOROOT)
export PATH=$GOROOT/bin:$PATH

# Jetbrains Toolbox
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# .local/bin
export PATH="$PATH:$HOME/.local/bin"

# Setting PATH for Python 3.12
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
export PATH
