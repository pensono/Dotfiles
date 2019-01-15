# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
#if command -v tmux>/dev/null; then
#  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
#fi

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    local RCol='\[\e[0m\]'

    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'

    if [ $EXIT != 0 ]; then
        PS1+="[${Red}$EXIT${RCol}] "      # Add red if exit code non 0
    fi
    PS1+="${RCol}${BBlu}\u@\h ${BYel}\w${RCol}\$ "
    #PS1+="\u@\h \w${RCol}\$ "
}


# https://linuxcommando.blogspot.com/2007/10/grep-with-color-output.html
export GREP_OPTIONS='--color=always -n'

# Make sure globstar is on
# https://stackoverflow.com/questions/793715/unable-to-enable-globstar-in-bash-4#793910
shopt -s globstar

# QEMU
export PATH=/cse/courses/cse451/17au/bin/x86_64-softmmu:$PATH

