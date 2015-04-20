#!/bin/sh

if test "$#" -lt 1 -o "$1" = "help";  then
  echo "available commands:"
  echo
  echo "  help"
  exit 0
fi

cmd=$1
shift

if test -f "/mesos/${cmd}.sh";  then
  exec /mesos/${cmd}.sh "$@"
else
  echo "unknown command: $cmd"
  exit 0
fi
