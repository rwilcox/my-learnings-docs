---
path: /learnings/rust
title: 'Learnings :Rust'
---
# Table Of Contents

<!-- toc -->

- [Learning Rust](#learning-rust)
  * [closures](#closures)
  * [Systems programming in Rust](#systems-programming-in-rust)

<!-- tocstop -->

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

# With MacPorts.

short answer: kinda eww.

## configuring IntelliJ

  * Toolchain location: (run `dirname $(which cargo)` in your terminal and paste the answer - which should be `/opt/local/bin` into this dialog via Command-Shift-C

  * Standard Library: depends on what version of Rust you have installed, but mine was `/opt/local/libexec/rust/src/rustc-1.68.2-src/library`)

You may also need to give it the location for rust-src, as `rustc --print sysroot` won't pick that up automatically on MacPorts. (This is kind of a problem for rust-analyizer but also :shrug: ??)

If you run `port contents rust-src` you should get back a base path that look like: `/opt/local/libexec/rust/src/rustc-1.68.2-src/library`.
