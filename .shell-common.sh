# Stuff sourced by both bash and zsh (see bashrc/zshrc)

alias vi=vim
alias e='emacsclient -n'

export PAGER='less -X'
export EDITOR='emacsclient -t'
export LESS='-R'

export PATH=~/bin:~/go/bin:~/.local/bin:~/.gem/ruby/1.8/bin:$PATH
export GOPATH=~/hack/go

# Per-machine stuff
[ -f ~/.shell-common-machine.sh ] && source ~/.shell-common-machine.sh
