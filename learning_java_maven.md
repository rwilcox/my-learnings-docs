---
path: "/learnings/java_maven"
title: "Learnings: Java: Maven"
---

# And Maven <<Java_And_Maven>> <<Java_Maven>>

## And Dependencies <<Java_And_Maven_And_Dependancies>>

[jdeps: lets you see what classes your dependencies rely on](http://marxsoftware.blogspot.com/2014/03/jdeps.html)

## And Debugging

Can use built into maven `mvnDebug` command line tool to open debugger ports for Java so can attach with normal debugger.s

    $ mvnDebug test # <-- would let you attach a debugger during test runs