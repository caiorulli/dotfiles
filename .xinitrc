#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Keymap setup
setxkbmap br

~/.fehbg
picom &
unclutter &

# DWM bar script
dwm_corona_cases() {
  cases="$(curl https://corona-stats.online/BR\?format=json | jq '.data[0].cases') cases"
  echo "$cases";
}

dwm_corona_deaths() {
  deaths="$(curl https://corona-stats.online/BR\?format=json | jq '.data[0].deaths') deaths"
  echo "$deaths";
}

dwm_battery(){
  cat /sys/class/power_supply/BAT0/capacity
}

dwm_date(){
  date '+%d/%m/%Y %H:%M'
}

dwm_weather(){
  curl wttr.in/Sao_Paulo?format=1
}

while true; do
  xsetroot -name " $(dwm_weather) | $(dwm_corona_cases) | $(dwm_corona_deaths) | $(dwm_battery)% | $(dwm_date) "
  sleep 1m
done &

exec dwm
