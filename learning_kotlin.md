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

# Book Recommendations

  * [Kotlin the Big Nerd Ranch Guide](https://www.amazon.com/Kotlin-Programming-Nerd-Ranch-Guide-ebook/dp/B07FXQ7SQN/ref=as_li_ss_tl?keywords=kotlin&qid=1555895959&s=books&sr=1-2&linkCode=ll1&tag=wilcodevelsol-20&linkId=5642a953da22d46844af6f200b112c91&language=en_US)



