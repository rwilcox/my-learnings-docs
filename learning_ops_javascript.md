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


