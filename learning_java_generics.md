---
path: "/learnings/java_generics"
title: "Learnings: Java: Generics"
---

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
