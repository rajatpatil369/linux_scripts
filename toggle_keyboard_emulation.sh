# in bash, string wrapped with single qutoes meams a string literal
# where as bash will try to interprete whatever is written in double quotes
# putting double quotes arounf command subsitution or any string comparision is a good practive and is helpful in particular when comparing with empty strings, like so: "$2" = ''
# file redirection operator: > overwites existing file, >> appends to existing file; if file does exist new one is created

# problem: when num lock goes from on to off state, its not getting detectes, else clause doesn't execute
# probable cause: before the "xset q" command's output gets udated, the script catches old value of numlock, which is on
# solution: delay, give the system some time to register the key state
sleep 0.08  # 80ms

# helpful in getting what's going on
#echo "num lock status: `xset q | grep 'Num Lock:' | awk '{print $8}'`" > numlock

if [ "`xset q | grep 'Num Lock:' | awk '{print $8}'`" = 'on' ]; then
    #echo 'turning OFF mouse keys...' >> numlock
    xkbset -m # turn off mouse keys
else
    #echo 'turning ON mouse keys...' >> numlock
    xkbset m # turn on mouse keys
fi

# checks if mouse keys are "on" or "off"
#echo "mouse keys: `xset q | grep 'Mouse Keys:' | awk '{print $8}'`" >> numlock
