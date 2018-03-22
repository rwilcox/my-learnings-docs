---
path: "/learnings/ops_linux_memory"
title: "Learnings: Ops: Linux Memory"
---

Ops: Unix Virtual Memory <<Learning_Unix_Memory>>
=============================

How Virtual Memory Works
-----------------------------

From RHL7 Install Guide

> Swap file systems support virtual memory; data is written to a swap file system when
> there is not enough RAM to store the data your system is processing. Swap size is a function
> of system memory workload, not total system memory and therefore is not equal to the total system memory size.

### Total Memory

Physical Memory + size in swap partition = Total Memory 

Total Memory Calculations
==========================

Recommended Swap Size
--------------------------

RHEL7 Installation Guide

|Amount of RAM in the system | Recommended swap space             | Recommended swap space if allowing for hibernation |
-----------------------------|------------------------------------| -------------------------------------------------- |
| less than 2 GB             | 2 times the amount of RAM          | 3 times the amount of RAM                          |
| 2 GB - 8 GB                | Equal to the amount of RAM         | 2 times the amount of RAM                          |
| 8 GB - 64 GB               | 4GB to 0.5 times the amount of RAM | 1.5 times the amount of RAM                        |
| more than 64 GB            | workload dependent (at least 4GB)  | hibernation not recommended                        |


Thus max size before the out-of-memory killer comes around
------------------------------------------------------------

|Amount of RAM in the system | Max memory size based on recommended              |
-----------------------------|------------------------------------|
| less than 2 GB             | up to 6GB memory                   |
| 2 GB - 8 GB                | 4-16GB memory                      |
| 8 GB - 64 GB               | 12-96GB memory                     |
| more than 64 GB            | workload dependent (at least 4GB)  |


See also
-----------------------

  * Learning_AWS_EC2_Swap
  * 

Knowing what your total memory actually is (Linux)
============================

    $ free -g
	                total       used        free      shared      buff/cache   available
	Mem:             31           9          17           1           4          19
	Swap:             0           0           0    
	
or

    $  cat /proc/meminfo
    
		MemTotal:       32518844 kB
		MemFree:        18227276 kB
		MemAvailable:   20657056 kB
		Buffers:            4136 kB
		Cached:          3988240 kB
		SwapCached:            0 kB
		Active:         11476648 kB
		Inactive:        1902564 kB
		Active(anon):   10484292 kB
		Inactive(anon):   516772 kB
		Active(file):     992356 kB
		Inactive(file):  1385792 kB
		Unevictable:           0 kB
		Mlocked:               0 kB
		SwapTotal:             0 kB
		SwapFree:              0 kB
		Dirty:               136 kB
		Writeback:             0 kB
		AnonPages:       9386884 kB
		Mapped:           111412 kB
		Shmem:           1614228 kB
		Slab:             544544 kB
		SReclaimable:     450428 kB
		SUnreclaim:        94116 kB
		KernelStack:       15584 kB
		PageTables:        31756 kB
		NFS_Unstable:          0 kB
		Bounce:                0 kB
		WritebackTmp:          0 kB
		CommitLimit:    16259420 kB
		Committed_AS:   13372220 kB
		VmallocTotal:   34359738367 kB
		VmallocUsed:       67916 kB
		VmallocChunk:   34359640064 kB
		HardwareCorrupted:     0 kB
		AnonHugePages:   8396800 kB
		HugePages_Total:       0
		HugePages_Free:        0
		HugePages_Rsvd:        0
		HugePages_Surp:        0
		Hugepagesize:       2048 kB
		DirectMap4k:       98304 kB
		DirectMap2M:     4096000 kB
		DirectMap1G:    29360128 kB    
	

HugePages: a RedHat extension that allocates 2MB pages for anon use instead of 4K ones

High vs Low Memory (mostly applicable to 32 bit)
==============================

In general, memory is split into zones:

  * `ZONE_DMA`     <-- low memory    (x86: first 16MB)
  * `ZONE_NORMAL`  <-- normal memory (x86: 16MB -> 896MB)
  * `ZONE_HIGHMEM` <-- high memory
  
  
On 32bit systems, When low memory is low, oom-killer will start killing things regardless of highmem.
Why? Because `struct page` has a cost of about 11MB memory / 1GB memory described. 
Eventually - around 16GB - this will fill up `ZONE_NORMAL` and thus trigger oom.


Q: Wait, how does 32bit Linux run on machines with >4GB memory?
--------------------

Physical Address Extension (PAE) <-- from Intel. Gives extra bits for addressing, thus can get to 64GB memory.


... and Physical Memory
==========================


Finding
-----------------

`_alloc_pages` is called for specific zone, and checks zone. If zone not suitable allocator may fall back to other zones.

### When memory is too tight or fragmented

If number of free pages reaches `pages_low` it will wake up `kswapd` to being freeing up pages from zones.
If memory super tight, caller will do work of `kswapd` itself.

Allocating
--------------

Binary Buddies: when block of required size is found, will be split and moved into two buddies. (Gorman Understanding Linux Virtual Memory, page 106)
(Also Knuth documented / described this???!!)

Allocated pages then put in TLB

Freeing
--------------------

When single page is freed, Linux checks buddy memory - if also has The Bit flipped, then both are free, and can be combined and moved back up heap. (Or swapped by kswapd???)

Fragmentation
---------------------

External fragmentation (avail memory only exists in small blocks) - usually not an issue because large requests for contiguous blocks are rare and usually done through `vmalloc` and friends.

Internal fragmentation (large block had to be assigned to service small request). This is:

  * serious failing of binary buddy system
  * frags expected to be 28% but could be in region of 60%
  
### Fixing

Slab allocator with buddy allocation - carves up pages into small blocks for memory

Slab Allocator
=========================

Consists of variable number of caches that are linked together. A Slab allocator cache is manager for objects of a particular type. Each cache maintains block of continuous memory (`slabs`) curved into small chunks.

Large Allocations via `vmalloc`
========================

`vmalloc` provides a mechanism where **noncontiguous** physical memory can be used as contiguous.

limitation on how much memory can be allocated this way: `VMALLOC_START` - `VMALLOC_END`

It finds process space large enough to allocate request, then updates the required PGD/PMD/PTE entries.

kswapd  <<Learning_Ops_Unix_Virtual_Memory_kswapd>>
=========================

Gorman, section 10.7

kswapd: responsible for reclaiming/freeing pages when memory is low. Checks `need_balance` in `zone_t` to see if can (not) sleep

kswapd for every memory node in system. 

Called only when physician page allocator needs it.

Calls (eventually): try_to_sawp_out:
  1. ensures this page can be swapped
  2. remove page from PTE
  3. Flushes TLB
  4. adds pointer in PTE how to get from swap

Swap Management
=========================

Two reasons swap is desirable:

  1. Expands amount of memory a process may use
  2. Pages may be referenced only during initialization and never used again

### Controlling swap <<Learning_Ops_Unix_Controlling_Swappiness>>

Parameters `vm.swappiness` can be turned down to 0 to force VM to not happen.

On Ubuntu:

    $ sysctl vm.swappiness=10
    
    
See also:

  * [SO: Controlling Swappiness on Ubuntu](https://askubuntu.com/questions/103915/how-do-i-configure-swappiness#103916)
  * [RHEL 7 Performance Tuning Guide: System Memory / VM Parameters](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/performance_tuning_guide/sect-red_hat_enterprise_linux-performance_tuning_guide-configuration_tools-configuring_system_memory_capacity#sect-Red_Hat_Enterprise_Linux-Performance_Tuning_Guide-Configuring_system_memory_capacity-Virtual_Memory_parameters)


Operator tools
==========================

- [TODO]: distill https://linuxaria.com/howto/linux-memory-management


Questions to answer
===========================

Q: When are inactive pages marked for swap?

When you try to allocate memory and the allocation fails

A: responsible function: refil_ inactive: moves pages from LRU list back to active if recently referenced. 

And if not, defects page for active lost and adds to the inactive (LRU??) list

Why: Because if the kswapd sends unused pages to disk, but the JVM comes and has to reload those pages into memory, just to garbage collect those objects, then that would be Bad.

Q2: Can avoid / reduce this happening??? (generational garbage collection here????)

Operational case studies
======================

  * [https://engineering.linkedin.com/performance/optimizing-linux-memory-management-low-latency-high-throughput-databases](LinkedIn turns off zone reclaim and gets better performance for high memory cache systems)< — see also Gorman Chapter 10
  
Tl;DR (reasonably sure this is accurate....)
=============

Linux total memory = physical memory + swap. memory is separated into zones, you’lol probably only use low and high (other is for kernel). may be able to create own.

Memory for a process is just lookup tables into this pool (PGDs??). Linux uses TLB is translate addresses from one to other. (Memory for a process includes several chunks for data segment, bss, etc. see Stevens on this.)

On memory allocation it allocates Binary Buddies of what you asked for. if not enough physical memory for this will activate kswapd.

Kswapd is per zone and examines Least Recently Used list to see if anything can be swapped to disk, thus giving enough space to allocate memory. Updates PTE for that memory spot t record offset on risk.

TLB access bumps reference count or avoids memory from hitting LRU(???).

Memory fragmentation most often happens when you have to use too bit of a page for your data: usually doesn’t happen other way (big huge allocation where you can’t fit because all the smalls running around).

Large memory on 32 bit Systems is Intel magic, but also could force out of memory situations(when really not) because the data constraints in that lookup table will overflow past 16GB.

Vocab
=========================

  * PGE - Page global enable (CPU level attribute)
  * PMD - page middle directory
  * PGD - page global directory
  * PTE - page table entries
  * PFN - Page Frame Number (index within physical memory that is counted in page sized units)
  * Page Table Layout - See 54 in pdf (34 printed) of Gorman, Understanding Linux Virtual Memory
  * TLB - translation lookaside buffer
  * LRU - least recently used

And Java <<Learning_Unix_Memory_Java>>
======================

_Performance Characteristics of Linux for Java Workloads Oversubscribing Memory_ ( Nakaike, Ueda, Ueda, Ohara) (Goodreader -> Ops) posits that:
  1. for some applications, Linuxs preference for swapping out file cache first hurts (see Kafka)
  2. Because of infrequent use of long lived objects in the tenure generation, swapping out of these objects *first* may be less performance impacting

See Also
=======================

  * https://www.infoworld.com/article/2617623/linux/making-sense-of-memory-usage-on-linux.html
  * http://www.redaht.com/archives/redhat-list/2007-August/msg00060.html  <-- memory implementation of 32bit linux with lots of RAM
  * https://lwn.net/Articles/317814/ <-- thoughts etc on the Out Of Memory killer
