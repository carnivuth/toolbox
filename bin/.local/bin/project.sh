#!/bin/bash

DEPS='tmux vim'
SECOND_WINDOW_NAME="worker"
MAIN_WINDOW_NAME="vim"

help(){
  echo "Usage $0 [project folder]"
  echo "open default tmux configuration in the given folder"
  echo "Usage $0 -k [project folder]"
  echo "kill tmux session with this name"
}

checks(){

  # check if deps are installed

  for dep in $DEPS; do
    [ ! -x "$(which "$dep")" ] && echo "$dep" binary not found  && return 1
  done

  # avoid nested sessions
  [ -n "$TMUX" ] && echo already in a tmux session  && return 1

  # check for wrong project parameters
  [ "$1" != '' ] && [ "$(tmux ls | grep "$1" )" == '' ] && [ ! -d "$1" ] && [ ! -L "$1" ] && echo "$1 is not a folder nor a tmux session" && return 1
  return 0
}

kill(){

  checks "$1" || exit 1

  # set  variable based on parameters
  if [[ "$1" != '' ]]; then PROJECT_NAME="$(basename "$1")"; else PROJECT_NAME="$(basename "$(pwd)")";fi

  SESSION_STATUS="$(tmux ls | grep "^$PROJECT_NAME:")"

  if [[ "$SESSION_STATUS" != '' ]]; then
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

  # check if a todo file exists
  if [[ -f "$1/todo.md" ]]; then TODO_FILE="todo.md"; fi
  if [[ "$1" == '' ]] && [[ -f "todo.md" ]]; then TODO_FILE="todo.md"; fi

  SESSION_STATUS="$(tmux ls | grep "^$PROJECT_NAME:")"

  if [[ "$SESSION_STATUS" != '' ]]; then

      # if session already exists attach to the session
      tmux attach-session -t "$PROJECT_NAME"\; \
        select-window -t "$MAIN_WINDOW_NAME" \; \
          select-pane -t 0\; \
            bind -r h select-pane -L\; \
            bind -r k select-pane -U\; \
            bind -r j select-pane -D\; \
            bind -r l select-pane -R

    else

      # start a new session in the given directory
      if [[ "$1" != '' ]] && [[ -d "$1" ]]; then cd "$1" || exit 1; fi

      tmux new  -n "$MAIN_WINDOW_NAME" -s "$PROJECT_NAME" vim $TODO_FILE \; \
        split-window  -v -l 6 \; \
        new-window -n "$SECOND_WINDOW_NAME" \; \
        select-window -t "$MAIN_WINDOW_NAME" \; \
          select-pane -t 0\; \
            bind -r h select-pane -L\; \
            bind -r k select-pane -U\; \
            bind -r j select-pane -D\; \
            bind -r l select-pane -R
  fi

}

case $1 in
  -k)
    kill "$2"
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
