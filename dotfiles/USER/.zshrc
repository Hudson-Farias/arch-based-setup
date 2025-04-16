ZSH_DISABLE_COMPFIX=true

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell" # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
plugins=(git zsh-autosuggestions zsh-completions asdf)

fpath=(~/scripts/completions ~/.zsh/completions $fpath)

export PATH="$HOME/scripts:$PATH"

source $ZSH/oh-my-zsh.sh

. "$HOME/.asdf/asdf.sh"

autoload -Uz compinit
compinit
