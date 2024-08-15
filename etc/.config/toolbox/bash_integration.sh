#!/bin/bash
export PATH="$HOME/.local/bin:$PATH"
export FZF_DEFAULT_OPTS='--cycle --bind "tab:toggle-up,btab:toggle-down"'
alias j='project.sh'
alias tls='tmux ls'
alias tk='tmux kill-session -t'
alias tm='tmux new-session -A -s main'
alias si='store.sh install'
alias sr='store.sh remove'
alias n='notify.sh'
alias nh='notify.sh -t homelab'
alias nw='notify.sh -t work'
alias nr='notify.sh -t random'

#ls aliases
alias ls='ls --color=auto '
alias ll='ls --color=auto -pl'
alias la='ls --color=auto -pa'
alias lla='ls --color=auto -pla'

# clear
alias c='clear'
