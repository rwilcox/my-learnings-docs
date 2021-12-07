---
path: /learnings/kotlin
title: 'Learnings: Kotlin'
---
# Table Of Contents

<!-- toc -->

- [Casts](#casts)
  * [Auto casts](#auto-casts)
  * [Unsafe cast](#unsafe-cast)
  * [Safe / Nullable cast -- `dynamic_cast` alike](#safe--nullable-cast----dynamic_cast-alike)
  * [When you need to cast to a generic thing](#when-you-need-to-cast-to-a-generic-thing)
- [Generic Functions](#generic-functions)
  * [And Type Erasure >](#and-type-erasure-)
      - [- [TODO]: Add examples here?!!](#--todo-add-examples-here)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

Release schedule
===================

1.x version once every 6 months

Stupid Things I always forget
===================

val vs var
------------

  * var: mutable variable (can be reassigned)
  * val: read only variable (not NOT be reassigned, like ES6's `const`, or `final` in Java)


Methods
===================

Ways to declare a method

`fun methodName(parameterOne: ParameterType): ReturnType {}`

`fun methodName(parameterOne: ParameterType) = foobar(x)`

this second one will figure out the return type of `foobar` and set the return type to the return type of that.

Notes
-------------

By default, Java void is mapped to Unit type in Kotlin. This means that any method that returns void in Java when called from Kotlin will return Unit — for example the System.out.println() function.

Also, Unit is the default return type and declaring it is optional, therefore, the below function is also valid:

[Source](https://www.baeldung.com/kotlin/void-type)

There is a `Nothing` type which _kinda_ works like null but with more type checking???!!!

Duration
====================


In Kotlin 1.6
--------------------

Older ways are deprecated.

The new way

    1.minutes

Except, to do this new way, you have to _first_

    import kotlin.time.Duration.Companion.minutes

NO, you can NOT just `import kotlin.time.Duration.Companion.*`, that would be too easy.

List of words you can import at the [Companion Object Properties](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.time/-duration/#companion-object-properties) parts of the Kotlin docs.




Casts
====================

Auto casts
--------------------

if you do an `is` check before when you would do a cast, then the cast is automatic

		fun demo(x: Any) {
			if (x is String) {
				print(x.length) // x is automatically cast to String
			}
		}

Unsafe cast
----------------------

    val x: String = y as String

Safe / Nullable cast -- `dynamic_cast` alike
-------------------------

    val x: String? = y as String?

When you need to cast to a generic thing
---------------------------

		if (something is List<*>) {
			something.forEach { println(it) } // The items are typed as `Any?`
		}

Generic Functions
======================

And Type Erasure <<Kotlin_Type_Erasure>>
-----------------------

CAN get around this by using inline functions and `reified` keyword

#### - [TODO]: Add examples here?!!

BUT it only works when type information is known at call site at compile time. (ie probably can't be used in an abstract class)


See also:

  * https://kotlinlang.org/docs/reference/inline-functions.html#reified-type-parameters
  * https://stackoverflow.com/a/48960832/224334

# Ughhh Kotlin makes me sad

## RAII vs lazy

if you _do_ use `by lazy` that means the value of the instance variable might be created _anytime_, creating somewhat hard to read stacktraces (or paying object initialization prices at _just_ the wrong time)

TODO: think about this more here....

## lateinit vs lazy

### intro / questions

Q: since you can, how do you un-init a `lateinit` property?

TODO is this a correct summary?
TODO: read Baeldug article

### lateinit

  * var properties initied later in constructor or any method
  * fancy `isInitialized` method
  * can not be a nullable type

### lazy

  * val properties initied when called later
  * custom getter


### See also

  * [lateinit vs lazy property in Kotlin](https://agrawalsuneet.github.io/blogs/lateinit-vs-lazy-property-in-kotlin/)
  * [Lazy initialization in Kotlin by Baeldung](https://www.baeldung.com/kotlin/lazy-initialization)

# Coroutines and kotlinx-coroutines

## builders

| Builder                  | Description                                                                        |
|:-------------------------|:-----------------------------------------------------------------------------------|
| launch                   | When you don't care about the result of the expression                             |
| async                    | returns a Deferred object which you need to call .await on later                   |
| runBlocking              | blocks thread it started on when its coroutine is suspended (unit testing, mostly) |


## primary object types

### Dispatchers

Let us decide what thread or thread pool or whatever a coroutine is running on

Provided ones:

  * Default: CPU intensive operations, size == # of CPUs, but at least 2
  * Main: main thread (see Android)
  * IO: backed by a thread pool, additional threads are brought on on demand
  * Unconfined: runs on thread that started it, resumes on thread that resumes it.

Can make your own with Java Executors `.asCoroutineDispatcher()`

### Job

is in the coroutine context, so access it like `coroutineContext[Job]` or just `coroutineContext.job`.

A coroutine context comes in with a job, and items spawned within the (builder) methods inherit that job as a parent.

However, joining the parent does not mean that all children are complete! `coroutineContext.job.children.forEach { it.join() }` will do it...

### How these interact

Dispatcher parent scope seems to be determined via parent scope / coroutine context. This is well explained in [this Stackoverflow answer](https://stackoverflow.com/a/69853768/224334)

### See also

  * [kotlinx.coroutine documentation on coroutine context and dispatchers](https://github.com/Kotlin/kotlinx.coroutines/blob/master/docs/topics/coroutine-context-and-dispatchers.md)


## using coroutines

### builder examples

Use the builders, like so

```
launch {
    something()
}
```

```
var defed Defered<MyResultType> = async {
  somethingWithAResult()
}

var actualRes : MyResultType = defed.await()
```

### but _using_ those functions...

If we have a function `someFunction` that is

`private suspend fun hereWeGo() {}`

We can - in our own `suspend` labelled method call it like any ordinary method.

### And testing

`beforeAll` and the actual unit tests must run the same dispatcher/scheduler.

Q: (Yes, but how, if you are using `runTest` ??!!)

TODO: ?? beats me ???

Be careful that your tests aren't accidentally using two different coroutine dispatchers, especially if you took shortcuts with one of them (a single thread or something, because testing...)

Do you really want to / need to test two dispatchers at a time, because coordinating some async events?

[CoroutineTestDispatcher lets you pause and resume the dispatcher](https://medium.com/androiddevelopers/testing-two-consecutive-livedata-emissions-in-coroutines-5680b693cbf8)

## using Coroutines with nensense from the rest of the Java ecosystem

Coroutines provides integrations for a bunch of Reactive stuff, Java stuff Play, etc etc:

  * [library integrations](https://github.com/Kotlin/kotlinx.coroutines/blob/master/integration/README.md).
  * [reactive/stream integrations](https://github.com/Kotlin/kotlinx.coroutines/tree/master/reactive)


### Coroutines and other reactive type things in Java

#### Java 8's Future, CompletableFuture etc


[Kotlin jdk8 extensions over Future, Completablefuture etc](https://github.com/Kotlin/kotlinx.coroutines/blob/master/integration/kotlinx-coroutines-jdk8/src/future/Future.kt)

interesting utilities here:

  * Deferred / Job.asCompletableFuture()
  * suspend CompletionStage.asDeferred()
  * suspend CompletionStage.await()

TODO: EXAMPLE / MORE INFO HERE

See also:

  * Java_Reactive_Builtins
  * [jdk 9 specific support](https://github.com/Kotlin/kotlinx.coroutines/tree/master/reactive/kotlinx-coroutines-jdk9)

#### Using coroutines and RxJava 3, specifically

See my RxJava specific notes: Learning_Java_Rx

[kotlin has a library about this](https://github.com/Kotlin/kotlinx.coroutines/tree/master/reactive/kotlinx-coroutines-rx3)

## Book recommendations

  * [Kotlin Coroutines book](https://leanpub.com/coroutines)

# Book Recommendations

  * [Kotlin the Big Nerd Ranch Guide](https://www.amazon.com/Kotlin-Programming-Nerd-Ranch-Guide-ebook/dp/B07FXQ7SQN/ref=as_li_ss_tl?keywords=kotlin&qid=1555895959&s=books&sr=1-2&linkCode=ll1&tag=wilcodevelsol-20&linkId=5642a953da22d46844af6f200b112c91&language=en_US)
