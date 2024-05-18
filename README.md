# t0k0sh1's dotfiles

## Requirements

Set zsh as your login shell:

```
chsh -s $(which zsh)
```

### Install

#### Install dotfiles

```
git clone https://github.com/t0k0sh1/dotfiles.git ~/dotfiles
```

### Install rcm

```
brew install rcm
```

Install the dotfiles:

```
env RCRC=$HOME/dotfiles/rcrc rcup
```
