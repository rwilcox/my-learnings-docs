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

  * Project -- can not create resources that span projects. In some cases you can create shared resource...
  * Zone -- 2+ data centers co-located, likely closely enough. 1ms round trip. Independent failure domain
  * Region -- geographic area, 2 or more zones seperated by tens of miles. 5ms latency
  * Project ID -- globaly unique (Google will _make_ / preview this unique when you create a project name)

# Cloud Console

https://console.cloud.google.com


# Cloud IAM


domain / organization -> folders -> roles -> principles (the humans)

includes default service accounts as starting point / best practice!

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

Cloud Shell Editor <-- ?? "more like an IDE" ???
Cloud Shell  <-- CLI and this is authed based on the project you're logged into. BUT is persistent!

# Monitoring

"Cloud Monitoring": formerly known as "StackDriver" (used to be a third party company, not acquired)

## Billing

Can do billing data -> bigquery so can SQL QUERY FOR IT!!!!

# Networking


## VPC

Global resource!!!!!

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


automode VPC - includes

## Load Balancing



## Cloud DNS

Global scope only
Public or private zones
Private zones 1:1 with VPC network
DNS peering for cross-network resolution
Uses Cloud Domains for DNS registration

# Compute Services

## Compute Engine (GCE)

Zonal resource

Live migration - virtual machines moved to different hardware while running

When you make one of these by clicking around you can copy the `gcloud` construction CLI parameters from the console!!!

## Cloud Functions

upload from web based editor, zip file upload, cloud source repository

Has a testing tab so you can try to invoke the function directly.

### Triggers

# Storage



# Pub Sub

From [Cloud Pub/Sub Documentation](https://cloud.google.com/pubsub/docs/overview)

> Pub/Sub enables you to create systems of event producers and consumers, called publishers and subscribers. Publishers communicate with subscribers asynchronously by broadcasting events, rather than by synchronous remote procedure calls (RPCs).

> Pub/Sub adopts from messaging middleware is per-message parallelism (rather than partition-based). Pub/Sub "leases" individual messages to subscriber clients, then keeps track of whether a given message has been successfully processed.

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Pub/Sub does not guarantee the order of message delivery.}

## Core concepts

  * Topic
  * Subscription
  * Message
  * Message Attribute <-- Messages are k/v pairs a publisher can define
  * ACK <-- signal sent by a subscriber after it has successfully retrieved (? and processed?) the message

Messages pushed out to all subscribers in Cloud Pub/Sub AT LEAST once. (aka: yes a subscriber does not pull from a consumer group / partition, essentially each subscription is its own stream)

### On Delivery methods

Methods:

  * Push <-- each message goes to a subscriber defined endpoint
  * Pull <-- your application asks for next message

### On ACK

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{Once a message has been acknowledged, the message is nt longer accessible to subscribers of a given subscription. In addition, the subscribers must process every message in a subscription—even if only a subset is needed.}

### On Topics, subscriptions

@quote-highlight[#:title "Programming Google Cloud"
  #:author  "Rui Costa"
  #:page-number 0]{The way I like to define it is that a topic is not the holding bucket of the message, but rather the subscription is the holding bucket.}

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

# See Also

  * [Programming Google Cloud](https://learning.oreilly.com/library/view/programming-google-cloud/9781492089025/)
