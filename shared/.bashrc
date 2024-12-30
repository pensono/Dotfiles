function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/ [\1]/p'
}

function status_emoji() {
    if [[ "${?}" == "0" ]]; then printf "○"; else printf "●"; fi
}

function set_terminal_title() {
    echo -en "\e]0;%~\a"
}

COLOR_DEF=$'%f'
COLOR_USR=$'%F{243}'
COLOR_DIR=$'%F{197}'
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
export PROMPT='$(set_terminal_title)$(status_emoji)${COLOR_GIT}$(parse_git_branch) ${COLOR_DIR}%~${COLOR_DEF} $ '
