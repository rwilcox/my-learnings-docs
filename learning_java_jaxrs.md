---
path: /learnings/java_jaxrs
title: 'Learnings: Java: JaxRS'
---
# Table Of Contents

<!-- toc -->

- [Learning Java: JaxRS >](#learning-java-jaxrs-)
  * [In Spring](#in-spring)
    + ["I set ApplicationPath to / and now I don't see my actuator endpoints!!!!"](#i-set-applicationpath-to--and-now-i-dont-see-my-actuator-endpoints)
  * [See also:](#see-also)
- [Book Recommedations](#book-recommedations)

<!-- tocstop -->

# Learning Java: JaxRS <<Learning_Java_JaxRS>>


## In Spring

Instead of setting `@ApplicationPath` you can set the property `spring.jersey.applicationPath`

### "I set ApplicationPath to / and now I don't see my actuator endpoints!!!!"

Two solutions:

  1. Set ApplicationPath to not be /
  2. [Wrap the Spring Actuators in JaxRS endpoints](http://ruhkopf.name/blog/exposing-spring-actuator-endpoints-via-jersey-jax-rs)


## See also:

  * https://github.com/rwilcox/spring_jaxrs_scala   <-- Spring + JaxRS + Scala + Spring Data

# Book Recommedations

  * [RESTful Java with JAX-RS 2: Designing and Developing RESTful web services](https://www.amazon.com/RESTful-Java-JAX-RS-2-0-Distributed-dp-144936134X/dp/144936134X/ref=as_li_ss_tl?_encoding=UTF8&me=&qid=1555870170&linkCode=ll1&tag=wilcodevelsol-20&linkId=ac98b030764d862ef4332d2da42f8e46&language=en_US)

