#!/bin/bash
function git_sync(){
  find "$SEARCH_DIR" -type d -name ".git" -prune -print 2>/dev/null | sed 's|/.git$||' | parallel -j $(nproc) 'echo "Syncing {}"; cd {} && git pull'
}

if test "$#" == '0' || [[ "$1" == '.' ]]  ;then SEARCH_DIR="$(pwd)"; else SEARCH_DIR="$1"; fi
git_sync
