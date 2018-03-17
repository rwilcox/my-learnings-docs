---
path: "/learnings/java_lambdas"
title: "Learnings: Java: Lambdas"
---

<<Learning_Java_Lambdas>>
====================================

Useful interfaces:

  * Predicate<T>  p = (in) -> false
  * BinaryOperator<T> p = (T one, T two) -> two
    (All must be of same type)
    
    
    https://docs.oracle.com/javase/8/docs/api/java/util/function/package-summary.html

Restrictions:
-----------------------

  1. Variables used in lambda must be final or effectively final - no reassigning values / no __block syntax
