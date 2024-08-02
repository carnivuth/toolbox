#!/bin/bash
git diff --name-only \| fzf --cycle --multi --preview 'git diff {}' \| xargs git add
get_elements(){
  echo "$(git diff --name-only | fzf --cycle --multi --preview 'git diff {}')"
}
selected=$(get_elements)
if [[ "$selected" != "" ]]; then
  git add "$selected"
fi
