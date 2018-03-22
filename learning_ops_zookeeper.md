---
path: "/learnings/zookeeper"
title: "Learning: Zookeeper"
---

# <<Learning_Ops_Zookeeper>>

## How a box knows its name

    echo "$SOME_UNIQUE_ID" > $ZOOKEEPER_DATA_DIR/myid
    
`$SOME_UNIQUE_ID` is what you declare for your `server.` in zookeeper.properties (??)


# See also:

  * [Zookeeper 4 letter words for admin / ops debugging](https://zookeeper.apache.org/doc/r3.1.2/zookeeperAdmin.html#sc_zkCommands)