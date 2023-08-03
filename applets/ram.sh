#!/bin/bash

# free out of total
# free -h | grep 'Mem:' | awk '{ printf("%s/%s\n", $7, $3) }'

# used out of total
# free -h | grep 'Mem:' | awk '{ printf("%s/%s\n", $3, $2) }'

free -h | grep 'Mem:' | awk '{ print $7 }'
