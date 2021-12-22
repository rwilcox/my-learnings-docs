#lang scribble/text
@(require "scribble-utils.rkt")

---
path: /learnings/kotlin
title: 'Learnings: Kotlin'
---
# Table Of Contents

<!-- toc -->

- [Release schedule](#release-schedule)
- [Stupid Things I always forget](#stupid-things-i-always-forget)
  * [val vs var](#val-vs-var)
- [Methods](#methods)
  * [Notes](#notes)
- [Duration](#duration)
  * [In Kotlin 1.6](#in-kotlin-16)
- [Casts](#casts)
  * [Auto casts](#auto-casts)
  * [Unsafe cast](#unsafe-cast)
  * [Safe / Nullable cast -- `dynamic_cast` alike](#safe--nullable-cast----dynamic_cast-alike)
  * [When you need to cast to a generic thing](#when-you-need-to-cast-to-a-generic-thing)
- [Generic Functions](#generic-functions)
  * [And Type Erasure >](#and-type-erasure-)
      - [- [TODO]: Add examples here?!!](#--todo-add-examples-here)
- [Ughhh Kotlin makes me sad](#ughhh-kotlin-makes-me-sad)
  * [RAII vs lazy](#raii-vs-lazy)
  * [lateinit vs lazy](#lateinit-vs-lazy)
    + [intro / questions](#intro--questions)
    + [lateinit](#lateinit)
    + [lazy](#lazy)
    + [See also](#see-also)
- [Coroutines and kotlinx-coroutines](#coroutines-and-kotlinx-coroutines)
  * [builders](#builders)
  * [primary object types](#primary-object-types)
    + [Dispatchers](#dispatchers)
    + [Job](#job)
    + [How these interact](#how-these-interact)
    + [See also](#see-also-1)
  * [using coroutines](#using-coroutines)
    + [builder examples](#builder-examples)
    + [but _using_ those functions...](#but-_using_-those-functions)
    + [And testing](#and-testing)
  * [using Coroutines with nensense from the rest of the Java ecosystem](#using-coroutines-with-nensense-from-the-rest-of-the-java-ecosystem)
    + [Coroutines and other reactive type things in Java](#coroutines-and-other-reactive-type-things-in-java)
      - [Java 8's Future, CompletableFuture etc](#java-8s-future-completablefuture-etc)
      - [Using coroutines and RxJava 3, specifically](#using-coroutines-and-rxjava-3-specifically)
      - [calling a `suspend` function from a non-suspend function](#calling-a-suspend-function-from-a-non-suspend-function)
  * [Book recommendations](#book-recommendations)
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
  * val: read only variable (not NOT be reassigned, like ES6's `const`, or `final` in Java). Mneomnic: both fina**l** and va**l** end with "l".


Methods
===================

## Ways to declare a method

`fun methodName(parameterOne: ParameterType): ReturnType {}`

`fun methodName(parameterOne: ParameterType) = foobar(x)`

this second one will figure out the return type of `foobar` and set the return type to the return type of that.

NOTES: you can use these labels at the call site

`methodName(parameterOne=ParameterType.FIRST_WHATEVER)`

(means you can also pass parameters out of order if they are all labelled)

## As Lambdas

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{Kotlin offers a simplified syntax for lambdas with a single parameter. This parameter is implicitly named it.}
@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{The value returned by the lambda is the value of the expression on the last line. }

### Variables

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{rd.map { it * 1.35 }
Here the function { it * 2.35 } has no name. But you could give it a name in order to be able to reuse it:

val ri: Result<Int> = ...
val rd: Result<Double> = ri.flatMap(inverse)
val function: (Double) -> Double = { it * 2.35 }
val result = rd.map(function)}

### More syntax shortcuts

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{The { x } syntax is the simplest way to write any constant function returning x, whatever argument is used.}

## Methods that take lambdas

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{When the lambda is the last argument of a function, it can be put outside of the parentheses:}


# Classes

## Access control or visibility

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{unlike Java, the enclosing class has no access to private inner or nested classes}

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{Unlike Java, Kotlin has no package private visibility (the default visibility in Java). }

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{An element can also be declared internal, meaning it’s only visible from inside the same module. A module is a set of files compiled together}

## Primary and secondary constructors

TODO: primary vs secondary constructors


## Properties

(auto generated) getters / setters of properties have to have the same or less than access permissions than their backing field

technically access of a property is - in background - using its auto-generated setter/getter

migrating a previously used accessor method to use a new backing field / implementation:

Two places to declare properties:

  * primary constructor
  * inside the class

```kotlin

var fullTime = maybeParameterFromPrimaryConstructorOrNot
get() {
  something
  return field  // ONLY place you can use this keyword!
}
set(value) {
  field = value
}
```

## data classes

When you just want to store information about some state

`data class MyClass(val name: String, val anotherThing: Int) {}`

This gives us default values for:
  * toString
  * equals
  * hashCopy
  * copy

based on parameters in primary constructor.

primary constructor has to have at least one parameter, parameters must be val/var. Can't be abstract, sealed or inner class.

## operator overloading

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{The invoke function declared with the keyword operator can be called as ClassName().}

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{Note that you can’t use the List() syntax to call the invoke function without an argument. You must explicitly call it; otherwise, Kotlin thinks you’re calling a constructor}

# Kotlin Standard Library

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{MutableMap can’t be used in a multi-threaded environment without providing some protection mechanisms that are difficult to design correctly and to use. The Map type, on the other hand, is protected against these kind of problems}


# Random Notes

methods are final by default

## try with resources a like

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{try with resource construct, provided these resources implement either Closable or AutoClosable. The main difference is that to achieve this, Kotlin offers the use function:}

## kinds of methods

Overriding: need to BOTH add `override` in your subclasses declaration of a method AND add `open` to your declaration of the mehod in the super class

abstract: (open by default)


NOTE: that `override` also by default means _your_ methods are `open` too!


## Unit, null, void, and nothing

By default, Java void is mapped to Unit type in Kotlin. This means that any method that returns void in Java when called from Kotlin will return Unit — for example the System.out.println() function.

Also, Unit is the default return type and declaring it is optional, therefore, the below function is also valid:

[Source](https://www.baeldung.com/kotlin/void-type)

There is a `Nothing` type which _kinda_ works like null but with more type checking???!!!

Classes, Objects and Instances
================================

Everything in Kotlin is `public final` by default

So if you want an extendable class you need to use `open class MySuperClass`.
`abstract` classes are open by default.


## class FooBar

Like Java BUT not the static part


## object FooBar

Declares a class AND ALSO it's a singleton

## extension functions

`fun Class.someMethod()`

In this you can access all the public members in `Class`

These can also be given access controls and thus only usable inside the method it was declared in. But to force it can do `final override fun foobar()` in declaration.

## data classes

can NOT be opened, inner, or abstract: are final no way around this. (They can _inherit_).


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

Generics
======================

Genera Generics Information
------------------------

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{Comparable is contravariant on T, meaning that the type parameter T occurs only in the in position}


Generic Functions
--------------------------

### And Type Erasure <<Kotlin_Type_Erasure>>

CAN get around this by using inline functions and `reified` keyword

#### - [TODO]: Add examples here?!!

BUT it only works when type information is known at call site at compile time. (ie probably can't be used in an abstract class)


See also:

  * https://kotlinlang.org/docs/reference/inline-functions.html#reified-type-parameters
  * https://stackoverflow.com/a/48960832/224334

# Delegates

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{Kotlin also supplies standard delegates, among which Lazy can be used to implement laziness:}


## Aka how as lay is implemented


# Ughhh Kotlin makes me sad

## tailrecursion support

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{Kotlin implements Tail Call Elimination (TCE). This means that when a function call to itself is the last thing the function does (meaning that the result of this call isn’t used in a further computation), Kotlin eliminates this tail call. But it won’t do it without you asking for it, which you can do by prefixing the function declaration with the tailrec keyword:
}
@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{if you indicate that your function has a tail-recursive implementation, Kotlin can check the function and let you know if you’ve made a mistake}


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


# Build Tools and Kotlin

Q: What version of Kotlin is my Gradle running?

In your build.gradle.kt file - and this can be somewhat anywhere, do

`println(embeddedKotlinVersion)`

`gradle -version` will also tell you that number

Q: Can I check for this in my Kotlin code?

Sure, do something like this

```kotlin

@at-sign{}SinceKotlin("1.6")
class IfIErrorThenCompilerIsNotKotlinOneSix {

}


fun main() {
    IfIErrorThenCompilerIsNotKotlinOneSix()
}

```

## and IntelliJ

### Gradle

Gradle Settings -> "Build and Run using Gradle" vs IntelliJ here.

# Basic Language Concepts

## String

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{multi-line strings by using the triple-quoted string (""") with the trimMargin}

## Equality

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{Identity (also called referential equality) is tested with ===. Equality (sometimes called structural equality) is tested with ==, which is a shorthand for equals}

## Casting

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{val result: String = payload as String
If the object isn’t of the right type, a ClassCastException is thrown}

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{This is called a smart cast because in the first branch of the if function, Kotlin knows that payload is of type String, so it performs the cast automatically. You can also use smart casts with the when function:}



# Coroutines and kotlinx-coroutines

Read [How Are Coroutines Different From Java's Thread Executor](https://stackoverflow.com/a/55645380/224334) either before, or after, because WOW. Then go read about what kotlinx.coroutines gives you.

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

#### calling a `suspend` function from a non-suspend function

?? use `runBlocking` ?

## Book recommendations

  * [Kotlin Coroutines book](https://leanpub.com/coroutines)

# and Java Interop
<<Kotlin_Java_Interropt>>

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{The Java way for dealing with a default value is through overloading. To make the function available as overloaded Java methods, use the JvmOverloads annotation}

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{You can change the name by which a Kotlin function can be called from Java code. For this, you need to use the JvmName("newName") annotation on the Kotlin function}

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{Kotlin public fields are exposed as Java properties (meaning with getters and setters). If you want to use them as Java fields, you have to annotate them in the Kotlin code like this: JvmField}

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{Extension functions in Kotlin are compiled to static functions with the receiver as an additional parameter.}

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{Unlike Kotlin, Java doesn’t have function types; functions are handled by converting lambdas into something that’s equivalent to a Single Abstract Method (or SAM) interface implementation. (It isn’t an implementation of the interface, but it acts as if it’s one.)

Kotlin, on the other hand, has true function types, so no such conversion is needed. But when calling Java methods taking SAM interfaces as their parameters, Kotlin functions are automatically converted.}

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{NOTE Kotlin supports the JSR-305 specification, so if you need more Java annotation support, refer to https://kotlinlang.org/docs/reference/java-interop.html.}

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{standard Java assertions, which are available in Kotlin. But as assertions,can be disabled at runtime}

@quote-highlight[#:title "The Joy of Kotlin"
  #:author  "Pierre-Yves Saumont"
  #:page-number 0]{You must use backticks to reference the in field of a Java System class because in is a reserved word in Kotlin.}


# Book Recommendations

  * [Kotlin the Big Nerd Ranch Guide](https://www.amazon.com/Kotlin-Programming-Nerd-Ranch-Guide-ebook/dp/B07FXQ7SQN/ref=as_li_ss_tl?keywords=kotlin&qid=1555895959&s=books&sr=1-2&linkCode=ll1&tag=wilcodevelsol-20&linkId=5642a953da22d46844af6f200b112c91&language=en_US)