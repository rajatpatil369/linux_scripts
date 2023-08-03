#!/bin/bash

# in KB/s
ifstat -i wlp2s0 0.2 1 | tail -n 1 | awk '{ printf("%4.0f⭳ %4.0f⭱", $1, $2) }'
