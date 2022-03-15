#lang scribble/text

---
path: /learnings/learning_time_series_database_druid
title: Learning Druid
---

# Druid Setup

@quote-highlight[#:title "Design · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/architecture.html"]{
Druid has several process types, briefly described below:
  * **Coordinator** processes manage data availability on the cluster. The workload on the Coordinator process tends to increase with the number of segments in the cluster. They watch over the Historical processes on the Data servers. They are responsible for assigning segments to specific servers, and for ensuring segments are well-balanced across Historicals.
  * **Overlord** processes control the assignment of data ingestion workloads. They watch over the MiddleManager processes on the Data servers and are the controllers of data ingestion into Druid. They are responsible for assigning ingestion tasks to MiddleManagers and for coordinating segment publishing.
  * **Broker** processes handle queries from external clients.
  * **Router** processes are optional; they route requests to Brokers, Coordinators, and Overlords.
  * **Historical** processes store queryable data. They handle storage and querying on "historical" data (including any streaming data that has been in the system long enough to be committed). Historical processes download segments from deep storage and respond to queries about these segments. They don't accept writes.
  * **MiddleManager** OR **Indexer** processes ingest data. Instead of forking separate JVM processes per-task, the Indexer runs tasks as individual threads within a single JVM process
  * **Supervisor** if you are using a streaming ingest somewhere
  }

External Dependencies:

  * Zookeeper
  * ingestion method
  * long term storage for segments (DB, block storage or big data cluster)
  * metadata storage

- [TODO]: what kind of data stores for metadata storage?


@quote-highlight[#:title "ZooKeeper · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/dependencies/zookeeper.html"]{
The operations that happen over ZK are:
  * Coordinator leader election
  * Segment "publishing" protocol from Historical
  * Segment load/drop protocol between Coordinator and Historical
  * Overlord leader election
  * Overlord/MiddleManager task management
  * Overlord to Indexer taks management. (Note: generated tasks - ie perfect rollups - may get very large depending on number of segments or metric columns involved)
  }


# Design of Druid Data Structure

@quote-highlight[#:title "Design · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/architecture.html"]{Druid data is stored in datasources, which are similar to tables in a traditional RDBMS. Each datasource is partitioned by time and, optionally, further partitioned by other attributes }


Each record in Druid:
  * timestamp
  * dimensions
  * metrics

Dimensions are bits of data that relate to the topic at hand. For example, building an analytics tool, would be:

  * browser type
  * page URL

Druid can then allow you to group records with distinct timestamps into a time series and let's you see to see how many times in an hour a particular URL was visited by Firefox.

And that eventually the cardinality of that will increase as you group more and more records together: the metrics part will be aggregated together as they now "cover" the same time period. (Logically. Physically these may reside in seperate segments). ie Druid's idea of what "the same timestamp" is is Waayyyyy more flexible and different from what ie Postgres or Java thinks of as the same timestamp.

(This is the granularity)


> my understanding is that any time it’s creating a segment chunk it will kind of by nature merge any data with matching timestamp and dimensions

- DG

@quote-highlight[#:title "Introduction to Apache Druid · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/"]{Columnar storage format. Druid uses column-oriented storage }



## Configuring the Supervisor for your datastore

@quote-highlight[#:title "Apache Kafka ingestion · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/development/extensions-core/kafka-ingestion.html"]{When a supervisor spec is submitted via the POST /druid/indexer/v1/supervisor endpoint, it is persisted in the configured metadata database. There can only be a single supervisor per dataSource, and submitting a second spec for the same dataSource will overwrite the previous one.

Q: Is this only for Kafka, or for all?
}

## Your datastore schema

### General Schema Design

@quote-highlight[#:title "Schema design tips · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/schema-design.html"]{At the time of this writing, Druid does not support nested dimensions. Nested dimensions need to be flattened }

@quote-highlight[#:title "Schema design tips · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/schema-design.html"]{Druid columns have types specific upfront and Druid does not, at this time, natively support nested data. }

@quote-highlight[#:title "Schema design tips · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/schema-design.html"]{Create metrics corresponding to the types of aggregations that you want to be able to query. Typically this includes "sum", "min", and "max" (in one of the long, float, or double flavors). If you want to be able to compute percentiles or quantiles, use Druid's approximate aggregators. }

@quote-highlight[#:title "Schema design tips · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/schema-design.html"]{Druid does not think of data points as being part of a "time series". Instead, Druid treats each point separately for ingestion and aggregation. }

@quote-highlight[#:title "Schema design tips · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/schema-design.html"]{Druid is not a timeseries database, but it is a natural choice for storing timeseries data. Its flexible data model allows it to store both timeseries and non-timeseries data, even in the same datasource. }

@quote-highlight[#:title "Schema design tips · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/schema-design.html"]{Totally flat schemas substantially increase performance, since the need for joins is eliminated at query time. As an an added speed boost, this also allows Druid's query layer to operate directly on compressed dictionary-encoded data.  }

@quote-highlight[#:title "Schema design tips · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/schema-design.html"]{In Druid, on the other hand, it is common to use totally flat datasources that do not require joins at query time }


### Nulls and Druid

@quote-highlight[#:title "Segments · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/segments.html"]{By default, Druid string dimension columns use the values '' and null interchangeably and numeric and metric columns can not represent null at all, instead coercing nulls to 0. However, Druid also provides a SQL compatible null handling mode, which must be enabled at the system level, through druid.generic.useDefaultValueForNull. This setting, when set to false, will allow Druid to at ingestion time create segments whose string columns can distinguish '' from null, and numeric columns which can represent null valued rows instead of 0. }

### Rollup

@quote-highlight[#:title "Druid data model · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/data-model.html"]{Metrics are columns that Druid stores in an aggregated form. Metrics are most useful when you enable rollup. If you specify a metric, you can apply an aggregation function to each row during ingestion }

@quote-highlight[#:title "Druid data model · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/data-model.html"]{If you disable rollup, then Druid treats the set of dimensions like a set of columns to ingest. The dimensions behave exactly as you would expect from any database that does not support a rollup feature. }

@quote-highlight[#:title "Druid data model · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/data-model.html"]{Druid also uses the primary timestamp column for time-based data management operations such as dropping time chunks, overwriting time chunks, and time-based retention rules. }

## Segments

@quote-highlight[#:title "Design · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/architecture.html"]{Druid stores data in files called segments. Historical processes cache data segments on local disk and serve queries from that cache as well as from an in-memory cache. }

@quote-highlight[#:title "Design · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/architecture.html"]{Each time range is called a chunk (for example, a single day, if your datasource is partitioned by day). Within a chunk, data is partitioned into one or more segments. Each segment is a single file, typically comprising up to a few million rows of data }


@quote-highlight[#:title "Segments · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/segments.html"]{For example, if you have hourly segments, but you have more data in an hour than a single segment can hold, you can create multiple segments for the same hour. These segments will share the same datasource, interval, and version, but have linearly increasing partition numbers. }

@quote-highlight[#:title "Segments · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/segments.html"]{The smoosh files represent multiple files "smooshed" together in order to minimize the number of file descriptors that must be open to house the data. They are files of up to 2GB in size (to match the limit of a memory mapped ByteBuffer in Java) }
@quote-highlight[#:title "Segments · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/segments.html"]{Identifiers for segments are typically constructed using the segment datasource, interval start time (in ISO 8601 format), interval end time (in ISO 8601 format), and a version }


@quote-highlight[#:title "Segments · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/segments.html"]{For Druid to operate well under heavy query load, it is important for the segment file size to be within the recommended range of 300MB-700MB. If your segment files are larger than this range, then consider either changing the granularity of the time interval or partitioning your data and tweaking the targetPartitionSize in your partitionsSpec (a good starting point for this parameter is 5 million rows). }

## Data flowing through Druid

@quote-highlight[#:title "Design · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/architecture.html"]{On the ingestion side, Druid's primary ingestion methods are all pull-based and offer transactional guarantees }

@quote-highlight[#:title "Design · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/architecture.html"]{On the Coordinator / Historical side:The Coordinator polls the metadata store periodically (by default, every 1 minute) for newly published segments.When the Coordinator finds a segment that is published and used, but unavailable, it chooses a Historical process to load that segment and instructs that Historical to do so.The Historical loads the segment and begins serving it.At this point, if the indexing task was waiting for handoff, it will exit. }


# Ingest

Can ingest from multiple data sources

Can also apply ingest side filters, transforms and un-nestle data

@quote-highlight[#:title "Ingestion · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/index.html"]{Streaming ingestion uses an ongoing process called a supervisor that reads from the data stream to ingest data into Druid }


@quote-highlight[#:title "Introduction to Apache Druid · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #url  "https://druid.apache.org/docs/latest/design/"]{Druid supports streaming inserts, but not streaming updates }

@quote-highlight[#:title "Design · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/architecture.html"]{Supervised "seekable-stream" ingestion methods like Kafka and Kinesis are idempotent due to the fact that stream offsets and segment metadata are stored together and updated in lock-step. }

## And rollup

@quote-highlight[#:title "Data rollup · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/rollup.html"]{If you use a best-effort rollup ingestion configuration that does not guarantee perfect rollup, try one of the following:Switch to a guaranteed perfect rollup option.Reindex or compact your data in the background after initial ingestion. }

@quote-highlight[#:title "Data rollup · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/rollup.html"]{You can optionally load the same data into more than one Druid datasource. For example:Create a "full" datasource that has rollup disabled, or enabled, but with a minimal rollup ratio.Create a second "abbreviated" datasource with fewer dimensions and a higher rollup ratio. When queries only involve dimensions in the "abbreviated" set, use the second datasource to reduce query times. Often, this method only requires a small increase in storage footprint because abbreviated datasources tend to be substantially smaller. }

@quote-highlight[#:title "Data rollup · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/rollup.html"]{Design your schema with fewer dimensions and lower cardinality dimensions to yield better rollup ratios. }

## Streaming: From Kafka

@quote-highlight[#:title "Partitioning · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/partitioning.html"]{Kafka topic partitioning defines how Druid partitions the datasource. You can also reindex or compact to repartition after initial ingestion. }

@quote-highlight[#:title "Partitioning · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/ingestion/partitioning.html"]{Not all ingestion methods support an explicit partitioning configuration, and not all have equivalent levels of flexibility }

@quote-highlight[#:title "Apache Kafka ingestion · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/development/extensions-core/kafka-ingestion.html"]{When you enable the Kafka indexing service, you can configure supervisors on the Overlord to manage the creation and lifetime of Kafka indexing tasks }

# Storage after ingestion (Deep Storage)

@quote-highlight[#:title "Design · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/architecture.html"]{Druid uses deep storage to store any data that has been ingested into the system. }


@quote-highlight[#:title "Design · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/architecture.html"]{When the indexing task has finished reading data for the segment, it pushes it to deep storage and then publishes it by writing a record into the metadata store. }

@quote-highlight[#:title "Introduction to Apache Druid · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/"]{Deep storage is typically cloud storage, HDFS, or a shared filesystem }

- [TODO]: how long does a segment hang out on a historical before sending to deep storage?

# Querying

## Druid SQL

@quote-highlight[#:title "SQL · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/querying/sql.html#client-apis"]{You can make Druid SQL queries using HTTP via POST to the endpoint /druid/v2/sql/. The request should be a JSON object with a "query" field, like {"query" : "SELECT COUNT(*) FROM data_source WHERE foo = 'bar'"} }

@quote-highlight[#:title "SQL · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/querying/sql.html#query-translation"]{Currently, Druid does not support pushing down predicates (condition and filter) past a Join (i.e. into Join's children). Druid only supports pushing predicates into the join if they originated from above the join. Hence, the location of predicates and filters in your Druid SQL is very important. }

@quote-highlight[#:title "SQL · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/querying/sql.html#query-translation"]{Try to avoid subqueries underneath joins: they affect both performance and scalability. }

@quote-highlight[#:title "SQL · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/querying/sql.html#dynamic-parameters"]{Druid SQL supports dynamic parameters using question mark (?) syntax, where parameters are bound to ? placeholders at execution time. }

@quote-highlight[#:title "SQL · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/querying/sql.html"]{The WHERE clause refers to columns in the FROM table, and will be translated to native filters.  }

@quote-highlight[#:title "SQL · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/querying/sql.html"]{The FROM clause can refer to any of the following:
  * Table datasources from the druid schema. This is the default schema, so Druid table datasources can be referenced as either druid.dataSourceName or simply dataSourceName.
  * Lookups from the lookup schema, for example lookup.countries. Note that lookups can also be queried using the LOOKUP function.
  * Subqueries.Joins between anything in this list, except between native datasources (table, lookup, query) and system tables. The join condition must be an equality between expressions from the left- and right-hand side of the join.
  * Metadata tables from the INFORMATION_SCHEMA or sys schemas. Unlike the other options for the FROM clause, metadata tables are not considered datasources. They exist only in the SQL layer. }

## Using console

Can use the dot menu beside the Run option to translate Druid SQL to Native (JSON based) query syntax!

## Architecture

@quote-highlight[#:title "Design · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/architecture.html"]{Queries are distributed across the Druid cluster, and managed by a Broker. Queries first enter the Broker, which identifies the segments with data that may pertain to that query }

@quote-highlight[#:title "Design · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/architecture.html"]{On the query side, the Druid Broker is responsible for ensuring that a consistent set of segments is involved in a given query }

@quote-highlight[#:title "Design · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/design/architecture.html"]{Broker will then identify which Historicals and MiddleManagers are serving those segments and distributes a rewritten subquery to each of those processes.  }

# Ops

@quote-highlight[#:title "Apache Kafka ingestion · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/development/extensions-core/kafka-ingestion.html"]{GET /druid/indexer/v1/supervisor/<supervisorId>/status returns a snapshot report of the current state of the tasks managed by the given supervisor. }

@quote-highlight[#:title "Apache Kafka ingestion · Apache Druid"
  #:author  "nil"
  #:page-number 0
  #:url  "https://druid.apache.org/docs/latest/development/extensions-core/kafka-ingestion.html"]{The POST /druid/indexer/v1/supervisor/<supervisorId>/reset operation clears stored offsets, causing the supervisor to start reading offsets from either the earliest or latest offsets in Kafka (depending on the value of useEarliestOffset). After clearing stored offsets, the supervisor kills and recreates any active tasks, so that tasks begin reading from valid offsets. }


# Watching

## Performance Tuning of Druid Cluster at High Scale @ ironSource

[video](https://www.youtube.com/watch?v=_co3nPOh7YM&t=1s)

## Operating Druid

[video](https://www.youtube.com/watch?v=_co3nPOh7YM&t=1s)
