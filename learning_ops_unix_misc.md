---
path: "/learnings/ops_unix_misc"
title: "Learnings: Unix: Misc"
---

# Unix (Misc)

## Getting Information about running processes ( <<Learning_Ops_Unix_Running_Process_Information>> )

See: `/proc/$PID/`

### where the running process lives on the file system

`ls -la /proc/$PID/exe`  # <-- it's a symlink to the application location

### the entire command issued

`cat proc/$PID/cmdline`  # <-- it's a file containing the command

## Debugging what's going on with your kernel 

https://github.com/iovisor/bcc <-- toolkit for creating kernel tracing programs. Also serves as an awesome list for programs written

## Examining mount points <<Learning_Ops_Unix_Mount_Points>>

Unix lets you mount external volumes onto folder paths.

`mount -l` lists all `/dev/NAME` mounts on `/what/path/it/maps/to`.

Configuring mounts

`$ cat /etc/fstab`

## File Handle Limits <<Learning_Ops_Unix_File_Handle_Limits>>
[Q: How many file descriptors am I using now?](https://www.cyberciti.biz/tips/linux-procfs-file-descriptors.html)

[RHEL / Centos Ulimit / max number of open files](https://tuxgen.blogspot.com/2014/01/centosrhel-ulimit-and-maximum-number-of.html)

[Ubuntu: setting file limits for all users (or not)](https://serverfault.com/a/570560/91037)
