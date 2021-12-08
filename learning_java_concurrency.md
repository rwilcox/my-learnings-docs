---
path: /learnings/java_concurrency
title: 'Learnings: Java: Concurrency'
---
# Table Of Contents

<!-- toc -->

- [>](#)
  * [>](#)
  * [>](#)
  * [>](#)
  * [>](#)
    + [and volatile keyword](#and-volatile-keyword)
      - [avoiding volatile](#avoiding-volatile)
    + [and fairness](#and-fairness)

<!-- tocstop -->

# <<Java_Concurrency>>


## <<Java_Concurrency_Memory>>

See also:

  * Learning_Java_Hotspot_Memory_Zones_And_Threads

## <<Java_Concurrency_Load>>

Q: how much are any one particular thread or executioner group actually using the CPU, vs waiting for sync IO/network? Profile this: this will tell you how much you can cheat WRT CPU core count...

## <<Java_Concurrency_Synchronized_Keyword>>

can be a method declaration

    public void syncronized addIt(int i) { MyClass.a += i;}

Can also do it as a block in a method

    public addIt(int i) {
        logger.info("into");
        syncronized(Myclass.class) {
            Myclass.a += i;
            }
        }

## <<Learning_Java_Concurrency_TROUBLE>>

### and volatile keyword

OS may cache value of a variable shared across threads. volatile will make sure to read this from memory instead
- [Source]: high performance apps with Java 9

#### avoiding volatile

  *Atomic... classes for adding stuff
  * ComcurrentHahMap, ArrayList, etc —- more efficient than wrapping self


### and fairness

Manually creating / waiting on a lock ReentrantLock can pass "fair" flag, which will make sure to give priority access to longest waiting requestor.


## <<Learning_Java_Thread_Exectors>>

### Fun different types of executors

Fixed thread pool: if threads are taken up wait in line for the next availible

cached thread pool: fixed thread pool that will reuse previously constructed threads
  threads that have not been used in 60 seconds thread will be removed


single thread executor - single worker thread off an unbounded queue. Tarmination means replacement thread is created.


# Java reactive / concurrency stuff <<Java_Reactive_Builtins>>

java.concurrent.Future from Java 5

## Futures

Guava brought `ListenableFuture` whene you could do `addCallback`, `onFailure`.

JDK 8's CompletableFuture implements Future's interface, but using Java 8's streams and lambdas stuff.
(these are backed by `CompletionStage`. `CompletableFuture` can be used as a `CompletionStage`).


When you run a CompletableFuture, if you don't provide a thread pool / executor one will be provided for you.

### Neat instance methods on CompletableFuture

`.thenApply` <-- really `map`

`.thenApplyAsync` <-- then apply but can jump to _another_ thread pool. Maybe you have different thread pool for different purposes (ie for different thread pool characteristics, etc). Can also provide your own executor, else one will be assigned for you.

`.thenCompose` <-- chains future together

### Wait huh I want to pass something into supplyAsync or whatever

just use the fact that these are closures and grab something from the outside scope.
