#lang scribble/text
@(require "scribble-utils.rkt")

---
path: /learnings/learning_google_cloud
title: Learning Google Cloud
---
# Table of contents

<!-- toc -->

- [Basics](#basics)
- [Cloud Console](#cloud-console)
- [Cloud IAM](#cloud-iam)
  * [Roles](#roles)
  * [Service Accounts](#service-accounts)
- [Cloud SDK](#cloud-sdk)
- [Tools](#tools)
- [Monitoring](#monitoring)
  * [Billing](#billing)
- [Networking](#networking)
  * [VPC](#vpc)

<!-- tocstop -->

# Basics

Terms:

  * Project -- can not create resources that span projects. In some cases you can create shared resource. DELETING PROJECT WILL DELETE ALL RESOURCES TO IT (aka: you've experimented and want to make sure you don't get billed for that huge GKE cluster? Just delete the project!)
    - can be assigned to folders ("location" when creating the project)

  * Zone -- 2+ data centers co-located, likely closely enough. 1ms round trip. Independent failure domain
  * Region -- geographic area, 2 or more zones seperated by tens of miles. 5ms latency
  * Project ID -- globaly unique (Google will _make_ / preview this unique when you create a project name)

# Cloud Console

https://console.cloud.google.com


# Cloud IAM


domain / organization -> folders -> roles -> principles (the humans)

includes default service accounts as starting point / best practice!

## Policies

policies are inherited from parents
a less restricted parent policy will override a more restricted resource policy
policies are set on a resource
each policy contains a set of roles and members


## Roles

Viewer
Editor <-- edit stuff
Owner <-- modify privs

(these are not great from a least priviledged aspect, but they're an AppEngine thing that came forward)

this is on the test!

## Service Accounts

right there in the IAM sidebar

# Cloud SDK

# Tools

## Cloud Shell / Cloud Shell Editor
Cloud Shell Editor <-- VS Code running on the web
Cloud Shell  <-- CLI and this is authed based on the project you're logged into. BUT is persistent!

## CLI tools for managing GCP resources etc

Avail through Cloud SDK.

gcloud

gsutil

# Monitoring

"Cloud Monitoring": formerly known as "StackDriver" (used to be a third party company, not acquired)

## Billing

Can do billing data -> bigquery so can SQL QUERY FOR IT!!!!

See GCP_BigQuery

# Networking


## VPC

Global resource!!!!! (not region based like AWS)

Elements:

  * default     <-- created for you. Probably don't want this b/c you don't control this
  * automode    <-- can not connect to other VPCs with VPC peering, allows traffic from subnets and to/from internet. (Uggh)
  * custom mode <-- define CIDR blocks, define firewall rules to open up just what you need
  * Subnets <-- regional resources
  * Routes
  * Firewall rules (ingest, egress)
  * VPC flow logging
  * VPC peering
  * shared VPC <-- lets you share VPCs with other project


automode VPC - includes one subnet per region

### See also

  * [VCP how-to guide](https://cloud.google.com/vpc/docs/how-to)

## Subnets

## Load Balancing

Hooks up Backend configuration - allows you to create a Service entry and configure health checks for that service etc etc.

## Static IPs

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{To create a new IP reserve, click on Reserve Static Address and fill in the details. In the wizard, you have the option to select the service tier type, region, and, most important, the VM instance that will use it.}

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{any public IP address that a VM instance is using is not static, and when the instance is restarted, it gets a new IP address.}

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{Under Type, you will see if the IP is ephemeral or static. An ephemeral IP will get replaced on reboot, while static will stay}

## Cloud DNS

Global scope only
Public or private zones
Private zones 1:1 with VPC network
DNS peering for cross-network resolution
Uses Cloud Domains for DNS registration

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{The zone name is a unique ID inside Google Cloud that is similar to a Compute Engine instance ID or a Cloud Bigtable instance ID. The DNS name is specific to the domain name system and refers to the subgroup of records for which this zone acts as a delegate.}

## Firewalls

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{Firewall policies allow you to expand the GCP firewall service and apply rules at the organization and folder levels.}

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{The GCP firewall offering is separated into the following services:
VPC firewall: This firewall helps you create firewall rules that apply to your VPC.

Firewall policies: These policies can be applied on a folder, project, or organization level.

Firewall rules for App Engine: These rules control traffic into our App Engine applications.

Firewall Insights: Gives detailed information on the logs of your firewall rules and traffic that is passing into and out of the firewall.}


# Compute Services

## Compute Engine (GCE)

Zonal resource

Live migration - virtual machines moved to different hardware while running

When you make one of these by clicking around you can copy the `gcloud` construction CLI parameters from the console!!!

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{Using the Container feature, you can specify a GCR container image that you would like to run on the VM without needing to run a single command like docker run. This feature is great if you need to run a single container image on your VM directly from GCR.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{setting a shutdown script—sort of the opposite of what you did with your instance templates’ startup scripts. Once the termination is triggered, GCE gives the VM 30 seconds to finish up, and then sends a firm termination signal (the equivalent of pressing your machine’s power button) and switches the machine to terminated}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{images are a good starting point for your VMs, and although you can create custom images, the curated list that Google provides should cover the common scenarios}

### Instance Types

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{By default, the [Google Container Optimized] image is configured to download updates every week, keeping it secure and optimized all the time.
}
### administration

Identify aware proxy: allows you to SSH into an instance without needing to open up SSH. So a cloud jumpbox. The best practice for connecting to your instance.

(or you could open the port, but that's a slight security risk etc etc)

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{Using a snapshot schedule, you can configure the backup process to take place on specific days and times.}

### monitoring

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{ In GCP, you monitor VM instances using a Cloud Monitoring agent, which is a software daemon that collects metrics regarding the performance of the VM and passes them to Cloud Monitoring.}

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{The agent provides a deeper insight into the VM.}

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
$ sudo bash add-monitoring-agent-repo.sh
$ sudo apt-get update
$ sudo apt-get install stackdriver-agent}

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{Cloud Monitoring agent, you need to create a service account with enough permissions to read and write events from the VM instance to Cloud Monitoring}


### Instance groups

multiple GCE instances grouped together. Integration with auto scaling, LBs.

Managed   <-- you upload an instance template and GCP manages the herd. Also has stateful option.
unmanaged <-- you add pre-created VMs to the group

## Cloud Run

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{With Vertical Pod Autoscaling (VPA), GKE handles the resource allocation of pods and automatically scales pods up and down.}

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{Cloud Run will scale applications horizontally, which means that GCP will add more pods to the application and will not add more CPU or RAM to existing pods.}

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{Domain mapping can map a top-level domain to a Cloud Run application. To do just that, from the Cloud Run console, click on the “Manage Custom Domains” link}


## GKE

<<Google_Cloud_Platform_Kubernetes_Engine>>

likely this stuff will be on the test too!


@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{Anthos allows you to turn your GKE cluster to Cloud Run–enabled infrastructure, which means that you can deploy your workload to GKE with the Cloud Run tools. }

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{To allow external access to your app, you need to explicitly expose it. You do so on GKE using the kubectl expose command, as you can see in the following code:}

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{GCP has developed its own Linux image for Kubernetes nodes, called Container-Optimized OS (cos), and it is set as the default option. }

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{GCP has developed its own Linux image for Kubernetes nodes, called Container-Optimized OS (cos), and it is set as the default option. }

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{NodeA GKE cluster’s master node and nodes can run different versions of Kubernetes.}

### scaling considerations

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{It is highly important and recommended you use VPA with GKE Cluster Autoscaler otherwise your cluster will run out of resources.}

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{Autoscaler’s decision to scale resources is also based on the auto-scaling profile you configure. Scaling profiles are based on the following two profiles:
Balanced: This is the default profile that GKE will use when using Autoscaler.

Optimize-utilization: This profile is very cost oriented and will try to keep the cost of running your cluster as low as possible by scaling down the cluster as soon as possible; however, this is not recommended for most environments, because of the aggressive nature of the profile, which prioritizes cost and not performance.}


### Neat GKE operator hacks

If you go into a pod in the toolbar / menu bar there is a `KUBECTL` dropdown. This will let you - in addition to other things - attach to the running pod in the Google Cloud Shell web thing.

### and specialized networking concerns

> For example, in Google Cloud, any traffic to the internet must come from a VM's IP. When containers are used, as in Google Kubernetes Engine, the Pod IP will be **rejected** for egress. To avoid this, we must hide the Pod IP behind the VM's own IP address - generally known as "masquerade"

Most IPs are masquerade-ed **EXCEPT** these CIDR blocks:

  * 10.0.0.0/8
  * 172.168.0.0/12
  * 192.168.0.0/16

[Source: IP-MASQ-AGENT](https://kubernetes.io/docs/tasks/administer-cluster/ip-masq-agent/)

If you need to talk to IPs within these ranges - like for example you're talking to another Google hosted cloud solution via some kind of peer VPC thing - you may need to force a range ON.

Ways to do this:

  * [ip-masq-agent](https://github.com/kubernetes-sigs/ip-masq-agent) <-- 500 lines of Go code on top of IPTables
  * [k8s-custom-iptables](https://github.com/bowei/k8s-custom-iptables) <-- 100 lines of Bash on top of IPTables

This works at all because [kube-proxy currently uses iptables under the hood](https://itnext.io/kubernetes-service-load-balancing-kube-proxy-and-iptables-da3ebf1c802a). Which works on both incoming and outbound traffic.

#### See Also

  * [Configuring an IP masquerade agent](https://cloud.google.com/kubernetes-engine/docs/how-to/ip-masquerade-agent)
  * [K8s Networking demystified: a brief guide](https://www.stackrox.io/blog/kubernetes-networking-demystified/)


## Cloud Functions

upload from web based editor, zip file upload, cloud source repository

Has a testing tab so you can try to invoke the function directly.

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Google Cloud Functions is a serverless compute solution that allows you to run event-based applications}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Cloud Functions comes with a perpetual free tier, which means that some chunks of the resources you use are completely free. With Cloud Functions, the following numbers represent free-tier usage and won’t count towards your bill:

Requests—the first 2 million requests per month
Compute—200,000 GHz-seconds per month
Memory—400,000 GB-seconds per month
Network—5 GB of egress traffic per month}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{gcloud beta functions deploy echo \
>   --source=https://source.developers.google.com/
      projects/your-project-id-here/repos/echo \                       1
>   --trigger-http}
@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{gcloud tool has a call function that triggers a function and allows you to pass in the relevant information. This method executes the function and passes in the data that would have been sent by the trigger, so you can think of it a bit like an argument override.}
@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{gcloud beta functions deploy echo --source=./echo/ \
  --trigger-http --stage-bucket=my-cloud-functions}
@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Even though events from different sources share quite a bit in common, they fall into two categories. Events based on HTTP requests are synchronous events (the requester is waiting for a response), whereas those coming from other services such as Cloud Pub/Sub are asynchronous (they run in the background).}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{The most common event that you’re likely familiar with is an HTTP request, but they can also come from other places such as Google Cloud Storage or Google Cloud Pub/Sub. Every event comes with attributes, which you can use when building your function, including the basic details of an event (such as a unique ID, the type of the event, and a timestamp of when the event occurred), the resource targeted by the event, and the payload of data specific to the event}


## App Engine


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{If you wanted to split 50% of the traffic currently going to version-a, you could do this by clicking the Split Traffic icon (which looks like a road sign forking into two arrows), which brings you to a form where you can configure how to split the traffic}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{App Engine uses some of the memory (about 0.4 GB) for overhead on your instance.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{By default (if you leave these fields out entirely), you’ll get a single-core VM with 0.6 GB of RAM, }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{App Engine Standard involves running your code in a special sandbox environment, you’ll need a way of configuring the computing power of that environment. To do so, you’ll use a setting called instance_class in your app.yaml file. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{By default, Flex services are limited to 20 instances, but you can increase or decrease that limit.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{As you’ve learned, at least one instance must be running at all times, but it’s recommended to have a minimum of two instances to keep latency low in the face of traffic spikes}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Similar to App Engine Standard, Flex has two scaling options: automatic and manual. The only difference is that Flex is lacking the “basic” scaling option. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Basic scaling has only two options to control, which are the maximum number of instances and how long to keep an idle instance around before turning it off.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{By default, App Engine will aim to handle eight requests concurrently on your instances}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{App Engine allows you to set a concurrency level as a way to trigger turning more instances on or off, meaning you can set a target for how many requests an instance can handle at the same time before it’s considered too busy. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{The minimum pending latency is the way you set a lower bound when telling App Engine when it’s OK to turn on more instances. When you set a minimum pending latency, it tells App Engine to not turn on a new instance if requests aren’t waiting at least a certain amount of time. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Now that you have a simple Dockerfile that serves some content, the next thing you’ll need to do is update your app.yaml file to rely on this custom runtime. To do that, you’ll replace nodejs in your previous definition with custom. This tells App Engine to look for a Dockerfile}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{The main difference you’ll notice at first is that it takes a bit longer to complete the deployment. It takes more time primarily because App Engine Flex builds a Docker container from your application code, uploads it to Google Cloud, provisions a Compute Engine VM instance, and starts the container on that instance.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Once you see that the new version works the way you expect, you can safely promote it by migrating all traffic to it using the Cloud Console.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{You can update the code again to change the message and deploy another version, without it becoming the live version immediately. To do so, you’ll set the promote_by_default flag to false:}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{It turns out that just as you can access a specific service directly, you can access the previous version by addressing it directly in the format of <version>.<service>.your-project-id-here.appspot.com (or using -dot- separators for HTTPS):}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{if you host lots of versions concurrently, those versions will spawn instances as necessary to service the traffic. If they’re running inside App Engine Flex, each version will have at least one VM running at all times.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Flex applications must always have at least a single VM instance running. As a result, Flex applications end up costing money around the clock. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Services on App Engine provide a way to split your application into smaller, more manageable pieces. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Each of your projects is limited to one application, with the idea that each project should have one purpose}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{App Engine uses four organizational concepts to understand more about your application: applications, services, versions, and instances}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{App Engine Flexible Environment (often called App Engine Flex) provides a fully managed environment with fewer restrictions and somewhat more portability, trading some scalability in exchange. App Engine Flex is based on Docker containers}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{App Engine Standard Environment, released in early 2008, offers a fully managed computing environment complete with storage, caching, computing, scheduling, and more.}

### Classic

Scans to 0

BUT with some severe limits.

Languages: Python, Java, PHP, Ruby, Go, Node

### Flexible

min footprint - no scaling to zero here.



## Load Balancing

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{To create the load balancer, choose Network Services from the left-side navigation in the Cloud Console, and choose Load Balancing after that.}


## Cloud CDN

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Cloud CDN sits between the load balancer and the various people making requests to the service and attempts to short-circuit requests}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{By default, Cloud CDN will attempt to cache all pages that are allowed. This definition mostly follows IETF standards (such as RFC-7234), meaning that the rules are what you’d expect if you’re familiar with HTTP caching in general. For example, the following all must be true for Cloud CDN to consider a response to a request to be cacheable:

Cloud CDN must be enabled.
The request uses the GET HTTP method.
The response code was “successful” (for example, 200, 203, 300).
The response has a defined content length or transfer encoding (specified in the standard HTTP headers).
In addition to these rules, the response also must explicitly state its caching preferences using the Cache-Control header (for example, set it to public) and must explicitly state an expiration using either a Cache-Control: max-age header or an Expires header.

Furthermore, Cloud CDN will actively not cache certain responses if they match other criteria, such as

The response has a Set-Cookie header.
The response size is greater than 10 MB.
The request or response has a Cache-Control header indicating it shouldn’t be cached (for example, set to no-store).}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{This is a common scenario when, for example, you deploy new static files, such as an updated style.css file, and don’t want to wait for the content to expire from the cache.

To do this, you can use the Cloud Console and click the Cache Invalidation tab. }

# Storage

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Cloud Storage. Google Cloud provides the following storage options:

Zonal standard persistent disk and zonal SSD persistent disk

Regional standard persistent disk and regional SSD persistent disk

Local SSD for high-performance local block storage

Cloud Storage buckets: Object storage.

Filestore: High-performance file storage
}

## Cloud Storage

Needs to be **globally** unique. Ideally workloads that are write once read many (as you have to replace objects to update them)

Lots of different options here that balance price, access time and min retention policy:
  * Standard
  * Nealline
  * Farline
  * Archive

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{each file in the bucket must not be larger than 5 terabytes}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{change notifications allow you to set a URL that will receive a notification whenever objects are created, updated, or deleted. Then you can do whatever other processing you might need based on the notification.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{You can define a couple of conditions to determine when objects should be automatically deleted in your bucket:

  * IsLive
  * NumberOfNewVersions
  * CreatedBefore
  * Age
}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Owners can change ACLs and metadata, which means that unless you trust someone to grant further access appropriately, you shouldn’t give them the Owner permission.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Signed URLs take an intent to do an operation (for example, download a file) and sign that intent with a credential that has access to do the operation}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{the more common scenario where you have content in your app that you want to share temporarily with users? For example, you might want to serve photos, but you don’t want them always available to the public to discourage things like hotlinking. Luckily this is easy to do in code}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{In any version-enabled bucket, every object will have a generation (tracking the object version) along with a metageneration (tracking the metadata version)}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{deleting objects from versioned buckets because deleting the file itself doesn’t delete other generations.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{ If you want to remove the file along with all of its previous versions, pass the -a flag to the gsutil rm command:}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{object-based storage uses a flat namespace to store your data. The key functionality of the Cloud Console interface is that it translates this flat namespace to replicate a folder hierarchy. Cloud Storage has no notion of folders.
}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{object-based storage uses a flat namespace to store your data. The key functionality of the Cloud Console interface is that it translates this flat namespace to replicate a folder hierarchy. Cloud Storage has no notion of folders.
}

### and bucket set retention period

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{If you attempt to delete objects younger than the retention period it will result in a PERMISSION_DENIED error.}

### and PII auditing

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{We can loop through all the buckets and objects, then scan them for PII information with the Google Cloud Data Loss Prevention API.}

@quote-highlight[
#:title "Programming Google Cloud"
 #:author  "Rui Costa"
  #:page-number 0]{A bucket lock allows you to create a retention policy that locks the data preventing it from being deleted or overwritten. You can also lock a retention policy. Once it is locked you cannot unlock it; you will only be able to increase the retention period}

### signed URLs

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Signed URLs is a URL that provides access to users and applications for a limited time. The signed URL allows users to access the object without authentication.}

# Cloud Dataflow

Managed Apache Beam

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Apache Beam is a programming model that defines and executes the defined pipeline. The pipelines can be batch and streaming which are exposed to different runners as:

Google Cloud Dataflow
Apache Spark
Apache Flink
Apache Apex
DirectRunner (a local runner for testing)}

## Terms

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{A pipeline defines what steps the runner will execute on your data}


@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{A PCollection defines the data on which your pipeline will operate on}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{A transform is a function that you define that is performed on your data}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{A ParDo is an Apache Beam transform operation. As outlined in the Transforms section, it performs a user defined operation on a collection of elements. The output of a ParDo can be a single element or many elements, however, it does not output a single output per input element. }

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{A Map is another transform operation available in Apache Beam. In the Framework you will be using the beam.Map as you will be performing a one-to-one mapping,}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Apache Beam I/O connectors let you read/write data into your pipeline as well as write output data}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{As an example, the Framework you are working with has a source of Cloud Pub/Sub and a sink of BigQuery}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Aggregation is an operation that is performed on many elements to produce some grouped value from those respective elements.}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Apache Beam provides the following aggregation methods:
CoGroupByKey
CombineGlobally
CombinePerKey
CombineValues
Count
Distinct
GroupByKey
GroupBy
GroupIntoBatches
Latest
Max
Min
Mean
Sample
Sum
Top}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Runners are the software that accepts a pipeline and executes it.}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Windowing enables you to group operations over the unbounded data set by dividing the data set into windows of finite collections according to their timestamps of the individual elements. You set the following windows with the Apache Beam SDK or Dataflow SQL streaming extensions:
Tumbling windows (called fixed windows in Apache Beam)
Hopping windows (called sliding windows in Apache Beam)
Session windows
}

# Pub Sub

From [Cloud Pub/Sub Documentation](https://cloud.google.com/pubsub/docs/overview)

> Pub/Sub enables you to create systems of event producers and consumers, called publishers and subscribers. Publishers communicate with subscribers asynchronously by broadcasting events, rather than by synchronous remote procedure calls (RPCs).

> Pub/Sub adopts from messaging middleware is per-message parallelism (rather than partition-based). Pub/Sub "leases" individual messages to subscriber clients, then keeps track of whether a given message has been successfully processed.

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Each subscription sees all of the messages you send on a topic}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Once one consumer consumes a message from a subscription, that message is no longer available on that same topic, so the next consumer will get a different message}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Work-queue messaging
Unlike fan-out messaging, where you deliver each message to lots of consumers, work-queue messaging is a way of distributing work across multiple consumers, where, ideally, only one consumer processes each message}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Pub/Sub does not guarantee the order of message delivery.}

Can view the messages in the web console UI for debugging purposes. Can also ACK here tooo!

Also PubSub Lite.

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{the payload is always base-64 encoded, whereas attributes aren’t,}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Once Cloud Pub/Sub receives the message, it’ll assign the message an ID that’s unique to the topic and will return that ID to the producer as confirmation that it received the message (figure 21.1)}

## Core concepts

  * Publisher
  * Topic
  * Subscription <-- A topic can have multiple subscriptions, but a given subscription belongs to a single topic.
  * Subscriber <-- program or instance of listening to / consuming a subscription
  * Message
  * Message Attribute <-- Messages are k/v pairs a publisher can define
  * ACK <-- signal sent by a subscriber after it has successfully retrieved (? and processed?) the message

Messages pushed out to all subscriptions in Cloud Pub/Sub AT LEAST once. (aka: yes a subscriber does not pull from a consumer group / partition, essentially each subscription is its own stream)

> Pub/Sub delivers each published message at least once for every subscription.

[Source](https://cloud.google.com/pubsub/docs/subscriber) "at least once delivery section"


Communication can be:

  * one to many <-- fan out
  * many to one
  * many to many

### Messages, sizes and quotas

10 MB/s per open stream. This is not just a quota but the buffer between the service and client library.

There also [may be a limit of 1,000 messages per pull](https://stackoverflow.com/a/58712547), regardless(??)

> To understand the impact of this buffer on client library behavior, consider this example:
>
> There is a backlog of 10,000 1KB messages on a subscription.
> Each message takes 1 second to process sequentially, by a single-threaded client instance.
> The first client instance to establish a StreamingPull connection to the service for that subscription will fill its buffer with all 10,000 messages.
> It takes 10,000 seconds (almost 3 hours) to process the buffer.
> In that time, some of the buffered messages exceed their acknowledgement deadline and are re-sent to the same client, resulting in duplicates.
> When multiple client instances are running, the messages stuck in the one client's buffer will not be available to any client instances.
>
> This would not occur if you are using Flow Control…

[Source](https://cloud.google.com/pubsub/docs/pull#streamingpull_dealing_with_large_backlogs_of_small_messages)


If you publish 10 500-byte messages in separate requests, your publisher quota usage will be 10,000 bytes. This is because messages that are smaller than 1000 bytes are automatically rounded up to the next 1000-byte increment.

[Source](https://cloud.google.com/pubsub/quotas)

So: Small messages (< 1K): 10,000 / second per stream

> If/when the user runs out of throughput quota, the stream is suspended, but the connection is not broken. When there is sufficient throughput quota available again, the connection is resumed.

[Source](https://cloud.google.com/pubsub/docs/pull)

### Streaming data patterns and how to architect them

#### Load balancing

"Load balancing" processing: Create a subscription to a topic and have multiple subscribers subscribe to the same subscription

> Multiple subscribers can make pull calls to the same "shared" subscription. Each subscriber will receive a subset of the messages.
[Source](https://cloud.google.com/pubsub/docs/subscriber#push-subscription) see comparison table

##### And H/A considerations

> To effectively load-balance across all your subscribers when the message load is small, or to achieve the goal of never starving a subscriber when you have a small message load, I would recommend using synchronous pull. Here's an example,

[Source](https://github.com/googleapis/java-pubsub/issues/582#issuecomment-863603463)

#### Fan out

"Fan out" need to do N different things with this message in parallel: create N subscriptions, each with howevever many subscribers. Thus the message goes to every subscription. Say one subscription just cares about user notification, one subscription just cares about bookkeeping, etc.

[Source](https://cloud.google.com/pubsub/architecture#the_basics_of_a_publishsubscribe_service)


### On Delivery methods

Methods:

  * Push <-- each message goes to a subscriber defined endpoint
  * Pull (your application asks for next message):
    * Synchronous pull <-- like pull but more like polling
    * Streaming pull <— "pull" as in creating a socket and getting messages as they are available published down the socket

Push: needs to have a public HTTPS endpoint. More latent then pull

Pull: Pull and Streaming Pull (default).

Synchronous pull use cases:
  * precise cap on messages sent (streaming pull may oversubscribed for first little bit)
  * if you have spikey loads of very small messages
  * languages without GRPC

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{With a push subscription, you’ll rely on HTTP response codes to communicate that. In this case, an HTTP code of 204 (No Content) is your way of saying you’ve successfully received and processed the message. Any other code (for example, a 500 Server Error or 404 Not Found) is your way of telling Cloud Pub/Sub that some sort of failure occurred.}


#### Message Control flow (needed aka when you have multiple replicas of a microservice who run the same consumer...)

> It's possible that one client could have a backlog of messages because it doesn't have the capacity to process the volume of incoming messages, but another client on the network does have that capacity.

[Source: Google PubSub documentation](https://cloud.google.com/pubsub/docs/pull#flow_control)

In that case set up a [flow control builder](https://cloud.google.com/pubsub/docs/samples/pubsub-subscriber-flow-settings) and attach it to your subscriber.

### On ACK

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{On each subscription, in addition to the push or pull configuration, you also must specify what’s called an acknowledgment deadline. This deadline, measured in seconds, acts as a timer of how long to wait before assuming that something has gone wrong with the consumer}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Once a message has been acknowledged, the message is nt longer accessible to subscribers of a given subscription. In addition, the subscribers must process every message in a subscription—even if only a subset is needed.}

### On Topics, subscriptions

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{The way I like to define it is that a topic is not the holding bucket of the message, but rather the subscription is the holding bucket.}

A topic has many subscriptions, and each subscription can have many subscribers

## Replayability

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Using the Seek feature allows you to recover from unexpected subscriber problems, perform acknowledgment on a backlog of messages that are no longer relevant, and deploy new code features without accidentally acknowledging messages.}

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Another way to replay messages that have been acknowledged is to seek to a timestamp.}


## The Java SDK specifically

### Subscribing to a pull topic

```java
  Subscriber.newBuilder( ProjectSubscriptionName.of(myProjectName, aSubscriptionId),
    MessageReciever_AFunctorClassWhichReallyShouldHaveBeenOneOfTheFunctionalInterfacesButIsNotBarely)
    .setParallelPullCount(4)
    .setExectorProvider(...) // thread executor goes here s
```

#### the executor provider

is of interface type `com.google.api.gax.core.ExecutorProvider` which seems to be implemented only one place `InstantiatingExectorProvider` which seems to be really a java `ScheduledThreadPoolExecutor`.

#### See also:

  * Learning_Java_Thread_Exector
  * [Pub/Sub Made Easy Youtube playlist from Google](https://www.youtube.com/playlist?list=PLIivdWyY5sqKwVLe4BLJ-vlh9r9zCdOse)

# Data Stores

## Cloud SQL

Zonal or regional resource scope

Managed relational DB service (mysql, postgres, SQL Server, Cloud Spanner)

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Cloud SQL is a VM that’s hosted on Google Compute Engine, managed by Google, running a version of the MySQL binary}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{By default, disks used as part of Cloud SQL have automatic growth enabled. As your disk gets full, Cloud SQL will automatically increase the size available.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Cloud SQL makes it easy to implement the most basic forms of replication. It does so by providing two different push-button replica types: read replicas and failover replicas.}


## Spanner

regional or multi regional resource scope

ACID compliant... but Google propretary engine.
multiple write entry points

Cloud Spanner one of those _basically_ breaking CAP theorum technologies.

Much higher entry cost than regular Cloud SQL

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{you write to Cloud Spanner via a separate API, which is more similar to a nonrelational key-value system, where you choose a primary key and then set some values for that key.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{In a typical database, like MySQL, you use an INSERT SQL query to add new data and an UPDATE SQL query to update existing data. Spanner doesn’t support those two commands, however, which shows its NoSQL influences.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Tables have a few other constraints, such as a maximum cell size of 10 MiB, but in general, Spanner tables shouldn’t be surprising}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Spanner instances are made up of a specific number of nodes that can be used to serve instance data. These nodes live in specific zones and are ultimately responsible for handling queries.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{The basic operations are

get—Retrieve an entity by its key.
put—Save or update an entity by its key.
delete—Delete an entity by its key.
Notice that it looks like all of these operations require the key for the entity, but if you omit the ID portion of the key in a put operation, Datastore will generate one automatically for you.}

@quote-note[
		#:original-highlight "If two keys have the same parent, they’re in the same entity group"
	#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{How do you make one of these keys? From the Python SDK

> Key('Parent', 'foo', 'Child', 1234)}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{queries inside a single entity group are strongly consistent (not eventually consistent). If you recall, an entity group, defined by keys sharing the same parent key, is how you tell Datastore to put entities near each other. If you want to query over a bunch of entities that all have the same parent key, your query will be strongly consistent.}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{SELECT * FROM Employees WHERE favoriteColor = "blue" AND
    __key__ HAS ANCESTOR Key(Company, 'apple.com')}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{It also means that although the operations you learned about will always return the truth, any queries you run are running over the indexes, which means that the results you get back may be slightly behind the truth.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{indexes are updated in the background, so there’s no real guarantee regarding when the indexes will be updated.}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{a Cloud Spanner instance acts as an infrastructural container that holds a bunch of databases}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Spanner supports ACID transactional semantics, even going as far as supporting distributed transactions (although at a performance cost). Spanner supports two types of transactions: read-only and read-writ}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{ If you ask for data that isn’t in the index, using the index itself won’t be any faster because after you’ve found the right primary keys that match your query, you still have to go back to the original table to get the other data (in this case, the start_date).}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{The moral of this story is that when writing new data, you should choose keys that are evenly distributed and never choose keys that are counting or incrementing (such as A, B, C, D, or 1, 2, 3). Keys with the same prefix and counting increments are as bad as the counting piece alone (for example, sensor1-<timestamp> is as bad as using a timestamp). Instead of using counting numbers of employees, you might want to choose a unique random number or a reversed fixed-size counter. A library, such as Groupon’s locality-uuid package (see https://github.com/groupon/locality-uuid.java), can help with this.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Spanner makes a big assumption: if you didn’t say that things must stay together, they can and may be split. These points that you haven’t specifically prohibited, which lie between two rows in a root table, are called split points.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{To clarify that the paychecks table should be kept near the employees table, use the INTERLEAVE IN PARENT statement and specify that if an employee is deleted, the paychecks should also be deleted.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Splitting up the data is easy for Spanner to do. In fact, Bigtable has supported this capability for quite some time. What’s unique is the idea of being able to provide hints to Spanner of where it should do the splitting, so that it doesn’t do crazy things like put an employee’s paycheck and insurance information on two separate machines.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{One of the first steps to fix this is to create read replicas, which duplicate data and act as alternative servers to query for the data. This solution is often the best one for systems that have heavy read load (lots of people asking for the data) and relatively light write load (modifications to the data), because read replicas do what their name says: act as duplicate databases that you can read from (see figure 6.13). All changes to the data still need to be routed through the primary server, which means it’s still the bottleneck of your database.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{That example sounds easy because we focused on a single table (employees). But you also need to make sure that, for example, paycheck information, insurance enrollment, and other employee data in different tables are similarly chopped up. In addition, you’d want to make sure that all of the data is consistently split, particularly when you want to run a JOIN across those two tables. If you want to get an employee’s name and the sum of their last 10 paychecks, having the paycheck data on one machine and the employee data on another would mean that this query is incredibly difficult to run.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{the new column can’t have a NOT NULL requirement. This is because you may already have data in the table, and those existing rows clearly don’t have a value for the new column and need to be set to NULL.}


### See also

  * [Google's Whitepapers on this tech](https://cloud.google.com/spanner/docs/whitepapers)


## Cloud DataStore / Firestore

NoSQL database with automatic scaling and cost based on data usage (costs scale to 0).

This seems to be the new(?) name for the App Engine object store thing, or at least what it's using now. (Or is backwards compatible with that API).

Document store

ACID compliance

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Cloud Datastore, formerly called the App Engine Datastore, originally came from a storage system Google built called Megastore}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Keys
The most primitive concept to learn first is the idea of a key, which is what Cloud Datastore uses to represent a unique identifier for anything that has been stored. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{The first major difference is that because Datastore doesn’t have an identical concept of tables, Datastore’s keys contain both the type of the data and the data’s unique identifier. }


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{The second major difference is that keys themselves can be hierarchical, which is a feature of the concept of data locality I mentioned before. Your keys can have parent keys, which colocate your data, effectively saying, “Put me near my parent.” An example of a nested (or hierarchical) key would be Employee:1:Employee:2, which is a pointer to employee #2.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Entities
The primary storage concept in Cloud Datastore is an entity, which is Datastore’s take on a document.}


  #:page-number 0]{An entity can have properties of all the basics, also known as primitives, such as

Booleans (true or false)
Strings (“James Bond”)
Integers (14)
Floating-point numbers (3.4)
Dates or times (2013-05-14T00:01:00.234Z)
Binary data (0x0401)}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{In addition to the basic types, Datastore exposes some more advanced types, such as

Lists, which allow you to have a list of strings
Keys, which point to other entities
Embedded entities, which act as subentities}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Datastore uses indexes to make a query possible (table 5.3).}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{As mentioned, Datastore chose to update data asynchronously to make sure that no matter how many indexes you add, the time it takes to save an entity is the same. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Do I have to create an index to do a simple filtering query? Luckily, no! Datastore automatically creates an index for each property (called simple indexes) so that those simple queries are possible by default. But if you want to do matching on multiple properties together, you may need to create an index.}

## Big Table

regional resource scope
Managed NoSQL
scalable but not serverless
H-Base compatible

great for many concurrent read/writes

K/V pairs

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{authors of the research paper describing Bigtable called it “a sparse, distributed, persistent, multi-dimensional sorted map”}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Google’s Bigtable, first announced in 2006, which has been reimplemented as the open source project Apache HBase. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{the minimum size of an instance is three nodes, so the minimum hourly rate for any production instance is technically three times the per-node hourly rate.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Bigtable can rely on the Hadoop file format, which makes it easy for you to export and import data not only to Cloud Bigtable but also to HBase if you happen to use that.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Hadoop, as you may remember, is Apache’s open source version of Google MapReduce and is commonly used alongside HBase, Apache’s open source version of Bigtable. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{most important thing you can do when using Bigtable is to choose row keys carefully so that they don’t concentrate traffic in a single spot. If you do that, Bigtable should do the right thing and perform well with your dataset}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{As mentioned earlier, choosing how to structure and format row keys is important for a few different reasons:

Row keys are always unique. If you have collisions, you’ll overwrite data.
Row keys are lexicographically sorted across the entire table. High traffic to lots of keys with the same prefix could result in serious performance problems.
Row key prefixes and ranges can be used in queries to make the query more efficient. Poorly structured keys will require inefficient full-table scans of your data.}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{In Bigtable the keys of this map are called column qualifiers (sometimes shortened to columns), which are often dynamic pieces of data. Each of these belongs to a single family, which is a grouping that holds these column qualifiers and act much more like a static column in a relational database}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{each row stores only the data present in that row, so there’s no penalty for those empty spaces}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Column families are helpful groupings that, in some ways, can be thought of as the keys pointing to maps of arbitrary maps of more data.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{In scenarios like these, where a few hot tablets are colocated on a single node, Bigtable rebalances the cluster by shifting some of the less frequently accessed tablets to other nodes that have more capacity to ensure that each of the three nodes sees about one-third of the total traffic,}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Tablets are a way of referencing chunks of data that live on a particular node. The cool thing about tablets is that they can be split, combined, and moved around to other nodes to keep access to data spread evenly across the available capacity. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{For example, writing lots of data quickly over a long period of time to keys with two distinct prefixes (such as machine_ and sensor_) will typically lead to the data being on two distinct tablets (such as machine_ prefixed data wouldn’t be on the same tablet as sensor_ prefixed data)}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{It’s also possible that a single tablet could become too hot (it’s being written to or read from far too frequently). Moving the tablet as it is to another node doesn’t fix the problem. Instead, Bigtable may split this tablet in half and then rebalance the tablets as we saw earlier, shifting one of the halves to another node.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Bigtable can mimic the key-value querying by constructing a row key and asking for the data with that row key, but it allows you to do something critical that services like Memcache don’t: scan the key space.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Cloud Bigtable has no free tier and has a minimum cluster size of three nodes, which translates to about $1,400 per month as a minimum. This is quite a change from the $30 per month minimum for Cloud SQL.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{In Bigtable you’re able to specify a range of keys to return, making it important to choose row keys that serve this purpose. In some ways, this is a bit like being able to choose one and only one index for your data. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{You can do a prefix scan, which asks, “Who does the prefix follow?” but there’s no way to do a suffix scan, which asks, “Who follows the suffix?”}

## Big Query

<<GCP_BigQuery>>

regional resource scope
managed data warehouse
relational
SQL compliant (ANSI:2011)
seperate compute and storage tiers

pricing:
  * amount of data in query
  * amount of data in response
  * data cost

You _can_ ask for flate rate

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{BigQuery is a column-oriented storage system, although the total data processed has to do with the number of rows scanned, the number of columns selected (or filtered) is also considered. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{BigQuery uses jobs to represent work that will likely take a while to complete.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{You can accomplish four fundamental operations with jobs:

Querying for data
Loading new data into BigQuery
Copying data from one table to another
Extracting (or exporting) data from BigQuery to somewhere else (like Google Cloud Storage [GCS])}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Unlike with a relational database, you define and set schemas as part of an API call rather than running them as a query. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Because BigQuery is intended to be used as an analytical storage and querying system, constraints like uniqueness in even a single column aren’t available}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{sharding the data across lots of drives and transporting it to lots of CPUs for processing allows you to potentially read and process enormous amounts of data incredibly quickly. Under the hood, Google is doing this, using a custom-built storage system called Colossus, which handles splitting and replicating all of the data so that BigQuery doesn’t have to worry about it}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{BigQuery uses SQL instead of Java or C++ code, exploring large data sets is both easy and fast. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Unlike for training jobs, a flat rate of $0.10 per 1,000 predictions ($0.11 for non-US locations) is available in addition to the hourly-based costs}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Ultimately, calculating this each time is going to be frustrating. Luckily you can jump right to the end by looking at the job itself either in the command line or the Cloud Console, where you can see the number of ML training units consumed in a given job.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Like scale tiers, each machine type comes with a cost defined in ML training units, which then follows the same pricing rules that you already learned about.}


### Data Modelling

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Each table contained in the dataset is defined by a set schema}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Unlike in a traditional relational database, BigQuery rows typically don’t have a unique identifier column, }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{field type called RECORD acts like a JSON object, allowing you to nest rows within rows.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{BigQuery comes with special ways of decomposing these repeated fields, such as allowing you to count the number of items in a repeated field or filtering as long as a single entry of the field matches a given value. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{REPEATED, which currently isn’t common in most relational databases. Repeated fields do as their name implies, taking the type provided and turning it into an array equivalent. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{BigQuery’s insert ID is about avoiding making the exact same request twice, and you shouldn’t use it as a way to deduplicate your data. If you need unique data, you should preprocess the data to remove duplicates first, then bulk load the unique data.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{BigQuery can accept a unique identifier called insertId, which acts as a way of de-duplicating rows as they’re inserted. The concept behind this ID is simple: if BigQuery has seen the ID before, it’ll treat the rows as already added and skip adding them}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Like a relational database has databases that contain tables, BigQuery has datasets that contain tables }


## See also

  * [Google Cloud Database Comparison Page](https://cloud.google.com/products/databases)


# Cloud Deployment Manager

IaC

... does not really have a dashboard

Templates can lookup values from a Python (and others?) script

Can also use DM Convert to export to K8s Resource Model or Terraform (!!!)

can use `--preview` on CLI to see what resource types it's going to create

# Cloud Build

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{NodeA GKE cluster’s master node and nodes can run different versions of Kubernetes.}

# Gogle Container Registry

@quote-highlight[#:title "Getting Started with Containers in Google Cloud Platform : Deploy, Manage, and Secure Containerized Applications"
  #:author  "Ifrah, Shimon"
  #:page-number 0]{you have the option to add the vulnerability scanning option, which scans all stored images for malicious code. Vulnerability scanning will cost you $0.26 per image; the charge will happen once}

# Google Artifact Registry


# Cloud AutoML

No service scope documented
NLP, translation, video intelligence, vision, ?? audio transscriptions ??

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{A neural network is a directed graph containing a bunch of nodes (the circles) connected to one another along edges (the lines with arrows), where each line has a certain weight. The directed part means that things flow in a single direction, indicated by the way the arrow is pointing. The line weights determine how much of an input signal is transmitted into an output signal, or how much the value of one node affects the value of another node that it’s connected to.}


@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{All of the pricing for ML Engine boils down to ML training units consumed, which have a price per hour of use. }

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{If the preset scale tiers offered by ML Engine aren’t a great fit (which, if you need access to GPUs, will likely be the case), ML Engine provides the ability to customize the hardware configuration to the specifics of your job}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{The next two tiers (STANDARD_1 and PREMIUM_1) are the only ones recommended for real production workloads because they’re distributed models that can handle things like large amounts of data}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{various preset scale tiers available, which follow:

BASIC, which is a single worker server that trains a model
BASIC_GPU, which is a single worker server that comes with a GPU attached
STANDARD_1, which uses lots of worker servers but has a single parameter server
PREMIUM_1, which uses lots of workers and lots of parameter servers to coordinate the shared model state}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{creating a training job on ML Engine, you have the option to specify something called a scale tier, which is a predefined configuration of computing resources that are likely to do a good job of handling your training workload.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{To deal with this, you rely on a “job,” which is a way of requesting work be done asynchronously. After you start one of these jobs, you can check on the progress later and then decide what to do when it completes.
}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{You’ll also need to make sure the bucket is located in a single region rather than distributed across the world. You do this to avoid cross-region data transfer costs,}

## Cloud Speech

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Cloud Speech API currently rounds audio inputs up to the nearest 15-second increment and bills based on that (so the actual amount is 0.6 cents per 15 seconds)}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{Cloud Speech API needs to “listen” to the entire audio file, so the recognition process is directly correlated to the length of the audio.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{the first 5,000 requests per month of each type are free of charge.}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{NL API measures the amount of text in chunks of 1,000 characters}

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{the NL API can annotate three features of input text: syntax, entities, and sentiment.}

## Cloud Vision

@quote-highlight[#:title "Google Cloud Platform in Action"
  #:author  "Geewax, JJ"
  #:page-number 0]{In this case, the google-cloud/vision client library for Node.js is making some assumptions for you, saying “If the likelihood is LIKELY or VERY_LIKELY, then use true.”}


# Tags

> A tag is a key-value pair that can be attached to an organization, folder, or project. You can use tags to conditionally allow or deny policies based on whether a resource has a specific tag. (ie permissions, firewall controls)

[Source](https://cloud.google.com/resource-manager/docs/tags/tags-creating-and-managing)

# Certs

## (1) Associate Cloud Engineer

Implementation, Deployment and Management. [Exam guide](https://cloud.google.com/certification/guides/cloud-engineer?skip_cache=true) $125 and 2 hours. Multiple choice / multiple select.

[training path](https://cloud.google.com/training/cloud-infrastructure?skip_cache=true#cloud-engineer-learning-path)

## (2) Pro Cloud Architect

Design, plan and optimize. Less hands on.

2nd highest paying cert in industry

## (3) Other stuff

get more specific AFTER those two

## Strategies

  * do these two as the foundation (then maybe specialize if you want/need)
  * Pace yourself
  * Run through the easiest shortest question first then go back to the more complex question
  * Focus on the business requirement if the question provides them
  * No partial credit for multiple answer questions
  * You can't take notes during the exam (must just use your head)
  * During your prep study your weakest topics early and often
  * There's a free online practice exam, so try that out


# See Also

  * [Programming Google Cloud](https://learning.oreilly.com/library/view/programming-google-cloud/9781492089025/)
