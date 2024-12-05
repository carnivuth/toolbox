#!/bin/bash
# tmux session tab complete function
_tmux_complete_session() {
  local IFS=$'\n'
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( ${COMPREPLY[@]:-} $(compgen -W "$(tmux -q list-sessions | cut -f 1 -d ':')" -- "${cur}") )
}
complete -A directory -F _tmux_complete_session tmx
complete -A directory -F _tmux_complete_session toolmux.sh
