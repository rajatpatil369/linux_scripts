#!/bin/bash

/home/rajat/src/Telegram/Telegram

opacity="0x$(printf "%02X" $(printf "%.0f" $(echo "scale=0; $1*255" | bc)))FFFFFF"
#echo $opacity

# get te id of the window by name
window_id=$(xwininfo -root -tree | grep '"Telegram": ("Telegram" "TelegramDesktop") ' | awk '{print $1}')
#echo $window_id

# set the opacity
xprop -id $window_id -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY $opacity
