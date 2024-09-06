---
path: /learnings/javascript_typescript
title: 'Learnings: Javascript: Typescript'
---
# Table Of Contents

<!-- toc -->

- [>](#)
  * [Declaring Types](#declaring-types)
    + [Variable Declarations](#variable-declarations)
    + [Declaring your own types](#declaring-your-own-types)
      - [When that variable is a higher order function](#when-that-variable-is-a-higher-order-function)
      - [Creating a typedef / interface for your callback functions](#creating-a-typedef--interface-for-your-callback-functions)
      - [Promises and types](#promises-and-types)
        * [Typesafe Promises](#typesafe-promises)
          + [See also](#see-also)
      - [Declaring variables read only (not just `const`)](#declaring-variables-read-only-not-just-const)
        * [readonly parameter vs ReadOnly<>](#readonly-parameter-vs-readonly)
      - [Declaring variables null - or not](#declaring-variables-null---or-not)
      - ["But this could be a string OR null ...."](#but-this-could-be-a-string-or-null-)
      - [with the strictNullChecks tsconfig parameter turned on](#with-the-strictnullchecks-tsconfig-parameter-turned-on)
      - [With the strictNullChecks tsconfig parameter turned off](#with-the-strictnullchecks-tsconfig-parameter-turned-off)
        * [See also:](#see-also)
      - [So, with strictNullChecks on.... string | null | undefined everywhere???](#so-with-strictnullchecks-on-string--null--undefined-everywhere)
      - [Function Declarations](#function-declarations)
      - [Optional Parameters](#optional-parameters)
      - [Generic Types](#generic-types)
      - [Union types](#union-types)
        * [And interfaces](#and-interfaces)
    + [Declaring Type Types](#declaring-type-types)
      - [GENERICS???!!!](#generics)
      - [Classes](#classes)
        * [Interfaces](#interfaces)
      - [Access control](#access-control)
    + [Examples of places where we generate types](#examples-of-places-where-we-generate-types)
  * [Enforcing compile time null checking >](#enforcing-compile-time-null-checking-)
    + [See also:](#see-also-1)
- [fancy type things](#fancy-type-things)
  * [noting how much of your codebase is typed](#noting-how-much-of-your-codebase-is-typed)
  * [casting](#casting)
    + [FORCING THE COMPILER TO DO THE BIDDING](#forcing-the-compiler-to-do-the-bidding)
  * [Type predicate if you have union types >](#type-predicate-if-you-have-union-types-)
    + [if you don't want to do that](#if-you-dont-want-to-do-that)
    + [See also](#see-also-1)
- [swicth statment completion](#swicth-statment-completion)
  * [Having the type system build types for you](#having-the-type-system-build-types-for-you)
    + [Creating a more restrict type than what you currently have](#creating-a-more-restrict-type-than-what-you-currently-have)
    + [See also](#see-also-2)
- [Interesting additions to JS](#interesting-additions-to-js)
- [Javascript -> Typescript](#javascript---typescript)
  * [@ts-check and JSDocs](#ts-check-and-jsdocs)
  * [allowJS](#allowjs)
- [Interacting with Javascript](#interacting-with-javascript)
  * [Places you can provide the types for](#places-you-can-provide-the-types-for)
  * [Interacting with some JS Object (aka: you have parsed some JSON... but want to make it type safe)](#interacting-with-some-js-object-aka-you-have-parsed-some-json-but-want-to-make-it-type-safe)
  * [See also](#see-also-3)
  * [In Backend apps](#in-backend-apps)
- [Type Checking > Clever Lint Rules](#type-checking--clever-lint-rules)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

# <<Learning_Javascript_Typescript>>

[TypeScript](https://www.typescriptlang.org/) is Micosoft' transpiler that adds type checking and attempts to bring new features from ECMAScipt proposals faster than the ECMAScript release cycle can.

Typescript' [design goals ane enumerated on the Typescript Github](https://github.com/Microsoft/TypeScript/wiki/TypeScript-Design-Goals).

    function concat( a: string, b: number): string {
        return `${a} ${b}`
    }

    console.log(concat("a", "b"))
    console.log( concat(42, {"name": "Ryan"}) )  // will not compile

Like Flow, which does this more drastically, Typescript splits the language into two:

  * type space <-- where the types live
  * variable space  <-- your transpiled code

Type space declarations are not reflected in the running of you program. There's a couple places where keywords implement things in both type and variable space (`class` being a prime example).

But this also make things hard, especially in certain situations when you want to know the type at runtime.

## Declaring Types

### Variable Declarations

    let thing: string = 'John Doe'

But sometimes types are infered

You can think of it NOT as "this variable is of this type", but "this variable should match this declaration, or conform to this series of duck-types.

You could think of an object being described by a shape, not an imstance of a type.

### Declaring your own types

- [TODO]: write this. Both inline types and part of their own thing types.


#### When that variable is a higher order function

    funtion sort(compareFn: (a: string, b: number) => number): this

#### Creating a typedef / interface for your callback functions


    interface ConcatCallable {
        (error: Error | null, result: string, firstInput: string): void
    }

    function concat( a: string, b?: string, callback: ConcatCallable): void {
        return callback(null, `${a} ${b}`, a)
    }

#### Promises and types

- [TODO]: write me

##### Typesafe Promises

- [TODO]: write me

###### See also

  * Learning_Flow_Typed_Promises

#### Declaring variables read only (not just `const`)

You might think you can use the `readonly` attribute, but this only applies to arrays and tuple types. Instead you have to / should use a generic

    class Animal {
        public name: string  = "default"
    }

    let thing: Readonly<Animal> = new Animal()

    thing.name = "Ryan"  // compile error here!!

(also `readonly` only applies to the array, not deep: it does not mean elements in the array are `readonly`!! Cast these to `ReadOnly<>`).

But note `Readonly<>` is not itself deep either.... you can use a `DeepReadonly` generic in `ts-essentials` to do this.

##### readonly parameter vs ReadOnly<>

- [TODO]: write me

#### Declaring variables null - or not

See also: Learning_Javascript_Typescript_Null_Checking

Note this is not a deep null check...

#### "But this could be a string OR null ...."
<<Learning_Javascript_Typescript_Handling_Null_Checking>>

#### with the strictNullChecks tsconfig parameter turned on

There are no exceptions

#### With the strictNullChecks tsconfig parameter turned off

With it turned off the following is legal. (With it turned on it is a compiler error):

```javascript
class Person {
    firstName: string
    lastName: string

    constructor(first: string, last?: string) {
        this.firstName = first
        this.lastName = last
        // type of lastName = string | undefined
        // but if strict type checking is off, that is ignored
    }
}
new Person('shaq')
```

##### See also:

  * Learning_Javascript_Typescript_Null_Checking
  * Learning_Typescript_Null_Handling_Strategies

#### So, with strictNullChecks on.... string | null | undefined everywhere???

You have some code that looks like this: `let a: string | null | undefined`

What you almost want is a Java Optional type, or something to make less typing here.

[This is not baked into the Typescript language](https://github.com/Microsoft/TypeScript/issues/23477)

- [TODO]: implementation of Maybe type here?
- [TODO]: read Functional Thinking Chapter on Functional Data Structures

#### Function Declarations

    function sayHello(name: string): string {
        return `hello, ${name}'
    }

    function sayHello(name: string='Ryan') {
        return `hello, ${name}'
    }

#### Optional Parameters

If it's at the end you can use the optional punctuation:

    function setName(firstName: string, lastName?: string) {}

However the compiler will not let you put that in anything but last parameter. (even if strict type checking is off).

In the case of an optional parameter in the middle (what ARE you doing???) you will need to do `function setName(firtName: string, middleName: string|null, lastName: string) {}`

#### Generic Types

    let v: Arry<Honkable> = []

#### Union types

    let thing: string | number = 42

but note: If we have a value that has a union type, we can only access members that are common to all types in the union.

##### And interfaces

- [BOOKQUOTE]: Pros of this approach
> would it make sense to have type: 'fill' but then a LineLayout and PointPaint? Certainly not. Convert Layer to a union of interfaces to exclude this possibility:
- from: Effective Typescript


- [BOOKQUOTE]: Cons of this approach
> Interfaces with multiple properties that are union types are often a mistake because they obscure the relationships between these properties.
- from: Effective Typescript


- From: Effective Typescript
### Declaring Type Types

can declare a type that is just a value

    type AB = 'AB'


#### GENERICS???!!!

- [TODO]: write me

#### Classes

Mostly like ES6, except

##### Interfaces

    interface Honkable {
        honk(times: integer)
    }

    class Goose implments Honkable {
        honk(times: integer) {
            console.log('HONK!')
        }
    }

#### Access control

You can mark fields as private, protected, public, like so

- [TODO]: example

But private is a feature of the type system and, like all features of the type system, it goes away at runtime (Effective Typescript)

### Examples of places where we generate types

  * https://spin.atomicobject.com/2018/03/26/typescript-data-validation/

## Enforcing compile time null checking <<Learning_Javascript_Typescript_Null_Checking>>

--strictNullChecks means you will need to union everything with null if you want to allow it to be null.

### See also:

  * Learning_Javascript_Typescript_Handling_Null_Checking

# fancy type things

## noting how much of your codebase is typed

    $ npx type-coverage


## casting

    let a = inHuman as Being

### FORCING THE COMPILER TO DO THE BIDDING

    a as unknown as Goose // <-- go all the way down to the base type, then back up. But seriously, only do this if there's no other alternative

could also be written as `a as any as Goose`

## Type predicate if you have union types <<Learning_Javascript_Typescript_Type_Predicate>>

But what if your function takes a union type, and it needs to call functions impleented in one type or another depending on the action type?

    function noise(animal: Goose | Duck) {
        if (animal as Goose) {
            animal.honk()
        } else {
            animal.quack()
        }
    }

You can safely perform this check with a type predicate

### if you don't want to do that

Typescript alo has something similar to Learning_Javascript_Refinements

    function noise(animal: Goose | Duck) {
        if ("quack" in animal) {
            animal.quack()
        }

### See also

  * Learning_Typescript_Null_Handling_Predicate_Explaination
  * Effective Typescript Chapter 3 Item 22 calls this "type narrowing"

# switch statment completion

use the never type in the default case to man=ke sure you implemented all of switch

## Having the type system build types for you

All this typing sometimes gets annoying, particularly when you have a lot of types that are kind sort of but not really like each other. Typescript is here for you

### Creating a more restrict type than what you currently have

    type CheckingAccount {
        accountNumber: number,
        checks: Array<Check>
        balance: number
    }

    type SavingsAccount = Pick<CheckingAccount, 'accountNumber', 'balanace'>

### See also

  * [ts-essentials](https://www.npmjs.com/package/ts-essentials)


# Interesting additions to JS

  1. Function overloading / multiple type definitions per function <-- can do this but it looks odd
  2. Access modifiers `public`, `protected`, `private`
  3. (Java style) interfaces


# Javascript -> Typescript

## @ts-check and JSDocs

Can check to see if your JSDocs actually declare types correctly, or if they fail in some way

## allowJS

Q: But this doesn't include type information??
A: if you have type information in jsdoc, yes it appears so

- [TODO]: check out this statement....

# Interacting with Javascript

## Places you can provide the types for

## Interacting with some JS Object (aka: you have parsed some JSON... but want to make it type safe)

You likely need the type here before going very far. Couple different ways to do this:

  1. Just cast it. `foobar as Thinger`. May have to pass through any type or something.
  2. Use a user defined type guard (see Learning_Typescript_Type_Guards) and have that cast the variable to the correct type
  3. Use something like json-schema to generate TS classes from JSON Schema, [as described in an atomicobject blog post](https://spin.atomicobject.com/2018/03/26/typescript-data-validation/)
  4. You can use Learning_Typescript_Null_Handling_Predicate_Explaination and `if field in object` checking the various shapes of the instance in quesion... until you find the right one, which by then the compiler should have refined it enogh to know what you are talking about.

## See also

  * https://devblogs.microsoft.com/typescript/how-to-upgrade-to-typescript-without-anybody-noticing-part-1/
  *
## In Backend apps

in tsconfig.json

    {
    "compilerOptions": {
        "target": "es2016",
        "module": "commonjs"
    }
    }

# Type Checking > Clever Lint Rules

- [TODO]: write me


# Typescript and Unit Testing Patterns

## "Ugh, can I just call this private method?"

Typesript compiler will error if you call a private method. (This, however, is only enforced at the compiler level, JS don't care).

But I want to unit test private methods, sometimes.

Easiest answer? typecast the object to any (`(personObject as any).aVeryPrivateMethod()`)

# Book Recommendations

  * [Effective Typescript](https://www.amazon.com/Effective-TypeScript-Specific-Ways-Improve/dp/1492053740/ref=sr_1_1?keywords=effective+typescript&qid=1571345085&sr=8-1) <--  Effective Java/C++ style book
