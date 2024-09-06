---
path: /learnings/azure
title: 'Learnings: Azure'
---
# Table Of Contents

<!-- toc -->

<!-- tocstop -->

# Regions

regions & AZs

regions are at least 300 miles apart, has automatic replication for some services

region pairs: most azure regions have another region in the same geography.

sovereign regions: DoD, Government, China,

Azure Subscriptions <-- IAM. (Looks like it's built on top of AD?)

VM scale sets - does what it says on the tin

App Services - PaaS offering

VNet - their network peering thing

# Hierarchy etc

Azure Account has many subscriptions has many resource groups and resources

# Resource Manager

deploy, manage, monitor resources as a group. Tags, templates, etc

## Resource Groups

Resources can only exist in one resource group
can have resources from many different regions

Makes resources inside have same lifecycle (if you don't want this ie maybe with databases don't put them in the same group)

location for the resource group is the location of the metadata about the resource group

## Locks

Can prevent accidental deletion of resources

Read-Only and Delete locks

# Cost Management

## Alert types

  * Budget Alerts
  * Credit Alerts
  * department spending quota alerts

# Azure Policy

Uses Microsoft Purview (autoated data governance, risk and compliance solution)

groups of policies called initiatives

Set at each level: resource, resource group, subscription, etc and then apply to children within that group.

# Azure Arc

Unifies management of azure compliance etc in hybrid scenarios

# Monitoring etc

Azure Monitor       : collects data on resources
Azure Log Analytics : run log queries based on ^^^

## App Insights

  * request rates, response times, failure rates
  * dependency rates
  * user and session counts
  * machine performance
  * synthetic transactions

# Compute

availiability sets:
  * update domain: machines that can be rebooted at same time (I guess batch 1/2 or 1/3rd of your machines in a cluster in an update domain so you only lose half at a time to reboots??)
  * fault domain: grouped by common hardware (power source, network switch). By default split across up to 3 fault domains.

## booting up a VM (ie from the CLI)

  `--settings` lets you specify a file URL to download and `--protected-settings` lets you specify a command to execute

## Azure App Service


## Container Runners

### Azure Container Apps

### AKS

# Network Related

Virtual Network

## W.R.T Hybrid Cloud

### point to point <-- computers to Azure

### site to site: Azure VPN Gateway

policy based: specify IP address of packets that should be encrypted

route based: IPSec tunnel

Can be configured as an ExpressRoute fallback

### Azure ExpressRoute

Uses BGP

Four models:
  * CloudExchange colocation
  * Point-to-point Ethernet connection
  * Any-to-any connection
  * Directly from ExpressRoute sites


## DNS

Azure DNS. Also supports private DNS domains. Can't use this to buy a domain name.
