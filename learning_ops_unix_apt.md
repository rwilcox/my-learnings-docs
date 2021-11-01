---
path: /learnings/ops_unix_apt
title: 'Learnings: Ops: Unix: APT'
---
# And `apt-secure`

Apt now does security checking at a couple different levels:

  1. Wants repos to have a signed RELEASE file in them
  2. Does SSL key validation

## Disable insecure repos this one time:

$ sudo apt-get -o Acquire::AllowInsecureRepositories=true update

## Setting apt config file to allow this

See [a stackexchange answer on setting up /etc/apt/apt.conf](https://unix.stackexchange.com/a/317708/193798).



