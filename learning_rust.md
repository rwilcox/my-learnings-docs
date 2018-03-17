---
path: "/learnings/rust"
title: "Learnings :Rust"
---

# Learning Rust

## closures

Ruby/Smalltalk syntax

Can *optionally* type closure parameters, like so:

	let expensive_closure = |num: u32| -> u32 {
	    println!("calculating slowly...");
	    thread::sleep(Duration::from_secs(2));
	    num
	};

Or as a function parameter:

	crossbeam::scope(|num| { ... });

## Systems programming in Rust

  * static compilation
  * easy cross-compilation
  * Can run Rust in "script" mode by using `run-cargo-script` ----> https://github.com/DanielKeep/cargo-script
     - can also embed Cargo manifests into program and run-cargo-script will find it.
