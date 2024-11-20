#!/bin/bash
source "$HOME/.local/lib/minimal_env.sh"

# add toolbox bins to path
export PATH="$HOME/.local/bin:$PATH"

# set manpager
if ! minimal_env; then export MANPAGER="nvim +Man! ";else export MANPAGER="vim -M +MANPAGER - "; fi

# set zff default command
export FZF_DEFAULT_COMMAND='rg "" -l '

# set fzf default options
if minimal_env; then
export FZF_DEFAULT_OPTS=" \
--cycle --bind 'tab:toggle-up,btab:toggle-down'"
else
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--cycle --bind 'tab:toggle-up,btab:toggle-down'"
fi

alias s='sudo'
alias si='store.sh install'
alias sr='store.sh remove'

# tmux aliases
alias tmls='tmux ls'
alias tmks='tmux kill-server'
alias tmk='tmux kill-session -t'
alias tmm='tmux new-session -A -s $HOSTNAME'

# notify aliases
alias nt='notify.sh'
alias nth='notify.sh -t homelab'
alias ntw='notify.sh -t work'
alias ntr='notify.sh -t random'

#ls aliases
alias l='ls --color=auto -lart'
alias ls='ls --color=auto '
alias ll='ls --color=auto -pl'
alias la='ls --color=auto -pa'
alias lla='ls --color=auto -pla'

# git
alias gst='git status'
alias gd='git diff'
alias gl='git log'
alias gr='git restore'
alias gg='lazygit'

# clear
alias c='clear'

# vim and nvim
alias v='vim'
alias nv='nvim'

#ssh alias
alias ssh='TERM=xterm-256color ssh'

# starship integration
if ! minimal_env; then eval "$(starship init bash)"; fi
