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

  # attach to session if exists
  if tmux has-session -t "$PROJECT_NAME" > /dev/null 2>&1 ; then

      # check if already in tmux session and switch client
      if [ -n "$TMUX" ]; then
        tmux switch-client -t "$PROJECT_NAME"\; select-window -t "$EDITOR" \; select-pane -t 0 \;
      else
        tmux attach-session -t "$PROJECT_NAME"\; select-window -t "$EDITOR" \; select-pane -t 0 \;
      fi
  else
      if [[ "$1" != '' ]] && [[ -d "$1" ]]; then cd "$1" || exit 1; fi

      # start a new session in the given directory
      if [ -n "$TMUX" ]; then
      tmux new  -n  "$EDITOR" -ds "$PROJECT_NAME"  "$EDITOR"

      tmux switch-client -t "$PROJECT_NAME" \; set -w remain-on-exit on \; \
        new-window -n "$WORKSPACE" \; \
        select-window -t "$EDITOR" \; \
        select-pane -t 0 \;

      else
      tmux new  -n  "$EDITOR" -s "$PROJECT_NAME"  "$EDITOR" \;  set -w remain-on-exit on \; \
        new-window -n "$WORKSPACE" \; \
        select-window -t "$EDITOR" \; \
        select-pane -t 0 \;
      fi

  fi
}

if test "$#" == '0'  ;then toolmux "$HOME" ;fi
if test "$#" == '1' && test -d $1 || tmux has-session -t $1 ;then toolmux "$1"; else help; fi
