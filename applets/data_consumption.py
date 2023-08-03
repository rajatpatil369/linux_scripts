#!/usr/bin/env python3

import subprocess

r = subprocess.run(['ip', '-s', 'link', 'show', 'wlp2s0'], capture_output=True)
op = r.stdout.decode().splitlines()

'''
r_flag, t_flag = True, True

total_rx = int(op[-3].strip().split()[0]) / 1024 ** 2
if total_rx > 999:
    r_flag = False
    total_rx /= 1024
total_tx = int(op[-1].strip().split()[0]) / 1024 ** 2
if total_tx > 999:
    t_flag = False
    total_rx /= 1024

print(f"{total_rx:.1f}{'M' if r_flag else 'G'}⥥ {total_tx:.1f}{'M' if t_flag else 'G'}⥣")
'''

# in GiB
total_rx = int(op[-3].strip().split()[0]) / 1024 ** 3
total_tx = int(op[-1].strip().split()[0]) / 1024 ** 3

print(f"{total_rx:.3f}⮟ {total_tx:.3f}⮝")

'''
⮟⮝
⭱⭳
⯅⯆
⭫⭭
⮉⮋
🡡🡣
🠅🠇
🠙🠛
🠕🠗
↑↓
⮅⮇
🢕🢗
↟ ↡
 🢑 🢓

'''

# ip -s -h -c -j link show dev wlp2s0
