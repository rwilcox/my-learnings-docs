---
path: "/learnings/kotlin"
title: "Learnings: Kotlin"
---

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
