---
path: /learnings/functional_programm
title: 'Learnings: Functional Programming'
---
# Table Of Contents

<!-- toc -->

- [Monad](#monad)
  * [what makes a monad a monad?](#what-makes-a-monad-a-monad)
- [Patterns in static typing languages](#patterns-in-static-typing-languages)
- [Dictionaries, HashMaps, etc](#dictionaries-hashmaps-etc)
- [See also](#see-also)

<!-- tocstop -->

# Monad

## what makes a monad a monad?

Monad laws:

  1. Must have a type constuctor
  2. Must have a `unit` function that wraps the value into the monad
  3. `bind` function chains operations on monadic values

# Patterns in static typing languages

Result, Either, Some types

# Dictionaries, HashMaps, etc


> Associative collections are collections that can be viewed as a function. Given an object o, a function f(o) returns true or false according to whether this object belongs to the collection or no
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

# See also

  * https://curiosity-driven.org/monads-in-javascript
  * [Simon Peyton Jones's book on Implementation of Functional Programming Languages ('87)](https://www.microsoft.com/en-us/research/publication/the-implementation-of-functional-programming-languages/)
