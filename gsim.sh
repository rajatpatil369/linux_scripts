#!/bin/bash

# sudo apt install ghdl gtkwave

# usage:
# gsim <path_to_vhdl_file> [-d]
# `-d` (optional): display waveforms using `gtkwave`

# directory structure:
# ├── `entity_name`.vhd           # input   <- "vhdl_file"
# ├── `entity_name`_tb.vhd        # input
# ╞══ work-obj93.cf               # output
# ╘══ waveforms.vcd               # output
# file naming convention used: `entity_name` is the name of the "main" ENTITY

dir_name=${1%/*}
file_name=${1##*/}
if [ $dir_name == $file_name ]; then
    dir_name='.'
fi
entity_name=${file_name%.vhd}

set -o errexit

cd $dir_name
ghdl syntax $entity_name.vhd ${entity_name}_tb.vhd
ghdl analyse $entity_name.vhd ${entity_name}_tb.vhd
ghdl elaborate ${entity_name}_tb
ghdl run ${entity_name}_tb --vcd=waveforms.vcd
# ghdl elab-run ${entity_name}_tb --vcd=waveforms.vcd
if [ "$2" == "-d" ]; then
    gtkwave waveforms.vcd
fi
