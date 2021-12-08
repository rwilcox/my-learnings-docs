---
path: /learnings/java_bytecode
title: 'Learnings: Java: Bytecode'
---
# Table Of Contents

<!-- toc -->

- [intro](#intro)
- [>](#)
- [>](#)

<!-- tocstop -->

# intro

JVM opcodes are 1 byte large. (200ish are used in Java9).

Statically typed

BIG ENDIAN

In general more CISC based architecture than RISC.

How does hotspot work? At a method (and sometimes loop) level. Because of this it will swap original pointer in the vtable of the object’s class structure. (See: Learning_Java_Memory_Hotspot_Object_Layout ).

# <<Learning_Java_Bytecode_Virtual_Methods>>

invokevirtual bytecode must be emitted, even for "final" methods. (Aka: non virtualizable). Why? JavaSpec 13.4.7 says final -> virtual changes can’t break existing binaries. thus must assume lowest common denominator (and in this case invokespecial would invoke the old non-overridden implementation). - Optimizing Java

# <<Learning_Java_JIT>>

In general JITed things are moved into JIT "code cache"

[OpenJDK code cache implementation](http://openjdk.java.net/jeps/197): (they separate it into 3 parts)
