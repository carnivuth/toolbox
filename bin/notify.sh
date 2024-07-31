#!/bin/bash
ENDPOINT='https://pokelab.ddns.net/ntfy/'

notify(){
  TOPIC="$1"
  shift
  COMMAND="$@"
  OUTPUT="$(mktemp)"
  echo "$OUTPUT"
  eval "$COMMAND" 2>&1 | tee "$OUTPUT"
  RESULT="$?"

  if [[ "$RESULT" == 0 ]]; then
    curl "$ENDPOINT/$TOPIC" \
            -X POST \
            -H "Title: SUCCESS $COMMAND" \
            -H "Filename: $OUTPUT" \
            -T "$OUTPUT"
  else
    curl "$ENDPOINT/$TOPIC" \
            -X POST \
            -H "Title: FAILURE $COMMAND" \
            -H "Filename: $OUTPUT" \
            -T "$OUTPUT"
  fi
}

help(){
  echo "usage $O -t TOPIC COMMAND "
}

if [[ "$#" -lt "3" ]]; then
  echo "error wrong parameters"
  help
  exit 1
fi

# get option parameters
while getopts t: flag; do
  case "${flag}" in
    t)
      TOPIC=${OPTARG}
      shift
      shift
      ;;
  esac
done

if [[ "$TOPIC" == '' ]]; then
  echo "no topic provided"
  help
  exit 1
fi

notify "$TOPIC" "$@"
