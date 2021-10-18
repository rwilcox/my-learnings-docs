---
path: /learnings/ops_java
title: 'Learnings: Ops: Java'
---
# Table Of Contents

<!-- toc -->

- [>](#)
  * [Q: How do the JVM diagnostic tools work, really? >](#q-how-do-the-jvm-diagnostic-tools-work-really-)
  * [Monitoring >](#monitoring-)
    + [jstack](#jstack)
    + [jstat](#jstat)
    + [jmap](#jmap)
    + [jConsole](#jconsole)
    + [See also:](#see-also)
- [Java on Docker >](#java-on-docker-)
  * [Running in Docker Images >](#running-in-docker-images-)
  * [Introspection / Debugging > . Or: looking for signs of epidemic in your herd of cattle](#introspection--debugging---or-looking-for-signs-of-epidemic-in-your-herd-of-cattle)
- [JMX >](#jmx-)
  * [And Docker >](#and-docker-)
  * [Operational Problems:](#operational-problems)
  * [Fixing operational problems:](#fixing-operational-problems)
    + [Firewalls / opening broad RMI range of ports](#firewalls--opening-broad-rmi-range-of-ports)
- [>](#)
  * [See also:](#see-also-1)
- [>](#)
  * [>](#)
    + [See Also](#see-also)
- [Java 9: Unified Logging >](#java-9-unified-logging-)
  * [See Also:](#see-also)
- [Why might pause time? >](#why-might-pause-time-)
  * [>](#)
  * [>](#)
- [>](#)
  * [Giving threads names:](#giving-threads-names)
  * [See also:](#see-also-2)
- [>](#)
- [See Also](#see-also-1)

<!-- tocstop -->

# <<Learning_Ops_SRE_Java>>

## Q: How do the JVM diagnostic tools work, really? <<Learning_Ops_SRE_Java_How_They_Work>>

How / what the JVM uses to allow itself to be diagnosed:

  * binary files dumped to tmp dirs
  * JVM reacts to QUIT signal and looks in CWD for `.attach_pid$PID`. If exists will create a thread that:
    a) creates a UNIX domain socket in the CWD called `.jaa_pid$PID`
    b) listens to commands on that socket

    ^^^^^ How jattach works !!! (jmap, jstack, jcmd work)!!!

  * JVMTI: allows an external .so to be loaded, attached and register for interesting events.
    ^^^^ This is how `agentpath` command line arguments work!!!

See also:

  * [DZone: Java Zone: JVM Diagnostic Tools and Containers](https://dzone.com/articles/lightweight-jvm-diagnostics-tools-and-containers) <-- this is actually written by someone on the Israelly Azure team at Microsoft
  * Learning_Ops_Java_Docker

## Monitoring <<Learning_Ops_SRE_Java_Monitoring>>

"Hmmm, I should get an alert when my Java process is taking up too much RAM / growing out of control"


### jstack

[How to take a thread dump from a JVM](https://helpx.adobe.com/experience-manager/kb/TakeThreadDump.html)
^^^^ this includes a script that will take N heapdumps, waiting M seconds between dumps

uses [jattach](https://github.com/apangin/jattach) under covers

### jstat

Can get statistics on old, new generation of GC, `gcutil`

See also:

  * [jstat](https://plumbr.io/handbook/gc-tuning-measuring/jstat)


### jmap

Java memory map printer

uses [jattach](https://github.com/apangin/jattach) under covers

See also:

  * [Oracle: jMap](https://docs.oracle.com/javase/7/docs/technotes/tools/share/jmap.html)
  * [A Test Developer's Blog: jmap](https://shantonusarker.blogspot.com/2013/07/jmap-java-memory-map-printer.html)
  * [Interpretation of jstat heap memory to debug suspected java memory leak](http://www.technologist-work.com/2015/09/interpretation-of-jstat-heap-memory-to-suspect-java-memory-leak/)

<<Learning_Ops_SRE_Java_Memory_Leak_Debugging>>

### jConsole

See also:

  * [Oracle 10 minute guide on jConsole](https://docs.oracle.com/javase/7/docs/technotes/guides/management/jconsole.html)

### See also:

  * [8 Options for Capturing thread dump data](https://dzone.com/articles/how-to-take-thread-dumps-7-options)
  * [How to analyze a thread dump](https://dzone.com/articles/how-analyze-java-thread-dumps?fromrel=true)
  * https://spring.io/blog/2015/12/10/spring-boot-memory-performance <-- using these tools to see memory etc of a Spring Boot application in action

# Java on Docker <<Learning_Ops_Java_Docker>>

## Running in Docker Images <<Java_In_Docker_Containers>>

Need to explicitly set heap size, memory because Java 8 can't understand limits placed upon it by Docker schedulers, Docker, cgroups, or CPU constraints.

See also:

  * [Deploying JVM in tiny containers](https://www.gamlor.info/wordpress/2017/04/deploying-jvm-in-tiny-containers-be-carefull/)
  * [Running Java in a Container - Mesosphere](https://mesosphere.com/blog/java-container/#talk) <-- goes into cgroups stuff, etc



## Introspection / Debugging <<Learning_Ops_SRE_Java_Debugging>> . Or: looking for signs of epidemic in your herd of cattle

"WHY is my Java app leaking memory / needing to be restarted every 4 hours?"


# JMX <<Learning_Ops_Java_JMX_Considerations>>

[Oracle: Deep Monitoring with JMX intro article on this](https://blogs.oracle.com/java-platform-group/deep-monitoring-with-jmx)

Problems:

  * need to mount directories for heapdumps, and other binary files dumped to /tmp by the JVM diagnostic tools
  * JVM attach interface communicates and passes around PID (recent versions of this account for cgroups namespaces)
  * Serviability API requires EXACT match between JDK/JRE version on the container and the host (this is hard to get exact)

## And Docker <<Learning_Ops_Java_Docker_JMX_Considerations>>


## Operational Problems:

  * Firewalls / opening broad RMI range of ports
  * Multiple Java processes on same OS could port conflict their JMX / RMI ports
  * JMX also sends hostname back to client ????????
  * If really in Docker containers than:

     * port mappings host -> container problems
     * Container may not know hostname

  * If Docker containers managed via a scheduler:

  * how to get at a specific instance of that container - see also: `Pets_Not_Cattle_Service_Debugging_Questions_Strategy`


## Fixing operational problems:

### Firewalls / opening broad RMI range of ports

Set following -D options (must be -D options, can not be Spring application properties):

    -Dcom.sun.management.jmxremote.rmi.port=1234
    -Dcom.sun.management.jmxremote.port=23454

May also need to set:

     -Djava.rmi.server.hostname=<your public hostname>
     -Dcom.sun.management.jmxremote.authenticate=false

[Blog article on how RMI hostname is determined by default](http://www.chipkillmar.net/2011/06/22/multihomed-hosts-and-java-rmi/)


# <<Learning_Ops_Performance_Metrics>>

"high dynamic range": or "long tail distributions": where yes the average is Nms, but 5% of consumers had a response time at ( (8*N)ms ) or some other waaaaayyyy outside the range metric.

Maven Coordinates:

  groupId  : org.hdrhistogram
  artifact : HdrHistogram

TL;DR: separate out distribution of data into buckets, display those buckets + their values.

## See also:

  * Learning_Java_Memory_Performace_Debuggin_Pause_Time

# <<Learning_Ops_Java_Operational_Information_Flags>>

## <<Learning_Java_Operational_Information_Flags_JIT>>

  * -XX:+PrintCompilation — prints information about what HotSpot is JIT-ing
  * -XX:+LogCompilation with -XX:+UnlockDiagnosticVMOptions (will generate 100s of MB of XML, use JITWatch)


### See Also

  * https://jakubstransky.com/2018/02/03/jvm-code-friendly-to-jit-optimisation/ —- using JITWatch

# Java 9: Unified Logging <<Learning_Java_Ops_Unified_Logging>>

**JAVA 9 intros new unified JVM internals log format**

New `-Xlog:THING` gives several abilities:

  * namespacing only select topics or all `Xlog:THING,THING+subthing` or `Xlog:THING*` <-- for all
  * destination (`java -Xlog:THING:stdout`), can also send to stderr or a specific file
  * field format

Command format: `-Xlog:SELECTOR:OUTPUT:DECORATORS:OUTPUT-OPTIONS`

See avail tags, etc: `java -Xlog:help`

## See Also:

  *

# Why might pause time? <<Learning_Java_Ops_Stop_The_World_Pauses>>

  * Deoptimization
  * Thread dump
  * Heap inspection
  * Class Redefinition
  * ... more
  *
- Source: https://stackoverflow.com/a/29673564/224334 , http://hg.openjdk.java.net/jdk8u/jdk8u/hotspot/file/fc3cd1db10e2/src/share/vm/runtime/vm_operations.hpp#l39

To do STW operations requires threads to be at safe point.

## <<Learning_Ops_Java_Safepoint_Requirements>>

Activities requiring a Safepoint:
* creating heap dump
* method deoptimization
* revoking biased lock
* class redefinition

BUT Safepoints happen when:
  * method return
  * loop back branch

  Loop unrolling etc may mean Safepoints are further away than normal! - source: Optimized Java

You can print information about mean time to Safepoint.

See also:

  * Learning_Java_Operational_Information_Flags

## <<Learning_Java_Ops_Stop_The_World_Pauses_Monitoring>>

JDK 8 and earlier add -XX:+PrintGCApplicationStoppedTime JVM option;
starting from JDK 9 add -Xlog:safepoint.

- [Source](https://stackoverflow.com/a/50381457/224334)

# <<Learning_Java_Ops_Monitoring_Threads>>

Can use thread dumps to get information about all running threads.

Will contain name, priority, ID, status and current callstack.

## Giving threads names:

  * A single thread: `Thread t = new Thread("myName!")`
  * In ThreadPools / ExecutorServices: can specify own `ThreadFactory`. See: [the simple implementation](https://stackoverflow.com/a/6113794/224334) and [the more complex one that auto increments thread numbers](https://stackoverflow.com/a/30279532/224334)
  * In `Runnable`s: just grab the name of `Thread.currentThread()`, stash it somewhere, then use a getter in some monitoring code

## See also:

  * https://www.javaworld.com/article/2074769/core-java/detecting-java-threads-in-deadlock-with-groovy-and-jmx.html
  * https://dzone.com/articles/how-analyze-java-thread-dumps

# <<Learning_Java_Finalize_Lifecycle>>



# See Also

  * Optimizing Java !!!

