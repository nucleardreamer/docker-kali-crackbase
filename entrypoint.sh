#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo ""
  echo "  Usage:"
  echo ""
  echo $"    $0 mkimg <device> <name>                 "
  echo ""
  exit 1
fi

case $1 in
  mkimg)
    exec dcfldd if=${2} hash=md5 of=/output/${3} bs=512
    ;;
esac
