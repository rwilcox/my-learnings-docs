---
path: /learnings/javascript_typescript_null_handling_strategies
title: 'Learnings: Javascript: Typescript: Null Handling Strategies'
---
# Table Of Contents

<!-- toc -->

- [Introduction >](#introduction-)
- [Write out the types](#write-out-the-types)
  * [... this gets old](#-this-gets-old)
- [Java heads are screaming: "This is an Optional!!!"](#java-heads-are-screaming-this-is-an-optional)
- [The Typescript way](#the-typescript-way)
  * [Using Type Guards >](#using-type-guards-)
    + [A fancy *generic* type guard...](#a-fancy-generic-type-guard)
  * [Using Refinments... type predicates >](#using-refinments-type-predicates-)
    + [See also:](#see-also)
- [Conclusion](#conclusion)

<!-- tocstop -->

# Introduction <<Learning_Typescript_Null_Handling_Strategies>>

Typescript with it's `strict` compiler mode makes optional values something we have to think about all the time. If you have programming in Swift this feels familiar.

There's a couple different ways we can write null/undefined safe programs in Typescript

We're going to use a good ol' fashioned Person object to work through these concepts. Definition:

    class Person {
        public firstName = 'Ryan'
    }

# Write out the types

    function getPerson(personId: number): Person | null

Required, because you might not find a person in the database.

## ... this gets old

As an old C++ progammer, we want to DRY up types as much as possible (unless, as an old Groovy progammer, it confuses the readability of the program).

    type PersonOrNot = Person | null
    function getPerson(personId: number): PersonOrNot

    function main() {
        let person = getPerson(1123)  // person is of type Person | null... be that wrapped into a fancy type alias or not
    }

Hiding the types behind a type alias like this actually is **not** Typescript best practice (it does hide the nullability). I'm not sure how much I agree with this: I likely disagree with this rule for the same reasons they like it. Whatever.

# Java heads are screaming: "This is an Optional<Person>!!!"

Speaking of Java 8... [typescript-optional](https://github.com/bromne/typescript-optional) has that interface covered.

Same interface you are used to working with in Java, here in TS-land.

If you ae looking for a more Haskell inspired version (Maybe Monad), see [typescript-nullable](https://github.com/kylecorbelli/typescript-nullable).

# The Typescript way

Using compiler fanciness, and not fundimentals of functional programming, is possible here too...

## Using Type Guards <<Learning_Typescript_Type_Guards>>

We can use [user defined type guards](https://www.typescriptlang.org/docs/handbook/advanced-types.html) to enter into a block of code where the compiler knows what kind of object a thing is (because we told it).

### A fancy *generic* type guard...

    function exists<T>(checking: T | undefined | null): checking is T {
        return checking != null
    }

    function main() {
        let currentPerson = getPerson(1123)
        if (exists<Person>(currentPerson)) {
            currentPerson.firstName
        }
    }

Fancy...

You could also get super fancy and switch on field attributes: only tall people allowed in this part of the `if` statement, etc.

## Using Refinments... type predicates <<Learning_Typescript_Null_Handling_Predicate_Explaination>>

Flow has a feature it calls Refinments (see Learning_Javascript_Refinements). This basically means that the compiler will gain context the more code and if statements you put the object in question in.

Typescript has this same feature.

One way to take advantage of this is to emulate Swift's guard statements: statements that exit the executing function when pre-conditions have been met (or not).

For example, if you get in (or are passed in!) a value that could be null: check up front if it is, and if so exit (or whatever is appropriate: provide a default value, whatever). If you can check for nullability early in your function (or code block), you can not worry about null checks: because the compiler knows it has a real object - it's smart enough to see your if statement!

Let's see this in action:

    function main() {
        let currentPerson = getPerson(1123)
        if (currentPerson == null) { return }

        console.log(currentPerson.firstName)
        // no compile error! remove the if guard and TS will complain that firstName may not exist on null!!
    }


### See also:

  * Learning_Javascript_Typescript_Type_Predicate

# Conclusion

Lots of different ways to handle `strict`'s tossing of nullability in your face... vs older programming languages letting you sweep it under the rug for the QA testers (or unit tests!) to find...
