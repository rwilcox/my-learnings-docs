---
path: "/learnings/ops_docker"
title: "Learnings: Ops: Docker"
---

# <<Learning_Ops_Docker>>

`docker stats` <-- a top but for running containers (can also be one shot static, not live updating)

`docker inspect` <-- get instance IP's address, mac address, log path, etc etc.

`docker info` <-- information from the docker daemon: number of containers running, plugins, storage drivers, etc

See also:

  * Learning_Docker_Storage_Where_It_All_Is

`<<VideoLessonsLearnedRunningDockerInProd>>`
================================

Container Composition
----------------

limit layers: about 30+ things break. So think about this a bit...

one container = one responsibility
(not just a process

Q: wait, lines in your Dockerfile = layers ??
A: YUPPP!!! That's how it works!

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

# And Memory <<Learning_Ops_Docker_Memory>>

## Kernel Memory on monolithic containers / kernels in images

> Kernel memory constraints
> Kernel memory is fundamentally different than user memory as kernel memory can’t be swapped out. The inability to swap makes it possible for the container to block system services by consuming too much kernel memory. Kernel memory includes：
> 
> stack pages
> slab pages
> sockets memory pressure
> tcp memory pressure
> You can setup kernel memory limit to constrain these kinds of memory. For example, every process consumes some stack pages. By limiting kernel memory, you can prevent new processes from being created when the kernel memory usage is too high.
> 
> Kernel memory is never completely independent of user memory. Instead, you limit kernel memory in the context of the user memory limit.

- [Docker documentation on docker run](https://docs.docker.com/engine/reference/run/#kernel-memory-constraints)

## and guest and host both doing page caching <<Learning_Ops_Docker_Page_Cache_Double_Cache>>

See paper Page/slab cache control in a virtualized environment

Q: if both containe and host are doing caching for commonly used files, will this create OOM conditions faster, or cause the container to run out of memory not because of app memory but because of page cache memory?


# <<Learning_Ops_Docker_With_Scheduler>>
