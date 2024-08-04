#!/bin/bash
show_menu(){
  echo "$( git ls-files --exclude-standard -mo | fzf --cycle --multi --preview 'git diff {}')"
}

selected=$(show_menu)

if [[ "$selected" != "" ]]; then
  git add "$selected"
  echo "added $selected files for commit"
fi
