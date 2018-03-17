---
path: "/learnings/java_jaxrs"
title: "Learnings: Java: JaxRS"
---

# Learning Java: JaxRS <<Learning_Java_JaxRS>>


## In Spring

Instead of setting `@ApplicationPath` you can set the property `spring.jersey.applicationPath`

### "I set ApplicationPath to / and now I don't see my actuator endpoints!!!!"

Two solutions:

  1. Set ApplicationPath to not be /
  2. [Wrap the Spring Actuators in JaxRS endpoints](http://ruhkopf.name/blog/exposing-spring-actuator-endpoints-via-jersey-jax-rs)
  
  
## See also:

  * https://github.com/rwilcox/spring_jaxrs_scala   <-- Spring + JaxRS + Scala + Spring Data
