#!/bin/bash
selected=$(git ls-files --exclude-standard -mo | fzf --cycle --multi --preview 'git diff {}')

if [[ "$selected" != "" ]]; then
  git add "$selected"
  echo "added $selected files for commit"
fi
