#!/bin/bash
ENDPOINT='https://pokelab.ddns.net/ntfy/'

notify(){
  TOPIC="$1"
  shift
  COMMAND="$@"
  eval "$COMMAND" && curl "$ENDPOINT/$TOPIC" -d "SUCCESS $COMMAND" -X POST || curl "$ENDPOINT/$TOPIC" -d "FAILURE $COMMAND" -X POST
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
