#!/bin/bash

HELP_MSG="usage $O -t TOPIC -c COMMAND "

# run command an send notification
notify(){
  OUTPUT="$(mktemp)"
  echo "$OUTPUT"
  eval "$COMMAND" 2>&1 | tee "$OUTPUT"
  RESULT="$?"

  if [[ "$RESULT" == 0 ]]; then
    curl "$NOTIFY_ENDPOINT/$TOPIC" \
      -X POST \
      -H "Title: SUCCESS command on $HOSTNAME completed"
  else
    curl "$NOTIFY_ENDPOINT/$TOPIC" \
      -X POST \
      -H "Title: ERROR command on $HOSTNAME has failed"
  fi
}

# get option parameters
while getopts t:c: flag; do
  case "${flag}" in
    t)
      TOPIC=${OPTARG}
      ;;
    c)
      COMMAND=${OPTARG}
      ;;
  esac
done

# checks on vars
if [[ -z $NOTIFY_ENDPOINT ]];then echo 'no endpoint set, run export NOTIFY_ENDPOINT=<ENDPOINT>'; exit 1; fi
if [[ -z $TOPIC ]]; then echo -e "no topic provided\n$HELP_MSG"; exit 1; fi
if [[ -z $COMMAND ]]; then echo -e "no command provided\n$HELP_MSG"; exit 1; fi

notify
