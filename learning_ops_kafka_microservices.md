---
path: "/learnings/ops_kafka_microservices"
title: "Learnings: Ops: Kafka Microservices"
---

# <<Learning_Ops_Kafka_Microservices>>

## Configuring Snappy C library location

If you turn on compaction on your topics it will / can use Snappy compaction. Snappy is a C library that is downloaded by (Kafka?) on startup.

Because it’s a C library it requires two things:
  1. A downloadable location that the current user can write to
  2. SELinux must be set to be permissive enough  to allow the C library to load, or for the jar to write files to the disk?? I forget which, but there was a fun issue here I think.

Set download location 

> -Dorg.xerial.snappy.tempdir=/some/writable/dir

This location [does not have to be unique if you are running multiple Kstreams apps in a single VM / container](https://github.com/xerial/snappy-java/issues/84).


# <<Learning_Ops_Kafka_Microservices_KStreams>>

## Configuring RocksDB store location <<Learning_Ops_Kafka_Microservices_KStreams_RocksDB>>

By default uses Java tmpdir. so can set that with a -D flag

> -Djava.io.tmpdir=/someplace/this/can/write/to/and/is/unique/for/app/tmp

### really overriding default

Use the properties API to set `state.dir` to the directory you want.

## Persistent vs ephemeral storage  <<Learning_Ops_Kafka_Microservices_Persistent_Storage>>

> Kafka Streams allows for stateful stream processing, i.e. operators that have an internal state. This internal state is managed in so-called state stores. A state store can be ephemeral (lost on failure) or fault-tolerant (restored after the failure). The default implementation used by Kafka Streams DSL is a fault-tolerant state store using 1. an internally created and compacted changelog topic (for fault-tolerance) and 2. one (or multiple) RocksDB instances (for cached key-value lookups).
>...
> Kafka Streams commit the current processing progress in regular intervals (parameter commit.interval.ms). 
> ...

- [Kafka Streams Internal Data Management wiki page](https://cwiki.apache.org/confluence/display/KAFKA/Kafka+Streams+Internal+Data+Management)

TL;DR: KStream data is stored on disk, yes, but also a Kafka topic. Thus, in default mode, the local data store can go away (instance reboot) and _nothing bad happens_. As the Kafka topic is used to boot back up the local data store.

## KStreams Considerations on AWS <<Learning_Ops_Kafka_Microservices_KStreams_AWS>>

> he AWS pricing model allocates a baseline read and write IOPS allowance to a volume, based on the volume size. Each volume also has an IOPS burst balance, to act as a buffer if the base limit is exceeded. Burst balance replenishes over time but as it gets used up the reading and writing to disks starts getting throttled to the baseline, leaving the application with an EBS that is very unresponsive. 

From: [Confluent: Running Kafka Streams on AWS](https://www.confluent.io/blog/running-kafka-streams-applications-aws/)

Answer: bigger disks - even though you don't need the storage - means more IOPS.

## On Alpine Linux <<Learning_Ops_Kafka_Microservices_KStreams_Alpine>>

[May have issues because of RockDB??](https://issues.apache.org/jira/browse/KAFKA-4988)

# <<Learning_Ops_Kafka_Consumer_Groups>>

Consumer Groups written to internal topic.
Each consumer in consumer group writes its current offset to this topic.

To reset offset - ie to rewind the consumer to the beginning of the group - requires no active members in the consumer group.

Q: How does Kafka know that there's an active consumer?
A: The group coordinator gets heart beats every 2 seconds, if no heartbeats received then the consumer group doesn't work.

## Viewing Consumer Group Info  <<Learning_Ops_Kafka_Viewing_Adjusting_Consumer_Offsets>>

    $ kafka-consumer-groups --bootstrap-server $KB --list
    
    $ kafka-consumer-groups --bootstrap-server $KB --group demo-group --describe
    
## Adjusting Offsets

    $ $ kafka-consumer-groups --bootstrap-server $KB --group demo-group --reset-offsets --topic demo:3 --shift-by 1 --execute
    
    $ kafka-consumer-groups --bootstrap-server $KB --group demo-group --reset-offsets --topic demo:6 --topic demo2:4 --shift-by -5 --execute
    
# <<Learning_Ops_Kafka_Monitoring>>

## <<Learning_Ops_Kafka_Monitoring_Applications>>

### KStreams

[Add state listener](https://stackoverflow.com/a/51454631/224334) ???

