---
path: "/learnings/learning_google_cloud"
title: "Learning Google Cloud"
---

# Table of contents

<!-- toc -->

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

  * default  <-- created for you
  * automode    <-- can not connect to other VPCs with VPC peering, allows traffic from subnets and to/from internet. (Uggh)
  * custom mode  <-- define CIDR blocks, define firewall rules to open up just what you need
  * Subnets
  * Routes
  * Firewall rules (ingest, egress)
  * VPC flow logging
  * VPC peering if in same organization (Q: _just_?)


automode VPC - includes
