---
path: /learnings/graph_databases
title: 'Learnings: Graph Databases'
---
# Table Of Contents

<!-- toc -->

- [Learning Graph Database : Gremlin / Tinkerpop >](#learning-graph-database--gremlin--tinkerpop-)
  * [Exploring a graph in Gremlin Console](#exploring-a-graph-in-gremlin-console)
    + [See also](#see-also)
  * [TinkerPop APIs](#tinkerpop-apis)
    + [Graph Structure API (org.apache.tinkerpop.gremlin.structure.Graph) >](#graph-structure-api-orgapachetinkerpopgremlinstructuregraph-)
    + [Traversal API (org.apachae.tinkerpop.gremlin.process.dsl.graph.GraphTraversal) >](#traversal-api-orgapachaetinkerpopgremlinprocessdslgraphgraphtraversal-)
    + [and connecting to Gremlin Server](#and-connecting-to-gremlin-server)
      - [Remote connection example (JanusGraph)](#remote-connection-example-janusgraph)
  * [Profiling](#profiling)
  * [See also:](#see-also)
- [Learning Graph Database: Gremlin-Scala >](#learning-graph-database-gremlin-scala-)
  * [and remote Gremlin Servers](#and-remote-gremlin-servers)
  * [See also:](#see-also-1)
- [Learning Graph Databases: Gremlin Server >](#learning-graph-databases-gremlin-server-)
  * [Setting up for HTTP mode](#setting-up-for-http-mode)
  * [Samples for HTTP mode](#samples-for-http-mode)
  * [And HA concerns](#and-ha-concerns)
  * [And configurations that matter to the client](#and-configurations-that-matter-to-the-client)
  * [See also:](#see-also-2)
- [Learning Graph Databases: Gremlin Console >](#learning-graph-databases-gremlin-console-)

<!-- tocstop -->

# Learning Graph Database : Gremlin / Tinkerpop <<Learning_GraphDatabase_Gremlin_Tinkerpop>>

## Exploring a graph in Gremlin Console

    gremlin> g.V().has("name", "saturn")    // queries for verticies that have name "saturn"

    gremlin> g.V().has("name", "saturn").outE()  // gets edge coming out

### See also

  * [IBM CloudDocs creating / traversing a Graph using Gremlin console](https://console.bluemix.net/docs/services/ComposeForJanusGraph/tutorial-gremlin-console.html#creating-and-traversing-a-graph-using-gremlin-console)
  * [Gremlin Graph Guide PDF](https://github.com/krlawrence/graph)  <--- TinkerPop, Gremlin, and Janus Graph!!!

## TinkerPop APIs

### Graph Structure API (org.apache.tinkerpop.gremlin.structure.Graph) <<Learning_GraphDatabase_Gremlin_Tinkerpop_APIS_Structure>>

Gremlin Guide, section 4.5.1:

> It is strongly recommended that the traversal source object g be used when adding, NOTE updating or deleting vertices and edges. Using the graph object directly is not
viewed as a TinkerPop best practice.

- source ????????

### Traversal API (org.apachae.tinkerpop.gremlin.process.dsl.graph.GraphTraversal) <<Learning_GraphDatabase_Gremlin_Tinkerpop_APIS_Traversal>>

NOTE: Need to always call `.next()` or `.iterate()` to save data to the graph. [Source](https://stackoverflow.com/a/44653972/224334)

ALSO: https://tinkerpop.apache.org/docs/current/reference/#graph-traversal-steps

### and connecting to Gremlin Server

  1. MUST(??) use Websockets mode for server instead of HTTP mode for Gremlin / Tinkerpop communications

Tinkerpop when given address will create ws:// URL instead of http:// [line](https://github.com/apache/tinkerpop/blob/453665d34e9a990def47e1ed35d18013b3286cbf/gremlin-driver/src/main/java/org/apache/tinkerpop/gremlin/driver/Host.java#L93)

  2. Can ONLY run Websocket Mode OR HTTP mode - can not run both [Stackoverflow answer](https://stackoverflow.com/a/37655156/224334)

  3. Remote connections are done via [(Remote) Traversal API](http://tinkerpop.apache.org/docs/3.3.1/reference/#connecting-via-remotegraph)

#### Remote connection example (JanusGraph)

    val graph = JanusGraphFactory.open("inmemory")
    val g : GraphTraversalSource = graph.traversal().withRemote( conf )

Q: Why not `EmptyGraph()`, like the examples say?

A: EmptyGraph doesn't seem to support transactions, add edges, etc etc. (???). See also [stackoverflow answer on JanusGraphFactory inmemory](https://stackoverflow.com/a/45733898/224334)
... because it doesn't have the JanusGraph goodness baked in (EmptyGraph is a Tinkerpop thing!)

## Profiling

`.profile` <-- outputs time / traverse info about your traversal

## See also:

  * https://github.com/tinkerpop/gremlin/wiki/basic-graph-traversals



# Learning Graph Database: Gremlin-Scala <<Learning_GraphDatabase_Gremlin_Scala>>

## and remote Gremlin Servers

??? Need to be careful about what is and is not supported with gremlin server
ie: + , -----, operators may not use the Traversal API (see: Learning_GraphDatabase_Gremlin_Tinkerpop_APIS_Traversal )
and may not support certain operations (????)

  * [My Github issue comment here](https://github.com/mpollmeier/gremlin-scala/issues/223)


## See also:

  * [Gremlin-Scala Examples](https://github.com/mpollmeier/gremlin-scala-examples)

# Learning Graph Databases: Gremlin Server <<Learning_GraphDatabases_Gremlin_Server>>

Can only use one mode: HTTP or WebSockets mode.
Sources:
  * [Stackoverflow answer](https://stackoverflow.com/a/37655156/224334)
  * [Answer to JIRA Ticket filed in TINKERPOP Project RE this topic](https://issues.apache.org/jira/browse/TINKERPOP-815?focusedCommentId=14718523&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-14718523)


## Setting up for HTTP mode

NOTE: configuration _only_ valid for server. If you try to connect via Gremlin with this configuration it will barf
(only partially related to URL schema of ws:// by Tinkerpop)

In config file set:  `channelizer: org.apache.tinkerpop.gremlin.server.channel.HttpChannelizer`

NOTE: HTTP / "REST" mode is not really RESTful

## Samples for HTTP mode

  * [Sample CURL statements / responses for HTTP/REST](http://tinkerpop.apache.org/docs/3.2.3/reference/#_connecting_via_rest)
  * [Connecting to JanusGraph with HTTP Requests](https://help.compose.com/docs/janusgraph-connecting-to-janusgraph-http-requests)


## And HA concerns

  * [Stackoverflow answer for Gremlin Servers behind load balancers](https://stackoverflow.com/a/47434207/224334)
  * Health Check: `http://myhostname:8182/?gremlin=100-1` <-- or `ws://...` ( [Stackoverflow answer source](https://stackoverflow.com/a/46513187/224334) )

    NOTE: in Websocket mode this connection, of course, never closes. In HTTP mode it does not keep alive.

## And configurations that matter to the client

??? `graphs: { }` in gremlin-server.yml needs to have same graph name in it as the Gremlin clients are trying to connect to (need to share YAML file, or parts of YAML file somehow??????)

## See also:

  * And using gremlin servers: https://github.com/mpollmeier/gremlin-scala/issues/223#issuecomment-362314314


# Learning Graph Databases: Gremlin Console <<Learning_GraphDatabase_Gremlin_Console>>

    gremlin> graph = JanusGraphFactory.open('janusgraph.properties')
    Backend shorthand unknown: janusgraph.properties

^^^^^ means that it can not find the properties file you are pointing at. Try using a relative path or just the full path in your string.

