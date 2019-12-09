#! /bin/sh

# set wallpaper
# feh --bg-scale /home/lialka/Pictures/wallpapers/tide.jpg
feh --bg-scale ~/Pictures/wallpapers/tide.jpg

# enable X manager
xcompmgr &

# time
dte() {
    dte="$(date "+%Y-%m-%d | 🕒 %H:%M")"
    echo -e "$dte"
 }

# memory usage
mem() {
    mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 /1024.0}'`
    echo -e "🖪 $mem"
}

# cpu usage
cpu() {
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 1
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
     echo -e "💻 $cpu% cpu"
}

# display vars
while true; do
    xsetroot -name " $(cpu) | $(mem) | $(dte)"
    sleep 5s # refresh interval
done &

# load dwm in a loop
while true; do
    # Log stderror to a file 
    dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done

# exec /usr/local/bin/dwm
