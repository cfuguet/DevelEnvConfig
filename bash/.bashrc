#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


###
#   Add local per-user binaries into the path
###

export PATH=$HOME/.local/bin:$PATH


###
#   Shell Pretty Ouput
###

# Activate the solarized dircolors theme
SOLARIZED_DIRCOLORS_PATH=$HOME/Config/Solarized/dircolors-solarized
SOLARIZED_DIRCOLORS_THEME=dircolors.ansi-dark
eval `dircolors $SOLARIZED_DIRCOLORS_PATH/$SOLARIZED_DIRCOLORS_THEME`


###
#   History Review
###

# Max number of commands to remember
HISTSIZE=1000

# Don't save lines which begin with a space or match a previous entry
HISTCONTROL=ignoreboth

# Bind keys for navigating on history 
bind -m emacs
bind '"\C-p"    history-search-backward'
bind '"\C-n"    history-search-forward'

# bash shell appends to the history file on exit, rather than overwrite it
shopt -s histappend


###
#   Misc Shell Behavior Options
###

# check the window size after each command and update LINES and COLUMNS.
shopt -s checkwinsize

# expand shell variables when performing filename completion
shopt -s direxpand


###
#   Aliases
###

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'
alias l='ls -l'

# Alias for the gvim application: It suppresses the "Gtk-Warning messages"
gvim() { $(which gvim) -p "$@" >&/dev/null & }


###
#   Prompt shell pretty format
###

# Prompt Shell (PS) colors
#   Regular Font = \e[0;
#   Bold Font    = \e[1;

NN="\[\e[0m\]"    # color none
BL="\[\e[0;30m\]" # black
RE="\[\e[0;31m\]" # red
GR="\[\e[0;32m\]" # green
YE="\[\e[0;33m\]" # yellow
BU="\[\e[0;34m\]" # blue
PU="\[\e[0;35m\]" # purple
CY="\[\e[0;36m\]" # cyan
WH="\[\e[0;37m\]" # white

function git_branch() {
	git branch 2> /dev/null | sed -n 's/\* *\(.*\)/ (\1)/p' ;
}

if (( $(tput colors) >= 8 )); then
	PS1="[\u@\h ${BU}\W${GR}\$(git_branch)${NN}]\$ "
else
	PS1="[\u@\h \W\$(git_branch)]\$ "
fi
