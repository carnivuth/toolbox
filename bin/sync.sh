#!/bin/bash

# synchronize dir content with remote for testing with VM's this is useful to avoid mounting remote filesystem with sshfs or similar solutions.
# ssh need to be cofigured for the remote host to sync

REMOTE="$1"
TARGET_FILES="."

if [[ $# -ne 1 ]]; then echo "Usage: $0 <remote_host>"; exit 1; fi
if ! ping -c 1 -W 1 "$1" > /dev/null; then echo "Error: Remote host '$1' is not reachable."; exit 1; fi

# monitor for move_self and create cause vim deletes original file and rename swapfile
inotifywait \
--monitor  \
--event move_self \
--event create \
--recursive \
--exclude "$(find .  -name '.git' -type d -printf '%P|').*\.aux|.*\.bbl|.*\.bcf|.*\.bcf-SAVE-ERROR|.*\.blg|.*\.fdb_latexmk|.*\.fls|.*\.idx|.*\.ilg|.*\.ind|.*\.log|.*\.out|.*\.pdf|.*\.run" \
--format "%w %e %f" $TARGET_FILES | while read file event newfile; do

# syncronize with remote host deleting remote files with local ones
rsync -avr --delete . ${REMOTE}:~/$(basename $(pwd) )

done
