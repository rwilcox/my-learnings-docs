---
path: /learnings/kubernetes
title: 'Learnings: Kubernetes'
---
# Table Of Contents

<!-- toc -->

- [Learning Kubertetes >](#learning-kubertetes--)
  * [Components](#components)
    + [Pods](#pods)
  * [Built in Capabilities](#built-in-capabilities)
    + [Service Discovery >](#service-discovery-)
    + [Load Balancing](#load-balancing)
    + [auto canery deploys](#auto-canery-deploys)
  * [Minikube](#minikube)
  * [Kubectl](#kubectl)
    + [Operations with Kubectl](#operations-with-kubectl)
    + [neat tips](#neat-tips)
      - [give me a junk container to just do stuff](#give-me-a-junk-container-to-just-do-stuff)
  * [API Server](#api-server)
  * [Pods](#pods-1)
    + [Volumes](#volumes)
      - [Abstracting away implementation of long term data storage](#abstracting-away-implementation-of-long-term-data-storage)
    + [And Service Discovery](#and-service-discovery)
      - [Notes:](#notes)
  * [Service Objects](#service-objects)
    + [Service Object Types >:](#service-object-types-)
    + [Jobs >](#jobs--)
    + [LoadBalancer](#loadbalancer)
      - [and Minikube](#and-minikube)
      - [And load balancing HTTP 1.1](#and-load-balancing-http-11)
      - [And your cluster (just) serving HTTP traffic](#and-your-cluster-just-serving-http-traffic)
    + [Replication Controller](#replication-controller)
    + [DaemonSets](#daemonsets)
    + [Deployments >](#deployments--)
    + [Services](#services)
    + [StatefulSets](#statefulsets)
    + [Nodes](#nodes)
  * [Operational Concerns](#operational-concerns)
    + [Application configuration](#application-configuration)
      - [Environmental Variables](#environmental-variables)
      - [ConfigMap](#configmap)
        * [Secrets >](#secrets-)
          + [>](#)
      - [operationally seeing WTF is in your configmap](#operationally-seeing-wtf-is-in-your-configmap)
    + [volume mounts](#volume-mounts)
    + [Pre launch tasks ("Init Containers") >](#pre-launch-tasks-init-containers-)
      - [Potential usage](#potential-usage)
    + [>](#)
      - [Operationally Debugging Init Containers](#operationally-debugging-init-containers)
    + [>](#)
    + [So how DOES the magic DNS stuff worked???](#so-how-does-the-magic-dns-stuff-worked)
  * [Configuring](#configuring)
  * [Health Checks](#health-checks)
  * [Questions](#questions)
  * [Service Catalog](#service-catalog)
  * [Additional Tools](#additional-tools)
  * [Networking](#networking)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

Learning Kubertetes  <<Learning_Kubertetes>>
==========================

Components
---------------

 * Master <-- contains etcd, api server, scheduler
   - note: scheduler may move "running" containers to reorg the cluster
 * workers <-- kublet, kube-proxy, container runtime


### Pods

Pod <-- set of co-located containers. A worker instance runs many pods. List pods, not containers.

A **pod template** can define how many replica pods to create for a container(s).

Seems like people conflate the word "pod" to mean, "pod template" and "pod instance" ????? The former is what you'd feed to ReplicationController / ReplicaSet, and the latter is what you get when you call `kubectl get pods`.

Built in Capabilities
------------------

### Service Discovery <<Kubernetes_Service_Discovery>>

  * (if asked?) all containers running same service can "share" same IP or DNS name <-- controlled via environmental variables

Performed via DNS or environmental variables.

### Load Balancing

If running on supported cloud platforms, can actually request additional instances in cluster if load scaling needs > current cluster size

### auto canery deploys

(hmm)

Minikube
-------------

download
`minikube start` <-- might take a while

Then install K8 client and run `kubectl`
`kubectl cluster-info` <-- should return useful info like DNS name to dashboard


`minikube dashboard` <-- opens up dashboard in your default browser

## Kubectl

"Just" sends REST commands to master.

kubectl has bash and zsh tab completions!!

`kubectrl get -o ` <-- -o will output the YAML description of that print Object

`kubectrl edit RESOURCE NAME` <-- will pop open your editor, and then when save/quit it will post the file back to the API server.

`kubectrl exec` <--- how to get into the container(s) of a pod.


### Operations with Kubectl

    $ kubectl get services # <-- gets the services aka the routing rules
    $ kubectl get pods     # <-- gets the deployed pods and information about them (for the services)
    $ kubectl logs $PODNAME # <-- logs from the thing

### neat tips

    kubectl get pods,deployments # list TWO resources at a time

#### give me a junk container to just do stuff

    kubectl run -it—image=$SOMEDOCKERIMAGE—restart=never /bin/sh


  (But you will need to delete the pod when you exit the container, k8s will not do thst cleanup for you )

API Server
---------

Configuration often done by YAML (and behind the scenes kubectl is POSTing it into)... but can also mbe JSON.

**Think of YAML as a representation of the request body** <-- RESTful, and not just on outputted document formats!!!

Pods
-----------

Each pod gets own internal IP addresss.

Pods also = instances of container or group of containers.

Does NOT span worker instances.

Can tell pod to do port forwarding without using a load balancer.

Can use labels on (pods, workers) to act on things as a bunch, or schedule based on capabilities of workers instances (big GPUs, etc).

Can also namespace objects.

Can also have `init` containers that run before the other containers ie to lay some required files and stuff down.

### Volumes

Can be configured with a volume that is an auto-checked-out git repo. (just not a private one! Use a git sidecar or something better like putting the files in the container...)

Remember if you set a volume to be a folder on the node, if the node goes away or gets rescheduled you won't have that data. Use your cloud providers elastic block storage long term file systems for that.

it also knows about Amazon EBS and Azure's disk/file stuff too.

#### Abstracting away implementation of long term data storage

can use a `PersistentVolumeClaim` to use a `PersistentVolume` set up by your k8 cluster admin.

**NOTE**: the location etc of this volume is the same across all of the instances of that pod template. This may or may not be a good idea (databases).

### And Service Discovery

on init k8 sets environmental variables pointing to each service that exists in the moment.
(ie if service is called odyssey-database ODYSSEY_DATABASE_SERVICE_HOST and ODYSSEY_DATABASE_SERVICE_PORT).

OR

provides a DNS server: odyssey-database.default.svc.cluster.local
^^^ default above is the k8 namespace the service is in!!!
(svc.cluster.local is the default domain in the pods, so you could refer to it by domain name of only `odyssey-database`)!!

#### Notes:

  * ping won't work <-- because of the virtual IP magic.
  * can also use this to abstract where resources live: maybe even outside the k8 cluster!!!

Service Objects
----------

    $ kubectl expose replicationcontroller MYREPLICATIONCONTROLLER --type=

### Service Object Types <<Learning_Kubertetes_Service_Object_Types>>:

### Jobs  <<Kubernetes_Jobs>>

Runs a pod but don't restart the container when the container quits success. (failure causes re-schedule).

Can have parallelism and number of completions

Also can configure CronJobs.

### LoadBalancer

Remember that each pod (instance) has its own IP address. Need to use load balancer so other services can address the pods as if they are one.

AND/OR you want a consistent IP address for a pod - ie a single IP for your database pod, regardless of pods moving around as they die or are scheduled away.

(can also tell load balancer to just return IP addresses of a pod, instead of using the one external one. It will return multiple A records, so if you're good with DIG you can get all the IP addresses of all the pod instances you have). (set `clusterIP` to None).

#### and Minikube

Creating load balancer will not create an external IP for you, but you can use `kubectl describe MY-LOAD-BALANCER-SERVICE` to get the port it's running on, then just use that port.

MEANING: because Minikube doesn't support creating external IP addresses it WILL act like it's super class, NodePort.

#### And load balancing HTTP 1.1

Keep-Alive will just send to the same pod as it used the first time...

#### And your cluster (just) serving HTTP traffic

Instead of needing to set up a public load balancer that sits in front of your k8 loadbalancer service, can create an `Ingess` service. This will look at PATH or domain name to figure out where to send the request. Also supports cookies as it works on Layer 7.

Ingress load balancers also terminate SSL traffic.

There’s also ClusterIp and NodePort kinds. see (NodePort Vs ClusterIP Vs LoadBalancer Vs Ingress)[https://medium.com/google-cloud/kubernetes-nodeport-vs-loadbalancer-vs-ingress-when-should-i-use-what-922f010849e0]

### Replication Controller

Want to create ReplicationController objects to manage pods - just creating pods directly will assign them to a node directly, and if the node goes down your pod will not be recreated.

Pods created by an application controller aren't tied to their creating replication controller.

Give ReplicationController a set of labels to manage pods that have that label.

You can relabel a pod to make the replication controller spin up a new one, then you could (say) examine it for what went wrong.

**Technically deprecated, prefer ReplicaSets and/or Deployments instead**

### DaemonSets

Runs one replica of a pod on every worker instance.

### Deployments  <<Kubernetes_Deployments>>

Creates ReplicaSets, but takes care of (rolling, or however you configure them) deployments.

Also provides `rollout undo` option!

Can do `pause` to halt rollback ie for canary deploys.

    kubectl get deployments -a # get all deploys across cluster
    kubectl describe deployment $deploymentname


### Services

    kubectl get svc

    kubectl describe service $servicename

### StatefulSets

Like ReplicaSets, but can:

  * preserve network identity (well... not the IP...)
  * have seperate storages for each pod (instance)
  * boot up one at a time

To use you need a `Service` (at least). Need to create headless.

StatefulSet instances are found by SRV DNS entries.

When stateful pods fail need to have an admin go in and delete the pod - then another (identical!) pod will take its place.

### Nodes

## Operational Concerns


### Application configuration

#### Environmental Variables

Have to set for each container in the pod (no such thing as pod wide settings).

Can also pass info about the container downward.

<<Kubernetes_Environmental_Configuration>>

Can use `env` block and create  variables that looks at `metadata.namespace`, for example. K8 will introspect and pass that info downward.

Can even pass cluster name, etc etc downward.

**NOTE**: can **NOT** use environmental variables for labels or annotations - these must be written to injected volumes. (because these may change!)

#### ConfigMap

Can create `ConfigMap` resources to hold config. Can reference these variables in `env` setting (special keys for this) one by one, have k8 put all of them in there (prefixed by something), use it to override `args` entry for container. Can also have mounted volume created to hold file version of these so your app can read it (including just mounting specific files so you don't blow away real directory mounting a Docker volume into /etc!)

##### Secrets <<Learning_Kubernetes_Secrets>>

Yup, k8 has them (essentially as a subclass of `ConfigMap`).

[Integration with Vault via K8 Service Account Token](https://www.vaultproject.io/docs/auth/kubernetes.html)

See also:

  * Learning_Ops_Vault
  * [A sample Rails app with secrets, K8, and Vault](https://medium.com/@gmaliar/dynamic-secrets-on-kubernetes-pods-using-vault-35d9094d169)


###### <<Kubernetes_Authenticating_With_Docker_Registry>>

Use a secret to do this! Builtin!

#### operationally seeing WTF is in your configmap


    kubectl get configmap $artifactName -o yaml

Without the -o yaml part you'll just see the name of the configmap, which is not super helpful.


### volume mounts



### Pre launch tasks ("Init Containers") <<K8s_Init_Containers>>

Run before the main pod is launched. Needs to execute its task then quit before the main container is launched (_not_ for long running tasks.)

Different file system from main container.

Can have multiple.

#### Potential usage

  1. Pull down a bash image to lay down some infrastructure / adjust something. But you don't want bash in your main container because of size limits... Then just do your work in the `command` part of the `initContainer` in your PodSpec.

### <<Learning_Kubernetes_Container_Lifecycle>>

container can define commands to run as part of lifecycle:

  * `preStart` <-- may be called before, or after, ENTRYPOINT
  * `preStop`  <-- K8's management of container will block, also must execute before the grace period happens (race!)

#### Operationally Debugging Init Containers

Not much difference from regular containers, beyond the fact that these are not long running. So you have to be quick or your debug information will just go away.

Steps:

  1. use `kubectl get pods` to wait for a pod named YOUR-THING-init-ADJECTIVE-NOUN-NUMBERS-AND-LETTERS

  2. When that shows up use that name to do `kubectl describe pod`

  3. `kubectl describe pod` will tell you what stage the container is in (ie downloading your docker image, booting the thing up, etc etc)

  4. When it looks up, do `kubectl logs` on that name. Logs should spew forth from the container.

  5. Eventually the init container will go away and be replaced with the non-init version of the container

### <<Learning_Kubernetes_Container_Lifecyle_And_Your_Microservice>>

Kubernetes shuts down your app with the following process:

  1. Will send `SIGTERM`
  2. Will wait (grace period)
  3. Will send `SIGKILL`
  4. container removed from load balancers

See also

  * [Graceful shutdown in k8](https://hackernoon.com/graceful-shutdown-in-kubernetes-435b98794461)
  * [Learning about k8 and Unix Signals](https://jbodah.github.io/blog/2017/05/23/learning-about-kubernetes-and-unix-signals/)
  * Learning_Ops_Docker_PID1_Signals

### So how DOES the magic DNS stuff worked???

  * https://pracucci.com/kubernetes-dns-resolution-ndots-options-and-why-it-may-affect-application-performances.html


Configuring
----------------

Create YAML describing your object (pod, ReplicationController, etc) and POST it to the API server.

Health Checks
-------------

Called "livenessProbe" in k8 yaml.

Can set path, port, and initial delay seconds (remember to give your app time to boot!)

Questions
----------------

Q: What about environments ie Kakfa where your broker string needs/wants to include all the addresses of all the brokers (to communicate with each directly-ish?)

A: Create a Kafka pod and run multiple instances of it. Tell the broker strings about those IP addresses.

Service Catalog
---------------

"Hey, I need a PostgreSQL install, does one exist Out There? If so go grab me it and instantiate it on the cluster"

So like Heroku addons(??)

Additional Tools
--------------

Helm: (from the deis people): create a "chart" which gets turned into a pod (eerrr.... tiller) which gets deployed.

- [REVIEW]: worth looking into when thinking about making this stuff developer repeatable????

Networking
------------------

Are you on GCP? You might want to read Google_Cloud_Platform_Kubernetes_Engine

# Book Recommendations

  * [Kubernetes Up And Running](https://www.amazon.com/Kubernetes-Running-Dive-Future-Infrastructure/dp/1492046531/ref=as_li_ss_tl?crid=8VWERBMXPN5B&keywords=kubernetes+up+and+running&qid=1555896154&s=books&sprefix=kubernetes+up+and+run,stripbooks,216&sr=1-15&linkCode=ll1&tag=wilcodevelsol-20&linkId=35134f1cbb6bc4c334def2d531ea65d4&language=en_US)
  * [Managing Kubernetes](https://www.amazon.com/Managing-Kubernetes-Operating-Clusters-World-ebook/dp/B07KFQL927/ref=as_li_ss_tl?crid=8VWERBMXPN5B&keywords=kubernetes+up+and+running&qid=1555896248&s=books&sprefix=kubernetes+up+and+run,stripbooks,216&sr=1-7&linkCode=ll1&tag=wilcodevelsol-20&linkId=40cf4bfe3d369cb6810a23bc53d92b67&language=en_US)
