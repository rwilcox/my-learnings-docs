---
path: "/learnings/ops_javascript"
title: "Learnings: Ops: Javascript"
---

# <<Learning_Ops_Javascript_Node>>

## <<Learning_Ops_Javascript_Docker>>

### <<Learning_Ops_Javascript_Docker_CMD>>

#### <<Learning_Ops_Javascript_Docker_Why_Not_NPM_Start>>

TL;DR:
  * don't use `npm start` as a launcher / CMD
  * don't put Node.js as PID 1 <-- use an init process (see )

This is a multi faceted problem. Because `npm` launches node by creating a `bash` process and running through that (at least on *nix). This creates... well a fun bit of complication because of this parent process, having to pass signals through bash (which isn't set up to handle them anyway ?? See: Learning_Ops_Docker_PID1_Why_Not_Bash )

Second facet: Node doesn't (probably) know enough to clean up child processes that have been thrust upon them ( See: Learning_Ops_Unix_PID1_Responsibilies ).

Third facet: If a NPM module you're using launches some process to complete its work. [This facet is commented on by someone in the node/build-containers repo](https://github.com/nodejs/build-containers/issues/19#issuecomment-71088153)

See also:

  * [blog post where author builds up PID story, explain what processes are launched by npm start (a bash wrapper over your node instance!!)](https://medium.com/@becintec/building-graceful-node-applications-in-docker-4d2cd4d5d392)
  * [the npm bug where they talk about this (and close it)](https://github.com/npm/npm/issues/4603)
  * [where the node/build-containers team talks about this](https://github.com/nodejs/build-containers/issues/19)
  * [libuv team weights in. May 2018 ticket remains open](https://github.com/libuv/libuv/issues/154)

#### <<Learning_Ops_Javascript_Docker_Just_Handle_Signals_Myself_or_Not>>

Theoretically you could handle the signals yourself in Javascript, if you didn't mind writing code coupling your application to Docker.

[Elastic.io says SIGTERM not caught by Node.js](https://www.elastic.io/nodejs-as-pid-1-under-docker-images/)

I'm not 100% sure I believe this. See: Learning_Ops_Docker_PID1_Signals where that author claims it works.

But:

  * set up `ENTRYPOINT`, not just `CMD` to insure no process accidentally in the middle. Aka maybe someone has "helpfully" set ENTRYPOINT to `bash -c`. See: Learning_Ops_Docker_PID1_Why_Not_Bash

Also [Node Process module documentation](https://nodejs.org/api/process.html#process_signal_events) seems to say it can handle `SIGTERM`, just not `SIGKILL`.

## <<Learning_Ops_Javascript_Node_Memory>>

By default memory limit for Node.js is 512MB (SOURCE?)

### Memory segments:

  * code <-- actual code executed
  * stack <-- primitives, data types, pointers
  * heap <-- objects, strings, closures

#### Segments of `heap` memory:

  * new space
  * old space

New space and old space. each space has memory pages.

`node --max_old_space_size=2000` —- now 2 gb ish

- [TODO]: read / understand https://github.com/thlorenz/v8-perf/blob/turbo-updates/gc.md

### see also
  * https://stackoverflow.com/q/42212416/224334 Docker and max_old_space_size

##### new space information

Size of 1-8MB ??

###### <<Learning_Ops_Javascript_Node_Memory_NewSpace_GC>>

GC algorithm: Scavenge and Mark and Sweep

`Scavenge` <-- concurrent!

##### old space information

###### <<Learning_Ops_Javascript_Node_Memory_OldSpace_GC>>

Garbage Collector:(Incremental, Concurrent) Mark -> (lazy) Sweep  (stop the world) -> Compact
- Node.js High Performance

`node --max-old-space-size=2042` <-- old space now 2GB

v8 garbage collector: periodic stop the world scans "cycle" - Node.js High Performance

"Shallow size" — size of object

This coupling of Mark/Sweep means gc pauses are (usually) minimal (5-50ms).

### <<Learning_Ops_Javascript_Node_Memory_Monitoring>>

Built in tools:

  * [process.cpuUsage](https://nodejs.org/dist/latest-v8.x/docs/api/process.html#process_process_cpuusage_previousvalue)
  * [process.memoryUsage](https://nodejs.org/dist/latest-v8.x/docs/api/process.html#process_process_memoryusage)

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

## <<Learning_Ops_Javascript_Node_JIT_Compilers>>

### OLD WORLD:

#### Full Compiler (full-codegen)

Generates code quickly. No type analysis, uses inline caches to refine type knowledge as running.

#### Optimizing Compiler (Crankshaft)

Classical JIT compiler, recompiles hot functions. Uses types from inline cache.

Some language features not supported yet (June 2018).

#### Machine Code JIT Compiler (Lithium)

### NEW WORLD

#### Ignition

##### Turbofan

### See also:

  * https://blog.sessionstack.com/how-javascript-works-inside-the-v8-engine-5-tips-on-how-to-write-optimized-code-ac089e62b12e
  * 