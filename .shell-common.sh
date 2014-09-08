# Stuff sourced by both bash and zsh (see bashrc/zshrc)
#
# NOTE that this is sourced for non-interactive shells, keep it free
# of interactive stuff.

export PAGER='less -X'
export EDITOR='emacsclient'
export LESS='-R'
export TZ="America/Los_Angeles"

export PATH=~/bin:~/go/bin:$PATH
export GOPATH=~/hack/go

# Per-machine stuff
[ -f ~/.shell-common-machine.sh ] && source ~/.shell-common-machine.sh
