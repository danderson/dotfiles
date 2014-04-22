source ~/.shell-common.sh
alias ..='cd ..'

# Nice and simple, no frills. It's only bash, after all.
if [[ `whoami` == "root" ]]; then
    PS1='\e[31m\u\e[0m@\h#'
else
    PS1='\u@\h$'
fi

# Nag that we're using bash, because bash is bad.
echo -e "\n\033[1;31mUsing bash\033[0m, can you switch to zsh?\n"

# Per-machine stuff
[ -f ~/.bashrc-machine ] && source ~/.zshrc-machine
