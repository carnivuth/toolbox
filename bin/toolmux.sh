#!/bin/bash
WORKSPACE="worker"

function help(){
  echo "Usage $0 [project folder]"
  echo "  open default tmux configuration in the given folder"
}

function toolmux(){

  # set  variable based on parameters
  if [[ "$1" != '' ]]; then PROJECT_NAME="$(basename "$1")"; else PROJECT_NAME="$(basename "$(pwd)")";fi
  if [[ "$1" == '.' ]]; then PROJECT_NAME="$(basename "$(pwd)")";fi

  # attach to session if exists
  if tmux has-session -t "$PROJECT_NAME" > /dev/null 2>&1 ; then

      # check if already in tmux session and switch client
      if [ -n "$TMUX" ]; then
        tmux switch-client -t "$PROJECT_NAME"\;
      else
        tmux attach-session -t "$PROJECT_NAME"\;
      fi
  else
      if [[ "$1" != '' ]] && [[ -d "$1" ]]; then cd "$1" || exit 1; fi

        CONFIG_FILE="$HOME/.config/toolmux/config.conf"
        if [[ -f ".tmux.conf" ]]; then CONFIG_FILE=".tmux.conf"; fi

        # check if command is runned inside tmux session
        if [ -n "$TMUX" ]; then
          echo "tmux new -d -s $PROJECT_NAME -n $PROJECT_NAME; tmux switch-client -t $PROJECT_NAME\; source-file $CONFIG_FILE\;"
          tmux new -d -s $PROJECT_NAME -n $PROJECT_NAME; tmux switch-client -t $PROJECT_NAME\; source-file $CONFIG_FILE\;
        else
          echo "tmux new -s $PROJECT_NAME -n $PROJECT_NAME \; source-file $CONFIG_FILE\;"
          tmux new -s $PROJECT_NAME -n $PROJECT_NAME \; source-file $CONFIG_FILE\;
        fi

  fi
}

if test "$#" == '0'  ;then toolmux "$HOME" ;fi
if test "$#" == '1' && test -d $1 || tmux has-session -t $1 ;then toolmux "$1"; else help; fi
