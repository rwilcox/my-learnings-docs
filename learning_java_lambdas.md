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

# Book Recommendations

  * [Java 8 Lambdas](https://www.amazon.com/Java-Lambdas-Pragmatic-Functional-Programming-ebook/dp/B00J3B3J3C/ref=as_li_ss_tl?keywords=java+lambdas&qid=1555870344&s=books&sr=1-3&linkCode=ll1&tag=wilcodevelsol-20&linkId=0897c965c02f60d6ab0b33b909a59de4&language=en_US)
