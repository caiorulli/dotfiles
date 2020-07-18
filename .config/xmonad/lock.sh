#!/usr/bin/env bash
set -euo pipefail

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D='#3B4252cc'  # default
T='#D8DEE9ee'  # text
W='#880000bb'  # wrong
V='#88C0D0bb'  # verifying

i3lock \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--insidewrongcolor=$C \
--ringwrongcolor=$W   \
\
--insidecolor=$B      \
--ringcolor=$D        \
--linecolor=$B        \
--separatorcolor=$D   \
\
--verifcolor=$T        \
--wrongcolor=$T        \
--timecolor=$T        \
--datecolor=$T        \
--layoutcolor=$T      \
--keyhlcolor=$W       \
--bshlcolor=$W        \
\
--screen 1            \
--blur 5              \
--clock               \
--indicator           \
--timestr="%H:%M:%S"  \
--datestr="%A, %m %Y" \
--keylayout 2         \
\
--time-font='Fantasque Sans Mono' \
--date-font='Fantasque Sans Mono' \
--layout-font='Fantasque Sans Mono' \
--verif-font='Fantasque Sans Mono' \
--wrong-font='Fantasque Sans Mono' \
--greeter-font='Fantasque Sans Mono' \
