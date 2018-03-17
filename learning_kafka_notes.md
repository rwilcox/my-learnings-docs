---
path: "/learnings/kafka"
title: "Learnings: Kafka"
---

<<Learning_Kafka>>

# Distributes running, limited, commit log

## File format
  * running log: old data deleted after 1GB or a week: so NOT THR BLOCKCHAIN
  * can be compressed on disk with LZ4, Snappy
  
  Why younneed state (in tables or somewhere else): because you may want to keep computations you've been doing on the data you've been seeing
  
  You can make Kafka keep the most recent value for a published key in it's log (compact mode). this may or may not be awesome.
  
  This is NOT awesome if you plan on using kstreams then reply the data, as the stream items are deltas, where as in ktables the field updates to a key are treated like new field values.
  
Not that on disk the messages are stored in the same format as from the producers sent - allowing Kafka to stream those bytes directly back to consumers.


## Uniqueness in Kafka:
  
    Topic(/partition) + [key]
    
    
(Destination partition may be set up to be determined by message key)
   
## Ordering in Kafka

  * preserves insert order of messages within a partition
  * 

### Interleaved messages: ie plays for multiple simultaneous games getting written to the same parition

Kstream's `mapValue`


Consumer notes:
  * remember that poll loop returns multiple records at a time
  * mark offset after processing message
  * always commit back the offset you were processing, not the last one you read (esp in multi threaded situations)
  * Kafka commits offsets, not individual messages. thus, if you failed processing record 30 but record 31 succeeded (multi-threaded) you have a problet (you can't set the offset because the previous one didnMt work).
   * DON'T BLOCK THE POLL EVENT LOOP!!
   
## Replication notes (producer side)

If set message to replicate to all replicas, this really means "in sync" brokers for that partion. This may be one, if all replicas are unavailable. Set  min.insync.replicas to a value > 1 to avoid this happening (consumers a trying to write to this topic will then throw an exception.

Consumers can continue reading data in this case, but no writes

# Network Model

## Followers / Replication

Follower replicas just work by being fancy Kafka consumers and listening to topic(s).
They are special in one way: they do not need to wait for data to be written to followers, as regular consumers do

Note that replicas that are a little behind can have performance impact, as the leader will wait for it to catch up before sending it more data (in a replica=all) scenario.

## Consumer Features

Consumers can ask for at least N bytes from Kafka to reduce polling on infrequently used tropics.
Can also couple this with a timeout, "at least 10K OR just give up if you don't get it in 5 minutes..."

### Idempotency and consumers

> The easiest, and probably most common way to do exactly-once is by writing results to a system that has some support for unique keys. This includes all key-value stores, all relational databases, Elastic search and probably many more data stores. In those cases, either the record itself contains a unique key (this is fairly common), or you can create a unique key using the topic, partition and offset combination - which uniquely identifies a Kafka record. If you write the record as a value with a unique key, and later you accidentally consume the same record again, you will just write the exact same key and value. The data-store will override the existing one, and you will get the same result as you would without the accidental duplicate. This pattern is called idempotent writes and is very common and very useful.
(Kafka Definitive Guide, 2017)


## Brokers 

Brokers store partitions on disk for each topic stored, and may contain replicas of partitions that need replication per replication prefs.

## and configuration

`bootstrap.servers`: 

> This list should be in the form host1:port1,host2:port2,.... Since these servers are just used for the initial 
> connection to discover the full cluster membership (which may change dynamically), this list need not contain the full
> set of servers (you may want more than one, though, in case a server is down).


### and ops

Brokers with many topics and partitions may run across number of files open exceptions (see Stevens, 2.5.5)

## Producer client (Java)

Built in producer does things like retry when no leader for topic, etc. Need to handle yourself auth errors, serialization errors (and maybe message size limit???)

# Kafka and CAP theorem

## Kafka processing and local storage

keeping data local, in RocksDB, gives a better performing system, and lets processing continue on through a network partition.

Also network lag could be a real thing, if you have to reset the offset of a topic to the beginning of time, then transfer all that information back across the network, to figure out the accumulation of a thing. Better to have the answer right there on the local box, and pre-computed.

## Kafka and exactly once delivery (explicit and implicit architecture)

Implicit: [Kafka versions > 0.11 have a feature for exactly once delivery](https://www.confluent.io/blog/exactly-once-semantics-are-possible-heres-how-apache-kafka-does-it/)

Woh, super magic!!

Explicit: 

> Theoretically you should design your pipeline to be idempotent: that
> multiple applications of the same change message should only affect the
> data once. This is, of course, easier said than done. But if you manage
> this then "problem solved": just send duplicate messages through and
> whatever it doesn't matter. This is probably the best thing to drive
> for, regardless of whatever once only delivery CAP Theorem bending magic
> KIP-98 does. (And if you don't get why this super magic well here's a
> homework topic :) )
> 
> Let's say your input data is posts about users. If your posted data
> includes some kind of updated_at date you could create a transaction log
> Kafka topic. Set the key to be the user ID and the values to be all the
> (say) updated_at fields applied to that user. When you're processing a
> HTTP Post look up the user in a local KTable for that topic, examine if
> your post has already been recorded. If it's already recorded then don't
> produce the change into Kafka.
> 
> Even without the updated_at field you could save the user document in
> the KTable. If Kafka is a stream of transaction log data (the database
> inside out) then KTables are the streams right side out: a database
> again. If the current value in the KTable (the accumulation of all
> applied changes) matches the object you were given in your post, then
> you've already applied the changes.

Source: [(me on stackoverflow)](https://stackoverflow.com/a/48472218/224334)


# Topic Schemas

## Schema Registry

Set via `props.put( "schema.registry.url", "HOSTNAME1,HOSTNAME2" )`
