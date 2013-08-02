# Path to oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme from ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"

COMPLETION_WAITING_DOTS="true"


source /usr/local/share/chruby/chruby.sh
chruby 1.9.3-p385-perf

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/exports.sh
source $ZSH/custom/aliases.sh
source $ZSH/custom/fns.sh
source $ZSH/custom/autorun.sh

plugins=(git rails ruby osx bundler autojump)
