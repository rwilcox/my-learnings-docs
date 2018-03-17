---
path: "/learnings/cassandra"
title: "Learnings: Cassandra"
---

# <<Learning_Cassandra>>

# about

Tables - really "column families"

Why? Model a Group table . easy / idiomatic way to do this is to have columns for each user in the group

## Cassandra and "data duplication"

If you have a bunch of tables that have "duplicated data", Cassandra is smart about using pointers to already existing data on disk, not necessarily duplicating the actual bytes (unless it has to).

Digging in questions:
  
  * Q: Is this helped because it's technically a column store, not a row store?
  * A:
  * Q: Are these pointers copy on write? What about if I propagate a name change across multiple tables because I'm updating a name, will this cause a ripple up then eventually ripple down in data storage needs? Or is this part of compaction????
  * A:

### Other ways to ensure data consistency

  * occasional batches to reflect data into other indexed tables
  * Spark / (SparkSQL) over Cassey
  * Solar

# indexes

Are required to search for record by anything other than the primary key

> [because data is partioned] each node must maintain its own copy of a secondary index based on the data stored in partitions it owns. For this reason, queries involving a secondary index typically involve more nodes, making them significantly more expensive.

## TTL fields

Cassy has them, just like redis

# tables

what you're used to in RDBS.

(Tables: exist on every host)

# partitions

Partitions in Cassandra are determined by *primary* or composing key. can also use clustering ""WITH CLUSTERING" statement so can control ordering.

Ideally a query will want to only read one partition: this means the query only has to get data from one node, vs all the nodes in the cluster.

Partitions: replicated out, but not all nodes in a cluster may have a particular cluster.

## "primary key" statement in CQL: does NOT guarantee uniqueness, it is **ONLY** a partition key
it is not analogous to a SQL primary key!!


PRIMARY KEY = PARTITION KEY + CLUSTERING COLUMNS

first column in the primary key class is a partition key. Second items are clustering columns

    PRIMARY KEY state, city
    
best practice: use 

    PRIMARY KEY ( (state), city )
    
### See also:

  * Cassandra_Primary_Key_Considerations

## composite partition key

    PRIMARY KEY ( (state, city) )

^^^ but means you have to query state + city every time, AND state must come first

## Partition sizing

> The number of values (or cells) in the partition (Nv) is equal to the number of static columns (Ns) plus the product of the number of rows (Nr) and the number of of values per row. The number of values per row is defined as the number of columns (Nc) minus the number of primary key columns (Npk) and static columns (Ns).

## How partition key limits your query options

CQL will warn you if you search on anything but the partition key. Cassy really wants to limit your queries to be on the same node in the cluster.

If you want to enable the developers to query Cassandra using different partition keys: ie developers are searching by name, and state, and company. Then you should create 3 different tables: one for primary key name, one for primary key state and one for primary key company.

### Thoughts around Java/$LANGUAGE programming patterns with these partition key limits

**NOTE**: this may mean you want to create services around data models, because your system may evolve from simple needs to multiple tables / multiple queries.

### how that affects writes

Application developer has to write to each of these tables (manually).

## Clustering Columns

A way of organizing the data in incrementing or decrementing sort order.

comes after the partitioning key in the primary key class

    PRIMARY KEY( (year), name, last_name )  <-- YEAR is the primary key, sorted by name or last name
    
Note: best to have clustering columns where the columns don't move much

Clustering columns increase disk space requirements.

## Primary Key: See Other:
  
  * Cassandra_Queries_Primary_Keys_Immutable_Concerns
  * Cassandra_Partition_Key_And_UDT_Thoughts
  * [Data Partitioning In Cassandra](https://docs.datastax.com/en/archived/cassandra/1.1/docs/cluster_architecture/partitioning.html#data-distribution-in-the-ring)

# tokens 

When inserting data into Cassey, will hash primary key. This value will be 0 -> 2^127.

Nodes in a cluster are given a token: the end of the range of hashes (aka primary keys) a node is responsible for.

With Cassey 3.0's [Virtual Nodes](https://docs.datastax.com/en/dse/5.1/dse-arch/datastax_enterprise/dbArch/archDataDistributeVnodesUsing.html) - each node in partion owns a large number of small partition range "nodes". If nodes are removed, through action or inaction, or new nodes are added, the cluster auto rebalances the tokens (it does not auto rebalance in the case of non-virtual nodes).

# snitches

Snitches way of identifying node by rack, machine, dc, etc etc.

Id what node with the data is the fastest to retrieve from determined also by which node has the most recent data. (Usually this correlates to location of a machine on a rack).

Can select a snitch based on simple, or based on different cloud  provider. (E.g.: org.apache.cassandra.locator.Ec2Snitch and Ec2MultiRegionSnith)

Popular one: `GossipSnitch`
(rack, DC details passed on as gossip information)

Determines the health of an node by heartbeating and figuring out how  healthy the node is on an accrual basis / probability of failure.


# replications

Replication controlled at a table level

`SimpleStrategy`: one ring, replication in this ring

`NetworkTopologyStrategy`: one ring, data copied to another ring ie across DCs

## Replication and data "I might not really care about" ie log entries

Still probably best to use replication factor of >= 3, and set the write consistency of 1: respond back to the client when at least one write happened... but the data should be copied to 3, ideally / eventually.

## Replication and partition size limits

In a ring a node is responsible for a range of tokens.

Excessive partition size: a node has reached size limits on acceptable size of responsible tokens. This is NEVER talking about replication size.

Partition record size is about 2B values (remember, _column store__!).

Note: these partition size limits are talking about theoretical limitations of Cassey, not about disk space!

# Consistency 

> Consistency is tuneable in Cassandra because clients can specify the desired consistency level on both reads and writes. 

## and network partitions

If message for node can not be delivered, coordinator for that message keeps a "hint" and will deliver when that node comes back online

## and transactions

Cassandra does have lightweight transactions but these are slightly expensive as they are a 4 stage process with Paxos (for more info read Laporte's Paxos Made Simple paper)

# schemes

## eventual considtancy of schema 

> schema information is itself stored using Cassandra, it is also eventually consistent, and as a result it is possible for different nodes to have different versions of the schema

## creation / modification in Java

com.datastax.driver.core.schemabuilder

This is not the best idea as a startup thing in your program, as you may have multiple instances of the same micro service launching at the same time and trying to create the same schema. (So, out of band??)

# and development

## ccm tool to set up fake cluster on your machine

GitHub/pcmanus/ccm

# Keyspace


# Field Types

## Time UUID: UUID contains timestamp embedded in the UUID

Q: How to eyeball the difference between UUID and TimeUUID?

    28442f00-2e98-11e2-0000-89a3a6fab5ef

                  ^ -----if the first number of the third chunk is 4(??) then it's a timeuuid, not a UUID
  
See also:

  * https://docs.datastax.com/en/cql/3.3/cql/cql_reference/timeuuid_functions_r.html

## Collection Columns

Notes:

  * __SMALL__ amounts of data!!!! It's not a BLOB!!!!
  * entire column is read
  * Can not nest a collection inside a collection

Types:  
  * Set
  * List
  * Map

## UDT

## COUNTER <-- not a guarantee of actual number - CAP theorm!! - will be approximately correct.

Also: NOTE: this demands a read before writes, thus will be slower than normal.

# Handling Writes

What stages a cassandra writes go into:

  1. Mem Table
  2. Commit log && FLUSH MEMTABLE <-- ammend only log of operations that happened on the database
       ^^^^^ is flushed when all data hits the SSTABLE
  3. SSTABLE <-- immutable records / file. Thus updated records will be stored multiple times in SSTABLE
  4. Compaction <-- looks at timestamp, tombstones, etc of SSTable and gets most up to date version of the "record"
    compaction only happens in a node itself
    
## Compaction and what that means for mutable primary keys  <<Cassandra_Queries_Primary_Keys_Immutable_Concerns>>

if you have a record where the primary key could be changing: ie you have a Person column with mailing state. When a person moves, then this record will be on two nodes: because records are "immutable" in Cassandra then the SSTable will be on one node, and then the modification will force that record to be on another node (most likely, assuming the partitioning scheme forces it to be out of a node).

Because compaction happens only at a node level, we will have an old record hanging out on the old node thanks to the changing partition key.

If your data model needs to guarantee a record is a singleton in your system, then your primary key should be a value that is immutable alway/forever. But also keep in mind your queries...

# Importing simple data into Cassandra

    COPY TABLE_NAME FROM 'videos'by_title_year' WITH HEADER=true;
    
If your CSV column names don't match the column names in your table:

    COPY bad_videos_by_tag_year (tag, added_year, video_id, added_date, description, title, user_id) FROM 'videos_by_tag_year.csv' WITH HEADER=true;
    
# Data Modelling #

Table naming best practice: `$NOUN_by_$SEARCH_NOUN` : `users_by_email`, etc etc.

<<Cassandra_Chebotko_Table_Diagrams>>:

UML :
  + K                       <-- partition key
  + C (up/down arrow )      <-- cluster fields, arrow notate assending or descending order of data
  + S                       <-- static: within a given partition this is defined just once
  + IDX                     <-- secondary index
  + []                      <-- collection column: list
  + {}                      <-- collection column: set
  + <>                      <-- collection column: map
  + **                      <-- UDT
  + ()                      <-- tuple column
  
<<Cassandra_And_Table_Modelling_Implications_For_ORMs>>
In Relational Model, all tables are entities themselves, and they are associated by queries / joins. In Cassandra the tables are (the result of a query).

Thinking about this from an ORM perspective: since tables are entities in the ORM world this mapping is 1:1. In Cassandra tables this is N:1... requires different thinking about this.

(Also, if you need to update many Cassandra tables when you've updated a name or whatever, well best to have an abstraction level over that).

## Data Modelling: What fields appear in the x_by_y fields: Gotta think about access patterns

The user case of the query may mean you need different data: if you have a video app, your "videos by user" access pattern may mean the query doesn't need to return the media encoding. It might... but it might not. Depends on your access patterns, you data and how it'll be used in the app.

If you find you always duplicate it all, you could defining a UDT to be "video" and use that, instead of individual fields on the tables.

<<Cassandra_Partition_Key_And_UDT_Thoughts>>
But you can not use a partition key inside a UDT: you would need to pull out your keyable attribute into a normal Cassandra field and then set that as a partition key.

<<Cassandra_Table_partion_ideals>>

  * Partition per query <-- ideal . Tables have own partition key
  * Partition+ per query <-- acceptable, but not ideal. Partition is so big that the data doesn't fit on only one node. Thus a couple nodes are required to get complete data set
  * Table scan <-- anti-pattern
  * multi table <-- anti pattern
  
## Data Modelling Mapping: Rules
These rules are also found in a paper: http://www.cs.wayne.edu/andrey/papers/bigdata2015.pdf

  * Rule 1: Entities and relationships:
  
    - Entities and relationship types map to tables
    - Entities and relationships map to partitions and row
    - Partition may have data about one or more entities and relationships
    - Attributes are represented by columns
    
  * Rule 2: Equality search attributes:
  
    - primary key is an ordered set of columns, made up of partition key and clustering columns
    - A partition key is formed by one or more of the leading primary key columns
    - Supported queries must include all partition key columns in the query
    - NOTE: equality should come first (set these as your partition key: this finds the node the partition lives on) THEN can do inequality searches
    
  * Rule 3: Inequality Search Attributes
    - Inequality search attributes become clustering columns
    - Clustering columns follow partition key columns in a primary key
    - The column involved in an inequality search must come after columns in the primary key that are used in an equality search

  * Rule 4: Ordering Attributes:
    - Ordering attributes map to clustering columns
    - In each partition, CQL rows are ordered based on the clustering columns
    - Ascending or descending order


  * Rule 5: Key Attributes:
    - Key attributes map to primary key columns
    - Primary key must include the columns that represent key attributes
    - Position and order of such columns may vary
    - Primary key may have additional columns to support specific queries

### Applying mapping rules:

  * Create table schema for the conceptional model and for each query
  * Apply the mapping rules in order
  
### Query driven methodology mapping patterns

Nine different patterns to use

## And it's implications on Disk usage

Calculating Disk Size: https://miguelperez.io/blog/2017/2/13/cassandra-data-modeling-notes#calculate-partition-size

    number of rows * ( number of columns - number of primary key columns - number of static columns) + number of static columns

See also: DS220 video on Physical Partition Size (Exercise 13): https://academy.datastax.com/resources/ds220-data-modeling

LATEX VERSION OF THIS FORMULA (paste it into Pages.app):

```
latex
\sum_{i}sizeof(partitionkey_i) + \sum_{j}sizeof(staticcolumns_j) + numrows * \sum_{k}(sizeof(regularcolumn_k) + \sum_{l}sizeof(clusteringcolumn_l))+8 * ( numrows * ( numcolumns - numprimarykeycolumns - numstaticcolumns) + numstaticcolumns
```

### Schema data consistency

  * with data duplication you need to worry about and handling consistency
  * all copies of the same data in your schema should have the same values
  * CRUD may require multiple INSERTS, UPDATEs and DELETEs
  * logged batches were built for maintaining consistency
  * document, assume people churn.

  
# Batches

https://docs.datastax.com/en/cql/3.3/cql/cql_reference/cqlBatch.html

Facts on Batch:
  * Written to log on the coordinator node and replicas before execution
  * batch succededs when the writes have been applied or hinted
  * replicas take over if the coordinator node fails mid batch
  * no need for rollback since Cassy will ensure that the batch suceeds
  * but no batch isolation: clients may read updated rows before the batch completes.
    ... thus may want to run these during the off peak hourse
  * not _really_ meant for data load: will not increase performance
  * might overwork coordinator
  * no ordering: all writes are executed with the same timestamp
  
# Joins in Cassandra

## Client side joins only

Cassandra WILL create caches or temporary like tables where's it notices you're running two queries soon after another, and will combine/cache tables behind your back.

1+N queries the norm, not the exception.

# Transactions and ACID in Cassandra

  * No transactions
  * INSERTS, UPDATEs, DELETE are atomic, isolated and durable (*not* consistent. Yay 3/4)
  * Tunable consistency for data replicated to nodes, but does not handle application integrity constraints
  * INSERT INTO.... IF NOT EXISTS statements. "Lightweight transactions"...

## Aggregations 

  * SUM, AVG, COUNT, MIN, MAX supported in super latest version of Cassandra. Supported in partition / node only.
  * ... or use counter type, aggregation in client side, use Spark or Solr.
  

# Keys to success  <<Cassandra_Primary_Key_Considerations>>

  * Minimum possible uniqueness
  * minimality: minimum number of columns for uniqueness

# Performance considerations / table optimizations <<Cassandra_Performance_Thoughts>>

Fixing the problem:

  * Splitting partitions  - size manageability:
    - add another column to partition key (either use an existing column or create an artifical column)
    - idea: fewer rows per partition
    - ... or introduce a bucket number and artificially create a partitioner, Kafka style...
    
  * Vertical Partitioning - speed:
    - some queries may perform faster
       No query profiler or optimizer to tell you if your queries are horrible given the data
       
    - reverse of vertical partitioning: ma
    - table partitions become smaller
    - faster to retrieve and more of them can be cached.
    
  * Merging partitions and tables - speed + eliminating duplication (+ reducing N+1 queries required):
  * Adding columns
    - like add an aggregation column, or denormalize data
    - ... or maybe avoid COUNTERs, as it will require a READ before doing a write
  
## Concurrency notes:

### ... and lightweight transactions

  * correctness is guaranteed
  * any update operation
  * performance penalty
  * failed LWTs must be repeated

### Isolate computation by isolating data

... by that means splitting out stats into own table

  * when correctness is not an issue
  * aggregation must be done by an application
  * ... then store back to Cassandra

# Datastacks Enterprise Bundle    <<Cassandra_DataStack_Enterprise_Bundle>>

  * DSE Graph: TitanDB
  * DSE Search: Cassandra + Solr
  * DSE Analytics: Cassandra, Spark



# Cassandra Operationally

Term:

  * data center: one ring in a cluster
  * 
  
## Configuration Location

/etc/cassandra/conf/*.yml

cassandra-env.sh <-- shell script that launches cassandra server. also sources jvm.options

and jvm.options <-- lets tweak JVM 

Files per node

## Min properties:

  * `cluster_name`    <-- should be the same across 
  * `listen_address`  <-- needs to be a real address, not 0.0.0.0, because this address is publicized and needs to be resolvable inside the node. Can be comma(?) delimited if multiple NICS
  * `seed_node`       <-- first point of contact
  * `rpc_address`     <-- This is the IP address that clients such as cqlsh will use to access this node

## Java Properties settings

  * `MAX_HEAP_SIZE`: set to a max of 8GB
  * `HEAP_NEW_SIZE`: set to 100MB per code
     ^^^ --- larger this is longer GC pause times will be
  * JMX port: by default 7199, set by cassandra-env.sh

# Hinted Handoff

Data for a node that's unavailable. Will be flushed after a while, or when the node comes back online


## Cluster sizing

This is an estimation process. Things to consider:

  * Throughput: how much data per second:
    - data movement per time period
    - consider reading and writing independently
    - f of:
      - operation generators (ie users, stream processing results)
      - rate of operation generation
      - size of operations (number of rows * row width)
      - operation mix (read/write ratio)
      
  * growth rate: how fast does data capacity increase?:
    - how big must the cluster be just to hold the data?
    - Given write throughput we can calculate growth. NOTE: velocity of growth may change / spike over time (pre season, in season, big news, finals, big news during finals, off season)
    - what is the ideal replication factor?
    - additional headroom for operations
    
  * latency: how quickly can the cluster respond?:
  
    - calculating cluster size not enough
    - Understand SLAs!!!:
      - latency
      - throughput
     
    -  Relevant factors:
      - IO rate
      - workload shape
      - access patterns
      - table width
      - node profile (cores, memory, storage, storage kind/speed, network)

  * Cluster sizing:
  
    - validate assumptions often
    - monitor for changes over time
    - plan for increasing cluster size before you need it
    - be ready to scale down when needed
    
# Cassandra Stress

stress / performance tool for cluster

* Configured via YML file, where you define schema, compaction strategy, create characteristic workload for cluster

# Nodetool performance stat tool

Runs on individual nodes, have to run this on all nodes in a cluster to get complete picture

## nodetool tablestats -h <-- -h = human, else just hashes...

## nodetool tablehistogram KEYSPACE TABLE <-- table and keyspace must exist on node (as primary or as replication)

There is a command to know what/where tables reside in your cluster

# Large Partitions

  * Will log: "Writing large partition" or "Compacting large partition". This warning can be configured: via `compaction_large_partition_warning_threshold_mb`

# Monitoring

  * uses slf4j
  * [configured via logback.xml file](https://docs.datastax.com/en/cassandra/2.1/cassandra/configuration/configLoggingLevels_r.html)
  

# Adding nodes:

  * when space on node is > 50%  
     Q: Why? Compaction uses disk space!! It requires a "file" copy operation, not just a move operation...
  * new nodes added will not be avail for read/write while join process is happening...
  * existing nodes will continue to handle requests, even if the new node should be handling
    that partition range / tokens (writes also forwarded to joining node)


# Removing nodes:

  * different ways to do this, from "please" to "do" to "assassinate "
  * NOTE: if "you" have removed a seed node:
    - then you need to: adjust the cassandra.yml file on all the different nodes to tell them to not remove them.
    - if you have multiple hosts in the seed node declaration, it will try, log and move to the next one

See also:



# Seed node thoughts <<Cassandra_Seed_Node_Thoughts>>

seed node values are read in the following situations:    
  + join of a totally new node (newly provisioned instance that you are adding back to a cluster)
  + Cassey dies on an existing node and a monitor has restarted the process
  + but do NOT set all nodes as a seed node: https://issues.apache.org/jira/browse/CASSANDRA-5836

Petzel: 
> I haven't done it yet, but what you just asked about [seed nodes in an unstable, AWS situation] is a big concern I've had,
> especially with churn over time you might eventually get all stale entries. You can provide your own seed provider (look in yaml)
> `class_name: org.apache.cassandra.locator.SimpleSeedProvider` so I wanted to write a seed provider that inspect the
> AWS API looking for tags, so you never have to maintain the file at all
> The same class could then be used by the client application to avoid having to hard code seeds in it (which you have to do as well)
> The provider class is dirt simple, https://github.com/apache/cassandra/blob/trunk/src/java/org/apache/cassandra/locator/SimpleSeedProvider.java



# cqlsh commands #

     $ cqlsh $A_CASSANDRA_HOST
     cqlsh> DESC keyspaces;

		dse_security   system_auth  dse_leases  system_distributed  dse_perf
		system_schema  system       stresscql   system_traces       dse_system
    
	 cqlsh> DESCRIBE KEYSPACE stresscql;

		CREATE TABLE stresscql.user_by_email (
		    email text PRIMARY KEY,
		    password text,
		    user_id uuid
		) WITH bloom_filter_fp_chance = 0.01
		....
		
# Care and feeding of Cassey Clusters

# Compaction

## Leveled compaction

Cassandra uses a bunch of different levels: level 0: to 16MB, level 1 to 160MB, level 2 1600MB (levels grow by 10x)

`sstable_size_in_mb` <-- how to tweak this compaction.

Leveled compaction good++ for heavy reads: each partition resides in one SSTable per level (max)
Generally reads handled by just a few SSTables

Best for high read, low write situations: the compaction will eat up IOPS

Need 4 of the same size before they compact again: this may result in unpredictable reads when there's a lot of writes: remember ideally we want to read a partition from one SSTable...

## Size tier compaction

Tiers categorized by record size: this is a moving average of the size of the SSTables in that group

The smaller the SSStables, the thinner the difference between mix and max threasholds.

Similar sized SSTables, system will make a random choice.

this is the default

### chooses hotest tier to compact first

(number of reads per second per partition key)

## Time Windowed compaction

  * built for time series data
  * records made in the hour will compact into tier / same SSTable
  * so if you have usage that cares / peaks around certain times (prime time viewing, etc etc) this may work for you
  * good practice to use 50 SS tables:
    - 20 for active data
    - 30 for previous time series data
    
New in Cassey 3.0


## Compaction requirements

Compacts tiers concurrently

`concurrency_compactors`: default to smaller number of disks or number of cores, with a min of 2 and max of 8 per CPU core
   remember you need to balance user performance + snitches + replications + compaction!
   
## Compactions and tombstones

  * compaction eliminates tombstones
  * largest SSTable choosen first
  * compaction ensures tombstones DO NOT overlay old records in other SSTables <-- ie old tombstones on other replications is deleted too
  
# Repair

Repair = synchronizing replicas

Happens:
  * 10% of time
  * when detected by reads: something fails QUORUM 
  * randomly with non quorum reads
  * `nodetool repair` <-- that node becomes inactive until repair finishes
  * happens in background of read request
  
Why?:

  * node may go down and miss writes
  * was down for too long and missed the hinted handoff
  * manual repair might be good if node was down for 3 hours and you're just now discovering it

Notes:

  * primary node of partition / token the only node that repairs that data (Cassey will fan this out anyway, why have everyone do it???)
  * can also do sub range repairs: break it down into subrange if a lot of data needs to be repaired.
  * suggested manual repair "every so often", yay entropy. (can schedule this via OpsCenter and have it do rolling repairs)
  
# SSTable Tools

## SSTableSplit

If you have a large SSTable that you don't want / may not get compacted for (time the system has taken to take get that much data) * 3... which might be some time

can NOT do this on a running node.

NOTE: table split **won't work** with time tiered - this is based on when the events happened, not on the size of the tables....

## SSTableDump

A diagnostic tool to dump SSTable files to JSON so you can inspect them

(will want to do a `nodetool flush` first...)

## SSTableLoader

Useful if you want to mirror or commission a new cluster 

Loads streams a set of SSTable data files to a live cluster. It transfers the relevant parts of each node, etc

Want to make sure the tables are already repaired, because this will not  happen automatically

Uses cassandra gossip to figure out topology of clusster

Needs properly configured cassandra.yml file

# "Data center"

Adding a second ring/data center

Note: you'll want to use `local` consistency levels here, to avoid a cross region network trip

Theoretically one data center going down may be unnoticed, but queries may take a while...

great to replicate across data centers, not great to *read* across data centers.
Need to specifically select your snitch.

# Snapshot

Snapshots made on each machine (but not great for machine specific hardware failure)
`tablesnap` <-- useful for backing up to S3

Note: these are not deleted, snapshots may grow if you're not careful

`nodetool clearsnapshot` <-- will remove all snapshots on a node

## Restoring

Delete current data files and copy snapshot and incremental files to the data directories

  * schema must be already present
  * restart and repair the node after file copy done
  
Or use sstableloader:

  * great if you're loading into a diff size cluster
  * will also be intensive on your cluster

# JVM Settings

# Profiling

## nodetool tpstats

* Cassandra uses SEDA: Staged Event Driven Architecture
* you can see the various stages and how they are going...

  * OpsCenter
  * JMX Clients
  
# Hardware Selection

## Memory

Production: 16GB to 64GB: min is 8GB
Development in non-load testing envs: min is 4

## CPU

  * will take all processors (no recommendation to give the OS a CPU itself)
  * Current sweet spot: 16 core (dedicated), 8GB (vm)
  
## Network

  * bind OS stuff to a separate NIC
  
## On The Cloud

  * GPU or IO2 EBS if you can't get ephemerals
  * Get big ones, get at least 3TB, as Cassy sweet spot seems to be 1.5GB (and then you have 50% for compaction etc needs)
  * Since hyperthreading: don't get a CPU most of the time, tune accordingly
  * CPU steal / noisey neighbors
  * AWS: may want to turn on enhanced networking on some instance types to get performance
  
# Hadoop style nodes: Big Fat Nodes

  * fat nodes are hot nodes == bad idea
  
# Authentication / Authorization #
  * Cassey stores auth data in "system_auth" <-- when using this make sure you ALTER your keyspace to tweak the replication;
  
  * system_auth.roles <-- roles etc just use this special Cassey table you need to define

        cql> select * from  system_auth.roles;
        cql> CREATE ROLE wilma WITH PASSWORD = 'Bambam' AND SUPERUSER = true AND LOGIN = true;
		cql> GRANT SELECT ON killr_video.user_by_email TO fred;
        cql> REVOKE DROP ON killr_video.user_by_email FROM fred;


## GRANT Abilities

Permission 	CQL Statements

| GRANT *   | What it does                                             |
----------- | :------------------------------------------------------ :|
| SELECT    | SELECT                                                   |
| ALTER     | ALTER KEYSPACE, ALTER TABLE, CREATE INDEX, DROP INDEX    |
| AUTHORIZE | GRANT, REVOKE                                            |
| CREATE    | CREATE KEYSPACE, CREATE TABLE                            |
| DROP      | DROP KEYSPACE, DROP TABLE                                |
| MODIFY    | INSERT, DELETE, UPDATE, TRUNCATE                         |
