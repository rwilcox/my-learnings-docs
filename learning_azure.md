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

## Monitor Activity Log

provides logging for subscription level events

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
