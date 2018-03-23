---
path: "/learnings/ops_kafka"
title: "Learnings: Ops: Kafka"
---

# `<<Learning_Ops_Kafka>>`

## Documentation

  * [Confluent Whitepaper: Optimizing Your Apache Kafka Deployment](https://www.confluent.io/white-paper/optimizing-your-apache-kafka-deployment/)
  * [Confluent Whitepaper: Monitoring your Apache Kafka Deployment End-To-End](https://de.confluent.io/monitoring-your-apache-kafka-deployment)
  
## `<<ListingAllBrokersInCluster>>`

    import org.apache.zookeeper.Zookeeper;
    
    public class KafkaBrokerInfoFetcher {

        public static void main(String[] args) throws Exception {
            ZooKeeper zk = new ZooKeeper("localhost:2181", 10000, null);
            List<String> ids = zk.getChildren("/brokers/ids", false);
            for (String id : ids) {
                String brokerInfo = new String(zk.getData("/brokers/ids/" + id, false, null));
                System.out.println(id + ": " + brokerInfo);
            }
        }
    }

[Source](https://stackoverflow.com/a/29521307/224334)

## Memory use

### How much memory Kafka is using

Set `KAFKA_HEAP_OPTS` <-- can set -X flags here.
(don't use -Xms - it's not required by Kafka)

### See also:

  * Learning_Ops_Unix_File_Cache

## File Descriptor Use <<Learning_Ops_Kafka_File_Usage>>

PROBABLY need to up file handle limits. See Learning_Ops_Unix_File_Handle_Limits

Kafka opens 3 file descriptors for each topic-partition-segment that exists on the broker

### See also:

  * [KAFKA-2580: Kafka broker keeps file handles open for all log files](https://issues.apache.org/jira/browse/KAFKA-2580) <-- see also comment from Jay Kreps here.
  * see Stevens, 2.5.5

## And Flush <<Learning_Ops_Kafka_Producer_Flush>>

Q: What is [KafkaProducer.flush?](https://kafka.apache.org/090/javadoc/org/apache/kafka/clients/producer/KafkaProducer.html#flush())
TL;DR: makes all produced records ready to send; blocks until these records are sent to brokers.

^^^ the documentation for this includes a simplistic MirrorMaker like example, of consuming from one topic and producing to another!!

#### See also:

  * [KafkaProducer.flush hangs when NetworkClient.handleCompletedRecords throws exception](https://issues.apache.org/jira/browse/KAFKA-4669)

## Heartbeats <<Learning_Ops_Kafka_Poll_Interval>> <<Learning_Ops_Kafka_Heartbeats>>

### and racing against `flush`  <<Learning_Ops_Kafka_Flush_Vs_Heartbeat>>

Given some code like this (from the `flush` documentation):

    for(ConsumerRecord<String, String> record: consumer.poll(100))
         producer.send(new ProducerRecord("my-topic", record.key(), record.value());
     producer.flush();
     consumer.commit();

As ProducerRecord.flush blocks until all messages are sent, the `consumer.commit()` may take too long - past `max.poll.interval.ms`.

Aka: the consumer will not send the heartbeat as appropriate and will be removed from the consumer group.

### and request timeout

Setting `request.timeout.ms` to larger than the `max.poll.interval.ms` - for example, if you're at the end of a large pipe aka an inter-data-center MirrorMaker - is Probably A Bad Idea.

Per KIP-19: `request.timeout` is given for each retry. (Thus if it takes 10 retries, that's `request.timeout * 10` which may be > max.poll.interval.ms).
(Another reason why this might fail at the end of a large, slow, unreliable cross data center pipe.)

See also:

  * [SO answer: how request.timeout.ms interacts with ack number](https://stackoverflow.com/a/30474089/224334)
  * [KIP-19: Add a request timeout to NetworkClient](https://cwiki.apache.org/confluence/display/KAFKA/KIP-19+-+Add+a+request+timeout+to+NetworkClient)

## MirrorMaker <<Learning_Kafka_Ops_MirrorMaker>>

Topics **must** exist on the destination also (either through manual creation or auto topic creation turned on). WHY? See [KAFKA-5298](https://issues.apache.org/jira/browse/KAFKA-5298) on this deadlock causing bug.

### See also:

  * [KIP-3: Mirror Maker Enhancement: how MM prevents data loss / exactly what conservative steps it takes <-- changes made in MM 1.0.x](https://cwiki.apache.org/confluence/display/KAFKA/KIP-3+-+Mirror+Maker+Enhancement)
  * Learning_Ops_Kafka_Poll_Interval


# See also:

  * [my Kafka_ops tag on pinboard](https://pinboard.in/u:rwilcox/t:kafka_ops)
  * Learning_Ops_Kafka_Viewing_Adjusting_Consumer_Offsets
  

