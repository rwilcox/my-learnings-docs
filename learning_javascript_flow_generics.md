---
path: /learnings/javascript_flow_generics
title: 'Learning Javascript: Flow: Generics'
---
# Table Of Contents

<!-- toc -->

- [Generics Experiments](#generics-experiments)

<!-- tocstop -->

# Generics Experiments

```flow
/* @flow */

// compiles
function hi<T>( name: T): T {
  return name
}

console.log(hi("Bobby"))


// does not
function yo<T>( name: T): T {
  return 42
}

function yoma<T>( name: T): T {
  return "hi"
}

console.log(yo("Bobby"))
console.log( yoma("Ryan") )

// compiles (!!!!!)
function three<T>(first: T, second: T) {
  console.log(first, second)
}

three("world", 34)

// compiles
function four<T>(first: T, second: T): T {
  return first
}

four("world", 34)
```
