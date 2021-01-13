# Edit the cmdline with modal bindings:
set -o vi

# Minimal prompt:
if [[ ${EUID} == 0 ]]; then
	PS1='\[\033[00;31m\]\w\[\033[0m\] '
else
	PS1='\w '
fi

# Sane long history (except for cmds beginning with space or dupes):
shopt -s histappend
HISTSIZE=100000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignoreboth

# Extended pattern matching and support for **:
shopt -s extglob
shopt -s globstar

# List files in one column, classify file types, print human sizes (when
# using -l), and list directories before files:
alias ls='ls -1Fh --group-directories-first'

# Colors for ip:
alias ip='ip --color=auto'
