---
path: "/learnings/ops_javascript"
title: "Learnings: Ops: Javascript"
---

# <<Learning_Ops_Javascript_Node>>

## <<Learning_Ops_Javascript_Node_Memory>>

(Incremental) Mark -> (lazy) Sweep -> Compact
- Node.js High Performance


v8 garbage collector: periodic stop the world scans "cycle" - Node.js High Performance

"Shallow size" — size of object

New space and old space. each space has memory pages.

Defaults: 1GB old space??

Node—max_old_space_size=2000 —- now 2 gb ish

### see also
  * https://stackoverflow.com/q/42212416/224334 Docker and max_old_space_size
  
### Heap Snapshots

require v8-profiler in your JS code then connect to it.

Also heapdump module, where you can trigger a heap dump to disk

### GC log
—tracegc
Will print out to console(??) every time GC happens

^^^^^ but not for long term usage!

### memwatch

Package, emits and event every time things get weird / leak

Can also do heapdiffs


