---
path: "/learnings/ops_unix_misc"
title: "Learnings: Unix: Misc"
---

# Learning Operations: Unix (Misc)

## Getting Information about running processes ( <<Learning_Ops_Unix_Running_Process_Information>> )

See: `/proc/$PID/`

### where the running process lives on the file system

`ls -la /proc/$PID/exe`  # <-- it's a symlink to the application location

### the entire command issued

`cat proc/$PID/cmdline`  # <-- it's a file containing the command

## Debugging what's going on with your kernel 

https://github.com/iovisor/bcc <-- toolkit for creating kernel tracing programs. Also serves as an awesome list for programs written

