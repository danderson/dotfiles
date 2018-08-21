# Stuff sourced by both bash and zsh (see bashrc/zshrc)
#
# NOTE that this is sourced for non-interactive shells, keep it free
# of interactive stuff.

export PAGER='less -X'
export EDITOR='emacsclient'
export LESS='-R'
export TZ="America/Los_Angeles"

# Make locally installed Gem binaries visible. Of course Gem doesn't
# have an easy way to do this, and you have to invoke a handwritten
# script to getthe information you need.
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
fi

export PATH=~/bin:~/hack/go/bin:~/.npm-global/bin:$PATH
export GOPATH=~/hack/go

# Per-machine stuff
[ -f ~/.shell-common-machine.sh ] && source ~/.shell-common-machine.sh
