---
path: "/learnings/ops_java"
title: "Learnings: Ops: Java"
---

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

# Java on Docker <<Learning_Ops_Java_Docker>>

## Running in Docker Images <<Java_In_Docker_Containers>>

Need to explicitly set heap size, memory because Java 8 can't understand limits placed upon it by Docker schedulers, Docker, cgroups, or CPU constraints.

See also:

  * [Deploying JVM in tiny containers](https://www.gamlor.info/wordpress/2017/04/deploying-jvm-in-tiny-containers-be-carefull/)
  * [Running Java in a Container - Mesosphere](https://mesosphere.com/blog/java-container/#talk) <-- goes into cgroups stuff, etc



## Introspection / Debugging <<Learning_Ops_SRE_Java_Debugging>> . Or: looking for signs of epidemic in your herd of cattle

"WHY is my Java app leaking memory / needing to be restarted every 4 hours?"


# JMX <<Learning_Ops_Java_JMX_Considerations>>

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


# <<Learning_Ops_Java_Spring>>

See also: Spring_Actuators  (includes more complete list), but here's ops scenarios you're probably running into...


## Jolokia Spring endpoint "built in"

See: Learning_Ops_Java_JMX_HTTP_Solution_Jolokia

`/jolokia`  <--- automatically there for Spring WebMVC or Jersey apps. If not then you can add it (see link)

See also:

  * [Spring Boot docs on Jolokia for JMX over HTTP](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-jmx.html#production-ready-jolokia)


## Changing log level on the fly using HTTP

[POST a partial entry (or null, meaning reset) to /loggers](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-loggers.html)

this means you can increase log level to debug to temporarily debug an issue, then set it back when you're done!!!

## Reporting JMX to Metric Collection Tools

[Supported JMX Metrics sent to metrics registries](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-metrics.html#production-ready-metrics-meter). Sends:

  * memory and buffer pools
  * GC stats
  * thread utilization
  * number of classes loaded / unloaded

^^^^^ Note: some breaking changes around here in Spring Boot 2.0

## Debugging what metrics are / should be sent

`/metrics` can be used to examine metrics collected.

### Viewing metric related to Max JVM non heap memory

`/actuator/metrics/jvm.memory.max?tag=area:nonheap`

## Getting Heapdumps

`/heapdump` <-- outputs it in `hprof` output format

## Getting threaddump

`/dump`  <-- outputs it in json format

See also:

  * [Idea for enhancing your thread names so you can see whats going on](https://moelholm.com/2016/08/15/spring-boot-enhance-your-threaddumps/)
  
# See Also

  * Optimizing Java !!!
  
# <<Learning_Ops_Performance_Metrics>>

"high dynamic range": or "long tail distributions": where yes the average is Nms, but 5% of consumers had a response time at ( (8*N)ms ) or some other waaaaayyyy outside the range metric.

Maven Coordinates:

  groupId  : org.hdrhistogram
  artifact : HdrHistogram
  
TL;DR: separate out distribution of data into buckets, display those buckets + their values.

## See also:

  * Learning_Java_Memory_Performace_Debuggin_Pause_Time
