#!/bin/bash
WORKSPACE="worker"

function help(){
  echo "Usage $0 [project folder]"
  echo "  open default tmux configuration in the given folder"
}

function toolmux(){

  # exit if no parameter is given
  test "$#" == '0' && echo "error, no parameter given, run $0 with an existing dir or a tmux session" && help && exit 1;

  # set  variable based on parameters
  PROJECT_NAME="$(basename "$1")"

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
          tmux new -d -s $PROJECT_NAME -n $PROJECT_NAME; tmux switch-client -t $PROJECT_NAME\; source-file $CONFIG_FILE\;
        else
          tmux new -s $PROJECT_NAME -n $PROJECT_NAME \; source-file $CONFIG_FILE\;
        fi

  fi
}

# if executed without arguments or with curdir `.` run with pwd as argument
if test "$#" == '0' || [[ "$1" == '.' ]]  ;then toolmux "$(pwd)" ;fi

# when launched with an argument test if it is a dir or an active tmux session and execute function
if test "$#" == '1' && test -d $1 || tmux has-session -t $1 ;then toolmux "$1"; else help; fi
