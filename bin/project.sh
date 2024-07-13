#!/bin/bash

DEPS="vim tmux"

help(){
        echo "Usage $0 [project folder]"
        echo "open default tmux configuration in the given folder"
}

checks(){

  # check if tmux is installed
  [ ! -x "$(which tmux)" ] && echo tmux binary not found  && return 1

  # avoid nested sessions
  [ -n "$TMUX" ] && echo already in a tmux session  && return 1

  # check for wrong project parameters
  [ "$1" != '' ] && [ "$(tmux ls | grep "$1" )" == '' ] && [ ! -d "$1" ] && [ ! -L "$1" ] && echo "$1 is not a folder nor a tmux session" && return 1
  return 0
}

open_project(){

  # do checks
  checks "$1" || exit 1


  # set  variable based on parameters
  if [[ "$1" != '' ]]; then PROJECT_NAME="$(basename "$1")"; else PROJECT_NAME="$(basename "$(pwd)")";fi

    SESSION_STATUS="$(tmux ls | grep "$PROJECT_NAME")"

    if [[ "$SESSION_STATUS" != '' ]]; then

      # if session already exists attach to the session
      tmux attach-session -t "$PROJECT_NAME"\; \
      selectp -t 0 \; \
      bind -r h select-pane -L\; \
      bind -r k select-pane -U\; \
      bind -r j select-pane -D\; \
      bind -r l select-pane -R

    else

      # start a new session in the given directory
      [[ -d "$1" ]] && cd "$1"
      tmux new  -s "$PROJECT_NAME" vim \; \
      split-window  -v -l 6 \; \
      selectp -t 0\; \
      bind -r h select-pane -L\; \
      bind -r k select-pane -U\; \
      bind -r j select-pane -D\; \
      bind -r l select-pane -R
    fi

}

case $1 in
    -h)
       help
       ;;
    --help)
       help
       ;;
    *)
       open_project $1
       ;;
esac
