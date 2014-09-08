### Basics

# /etc/zprofile resets PATH, among other things, so we need to
# re-source.
source ~/.zshenv

# In the case of an interactive, non-login shell, this leads to
# repetitions in PATH. Fortunately, zsh to the rescue.
export -U PATH=$PATH

# Notify asynchronously of background job completion, don't
# synchronize on prompt display.
setopt notify
# NO BEEPING!
unsetopt beep
# Show non-zero return codes
setopt printexitvalue

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

### Keybindings - why are these even still a thing? Stupid defaults.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -e                                            # Use emacs key bindings

bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
if [[ "${terminfo[kpp]}" != "" ]]; then
    bindkey "${terminfo[kpp]}" up-line-or-history       # [PageUp] - Up a line of history
fi
if [[ "${terminfo[knp]}" != "" ]]; then
    bindkey "${terminfo[knp]}" down-line-or-history     # [PageDown] - Down a line of history
fi

if [[ "${terminfo[kcuu1]}" != "" ]]; then
    bindkey "${terminfo[kcuu1]}" up-line-or-search      # start typing + [Up-Arrow] - fuzzy find history forward
fi
if [[ "${terminfo[kcud1]}" != "" ]]; then
    bindkey "${terminfo[kcud1]}" down-line-or-search    # start typing + [Down-Arrow] - fuzzy find history backward
fi

if [[ "${terminfo[khome]}" != "" ]]; then
    bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
    bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
fi

bindkey ' ' magic-space                               # [Space] - do history expansion

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word

if [[ "${terminfo[kcbt]}" != "" ]]; then
    bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
    bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
    bindkey "^[[3~" delete-char
    bindkey "^[3;5~" delete-char
    bindkey "\e[3~" delete-char
fi


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
