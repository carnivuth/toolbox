#!/bin/bash
export PATH="$HOME/.local/bin:$PATH"
export FZF_DEFAULT_OPTS='--cycle --bind "tab:toggle-up,btab:toggle-down"'

alias s='sudo'
alias si='store.sh install'
alias sr='store.sh remove'

# tmux aliases
alias j='project.sh'
alias tls='tmux ls'
alias tk='tmux kill-session -t'
alias tm='tmux new-session -A -s $HOSTNAME'

# notify aliases
alias n='notify.sh'
alias nh='notify.sh -t homelab'
alias nw='notify.sh -t work'
alias nr='notify.sh -t random'

#ls aliases
alias l='ls --color=auto -lart'
alias ls='ls --color=auto '
alias ll='ls --color=auto -pl'
alias la='ls --color=auto -pa'
alias lla='ls --color=auto -pla'

# git
alias gst='git status'
alias gd='git diff'
alias gg='lazygit'

# clear
alias c='clear'
