---
path: "/learnings/ops_docker"
title: "Learnings: Ops: Docker"
---

# <<Learning_Ops_Docker>>

`docker stats` <-- a top but for running containers (can also be one shot static, not live updating)

`docker inspec` <-- get instance IP's address, mac address, log path, etc etc.

<<VideoLessonsLearnedRunningDockerInProd>>
================================

Container Composition
----------------

limit layers: about 30+ things break. So think about this a bit...

one container = one responsibility
(not just a process

wait, lines in your Dockerfile = layers ??

logging your app's log files to Docker's log stuff

		ln -sf /dev/stdout /var/log/whatever.log

Phusion/baseimage-docker has syslog

constrain memory for containers, then use this to note memory hugs etc


Host configuration
-----------------
### Service Discovery

use an ambassador container when linking

Enable TLS for Docker (Swarm)

Use etcd, consul, zookeeper, etc etc


Operations Management
----------------------
### Standarization

Config, source and log locations should be standarized across containers
create a base image for your dockerfile to inherit from for your org

use Docker Compose for multi container setup for development. Some scheduler tools let you use this for production running too...

And Java
====================

See:

  * Java_In_Docker_Containers

# <<Learning_Ops_Docker_With_Scheduler>>

