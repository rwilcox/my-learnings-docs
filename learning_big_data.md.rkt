#lang scribble/text
@(require "scribble-utils.rkt")

---
path: "/learning/big_data"
title: "Learning Big Data"

# Parts to Hadoop Architecture


```graphviz
digraph A {
// Applications layer
    MapReduce [label="MapReduce (Batch)"];
    Spark [label="Spark (In-Memory)"];
    Storm [label="Storm (Streaming)"];
    Hive [label="Hive(SQL)"];

// YARN layer
    YARN [label="YARN (Yet Another Resource Negotiator)"];

// HDFS layer
    HDFS [label="HDFS (Hadoop Distributed File System)"];

    // Cluster layer
    Cluster [label="Cluster of economy disks and processors"];

MapReduce -> YARN
Spark -> YARN
Storm -> YARN
Hive -> YARN

YARN -> HDFS

HDFS -> Cluster
}
```

Cluster identified by master / worker nodes.

Services:
  * NameNode <-- directory tree of the file system and location
  * Secondary NameNode
  * DataNode <-- worker

YARN:

  * ResourceManager   <-- allocates and monitors cluster resources
  * ApplicationMaster <-- coordinates applications being run
  * NodeManager       <-- runs and manages processing tasks on an individual node / reports status
