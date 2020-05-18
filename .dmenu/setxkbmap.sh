#!/bin/bash

declare options=("br
us")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Keymap: ')

case "$choice" in
  br)
    setxkbmap br
  ;;
  us)
    setxkbmap us -variant alt-intl
  ;;
  *)
    exit 1
  ;;
esac

