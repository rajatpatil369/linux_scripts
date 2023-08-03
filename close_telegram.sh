# $(...) or `...` is command substitution, where the ouput of "...", i.e. command will be substritutes in place of "..."
# -v switch is of --inverted ouput, so grep will give anything that does NOT contain the pattern
# $2 is the 2nd column

kill `ps aux | grep Telegram | grep -v grep | awk '{print $2}'`
