---
path: "/learnings/java_memory"
title: "Learnings: Java: Memory"
---

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

#### Low Latecy Mark and Sweep

Phases:

  1. initial mark
  2. concurrent marking phase
  3. remark
  4. concurrent sweep 

*Only collector that is not compacting*. Memory fragmentation problems, requiring time by CMS allocator to plan for / break or join blocks to deal with (See: Sun: Memory Management in Hotspot Virtual Machine)
(means needs free lists)


#### <<Learning_Java_Hotspot_Memory_When_GC_Triggered>>

  * If TLAB is full but thread needs to have yet more memory
  *
