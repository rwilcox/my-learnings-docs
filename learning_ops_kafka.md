---
path: "/learnings/ops_kafka"
title: "Learnings: Ops: Kafka"
---

# <<Learning_Ops_Kafka>>

## Setup <<Learning_Ops_Kafka_Setup>>

May need to up file handle limits. See Learning_Ops_Unix_File_Handle_Limits

## <<ListingAllBrokersInCluster>>

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

# See also:

  * [my Kafka_ops tag on pinboard](https://pinboard.in/u:rwilcox/t:kafka_ops)
  * Learning_Ops_Kafka_Viewing_Adjusting_Consumer_Offsets