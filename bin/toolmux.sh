#!/bin/bash
WORKSPACE="worker"

function help(){
  echo "Usage $0 [project folder]"
  echo "  open default tmux configuration in the given folder"
}

toolmux(){

  # set  variable based on parameters
  if [[ "$1" != '' ]]; then PROJECT_NAME="$(basename "$1")"; else PROJECT_NAME="$(basename "$(pwd)")";fi
  if [[ "$1" == '.' ]]; then PROJECT_NAME="$(basename "$(pwd)")";fi

  #export TERM=xterm-256color
  if tmux has-session -t "$PROJECT_NAME" > /dev/null 2>&1 ; then
      # if session already exists attach to the session
      tmux attach-session -t "$PROJECT_NAME"\; select-window -t "$EDITOR" \; select-pane -t 0 \;
  else
      # start a new session in the given directory
      if [[ "$1" != '' ]] && [[ -d "$1" ]]; then cd "$1" || exit 1; fi
      # source python env if present
      if [[ -d "env" ]]; then source "env/bin/activate"; fi
      tmux new  -n  "$EDITOR" -s "$PROJECT_NAME"  "$EDITOR" \;  set -w remain-on-exit on \; \
        new-window -n "$WORKSPACE" \; \
        select-window -t "$EDITOR" \; \
          select-pane -t 0 \;

  fi
}

# avoid nested sessions
[ -n "$TMUX" ] && echo already in a tmux session && exit 1

if test -d $1 || tmux has-session -t $1 ;then toolmux "$1"; else help; fi
