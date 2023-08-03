#!/usr/bin/python3

from subprocess import run

TO_FIND = "usb-Sony_Hard_Drive_4720451F2135-0:0 -> ../../sd"

command_ls = run(['ls', '-l', '/dev/disk/by-id'], capture_output=True)          # '-lF' ?
assert command_ls.returncode == 0
list_disks_by_id = command_ls.stdout.decode().splitlines()

command_mount = run(['mount', '-l'], capture_output=True)
assert command_mount.returncode == 0
mounted_devices = command_mount.stdout.decode().splitlines()

for n, l in enumerate(list_disks_by_id):
    if (i := l.find(TO_FIND)) != -1:
        assert len(l[i:]) - len(TO_FIND) == 1
        drive_letter = l[-1]
        assert list_disks_by_id[n + 1][i:] == f"{TO_FIND.replace(' ->', '-part1 ->')}{drive_letter}1"
        if len(list_disks_by_id) >= n + 3:                                      ####
            assert list_disks_by_id[n + 2].find(TO_FIND.split()[0]) == -1       ####
        print('INFO: Hard Drive is plugged in.')
        for dev in mounted_devices:
            if (i := dev.find(f'/dev/sd{drive_letter}1')) != -1:
                assert i == 0
                print('INFO: Unmounting the partition...\n      ', end='', flush=True)
                unmount_drive = run(['udisksctl', 'unmount', '-b', f'/dev/sd{drive_letter}1'])
                assert unmount_drive.returncode == 0
                break
        else:
            print('INFO: Hard Drive not mounted.')
        print('INFO: Powering off the drive...')
        power_off_drive = run(['udisksctl', 'power-off', '-b', f'/dev/sd{drive_letter}'])
        assert power_off_drive.returncode == 0
        print('      POWERED OFF.')
        break
else:
    print('INFO: Hard Drive is not plugged in (or probably is, but was powered off).')

