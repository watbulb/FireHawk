#!/bin/bash

f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
d=$'\e[1m'
t=$'\e[0m'
v=$'\e[7m'

# Time and date
time=$( date "+%H.%M")
date=$( date "+%a %d %b" )

# OS
OS=$(uname -r)
bit=$(uname -m)

# Other
uptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
ram=$(expr $memkb / 1024)

cat << EOF
$f3$d
$f3 ______                _   _                   _
$f3 |  ___|(_) _ __  ___ | | | |  __ _ __      __| | __
$f3 | |_   | || ___|/ _ \| |_| | / __ |\ \ /\ / /| |/ /
$f3 |  _|  | || |  |  __/|  _  || (_| | \ V  V / |   <
$f3 |_|    |_||_|   \___||_| |_| \__,_|  \_/\_/  |_|\_\
$f3
$f6             $USER $f7@ $f1$HOSTNAME
$f6            $H $f4$time$NC - $f7$date
$f6             $f2$ram$f7 MB Memory
$f6              uptime: $f2$uptime
EOF
