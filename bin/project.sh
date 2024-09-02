#!/bin/bash
source "$HOME/.local/lib/is_ssh_session_or_root.sh"
SECOND_WINDOW_NAME="worker"

help(){
  echo "Usage $0 [project folder]"
  echo "open default tmux configuration in the given folder"
  echo "Usage $0 -k [project folder]"
  echo "kill tmux session with this name"
}

checks(){

  # avoid nested sessions
  [ -n "$TMUX" ] && echo already in a tmux session && return 1

  # check for wrong project parameters
  [ "$1" != '' ] && [ "$(tmux ls | grep "$1" )" == '' ] && [ ! -d "$1" ] && [ ! -L "$1" ] && echo "$1 is not a folder nor a tmux session" && return 1
  return 0
}

kill_project(){

  checks "$1" || exit 1

  # set  variable based on parameters
  if [[ "$1" != '' ]]; then PROJECT_NAME="$(basename "$1")"; else PROJECT_NAME="$(basename "$(pwd)")";fi

  if tmux has-session -t "$PROJECT_NAME" > /dev/null 2>&1 ; then
    # kill if session exists
    tmux kill-session -t "$PROJECT_NAME"
    echo "session $PROJECT_NAME killed"
  else
    echo "session $PROJECT_NAME does not exists"
  fi

}

open_project(){

  # do checks
  checks "$1" || exit 1

  # set  variable based on parameters
  if [[ "$1" != '' ]]; then PROJECT_NAME="$(basename "$1")"; else PROJECT_NAME="$(basename "$(pwd)")";fi
  if [[ "$1" == '.' ]]; then PROJECT_NAME="$(basename "$(pwd)")";fi



  export TERM=xterm-256color
  if tmux has-session -t "$PROJECT_NAME" > /dev/null 2>&1 ; then

      # if session already exists attach to the session
      tmux attach-session -t "$PROJECT_NAME"\; \
        select-window -t "$EDITOR" \; \
          select-pane -t 0 \;
          else
            # start a new session in the given directory
            if [[ "$1" != '' ]] && [[ -d "$1" ]]; then cd "$1" || exit 1; fi
            tmux new  -n  "$EDITOR" -s "$PROJECT_NAME"  "$EDITOR" \;  set -w remain-on-exit on \; \
              new-window -n "$SECOND_WINDOW_NAME" \; \
              split-window  -h \; \
              select-window -t "$EDITOR" \; \
                select-pane -t 0 \;

  fi
}

if is_ssh_session_or_root; then EDITOR=vim; else EDITOR=nvim; fi

case $1 in
  -k)
    kill_project "$2"
    ;;
  -h)
    help
    ;;
  --help)
    help
    ;;
  *)
    open_project "$1"
    ;;
esac
