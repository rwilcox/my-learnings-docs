---
path: "/learnings/javascript_typescript"
title: "Learnings: Javascript: Typescript"
---


# <<Learning_Javascript_Typescript>>

## Declaring Types

### Variable Declarations 

    let thing: string = 'John Doe'

But sometimes types are infered

#### When that variable is a higher oder function

    funtion sort(compareFn: (a: strinng, b: number) => number): this

#### Declaring variables read only (not just `const`)

You might think you can use the `readonly` attribute, but this only applies to arrays and tuple types. Instead you have to / should use a generic

    class Animal {
        public name: string  = "default"
    }

    let thing: Readonly<Animal> = new Animal()

    thing.name = "Ryan"  // compile error here!!

(also `readonly` only applies to the array, not deep: it does not mean elements in the array are `readonly`!! Cast these to `ReadOnly<>`).

But note `Readonly<>` is not itself deep either.... you can use a `DeepReadonly` generic in `ts-essentials` to do this.

#### Declaring variables null - or not

See also: Learning_Javascript_Typescript_Null_Checking

Note this is not a deep null check...

#### Function Declarations

    function sayHello(name: string): string {
        return `hello, ${name}'
    }

    function sayHello(name: string='Ryan') {
        return `hello, ${name}'
    }

#### Generic Types

    let v: Arry<Honkable> = []

#### Union types

    let thing: string | number = 42

but note: If we have a value that has a union type, we can only access members that are common to all types in the union.

### Declaring Type Types

can declare a type that is just a value

    type AB = 'AB'


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

### Examples of places where we generate types

  * https://spin.atomicobject.com/2018/03/26/typescript-data-validation/

## Enforcing compile time null checking <<Learning_Javascript_Typescript_Null_Checking>>

--strictNullChecks means you will need to union everything with null if you want to allow it to be null.


# fancy type things

## noting how much of your codebase is typed

    $ npx type-coverage


## casting

    let a = inHuman as Being

### FORCING THE COMPILER TO DO THE BIDDING

    a as unknown as Goose // <-- go all the way down to the base type, then back up. But seriously, only do this if there's no other alternative


## Type predicate if you have union types

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

# swicth statment completion

use the never type in the default case to man=ke sure you implemented all of switch

# Interesting additions to JS

  1. Function overloading / multiple type definitions per function <-- can do this but it looks odd
  2. Access modifiers `public`, `protected`, `private`
  3. (Java style) interfaces
w

# Javascript -> Typescript

## @ts-check and JSDocs

Can check to see if your JSDocs actually declare types correctly, or if they fail in some way

## allowJS

Q: But this doesn't include type information??
A: if you have type information in jsdoc, yes it appears so

- [TODO]: check out this statement....

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
# See Also

  * Effective Typescript <--  Effective Java/C++ style book
