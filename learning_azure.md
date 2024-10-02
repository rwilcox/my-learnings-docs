---
path: /learnings/azure
title: 'Learnings: Azure'
---
# Table Of Contents

<!-- toc -->

<!-- tocstop -->

# Regions

regions & AZs (availibility zones)

AZ is combo of fault domain and update domain

regions are at least 300 miles apart, has automatic replication for some services

region pairs: most azure regions have another region in the same geography.

sovereign regions: DoD, Government, China,

Azure Subscriptions <-- IAM. (Looks like it's built on top of AD?)

VM scale sets - does what it says on the tin

App Services - PaaS offering

VNet - their network peering thing

# Hierarchy etc

## Management Groups

Scope above subscriptions

Can nestle the groups, max depth of 6

Can make use of policy inheritance

## Subscriptions

Azure Account has many subscriptions has many resource groups and resources

each subscription can have different billing and payment configurations
multiple subscriptions can be linked to the same account
billing for azure is done on a per-subscription basis

consider a shared services subscription

Subscriptions associated with a single Entra directory.

# Cost

## Microsoft Cost Management

(the cost analytics dashboard thing + budget control)


# Resource Manager

Pre Resource Manager (or "classic deployments" or "Cloud Services (classic)")

"Cloud Services (extended)" does let you use Resource Manager

deploy, manage, monitor resources as a group. Tags, templates, etc

Classic deployments limited to 20 virtual cores across all VMs in a region

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

Can set restrictions on ie location, kinds of resources created, etc etc

policy defintion: condition to evaluate and actions to perform when it's met
initiative definition: set of policy definitions

Built in policy definitions include:
  * (List of) not allowed resource types
  * allowed storage SKUs
  * allowed resource types
  * allowed locations
  * ... etc

"Compliance" tab shows you areas in your subscription that are out of compliance with your set policies or initiatives

JSON documents

# Containers

## Container Instances

Sources:
  * Quickstart !?!!!
  * Azure Container Registry
  * (other registry)

# Azure Arc

Unifies management of azure compliance etc in hybrid scenarios

# Tools

## Cloud Shell

ALSO has Visual Studio Code installed (via `code`) and it fires up the VSC UI right in the shell!!!

# Monitoring etc

Azure Monitor       : collects data on resources
Azure Log Analytics : run log queries based on ^^^

## App Insights

  * request rates, response times, failure rates
  * dependency rates
  * user and session counts
  * machine performance
  * synthetic transactions

## Monitor Activity Log

provides logging for subscription level events

# Compute

availiability sets:
  * update domain: machines that can be rebooted at same time (I guess batch 1/2 or 1/3rd of your machines in a cluster in an update domain so you only lose half at a time to reboots??).
  * fault domain: grouped by common hardware (power source, network switch). By default split across up to 3 fault domains.
  * items in here should perform the same function

Azure compute only supports 64bit OSes

VMs have at least two disks: OS disk (limited to 2GB, BTW) and temp disk (sized based on VM size, reeallly wants you to use it for virtual memory...)
(temp disk survives reboots BUT moving the VM around will NOT. NOT for storage of stuff)

(then you need a data disk)

You can use the Template (or Export Template) thing on the sidebar to get the BISON for the resources created when you ie create a VM via click-ops
(the navigator thing with resources feels like a function popup/mini map

Neat you can clickops have the VM run a script without leaving the Azure Portal

## VMs

Patch Orchestration / Update options:
  * let OS on the VM do it
  * Azure Orchestrated patching (patches across availibility sets)
  * Manual updates

[Virtual Machine Size(https://azure.microsoft.com/en-us/pricing/details/virtual-machines/series/)

For Windows VMs the Connect tab gives you a .rdp file for Remote Desktop to connect to the VM

### booting up a VM (ie from the CLI)

  `--settings` lets you specify a file URL to download and `--protected-settings` lets you specify a command to execute

### Scale Sets

orchestration mode:
  * flexible: you manually create VM
  * uniform: Azure generates instances based on the model

Can do:
  * auto scale based rules ?? (CPU)
  * metrics based rules (App Insights)
  * schedule rules (ie time/date)

## Azure App Service

"Deployment Slots" = ie whatever your environment setup is: blah-dev, blah-staging, blah-prod for example

Auto Swap <-- when code changes to that slot App Service warms up the service then swaps the entire deployment slot to production (Win only)

Has it's own auth services built in you can use

Plans:
  * Free / shared <-- no scale out
  * Basic <-- 3 max instances
  * Standard <-- starts supporting auto scale. 5 deployment slots. Up to 10 instances
  * Premium <-- 5 instances. 20 deployment slots. Up to 30 instances
  * Isolated <-- 20 deployment slots. Up to 100 instances.

First class support for:
  * ASP.NET
  * Java
  * Ruby
  * Node
  * PHP
  * Python

`az webapp up` / `az webapp deploy` <-- another way to deploy

## Container Runners

### Azure Container Apps

See also: "Container Instances" in this document

Container Group: collection of containers that get scheduled on a host machine

Ways to specify:
  * ARM template
  * YAML <-- recommended if that's all you're deploying

Teeeeecccchhhhhhnically it's running K8s under the hood, but you don't have access to all of it

### AKS

# Storage

Storage Explorer: standalone app to manage all your storage content

Kinds:
  * blob                    : via HTTP(S); REST API; Powershell; NFS
  * data lake
  * azure files           : managed file share (SMB/NFS)
  * queue storage    : messaging store. Up to 64K
  * table storage      : NoSQL table (newer version use Cosmos DB Table API)

Types:
  * standard <-- spinning disks
  * premium <-- SSD

Storage Account is immutably created with one of these types above
Storage account default is allow connections from all networks
Storage account specifies Performane too
... specifies replication
access tier

Data is encrypted automatically before being persisted to managed disks, blob, queue etc; then decrypted before retrieval

## Azure Files

can provided shared acces to files across multiple VMs

Supports SMB or NFS (pick one per disk)

Snapshots diff based but you just need to run the last one to restore

Soft delete can be enabled on new or existing file shares

Cloud Tiering: allowing frequently accessed files to be cached locally

### Azure File Sync


## Azure Disks

Are page based blobs

## Blob Storage

"blob containers" is Azure's name for Buckets

Access permissions:
  * Private
  * "Blob" <-- anon read only access
  * Container <-- anon read access for containers - and by this they mean the heirarchy - and blobs

You can use rules to ie if the last modified date was > 60 days ago move to cool storage

Types:
  * block (default) <-- can set the block size
  * append (optimized for append operations)
  * page (8TB in size)

locally redundent: "basic protections against rack and drive failure"

mocking out some of the cloud experience locally: Azure Storage Emulator (table, queue and blob) and Azurite (Azure Storage)

### Access

  * shared access secrets (SAS) <-- read only or read/write ; expiration time
  * Entra backed auth
  * RBAC roles
  * access keys
  * shared key <-- grants anyone with access essentially root access
  * anon

#### Stored Access Policy

Can create based on four kinds of storage resources:
  * blob containers
  * file shares
  * queues
  * tables

"The stored access policy you create for a blob container can be used for all the blobs in the container and for the container itself."

#### SAS

Parts: URI to a resource; token on how client may access resources

Can reference a stored access policy

Types:

  * User delegation SAS <-- Entra ID; only for Blob storage
  * Service SAS <-- Useful for Blob, Queu, Table or File
  * Account SAS <-- same as service but can control access to service-level ops

## Azure Migrate

Sections:
  * Migrate: Server Migration (VMWare or Hyper-V VMs, can also ID physical servers)
  * Data Migration Assistant
  * Database Migration Assistant
  * App Service Migration Assistant

# Network Related

## IP addresses

Dynamic: associated with an Azure resource and can change if the resource changes (ie stopped). <-- for Basic IP Addresses IPv6 must be dynamic

Static: aren't released until you delete them. <-- Standard SKU allows IPv6

## subnets

Azure reserves 5 addresses in each subnet (first four, and last)

Azure Services may create their own resources in a subnet (using that subnet's address space)

Azure routes all traffic between subnets by default. (Can control or block this completely with a network virtual appliance.)

subnet can have only one route table

## Network Security Group

Azure processes security group associated to subnet, then the one applied to the network interface (for inbound. Outbound just opposite)

If no Security Group is applied default is allow all traffic (!!)

Last rule SHOULD be Deny All (would turn the NSG into an explicit allow-list, not a deny-list)

DENY rules take precedence

(Traffic that doesn't match a NSG is denied)

## VPC

System routes controls traffic for VMs in scenarios:
  * between VMs in same subnet
  * between VMs in different subnets in the same VPC
  * traffic from VMs to the Internet

peer networks don't give transitive peering affects

Frequent patterns:
  * hub and spoke
  * User defined routes
  * service chaining

Gateway Transit allows peered virtual networks to share the gateway
### Service Endpoint

provides the identity of your virtual network to Azure.
Normally traffic from VPC - including traffic going to Azure resources - are marked with public IP. HOWEVER, using Service Endpoints means it'll use the VPC address when accessing Azure resources

### Peering VPCs


## Application Security Group

Let's you think about your network architecture from an application, not subnet / VPC level of abstraction.

Valid next hops:
  * virtual appliances
  * virtual network gateway
  * virtual network
  * internet
  * none

## W.R.T Hybrid Cloud

### Azure Private Link


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

# IAM

## Entra (Active Directory)

In hybrid scenarios you need to keep two different AD installs, but can connect them (Entra Connect) - one way sync.

Entra Domain Services: connects Azure Entra with a more AD like interface for applications to use

An Azure subscription must have only one Entra tenant but an Entra tenant may have multiple subscriptions

Characteristics of Entra:

  * Identity solution
  * Users and groups in a flat structure
  * Entra ID not queryable by LDAP
  * Entra ID doesn't use Kerberos
  * Includes OAuth federated signins

User accounts supported:

  * Cloud identity <-- only defined in Entra ID
  * Directory Synced  <-- defined in the on-prem AD
  * Guest user


### Entra Domain Services

Provides group policy joining, Kerberos auth to Entra tenant. Fully compatible with AD DS (does not require additional domain controllers in the cloud)

#### Entra B2B

Can give users in tenant A access to resources in tenant B.

### and users

You can assign users to a group, or there is Dynamic Assignment

## RBAC

Azure RBAC built on Resource Manager

Role definition: collection of permissions with a name that you can assign a user, group, or application

Parts:
  * Security Principal
  * Role Definition
  * Scope
  * Role Assignment     <-- attaches the role definition to security principal at scope

  Azure RBAC provides built in roles/scopes, and you can create custom ones

  System subtracts NoAction permissions from Actions permissions to arrive at ability

  Fundimental Roles:

    * Owner
    * Contributor  <-- can create and manage all types of Azure resources, but can't grant user access
    * Reader
    * User Access Administrator

### Seeing what permissions a user has

IAM -> Check Access
