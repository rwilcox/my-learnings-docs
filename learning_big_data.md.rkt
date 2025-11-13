#lang scribble/text
@(require "scribble-utils.rkt")

---
path: "/learning/big_data"
title: "Learning Big Data"

# Parts to Hadoop Architecture

@quote-note[
		#:original-highlight "Unlike data warehouses, however, Hadoop is able to run on more economical, commercial off-the-shelf hardware. As such, Hadoop has been leveraged primarily to store and compute upon large, heterogeneous datasets stored in “lakes” rather than warehouses,"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}


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

@quote-note[
		#:original-highlight "For more significant deployments of hundreds of nodes, each master requires its own machine; and in even larger clusters of thousands of nodes, multiple masters are utilized for coordination."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

Services:
  * NameNode <-- directory tree of the file system and location
  * Secondary NameNode
  * DataNode <-- worker

YARN:

  * ResourceManager   <-- allocates and monitors cluster resources
  * ApplicationMaster <-- coordinates applications being run
  * NodeManager       <-- runs and manages processing tasks on an individual node / reports status

## YARN

@quote-note[
		#:original-highlight "YARN (“Yet Another Resource Negotiator”)."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}





@quote-note[
		#:original-highlight "Master programs allocate work to worker nodes"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Jobs are fault tolerant usually through task redundancy,"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Jobs are written at a high level without concern for network programming, time, or low-level infrastructure,"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "jobs are broken into tasks where each individual node performs the task on a single block of data."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "job; jobs are broken into tasks where each individual node performs the task on a single block of data."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "typical analytical workflow: ingestion→wrangling→modeling→reporting and visualization"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "HDFS and YARN work in concert to minimize the amount of network traffic in the cluster primarily by ensuring that data is local to the required computation."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "YARN and HDFS are implemented by several daemon processes—that is, software that runs in the background and does not require user input. Hadoop processes are services, meaning they run all the time on a cluster node and accept input and deliver output through the network, similar to how an HTTP server works. Each of these processes runs inside of its own Java Virtual Machine (JVM) so each daemon has its own system resource allocation and is managed independently by the operating system."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

## HDFS

@quote-note[
		#:original-highlight "HDFS (sometimes shortened to DFS) is the Hadoop Distributed File System"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "HDFS, a client application must first make a request to the NameNode to locate the data on disk. The NameNode will reply with a list of DataNodes that store the data, and the client must then directly request each block of data from the DataNode. Note that the NameNode does not store data, nor does it pass data from DataNode to client, instead acting like a traffic cop, pointing clients to the correct DataNodes."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "HDFS performs best with a modest number of very large files—for example, millions of large files (100 MB or more) rather than billions of smaller files that might occupy the same volume."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "HDFS has POSIX-like file permissions."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Additionally, blocks will be replicated across the DataNodes. By default, the replication is three-fold,"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "HDFS files are split into blocks, usually of either 64 MB or 128 MB, although this is configurable at runtime and high-performance systems typically select block sizes of 256 MB."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "It is not a good fit as a data backend for applications that require updates in real-time, interactive data analysis, or record-based transactional support."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "HDFS implements the WORM pattern—write once, read many. No random writes or appends to files are allowed.

"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}




@quote-note[
		#:original-highlight "Other data storage systems aside from HDFS can be integrated into the Hadoop framework such as Amazon S3 or Cassandra. Alternatively, data storage systems can be built directly on top of HDFS to provide more features than a simple file system. For example, HBase is a columnar data store built on top of HDFS"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}


@quote-note[
		#:original-highlight "Data is stored in blocks of a fixed size (usually 128 MB) and each block is duplicated multiple times across the system to provide redundancy and data safety."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "Data is distributed immediately when added to the cluster and stored on multiple nodes"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "refactor the human-driven data science pipeline into an iterative model with four primary phases: ingestion, staging, computation, and workflow management"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

## Raw Hadoop API

@quote-note[
		#:original-highlight "Combiners reduce network traffic by performing a mapper-local reduction of the data before forwarding it on to the appropriate reducer."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "The reducer is also launched as its own executable after the output from the mappers is shuffled and sorted to ensure that each key is sent to the same reducer"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "When Streaming executes a job, each mapper task will launch the supplied executable inside of its own process. The mapper then converts the input data into lines of text and pipes it to the stdin of the external process while simultaneously collecting output from stdout. "
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Streams in Hadoop Streaming refer to the standard Unix streams: stdin, stdout, and stderr. "
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Hadoop Streaming, a utility written in Java that allows the specification of any executable as the mapper and reducer. "
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Typically, a MapReduce application is composed of three Java classes: a Job, a Mapper, and a Reducer. "
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "The MapReduce API is written in Java, and therefore MapReduce jobs submitted to the cluster are going to be compiled Java Archive (JAR) files. Hadoop will transmit the JAR files across the network to each node that will run a task (either a mapper or reducer) and the individual tasks of the MapReduce job are executed."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Jobs for complex analyses are generally comprised of many internal tasks, where a task is the execution of a single map or reduce operation on a block of data. Because there are many workers simultaneously performing similar tasks, some data processing workflows can take advantage of that fact and run “map-only” or “reduce-only” jobs"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Because mappers apply the same function to each element of any arbitrary list of items, they are well suited to distribution across nodes on a cluster."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Consider how filters are implemented in a map context: each key/value pair is tested to determine whether it belongs in the final dataset, and is emitted if it does or ignored if not. After the map phase, any emitted key/value pairs will then be grouped by key and those key/value groups are applied as input to reduce functions on a per-key basis. "
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "A map function takes as input a series of key/value pairs and operates singly on each individual pair"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

# Airflow

@quote-note[
		#:original-highlight "Airflow scheduler is the brains behind examining task instances and determining what to run next. "
	#:title "Big Data on Kubernetes"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781835462140/"]{YELLOW}

@quote-note[
		#:original-highlight "Airflow should trigger processing tasks that will run somewhere else. "
	#:title "Big Data on Kubernetes"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781835462140/"]{YELLOW}

@quote-note[
		#:original-highlight "The Airflow web server is responsible for hosting the Airflow UI you interact with, providing REST APIs for other services to communicate with Airflow, and serving static assets and pages. "
	#:title "Big Data on Kubernetes"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781835462140/"]{YELLOW}

@quote-note[
		#:original-highlight "KubernetesExecutor is specially designed for Airflow deployments running in Kubernetes. It launches worker Pods in Kubernetes dynamically. It provides excellent scalability and resource isolation.
"
	#:title "Big Data on Kubernetes"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781835462140/"]{YELLOW}

@quote-note[
		#:original-highlight "CeleryExecutor uses a Celery pool to distribute tasks. It allows running workers across multiple machines and, thus, provides horizontal scalability."
	#:title "Big Data on Kubernetes"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781835462140/"]{YELLOW}

# Spark

@quote-note[
		#:original-highlight "Apache Spark is a cluster-computing platform that provides an API for distributed programming similar to the MapReduce model, but is designed to be fast for interactive queries and iterative algorithms"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "SparkKubernetesOperator task that runs a Spark job on Kubernetes."
	#:title "Big Data on Kubernetes"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781835462140/"]{YELLOW}

@quote-note[
		#:original-highlight "Above the storage layer and the batch processing layer, in Figure 4.3, we find an orchestration layer."
	#:title "Big Data on Kubernetes"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781835462140/"]{YELLOW}

@quote-note[
		#:original-highlight "A Spark job triggers the execution of a Spark program. This gets divided into smaller sets of tasks called stages that depend on each other.

Stages consist of tasks that can be run in parallel. The tasks themselves are executed in multiple threads within the executors. The number of tasks that can run concurrently within an executor is configured based on the number of slots (cores) pre-allocated in the cluster."
	#:title "Big Data on Kubernetes"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781835462140/"]{YELLOW}

@quote-note[
		#:original-highlight "Spark’s DataFrames are interoperable with native Pandas (using pyspark) and R data frames (using SparkR). "
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "Spark SQL is a module in Apache Spark that provides a relational interface to work with structured data using familiar SQL-based operations in Spark"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "Once the dataset is reduced to an in-memory computation, it can be analyzed using standard techniques, then validated across the entire dataset."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "decompose your problem by transforming the input dataset into a smaller one, until it fits in memory."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "in Spark this computation has to be modified slightly. Instead of being able to apply an operation that accepts a collection as input, you must be able to apply your operation to pairs of input at a time, and because the result of one application is the first input to the second application, the operation must be associative and commutative."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "By default in Spark, the Python API uses the pickle module for serialization, which means that any data structures you use must be pickle-able"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Keys need not be simple primitives such as integers or strings; instead, they can be compound or complex types so long as they are both hashable and comparable."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Algorithms that cannot be described as a directed data flow include those that maintain or update a single data structure throughout the course of computation (requiring some shared memory) or computations that are dependent on the results of another at intermediate steps (requiring intermediate interprocess communication). Algorithms that introduce cycles, particularly iterative algorithms that are not bounded by a finite number of cycles, are also not easily described as DAGs."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "However, if this RDD was extremely large, a distributed sort using rdd.sort could be used"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "As with Hadoop Streaming, any third-party Python dependencies that are not part of the Python standard library must be pre-installed on each node in the cluster"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Spark performs lazy evaluation,"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "two modes: yarn-client and yarn-cluster. In yarn-client mode, the driver is run inside of the client process as described, and the ApplicationMaster simply manages the progression of the job and requests resources. However, in yarn-cluster mode, the driver program is run inside of the ApplicationMaster process, thus releasing the client process and proceeding more like traditional MapReduce jobs."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Spark provides two types of shared variables that can be interacted with by all workers in a restricted fashion: broadcast variables and accumulators. Broadcast variables are distributed to all workers, but are read-only and are often used as lookup tables or stopword lists. Accumulators are variables that workers can “add” to using associative operations and are typically used as counters. "
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "RDDs are essentially a programming abstraction that represents a read-only collection of objects that are partitioned across a set of machines. RDDs can be rebuilt from a lineage (and are therefore fault tolerant), are accessed via parallel operations, can be read from and written to distributed storages (e.g., HDFS or S3), and most importantly, can be cached in the memory of worker nodes for immediate reuse"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "resilient distributed datasets (RDDs). "
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Spark focuses purely on computation rather than data storage and as such is typically run in a cluster that implements data warehousing and cluster management tools."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Spark programmers therefore do not simply specify map and reduce steps, but rather an entire series of data flow transformations to be applied to the input data before performing some action that requires coordination like a reduction or a write to disk. "
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}


# HBase

@quote-note[
		#:original-highlight "HBase is classified as a column-family or column-oriented database, modeled on Google’s BigTable architecture."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "HBase provides a special mechanism to treat columns as counters."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "because HBase doesn’t support joins and provides only a single indexed rowkey, we must be careful to ensure that the schema can fully support all use cases."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

# Hive

@quote-note[
		#:original-highlight "Apache Hive is a “data warehousing” framework built on top of Hadoop"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "Hive provides its own dialect of SQL called the Hive Query Language, or HQL. HQL supports many commonly used SQL "
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "particular, because HDFS is a write-once, read-many (WORM) file system and does not provide in-place file updates, Hive is not very efficient for performing row-level inserts, updates, or deletes."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "In addition to the primitive data types, Hive also supports complex data types, listed in Table 6-2, that can store a collection of values."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "Hive can only enforce queries on schema reads"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

# Notes from books (To Organize)



@quote-note[
		#:original-highlight "Trino, it can directly connect to object storage systems such as Amazon S3, Azure Blob Storage, or Google Cloud Storage, where data is often stored in formats such as Parquet, ORC, or CSV. Trino can read and process this data directly from the object storage, without the need for intermediate data loading or transformation steps."
	#:title "Big Data on Kubernetes"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781835462140/"]{YELLOW}







@quote-note[
		#:original-highlight "In the 2010s, the term “lakehouse” gained attention because of new open source technologies such as Delta Lake, Apache Hudi, and Apache Iceberg"
	#:title "Big Data on Kubernetes"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781835462140/"]{YELLOW}


@quote-note[
		#:original-highlight "There are many other distributed SQL or SQL-on-Hadoop technologies that we did not discuss—Impala, Presto, and Hive on Tez, to name a few. "
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}



@quote-note[
		#:original-highlight "Pig provides extensive support for such user-defined functions (UDFs), and currently provides integration libraries for six languages: Java, Jython, Python, JavaScript, Ruby, and Groovy."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "Pig, like Hive, is an abstraction of MapReduce, allowing users to express their data processing and analysis operations in a higher-level language that then compiles into a MapReduce job"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "Sqoop can generate a Hive table and load data based on the defined schema and table contents from a source database, using the import command"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
@quote-note[
		#:original-highlight "Sqoop (SQL-to-Hadoop) is a relational database import and export tool created by Cloudera,1 and is now an Apache top-level project"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "Sqoop is designed to transfer data between relational database management systems (RDBMS) and Hadoop"
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "Apache Flume was designed to efficiently collect, aggregate, and move large amounts of log data from many different sources into a centralized data store."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}

@quote-note[
		#:original-highlight "Sqoop is designed to transfer data between relational database management systems (RDBMS) and Hadoop."
	#:title "Data Analytics with Hadoop"
  #:author  "N/A"
  #:page-number 0
  #:url  "https://learning.oreilly.com/library/view/-/9781491913734/"]{YELLOW}
