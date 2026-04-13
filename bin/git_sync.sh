#!/bin/bash
function git_sync(){
  find "$SEARCH_DIR" -type d -name ".git" -prune -print 2>/dev/null | sed 's|/.git$||' | parallel 'echo "Syncing {}"; cd {} && git pull'
}

set -x
if test "$#" == '0' || [[ "$1" == '.' ]]  ;then echo "pass dir to search for"; exit 1; else SEARCH_DIR="$1"; fi
git_sync
