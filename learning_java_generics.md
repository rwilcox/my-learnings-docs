---
path: /learnings/java_generics
title: 'Learnings: Java: Generics'
---
# Table Of Contents

<!-- toc -->

- [Generic Declarations >](#generic-declarations--)
  * [Only an instance method, not on a class](#only-an-instance-method-not-on-a-class)
  * [T must inherit from some base class](#t-must-inherit-from-some-base-class)
  * [T must implement some interface](#t-must-implement-some-interface)
- [And Type Erasure >](#and-type-erasure-)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

Generic Declarations  <Learning_Java_Generic_Declarations>>
==========================

Only an instance method, not on a class
---------------------------

    class Thing {
        public <T> void methodName( String thing, T whatsit ) {

	    }
    }

T must inherit from some base class
--------------------------

    public <T extends String> void fooBar(T) { ... }

T must implement some interface
--------------------------

    public <T extends String & Runnable> void foobar(T) { ... }

The `&` signals that the class must implement that thing.

If you want to just check for interface implementation can do `extends Object & Runnable`.


And Type Erasure <<Java_Type_Erasure>>
========================


See also:

  * <<Kotlin_Type_Erasure>>

# Book Recommendations

  * [Java Generics](https://www.amazon.com/Java-Generics-Collections-Development-Process/dp/0596527756/ref=as_li_ss_tl?_encoding=UTF8&qid=1555869983&sr=1-1&linkCode=ll1&tag=wilcodevelsol-20&linkId=acfe8e02f14d4329fa5865d7425ea665&language=en_US)
