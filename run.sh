#!/bin/bash

set -ue

function usage () {
  cat <<EOF
Usage: $(basename "$0") -i input [OPTION]...
  -i          input
  -d          debug
  -h          display help
EOF
  exit 2
}

function existsCmd () {
    if ! type "$1" > /dev/null 2>&1; then
        echo "Please install $1 command.";
        exit 2;
    fi
}


INPUT=""

while getopts i:dh OPT
do
    case $OPT in
        i) INPUT="$OPTARG"
            ;;
        d) DEBUG=1
            ;;
        h|*) usage
            ;;
    esac
done

if [ -z $INPUT ]; then
    usage
fi

existsCmd jq

echo $INPUT | jq -r '.name'
