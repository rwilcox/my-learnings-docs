---
path: /learnings/kotlin
title: 'Learnings: Kotlin'
---
# Table Of Contents

<!-- toc -->

- [Release schedule](#release-schedule)
- [Stupid Things I always forget](#stupid-things-i-always-forget)
  * [val vs var](#val-vs-var)
  * [Ways to declare a method](#ways-to-declare-a-method)
    + [Variables](#variables)
    + [More syntax shortcuts](#more-syntax-shortcuts)
  * [Methods that take lambdas](#methods-that-take-lambdas)
- [Classes](#classes)
  * [writing classes that you can destructure](#writing-classes-that-you-can-destructure)
  * [Access control or visibility](#access-control-or-visibility)
  * [Primary and secondary constructors](#primary-and-secondary-constructors)
  * [Properties](#properties)
  * [data classes](#data-classes)
  * [operator overloading](#operator-overloading)
- [Kotlin Standard Library](#kotlin-standard-library)
- [Flow Control](#flow-control)
  * [with functional programming / interfaces](#with-functional-programming--interfaces)
    + [streaming vs intermediate collections](#streaming-vs-intermediate-collections)
  * [labels](#labels)
  * [Exception handling](#exception-handling)
- [Functional Programming Patterns](#functional-programming-patterns)
  * [Lambdas](#lambdas)
    + [great but like, let's see some examples....](#great-but-like-lets-see-some-examples)
    + [and Java interop](#and-java-interop)
  * [Result / Optional types](#result--optional-types)
    + [returning a Result with a success](#returning-a-result-with-a-success)
    + [returning a Result with a failure](#returning-a-result-with-a-failure)
    + [other Result types](#other-result-types)
      - [Kotlin-Result](#kotlin-result)
        * [See also](#see-also)
        * [Code examples](#code-examples)
        * [Kotlin-Result using that function above](#kotlin-result-using-that-function-above)
- [Random Notes](#random-notes)
  * [try with resources a like](#try-with-resources-a-like)
  * [kinds of methods](#kinds-of-methods)
  * [Unit, null, void, and nothing](#unit-null-void-and-nothing)
- [Classes, Objects and Instances](#classes-objects-and-instances)
  * [class FooBar](#class-foobar)
  * [object FooBar](#object-foobar)
  * [extension functions](#extension-functions)
  * [data classes](#data-classes-1)
- [Nullability](#nullability)
  * [Kotlin patterns around nullability](#kotlin-patterns-around-nullability)
    + [Let wrapping an nullable](#let-wrapping-an-nullable)
- [Duration](#duration)
  * [In Kotlin 1.6](#in-kotlin-16)
- [Casts](#casts)
  * [Auto casts](#auto-casts)
  * [Unsafe cast](#unsafe-cast)
  * [Safe / Nullable cast -- `dynamic_cast` alike](#safe--nullable-cast----dynamic_cast-alike)
  * [When you need to cast to a generic thing](#when-you-need-to-cast-to-a-generic-thing)
- [Generics](#generics)
  * [General Generics Information](#general-generics-information)
  * [Generic Functions](#generic-functions)
    + [And Type Erasure >](#and-type-erasure-)
      - [- [TODO]: Add examples here?!!](#--todo-add-examples-here)
- [Delegates](#delegates)
  * [Aka how as lazy is implemented](#aka-how-as-lazy-is-implemented)
  * [Where is Groovy's concept of Delegate?](#where-is-groovys-concept-of-delegate)
- [DSL Stuff](#dsl-stuff)
  * [Avoiding punctuation in method calls or parameter specifications](#avoiding-punctuation-in-method-calls-or-parameter-specifications)
  * [Scope functions](#scope-functions)
    + [Huha what is it good for?](#huha-what-is-it-good-for)
      - [Optional to non optional variables](#optional-to-non-optional-variables)
      - [Implicit objects / Groovy's Delegate object](#implicit-objects--groovys-delegate-object)
    + [See also](#see-also-1)
- [Ughhh Kotlin makes me sad](#ughhh-kotlin-makes-me-sad)
  * [tailrecursion support](#tailrecursion-support)
  * [RAII vs lazy](#raii-vs-lazy)
  * [lateinit vs lazy](#lateinit-vs-lazy)
    + [intro / questions](#intro--questions)
    + [lateinit](#lateinit)
    + [lazy](#lazy)
    + [See also](#see-also-2)
- [Build Tools and Kotlin](#build-tools-and-kotlin)
  * [Q: What version of Kotlin is my Gradle running?](#q-what-version-of-kotlin-is-my-gradle-running)
  * [Q: Can I check for this in my Kotlin code?](#q-can-i-check-for-this-in-my-kotlin-code)
  * [and IntelliJ](#and-intellij)
    + [Gradle](#gradle)
      - [See also:](#see-also)
  * [creating playground projects I can run / compile from the command line](#creating-playground-projects-i-can-run--compile-from-the-command-line)
- [Basic Language Concepts](#basic-language-concepts)
  * [String](#string)
  * [Equality](#equality)
  * [Casting](#casting)
- [Coroutines and kotlinx-coroutines](#coroutines-and-kotlinx-coroutines)
  * [builders](#builders)
  * [primary object types](#primary-object-types)
    + [Dispatchers](#dispatchers)
    + [Job](#job)
    + [How these interact](#how-these-interact)
    + [See also](#see-also-3)
  * [using coroutines](#using-coroutines)
    + [builder examples](#builder-examples)
    + [but _using_ those functions...](#but-_using_-those-functions)
    + [And testing](#and-testing)
  * [using Coroutines with nonsense from the rest of the Java ecosystem](#using-coroutines-with-nonsense-from-the-rest-of-the-java-ecosystem)
    + [Coroutines and other reactive type things in Java](#coroutines-and-other-reactive-type-things-in-java)
      - [Java 8's Future, CompletableFuture etc](#java-8s-future-completablefuture-etc)
      - [Using coroutines and RxJava 3, specifically](#using-coroutines-and-rxjava-3-specifically)
      - [calling a `suspend` function from a non-suspend function](#calling-a-suspend-function-from-a-non-suspend-function)
  * [Book recommendations](#book-recommendations)
- [and Java Interop](#and-java-interop)
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



## Ways to declare a method

`fun methodName(parameterOne: ParameterType): ReturnType {}`

`fun methodName(parameterOne: ParameterType) = foobar(x)`

this second one will figure out the return type of `foobar` and set the return type to the return type of that.

NOTES: you can use these labels at the call site

`methodName(parameterOne=ParameterType.FIRST_WHATEVER)`

(means you can also pass parameters out of order if they are all labelled)


### Variables


> rd.map { it * 1.35 }
> Here the function { it * 2.35 } has no name. But you could give it a name in order to be able to reuse it:
> val ri: Result<Int> = ...
> val rd: Result<Double> = ri.flatMap(inverse)
> val function: (Double) -> Double = { it * 2.35 }
> val result = rd.map(function)
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

### More syntax shortcuts


> The { x } syntax is the simplest way to write any constant function returning x, whatever argument is used.
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

## Methods that take lambdas


> When the lambda is the last argument of a function, it can be put outside of the parentheses:
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


# Classes

## writing classes that you can destructure

So you can assign multiple variables from attributes of a class on one line

Create `operator` functions whose names are `componentN` where N is as high as you want to count.

example: `operator fun component1() = myField`

You do NOT need to do this for data classes.

[Kotlin documentation on destructuring declarations](https://kotlinlang.org/docs/destructuring-declarations.html)

## Access control or visibility


> unlike Java, the enclosing class has no access to private inner or nested classes
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


> Unlike Java, Kotlin has no package private visibility (the default visibility in Java). 
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


> An element can also be declared internal, meaning it’s only visible from inside the same module. A module is a set of files compiled together
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

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


> The invoke function declared with the keyword operator can be called as ClassName().
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


> Note that you can’t use the List() syntax to call the invoke function without an argument. You must explicitly call it; otherwise, Kotlin thinks you’re calling a constructor
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

# Kotlin Standard Library


> MutableMap can’t be used in a multi-threaded environment without providing some protection mechanisms that are difficult to design correctly and to use. The Map type, on the other hand, is protected against these kind of problems
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

# Flow Control

## with functional programming / interfaces

### streaming vs intermediate collections

could use [Kotlin Sequences](https://kotlinlang.org/docs/sequences.html#construct) (yes kind of like Java's Streams API, but not limited to JVM)

this is a lazy collection!

(it does add some overhead, so may be less useful in small collections, but if you're here you likely have a big collection).

two kinds of operations: intermediate, and terminal.

```kotlin
val l = listOf(1, 2, 3, 4)

l.asSequence().filter { ... }.map { ... }
println( l.toList() ) // terminal operation to get value of sequence
```

## labels

A label is a Java style annotation of any expression, but enables you to essentially reference that label - or the variable context around that label - ie to return out of a lambda without exiting its method, or to reference an above context when you are in a lower context.

Easy example: you have a `for` inside a `for` and want the inner `for` to essentially do a `next` on that outer iteration.
Medium example: you could use this to break out of collection/functional methods!!
Hard example: use a label a couple lambdas deep to get at the context object passed into the parent (or grandparent!) lambda. (Turing help you, and you probably want to refactor things to _not_ do this, but.....)

Easy example documented:

```kotlin

fun foo() {
    listOf(1, 2, 3, 4, 5).forEach lit@{
        if (it == 3) return@lit // local return to the caller of the lambda - the forEach loop
        print(it)
    }
    print(" done with explicit label")
}

```

having a plain `return` in that lambda would exit the `foo` function. But instead we just want to exit to the `forEach` block (we have some cleanup or something to do after the functional work).

[Kotlin documentation on labels](https://kotlinlang.org/docs/returns.html#return-to-labels)

## Exception handling

like try/catch/finally in Java

NOTES:

  * can NOT return a function value in `finally` (will be ignored)
  * `catch (t: Throwable)` > `catch(t: Exception)` . [See SO answer pointing to tweets by head Kotlin language designer](https://stackoverflow.com/a/64323675/224334)

No such thing as checked exceptions

# Functional Programming Patterns

(classifications / patterns taking from my [blog entry on intermediate functional programming patterns in Javascript](https://blog.wilcoxd.com/2023/06/05/Intermediate-Functional-Programming-Patterns-in-Javascript/)

## Lambdas


> Kotlin offers a simplified syntax for lambdas with a single parameter. This parameter is implicitly named it.
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


> The value returned by the lambda is the value of the expression on the last line. 
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

Variables that live outside the lambda/closure can be changed inside the closure (ie: unlike Java does not have to be `final`). See Java_Lambda_Outside_Variable_Restrictions for info on that restriction in Java.

### great but like, let's see some examples....

```kotlin
val mn = listOf("January", "February","March","April","May","June","July","August","September","October","November","December")

mn.forEach { whatMonth: String ->
    println(whatMonth)
}

```

For multiple parameters: `{ (whatMonth: String, monthNumber: int) ->`

Q: What about specifing the return type (ie the type inferience has fubar-ed up...)?
A: [No, you can not](https://kotlinlang.org/docs/lambdas.html#anonymous-functions). Kotlin suggests writing an anonymous function and passing it, instead of inlining / using lambda literals.

### and Java interop

Kotlin supports Learning_Java_Lambdas_Single_Abstract_Interface and it Just Works like it does it Plain Ol' Java.

## Result / Optional types

A [Result type](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-result/) returns some success object of type T, and on failure returns a Throwable (of which you have no control over the type)

### returning a Result with a success

```
fun myThing(): Result<Boolean> {
        return Result.success(true)
}

myThing().isFailure
myThing().getOrThrow()
```

### returning a Result with a failure

```
fun myThing(): Result<Boolean> {
        return Result.failure(Exception("boo"))
}

myThing().isFailure
myThing().getOrThrow()
```

### other Result types

A (probably better) result type is [kotlin-result](https://github.com/michaelbull/kotlin-result), which lets you ?? more easily model success or failure

#### Kotlin-Result

##### See also

  * [The Result Monad, Kotlin and Kotlin-Result](https://adambennett.dev/2020/05/the-result-monad/)

##### Code examples

```
kotlin

fun myThing(): Result<Boolean, String> {
    return Ok(true)

    // or...

    return Err("boo!")
}
```

##### Kotlin-Result using that function above

```
kotlin

fun callMyThing() {
    val res = myThing()

    // want to get the Value and Error seperately?
    // (just use Kotlin's destructuring abilities!)
    val (value, error) = res

    val actualResult = res.getOr(default=false)
    // ^^ gets the Value part, or if there was an Error return the default parameter value


}

```

# Random Notes

methods are final by default

## try with resources a like


> try with resource construct, provided these resources implement either Closable or AutoClosable. The main difference is that to achieve this, Kotlin offers the use function:
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

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

# Nullability

Kotlin type checks against nullable


## Kotlin patterns around nullability

### Let wrapping an nullable

<<Kotlin_Let_Wrapping_An_Optional>>

> let is often used for executing a code block only with non-null values. To perform actions on a non-null object, use the safe call operator ?. on it and call let with the actions in its lambda.

```kotlin
val str: String? = "Hello"
//processNonNullString(str)       // compilation error: str can be null
val length = str?.let {
    println("let() called on $it")
    processNonNullString(it)      // OK: 'it' is not null inside '?.let { }'
    it.length
}
```

**YES THAT ? part of the `?.let` is IMPORTANT!!**

For more information around `let`, see Kotlin_Scope_Functions

ALSO NOTE: this could be an alternative to [Swift's if-let statements](https://swiftly.dev/if-let)

```
swift

if let l = functionThatMayReturnNull() {
    print("l is something!")
}

```

You'll write this in Kotlin as:

```
kotlin

functionThatMayReturnNull().let { l ->
    println("l is something")
}
```

(Personally I'm not sure hiding the `if` statement in this way is a good idea, because it hides that potentially smelly `if` behind some syntax sugar.... but whatevs

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

General Generics Information
------------------------


> Comparable is contravariant on T, meaning that the type parameter T occurs only in the in position
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

[covariant vs contravariant](https://medium.com/kotlin-thursdays/introduction-to-kotlin-generics-9d18d3719e1d)

quick rundown: `out` keyword for covariant means can only use type T in ie function return places

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


> Kotlin also supplies standard delegates, among which Lazy can be used to implement laziness:
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


## Aka how as lazy is implemented

## Where is Groovy's concept of Delegate?

See Kotlin_Delegate_Equivalent

# DSL Stuff

## Avoiding punctuation in method calls or parameter specifications

You can do this with [infix notation](https://kotlinlang.org/docs/functions.html#infix-notation).

Rules:
  * must be member functions
  * must have a single parameter
  * method must not accept variable number of args and must not have a default value

## Scope functions

<<Kotlin_Scope_Functions>>

Scope functions: `let`, `run`, `also`, `with`, `apply`

From Kotlin documentation:

> `run`, `with`, and `apply` refer to the context object as a lambda receiver - by keyword this.

> In turn, `let` and `also` have the context object as a lambda argument. If the argument name is not specified, the object is accessed by the implicit default name it. it is shorter than this and expressions with it are usually easier for reading. However, when calling the object functions or properties you don't have the object available implicitly like this.

### Huha what is it good for?

#### Optional to non optional variables

`let` is good for turning optional objects into non-optional objects

```kotlin
var str: String? = "Hello"
str?.let { println("only called when str is non null") }
```

You could also use this as a very fancy if statement

`str?.let { it } ?: "default value"`

#### Implicit objects / Groovy's Delegate object
<<Kotlin_Delegate_Equivalent>>

AKA: Kotlin version of Groovy's Delegate object

See [Kotlin Documentation: Scope functions](https://kotlinlang.org/docs/scope-functions.html)

Inside the scope (lambda) of the function you'll be able to call methods of (the current scope object) without having to specify the variable name.

```kotlin
someVariableHere.let { it.methodThatWillActOnSomeVariableHere }
```

Without needing to provide the explicit `it`

```kotlin
someVariableHere.with {methodThatwillactonsomeVarariableHere} // can also be `run`
```
(You could also do `with(someVariableHere) {lambdaStuff}` but that may be showing off a bit...)

### See also

  * Kotlin_Let_Wrapping_An_Optional

# Ughhh Kotlin makes me sad

## tailrecursion support


> Kotlin implements Tail Call Elimination (TCE). This means that when a function call to itself is the last thing the function does (meaning that the result of this call isn’t used in a further computation), Kotlin eliminates this tail call. But it won’t do it without you asking for it, which you can do by prefixing the function declaration with the tailrec keyword:
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

> if you indicate that your function has a tail-recursive implementation, Kotlin can check the function and let you know if you’ve made a mistake
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


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

## Q: What version of Kotlin is my Gradle running?

In your build.gradle.kt file - and this can be somewhat anywhere, do

`println(embeddedKotlinVersion)`

`gradle -version` will also tell you that number

## Q: Can I check for this in my Kotlin code?

Sure, do something like this

```kotlin

@SinceKotlin("1.6")
class IfIErrorThenCompilerIsNotKotlinOneSix {

}


fun main() {
    IfIErrorThenCompilerIsNotKotlinOneSix()
}

```

## and IntelliJ

### Gradle

Gradle Settings -> "Build and Run using Gradle" vs IntelliJ here.

#### See also:

  * Kotlin_Gradle_BuildSrc

## creating playground projects I can run / compile from the command line

In IntelliJ you can use [Scratch files](https://kotlinlang.org/docs/run-code-snippets.html#ide-scratches-and-worksheets)


# Basic Language Concepts

## String


> multi-line strings by using the triple-quoted string (""") with the trimMargin
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

## Equality


> Identity (also called referential equality) is tested with ===. Equality (sometimes called structural equality) is tested with ==, which is a shorthand for equals
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

## Casting


> val result: String = payload as String
> If the object isn’t of the right type, a ClassCastException is thrown
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


> This is called a smart cast because in the first branch of the if function, Kotlin knows that payload is of type String, so it performs the cast automatically. You can also use smart casts with the when function:
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()



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

## using Coroutines with nonsense from the rest of the Java ecosystem

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


> The Java way for dealing with a default [parameter] value is through overloading. To make the function available as overloaded Java methods, use the JvmOverloads annotation
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


> You can change the name by which a Kotlin function can be called from Java code. For this, you need to use the JvmName("newName") annotation on the Kotlin function
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


> Kotlin public fields are exposed as Java properties (meaning with getters and setters). If you want to use them as Java fields, you have to annotate them in the Kotlin code like this: JvmField
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


> Extension functions in Kotlin are compiled to static functions with the receiver as an additional parameter.
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


> Unlike Kotlin, Java doesn’t have function types; functions are handled by converting lambdas into something that’s equivalent to a Single Abstract Method (or SAM) interface implementation. (It isn’t an implementation of the interface, but it acts as if it’s one.)
> Kotlin, on the other hand, has true function types, so no such conversion is needed. But when calling Java methods taking SAM interfaces as their parameters, Kotlin functions are automatically converted.
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


> NOTE Kotlin supports the JSR-305 specification, so if you need more Java annotation support, refer to https://kotlinlang.org/docs/reference/java-interop.html.
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


> standard Java assertions, which are available in Kotlin. But as assertions,can be disabled at runtime
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()


> You must use backticks to reference the in field of a Java System class because in is a reserved word in Kotlin.
> 
> - From The Joy of Kotlin by Pierre-Yves Saumont on page 0 ()

If you have a function that throws in Kotlin you'll likely need to annotate it with `@Throws(IOExceptionOrWhateverItIs::class)`

# Book Recommendations

  * [Kotlin the Big Nerd Ranch Guide](https://www.amazon.com/Kotlin-Programming-Nerd-Ranch-Guide-ebook/dp/B07FXQ7SQN/ref=as_li_ss_tl?keywords=kotlin&qid=1555895959&s=books&sr=1-2&linkCode=ll1&tag=wilcodevelsol-20&linkId=5642a953da22d46844af6f200b112c91&language=en_US)
