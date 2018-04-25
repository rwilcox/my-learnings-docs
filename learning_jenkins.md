---
path: "/learnings/jenkins"
title: "Learnings: Jenkins"
---


# Installing Jenkins on RHEL box

First, install Java 8... (see Cloud9InstallingJava8)

  1. Execute commands on: https://pkg.jenkins.io/redhat-stable/
  2. `$ sudo service jenkins start`
  3. In /etc/sysconfig/jenkins set `JENKINS_LISTEN_ADDRESS` to 127.0.0.1 (see: https://community.c9.io/t/cant-preview-in-aws-c9/23340/2)
  4. ???????


# <<Learning_Jenkins_Config_File_Location>>

    /etc/sysconfig/jenkins

See also:

  * https://stackoverflow.com/a/28481692/224334  <-- where this file is on the other distros

`JENKINS_LISTEN_ADDRESS` <-- defaults to 0.0.0.0

# Jenkins Concepts

## Master Node

has access to all data, config, options etc.
Not recommended you run jobs here

## (Build) Agents (Nodes)

Only a lightweight Jenkins agent installed here

## Executor

How many concurrent jobs can be run on that (agent)
