---
path: "/learnings/docker"
title: "Learnings: Docker"
---

# <<Learning_Docker>>

## Docker Storage <<Learning_Docker_Storage>>

### Docker Storage / Overlay Mount Types <<Learning_Docker_Storage_Types>>

| Name                   | Desc                          |
|:---------------------- |:----------------------------- |
| Volumes                | what you know and love        |
| Bind mounts            |                               |
| tmpfs                  | RAM Disks for Docker!!!!! (... or virtual RAM disks, depending on the wills of Learning_Ops_Unix_Virtual_Memory_kswapd ). Only works on Linux / Unix containers, not Windows. Can not be shared across containers. |


### Writing Data in your container for state <<Learning_Docker_Storage_In_Container_State>>

Normally, the top-most layer of a Docker image is read+write. You can treat this as a normal file system.

Remember:

  * Data written here will go away when container restarted - only store re-creatable data or state here
  * Could [docker commit](https://docs.docker.com/engine/reference/commandline/commit/#options) to save these changes into a new, read-only later.

> The major difference between a container and an image is the top writable layer. All writes to the container that add new or modify existing data are stored in this writable layer. When the container is deleted, the writable layer is also deleted. 

- [Source](https://docs.docker.com/storage/storagedriver/#images-and-layers)

#### Where everything is stored on the Docker host  <<Learning_Docker_Storage_Where_It_All_Is>>

`docker info` <-- Storage driver

`/var/lib/docker` <-- ls

	$ ls -la /var/lib/docker
	drwx--x--x 12 root root  4096 Dec 13 10:57 .
	drwxr-xr-x 22 root root  4096 Mar 19 03:40 ..
	drwx------  4 root root  4096 Mar  3 00:31 containers
	drwx------  3 root root  4096 Nov 14 14:33 image
	drwx------  2 root root 16384 Nov 14 14:32 lost+found
	drwxr-x---  3 root root  4096 Nov 14 14:33 network
	drwx------ 21 root root  4096 Mar  3 00:58 overlay2
	drwx------  4 root root  4096 Nov 14 14:33 plugins
	drwx------  2 root root  4096 Nov 14 14:33 swarm
	drwx------  2 root root  4096 Mar  2 21:30 tmp
	drwx------  2 root root  4096 Nov 14 14:33 trust
	drwx------  2 root root  4096 Nov 14 14:33 volumes

This Docker host uses overlay2 as a storage driver, so layers will be in `/var/lib/docker/overlay2`.

See also:

  * Q: "So... what volume does /var/lib/docker live on?" 
    A: See Learning_Ops_Unix_Mount_Points

##### Using a folder not `/var/lib/docker`

you can use `docker daemon -g` / the [graph parameter in daemon.json](https://docs.docker.com/v1.11/engine/reference/commandline/daemon/#daemon-configuration-file).

See also:

  * [Stackoverflow: How to change the docker image installation directory](https://stackoverflow.com/questions/24309526/how-to-change-the-docker-image-installation-directory)
  

## Docker Networking <<Learning_Docker_Networking>>

### And Using Docker Networks to join two Docker Compose Clusters <<Learning_Docker_Networking_Compose>>

Docker Compose boots [a separate network](https://docs.docker.com/compose/networking/) for each Docker compose cluster you are running. Thus if you `docker-compose up` with two separate docker-compose.yml, these two clusters will not be able to talk to each other.

Thus you want your infrastructure in one Docker Compose, and your app in another Docker compose... but the apps need to talk to the services (and each Docker Compose is in a seperate network that don't talk to each other).

In Docker Compose file

First, define the network at all (this is a top level key):

    networks:
      MY_NETWORK_NAME:
        driver: bridge


NOTE: this will be prefixed by the (same name the docker images are prefixed with). If you don't want this, create the networks externally, like so:


    networks:
      MY_NETWORK_NAME:
        external:
            name: MY_NETWORK_NAME


then in the services section define what network this is on

    services:
      my_thing:
        networks:
          - network_one
          - network_two

  


