### Basics

# Notify asynchronously of background job completion, don't
# synchronize on prompt display.
setopt notify
# NO BEEPING!
unsetopt beep
# Show non-zero return codes
setopt printexitvalue
# Emacs-style keybindings
bindkey -e

### Completion
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' ignore-parents parent
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
autoload -Uz compinit
compinit

### History management
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
# Allow concurrent writing to the history file, write with timestamps,
# suppress duplicate commands.
setopt appendhistory extended_history hist_save_no_dups

### Prompt
function make_prompt() {
  local host_color
  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    host_color='%F{yellow}'
  else
    host_color='%F{green}'
  fi

  local time="%F{cyan}%*%f" # 24-hour, second resolution
  local user='%(!.%F{red}.%F{green})%n%f' # red if root, else green
  local at='%F{cyan}@%f'
  local host="$host_color%m%f"
  local dir='%B%F{blue}%3~%f%b'

  echo "${time} ${user}${at}${host} ${dir} » "
}
PROMPT="$(make_prompt)"

### Machine specializations
if [ -f ~/.zshrc-machine ]; then
  source ~/.zshrc-machine
else
  true
fi
