---
path: "/learnings/graph_databases_janusgraph"
title: "Learnings: Graph Databases: JanusGraph"
---

# Learning Graph Database: JanusGraph <<Learning_GraphDatabase_JanusGraph>>

## And Vertex IDs  <<Learning_GraphDatabase_JanusGraph_And_IDs>>
JanusGraph does not guarantee to respect user provided vertex and edge IDs
to do this you MUST set config option `graph.set-vertex-id` (true / false). Defaults to false.
(This is a feature as of Jun 2017)

NOTE ABOUT THIS FEATURE:

> but disables some of JanusGraph’s advanced features which can lead to inconsistent data.
> EXPERT FEATURE - USE WITH GREAT CARE.

REFERENCE: https://github.com/JanusGraph/janusgraph/issues/45

### Why not??

> The (64 bit) vertex id (which JanusGraph uniquely assigns to every vertex) is the key which points to the row
> containing the vertex’s adjacency list.
>
> AND sometimes JanusGraph adjusts these keys to put related vertices together (index free adjacency)

## Configuration <<Learning_GraphDatabase_JanusGraph_Configuration>>

### Cassandra

Q: Still requires Thrift ??


Config file

    storage.backend=cassandra <--- can a
    storage.cassandra.keyspace=mykeyspacename  <---- defaults to janusgraph
  
### indexes, buildIndex, and multiple index stores

NOTE:

    index.A_NAME_I_CAN_USE.backend=elasticsearch           <-- these "shorthands" are defined in JanusGraph configuration reference: http://docs.janusgraph.org/latest/config-ref.html#_index_x_elasticsearch
    index.A_NAME_I_CAN_USE.index-name=my_searchy_index

When you need to do `management.buildIndex` you MUST give this `A_NAME_I_CAN_USE` to the `buildMixedIndex` method


## Indexing  <<Learning_GraphDatabase_JanusGraph_Indexes>>

Both Composite and Mixed Indexes require reindexing if a new index is working on already present data.

>  Enable the force-index configuration option in production deployments of JanusGraph to prohibit graph scans.

### Composite Indexes

  * previously defined combination of property keys
  * Do not require external indexes (ie Elasticsearch)
  * CAN be used to enforce uniqueness
  * ALL keys in the index MUST be found in the traversal for this to work
    
### Mixed Indexes

  * support full text search, range search, geo search
  * some indexing options dependent on backend
  * can restrict index to particular vertex or label edge ("don't index ALL the name properties of vertices, just ones that match this label")
  * can speed up order().by() queries
  
### Vertex Centric Indexes

> local indexes built individually per vertex

IE a vertex can have an index for all its edges, thus if you have a supernode type problem you can traverse selected edges faster (vs iterating *all* edges)

Multiple vertex centric indexes can be built for same edge label to support different traversals.
Traversals can be answered with vertex centric indexes if order key watches the key of the index and the requested order is the same as the one defined by the index.

> JanusGraph automatically builds vertex-centric indexes per edge label and property key. That means, even with thousands of incident battled edges, queries 
> like g.V(h).out('mother') or g.V(h).values('age') are efficiently answered by the local index.

### Indexing and (Index free) adjacency

See: Learning_JanusGraph_DataModel_Traversals

## Data Model and how it affects speed of queries <<Learning_JanusGraph_DataModel_Traversals>>


In BigTable / Column family stories:

  * vertexes are stored as: vertex ID -> property cell, property cell, property cell, edge cell, edge cell, edge cell

Edge cells contain label id / direction, sort key, adjact vertex id, edge id

Property cells contain key id property id and property value

Each edge / property are stored in one cell of its adjacent vertices.

If storage backend supports key order JanusGraph 

## See Also:

  * the concept of schema in graph databases (JanusGraph lets you do this!!): https://stackoverflow.com/a/48500665/224334
