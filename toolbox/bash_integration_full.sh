#!/bin/bash
export PATH="$HOME/.local/bin:$PATH"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--cycle --bind 'tab:toggle-up,btab:toggle-down'"

alias s='sudo'
alias si='store.sh install'
alias sr='store.sh remove'

# tmux aliases
alias j='project.sh'
alias tls='tmux ls'
alias tks='tmux kill-server'
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

# vim and nvim
alias v='vim'
alias nv='nvim'

#ssh alias
alias ssh='TERM=xterm-256color ssh'

# starship integration
eval "$(starship init bash)"
