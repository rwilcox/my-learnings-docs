---
path: /learnings/ops_java_spring
title: 'Learnings: Ops: Java: Spring'
---
# Table Of Contents

<!-- toc -->

- [>](#)
  * [Jolokia Spring endpoint "built in"](#jolokia-spring-endpoint-built-in)
  * [Changing log level on the fly using HTTP](#changing-log-level-on-the-fly-using-http)
  * [Reporting JMX to Metric Collection Tools](#reporting-jmx-to-metric-collection-tools)
  * [Debugging what metrics are / should be sent](#debugging-what-metrics-are--should-be-sent)
    + [Viewing metric related to Max JVM non heap memory](#viewing-metric-related-to-max-jvm-non-heap-memory)
  * [Getting Heapdumps](#getting-heapdumps)
  * [Getting threaddump](#getting-threaddump)
- [> , >](#--)
- [>](#)
  * [See also:](#see-also)
- [>](#)
- [>](#)
  * [About the Tomcat connection thread pool:](#about-the-tomcat-connection-thread-pool)
  * [Setting the size of the Tomcat Connection Thread Pool](#setting-the-size-of-the-tomcat-connection-thread-pool)
  * [>](#)
  * [>](#)
  * [See also:](#see-also-1)
- [See also:](#see-also-2)

<!-- tocstop -->

# <<Learning_Ops_Java_Spring>>

See also:

  * Spring_Actuators  (includes more complete list)

but here's ops scenarios you're probably running into...


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

# <<Learning_Ops_Java_Spring_Servlet_Information>> , <<Learning_Ops_Java_Spring_Tomcat_Set_Threads>>

Q: How many threads does Tomcat create by default for a Spring Boot App?
A: [200 by default](https://docs.spring.io/spring-boot/docs/current/reference/html/common-application-properties.html), controlled by server.tomcat.max-thread (do a Find in that page...)



# <<Learning_Ops_Java_Spring_Health_Endpoint>>

## See also:

  * Spring_Actuators_Health

# <<Learning_Ops_Java_Spring_And_Kubernetes>>

# <<Learning_Ops_Java_Tomcat>>

Tomcat provides the following features:

  * HTTP Sessions. [See some example code about using that directly](https://www.oxxus.net/tutorials/tomcat/persistent-sessions)
  * A thread pool for handling connections
  * [A threadpool for JDBC connections in case your client connections need the database](https://blog.zenika.com/2013/01/30/using-tomcat-jdbc-connection-pool-in-a-standalone-environment/)
  * A cache for things??
    - code
    - responses?????

Tomcat is a:

  * standalone server you can run .wars in
  * embedded server Spring Boot can use

## About the Tomcat connection thread pool:

Acceptor thread -> worker thread pool -> worker thread. Worker thread reads data from connection, does the thing and responds. [Source](https://medium.com/netflix-techblog/tuning-tomcat-for-a-high-throughput-fail-fast-system-e4d7b2fc163f).

## Setting the size of the Tomcat Connection Thread Pool

See Learning_Ops_Java_Spring_Tomcat_Set_Thread

## <<Learning_Ops_Java_Tomcat_Metrics_Monitoring>>

[some information about when the aggregated metrics are updated](https://docs.oracle.com/cd/E73210_01/EMASM/GUID-2BC1C083-EC80-4E10-B6DE-EAA6C74B8959.htm#EMASM34238)


## <<Learning_Ops_Java_Tomcat_Spring_Boot_Metrics>>

[Published metrics from Tomcat](https://github.com/micrometer-metrics/micrometer/blob/master/micrometer-core/src/main/java/io/micrometer/core/instrument/binder/tomcat/TomcatMetrics.java).

Useful metrics from Spring Boot 2.0:

  * tomcat.threads.busy        <-- busy threads
  * tomcat.threads.current     <-- busy + free threads
  * tomcat.threads.config.max  <-- point where thread exhaustion happens. (See below)

[Good explanation here at source](https://stackoverflow.com/a/41578938/224334)

**How to set** `tomcat.threads.config.max` : see Learning_Ops_Java_Spring_Tomcat_Set_Threads

**GOTCHA when running not embedde Tomcat**: make sure you are running > 1.0.7 of micrometer metrics to avoid [this bug](https://github.com/micrometer-metrics/micrometer/issues/835).

## See also:

  * http://www.jcgonzalez.com/java-monitor-jdbc-connection-pool-servlet
  * https://nixmash.com/post/how-to-increase-embedded-tomcat-cache-in-spring


# See also:

  * https://spring.io/blog/2015/12/10/spring-boot-memory-performance
