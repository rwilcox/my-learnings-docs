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
  * Subnets
  * Routes
  * Firewall rules (ingest, egress)
  * VPC flow logging
  * VPC peering
  * shared VPC <-- lets you share VPCs with other project


automode VPC - includes one subnet per region

### See also

  * [VCP how-to guide](https://cloud.google.com/vpc/docs/how-to)



## Load Balancing

Hooks up Backend configuration - allows you to create a Service entry and configure health checks for that service etc etc.

## Cloud DNS

Global scope only
Public or private zones
Private zones 1:1 with VPC network
DNS peering for cross-network resolution
Uses Cloud Domains for DNS registration

## Firewalls


# Compute Services

## Compute Engine (GCE)

Zonal resource

Live migration - virtual machines moved to different hardware while running

When you make one of these by clicking around you can copy the `gcloud` construction CLI parameters from the console!!!

### administration

Identify aware proxy: allows you to SSH into an instance without needing to open up SSH. So a cloud jumpbox. The best practice for connecting to your instance.

(or you could open the port, but that's a slight security risk etc etc)

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

## Object Storage

Needs to be **globally** unique. Ideally workloads that are write once read many (as you have to replace objects to update them)

Lots of different options here that balance price, access time and min retention policy:
  * Standard
  * Nealline
  * Farline
  * Archive


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

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Pub/Sub does not guarantee the order of message delivery.}

Can view the messages in the web console UI for debugging purposes. Can also ACK here tooo!

Also PubSub Lite.

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

#### Message Control flow (needed aka when you have multiple replicas of a microservice who run the same consumer...)

> It's possible that one client could have a backlog of messages because it doesn't have the capacity to process the volume of incoming messages, but another client on the network does have that capacity.

[Source: Google PubSub documentation](https://cloud.google.com/pubsub/docs/pull#flow_control)

In that case set up a [flow control builder](https://cloud.google.com/pubsub/docs/samples/pubsub-subscriber-flow-settings) and attach it to your subscriber.

### On ACK

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

## Spanner

regional or multi regional resource scope

ACID compliant... but Google propretary engine.
multiple write entry points

Cloud Spanner one of those _basically_ breaking CAP theorum technologies.

Much higher entry cost than regular Cloud SQL

### See also

  * [Google's Whitepapers on this tech](https://cloud.google.com/spanner/docs/whitepapers)

## Cloud DataStore / Firestore

NoSQL database with automatic scaling and cost based on data usage (costs scale to 0).

This seems to be the new(?) name for the App Engine object store thing, or at least what it's using now. (Or is backwards compatible with that API).

Document store

ACID compliance

## Big Table

regional resource scope
Managed NoSQL
scalable but not serverless
H-Base compatible

great for many concurrent read/writes

K/V pairs

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

## See also

  * [Google Cloud Database Comparison Page](https://cloud.google.com/products/databases)

# GCP Application Deployment Options

## Instance groups

multiple GCE instances grouped together. Integration with auto scaling, LBs.

Managed   <-- you upload an instance template and GCP manages the herd. Also has stateful option.
unmanaged <-- you add pre-created VMs to the group

## App Engine

### Classic

Scans to 0

BUT with some severe limits.

Languages: Python, Java, PHP, Ruby, Go, Node

### Flexible

min footprint - no scaling to zero here.

## GKE

<<Google_Cloud_Platform_Kubernetes_Engine>>

likely this stuff will be on the test too!

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


### Triggers

# Cloud Deployment Manager

IaC

... does not really have a dashboard

Templates can lookup values from a Python (and others?) script

Can also use DM Convert to export to K8s Resource Model or Terraform (!!!)

can use `--preview` on CLI to see what resource types it's going to create

# Cloud AutoML

No service scope documented
NLP, translation, video intelligence, vision, ?? audio transscriptions ??

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
