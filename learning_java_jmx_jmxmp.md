---
path: "/learnings/ops_java_jmx_jmxmp"
title: "Learnings: Ops: Java: JMX: JMXMP"
---

# <<Learinng_Ops_Java_JMX>>

Start here: [Platform Monitoring and Management with JMX](https://docs.oracle.com/javase/1.5.0/docs/guide/management/agent.html)

## Background:

Traditional JMX / RMI works the following way:

  1. Client request goes into JMX port
  2. Server responds with port in RMI range
  3. Client connects on that port
  
See also:

  * Learning_Ops_Java_Docker_JMX_Considerations

# JMX Over HTTP  <<Learning_Ops_Java_JMX_HTTP_Solution_Jolokia>>

Use [Jolokia](https://jolokia.org). Allows read, write, exec of attributes, beans

See also:

  * https://www.ctheu.com/2017/02/14/all-the-things-we-can-do-with-jmx/#jolokia-jmx-to-http
