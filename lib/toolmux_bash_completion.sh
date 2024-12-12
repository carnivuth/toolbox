#!/bin/bash
# tmux session tab complete function
_tmux_complete_session() {
  local IFS=$'\n'
  local cur=${COMP_WORDS[COMP_CWORD]}
  if ps aux | awk -F' ' '{print $11}' | grep -qe tmux; then
  COMPREPLY=( ${COMPREPLY[@]:-} $(compgen -W "$(tmux -q list-sessions | cut -f 1 -d ':')" -- "${cur}") )
  fi
}
complete -A directory -F _tmux_complete_session tmx
complete -A directory -F _tmux_complete_session toolmux.sh
