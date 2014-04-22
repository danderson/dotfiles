# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

if [ ! -d $ZSH ]; then
    echo "Looks like you're missing oh-my-zsh, trying to get it..."
    if which git >/dev/null 2>&1; then
        git clone git://github.com/robbyrussell/oh-my-zsh.git $ZSH
    else
        echo "Oh noes, you don't have git. That's not going to work."
        echo "Sorry, prepare for a slew of errors :("
    fi
fi

ZSH_THEME=""
# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

plugins=(git gem pip history-substring-search)
source $ZSH/oh-my-zsh.sh

# Emacs keybindings
bindkey -e

source ~/.shell-common.sh

function go-switch() {
    eval `command go-switch $@`
    rehash
}

# Prompt
function make_prompt() {
  local host_color
  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    host_color='%F{yellow}'
  else
    host_color='%F{green}'
  fi

  local user='%(!.%F{red}.%F{green})%n%f' # red if root, else green
  local at='%F{cyan}@%f'
  local host="$host_color%m%f"
  local dir='%B%F{blue}%4~%f%b'

  echo "${user}${at}${host} ${dir} » "
}
PROMPT="$(make_prompt)"
setopt printexitvalue

# Per-machine config, if any
if [ -f ~/.zshrc-machine ]; then
  source ~/.zshrc-machine
else
  true
fi
