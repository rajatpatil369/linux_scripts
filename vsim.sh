#!/bin/bash

# sudo apt install iverilog gtkwave

# usage:
# vsim <path_to_verilog_file> [-d]
# `-d` (optional): display waveforms using `gtkwave`

# directory structure:
# ├── `module_name`.v             # input   <- "verilog_file"
# ├── `module_name`_tb.v          # input
# ╞══ `module_name`.vcd           # output
# ╘══ a.out                       # output
# file naming convention used: `module_name` is the name of the "main" MODULE

dir_name=${1%/*}
file_name=${1##*/}
if [ $dir_name == $file_name ]; then
    dir_name='.'
fi
module_name=${file_name%.v}

set -o errexit

cd $dir_name
iverilog $module_name.v ${module_name}_tb.v
vvp a.out
if [ "$2" == "-d" ]; then
    gtkwave $module_name.vcd
fi
