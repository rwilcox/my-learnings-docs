---
path: /learnings/java_memory
title: 'Learnings: Java: Memory'
---
# Table Of Contents

<!-- toc -->

- [>](#)
  * [>](#)
    + [>](#)
      - [- [REVIEW]: So if you're cookie-cuttering based purely on Java heap `-Xmx` settings, you're underestimating the actual memory required by your process? (in addition to missing the overhead of ie the `cdata` section of Unix process memory ????](#--review-so-if-youre-cookie-cuttering-based-purely-on-java-heap--xmx-settings-youre-underestimating-the-actual-memory-required-by-your-process-in-addition-to-missing-the-overhead-of-ie-the-cdata-section-of-unix-process-memory-)
      - [>](#)
    + [>](#)
      - [- [BOOKQUOTE]:](#--bookquote)
      - [>](#)
        * [- [BOOKQUOTE]:](#--bookquote-1)
      - [See also:](#see-also)
    + [>](#)
      - [Concurrent Mark and Sweep (CMS): >](#concurrent-mark-and-sweep-cms-)
      - [G1: Garbage First >](#g1-garbage-first--)
      - [>](#)
- [>](#)
  * [See also:](#see-also-1)
  * [Performance stats](#performance-stats)
    + [tentured item promotion](#tentured-item-promotion)
    + [Pause time >](#pause-time-)
  * [heap fragmentation >](#heap-fragmentation-)
    + [and concurrent mark and sweep collector](#and-concurrent-mark-and-sweep-collector)
      - [see also](#see-also)
  * [See also](#see-also)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

# <<Learning_Java_Memory>>

## <<Learning_Java_Memory_Hotspot>>


### <<Learning_Java_Memory_Hotspot_Object_Layout>>

Java objects at runtime are pointers to:

  * 2 words: mark word (pointer to instance specific metadata); klass word (class wide metadata)

^^^ note with `-XX:UseCompressedOops` on this "word" may not be word sized.
^^^^ DEFAULT FOR Java 7=<

Java =< 7:

klassWord points to `PermGem` space in Java heap to hold class metadata. These were Java objects, because they live in Java header (thus require java object header).

Java >= 8:

klassWord points to memory **outside the Java heap but inside the heap of the application process**. Do not require a java object header.

#### - [REVIEW]: So if you're cookie-cuttering based purely on Java heap `-Xmx` settings, you're underestimating the actual memory required by your process? (in addition to missing the overhead of ie the `cdata` section of Unix process memory ????
s

demarked so because `klassWord` does _not_ point to an Class instance, but a struct in C memory.

#### <<Learning_Java_Memory_Hotspot_Object_Layout_With_JIT_Optimizations>>

- [BOOKQUOTE]:

> By proving that an allocated object does not escape the method (classed as a NoEscape) the VM can apply an optimization called scalar replacement. The fields in the object become scalar values, similar to if they had all been local variables instead of object fields. They can then be arranged into CPU registers by a HotSpot component called the register allocator.

- Optimizing Java

### <<Learning_Java_Hotspot_Memory_Zones>>

Hypothesis: most objects live and are discarded young.

Eden -> Survivor ("S1", "S2" )-> Tenured

Uses "card table" to keep track of old objects pointing at new object

_NOTE:_ G1, not this old and young memory zones, default in Java 9+.


#### - [BOOKQUOTE]:

> A typical pause time for a young collection on a 2G heap (with default sizing) on modern heap might well be just a few milliseconds, very frequently under 10ms.

- Optimizing Java


#### <<Learning_Java_Hotspot_Memory_Zones_And_Threads>>

pre-allocated eden space from heap divvyed up for each app thread: called thread local allocation buffers (TLABs).

(TLABs can grow if a thread needs it).


##### - [BOOKQUOTE]:

> veral techniques to minimize space wastage due to the use of TLABs are employed. For example, TLABs are sized by the allocator to waste less than 1% of Eden, on average. The combination of the use of TLABs and linear allocations using the bump-the-pointer technique enables each allocation to be efficient, only requiring around 10 native instructions.

- Memory Management in Hotspot Virtual Machine

#### See also:

  * [Sun: Memory Management in Hotspot Virtual Machine](http://www.oracle.com/technetwork/java/javase/memorymanagement-whitepaper-150215.pdf)


### <<Learning_Java_Hotspot_Garbage_Collector_Type>>

#### Concurrent Mark and Sweep (CMS): <<Learning_Java_Garbage_Collector_Concurrent_Mark_And_Sweep>>

Phases:

  1. initial mark (stop the world)
  2. concurrent marking phase
  3. Concurrent Preclean
  3. remark (Stop the World)
  4. concurrent sweep
  6. Concurrent Reset

*Only collector that is not compacting*. Memory fragmentation problems, requiring time by CMS allocator to plan for / break or join blocks to deal with (See: Sun: Memory Management in Hotspot Virtual Machine)
(means needs free lists).

See: Learning_Java_Memory_Heap_Fragmentation

**ONLY** available for old generations. ( Usually paired with `ParNew` or `ParallelGC` ).

Source: Memory Management in Hotspot

See also:

  * Tri-Color Invariant garbage collection; “On-the-Fly Garbage Collection: An exercise in Cooperation” (1978) by Dijkstra and (Leslie) Lamport. ALSO NOTE: initial publication contained some bugs that Dijkstra and Lamport semi independently solved slightly later. (See [Lamport's homepage](http://lamport.azurewebsites.net/pubs/pubs.html) for more information here)
  * `ParallelOld` <-- what CMS falls back on if Concurrent Mode Failure happens aka the running app collects too much garbage while in the middle of concurrently collecting garbage.

#### G1: Garbage First  <<Learning_Java_Hotspot_Java_9_Default_GC>>

_not recommended for JVMs < 1.8u40_.

**DEFAULT GARBAGE COLLECTOR IN JAVA 9**

Works on regions: 1MB-ish a piece, and 2048-4095 regions in memory at a time.

Large objects special cased into humongous region

Still has:

  * eden vs tenured regions
  * TLABs

Steps:

  1. Initial Mark (Stop the World)
  2. Concurrent Root Scane
  3. Concurrent Mark
  4. Remark (Stop the World)
  5. Cleanup (Stop the World)

G1 based around pause goals.

#### <<Learning_Java_Hotspot_Memory_When_GC_Triggered>>

  * If TLAB is full but thread needs to have yet more memory
  *

# <<Learning_Java_GC>>

Can set flags to enable GC logs (at ~0 cost: asynchronous log writer).
(`java -X:+PrintGC`).

**JAVA 9 CHANGE**: Use `java -X:log:gc*` instead!!

Bad:
  * (the JVM < 1.9 version): will send to log _file_, not just stdlog (this may be a good thing)
  * log format NOT standarized: your parser may super break if you add another option _>> use Censum or GCViewer

Good:
  * more metrics than (say) JMX

## See also:

  * https://dzone.com/articles/disruptive-changes-to-gc-logging-in-java-9

## Performance stats
### tentured item promotion

Too high? Unclaimed memory for longer!
Too low? Could have more of that in Eden..

### Pause time <<Learning_Java_Memory_Performace_Debuggin_Pause_Time>>
 > One useful heuristic for pause time tuning is to divide applications into three broad bands. These bands are based on the application’s need for responsiveness, expressed as the pause time that the application can tolerate. They are:
>
> >1s: Can tolerate over 1s of pause
>
> 1s - 100ms: Can tolerate more that 200ms but less than 1s of pause
>
> < 100ms: Cannot tolerate 100ms of pause.
 - Optimizing Java

 Can also use https://github.com/giltene/jHiccup to see pause times due to memory or just when you have a ns-scale application requirements and need to see profile.



## heap fragmentation <<Learning_Java_Memory_Heap_Fragmentation>>

### and concurrent mark and sweep collector

GC logging includes additional flag for Free List Statistics: -XX:PrintFLSStatistics=1

Java jargon: concurrent Mode Failures


#### see also

  * Learning_Java_Garbage_Collector_Concurrent_Mark_And_Sweep


## See also

  * Learning_Ops_Java_JMX_GC_Debugging

# Book Recommendations

  * [Optimizing Java](https://www.amazon.com/Optimizing-Java-Techniques-Application-Performance-dp-1492025798/dp/1492025798/ref=as_li_ss_tl?_encoding=UTF8&me=&qid=1555870760&linkCode=ll1&tag=wilcodevelsol-20&linkId=be039084b39d61a72afb9e6fa0be2a37&language=en_US)



