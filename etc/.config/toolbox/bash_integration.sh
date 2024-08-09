#!/bin/bash
export PATH="$HOME/.local/bin:$PATH"
export FZF_DEFAULT_OPTS='--cycle --bind "tab:toggle-up,btab:toggle-down"'
alias j='project.sh'
alias tls='tmux ls'
alias si='store.sh install'
alias sr='store.sh remove'
alias n='notify.sh'
alias nh='notify.sh -t homelab'
alias nw='notify.sh -t work'
alias nr='notify.sh -t random'
