---
path: "/learnings/javascript_typescript"
title: "Learnings: Javascript: Typescript"
---


# <<Learning_Javascript_Typescript>>

[TypeScript](https://www.typescriptlang.org/) is Micosoft' transpiler that adds type checking and attempts to bring new features from ECMAScipt proposals faster than the ECMAScript release cycle can.

Typescript' [design goals ane enumerated on the Typescript Github](https://github.com/Microsoft/TypeScript/wiki/TypeScript-Design-Goals).

    function concat( a: string, b: number): string {
        return `${a} ${b}`
    }

    console.log(concat("a", "b"))
    console.log( concat(42, {"name": "Ryan"}) )  // will not compile 


## Declaring Types

### Variable Declarations 

    let thing: string = 'John Doe'

But sometimes types are infered

#### When that variable is a higher order function

    funtion sort(compareFn: (a: string, b: number) => number): this

#### Creating a typedef / interface for your callback functions

- [TODO]: write me

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

#### So, with strictNullChecks on.... string | null | undefined everywhere???

You have some code that looks like this: `let a: string | null | undefined`

What you almost want is a Java Optional type, or something to make less typing here.

[This is not baked into the Typescript language](https://github.com/Microsoft/TypeScript/issues/23477)

- [TODO]: implementation of Maybe type here?

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

### Declaring Type Types

can declare a type that is just a value

    type AB = 'AB'

#### Declaring your callbacks: Declaring a type that is a function so you can reuse it later

- [TODO]: write me

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

# Configuring Language

Ways of configuring:

  * tsconfig.json
  * compile time parameters passed to `tsc`
  * [triple-slash directives](https://www.typescriptlang.org/docs/handbook/triple-slash-directives.html): top of the file embed XML inside Javascript comments? But if you're doing this you're already in the weird... 

... but apparently the triple-slash directives aren't supported by everything? A bit confused here...


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

# Type Checking > Clever Lint Rules

# And the CLI

## running individual files through the compiler (playground style)

Running a single file through `tsc` will NOT pick up the options specified in `tsconfig.json`.

This makes the following use cases pretty annoying:

  * override a project's entrypoint with your own, for experimentation purposes
  * have a series of typescript files in a directory to show different aspects of the language
  * you are a beginning developer, or testing something out, and don't want to set up the entire project directory structure with proper entrypoint

### a (bad) solution

I solved this by adding commands for my playground in my package.json's `script` section and manually setting the compile options I would have set in the `tsconfig.json` file as command line parameters.

This obviously doesn't work very well (at all) from a DRY perspective, but my other option (adding to the `#!` line and treating the .ts files as shell scripts) ALSO was no good (especially since I may be running the scripts on Windows).

#### making a bad solution slightly not so bad

Because npm scripts, if called with parameters, pass those parameters on to the command called - even if that's another npm command, we can abuse the system like so:

```json

  "scripts": {
    "simple": "npm run basetsc -- --strict simple.ts",
    "record": "npm run basetsc -- --strict record.ts",
    "record-not-strict": "npm run basetsc record.ts",
    "basetsc": "tsc --outDir build --target es2017 --noUnusedLocals --noUnusedParameters --noImplicitReturns"
  }
```

simple.ts, record.ts etc are our scripts we want to play with.

You need to use `--` so that npm doesn't swallow the arguments, but passes them along to the command.

# Book Recommendations

  * [Effective Typescript](https://www.amazon.com/Effective-TypeScript-Specific-Ways-Improve/dp/1492053740/ref=sr_1_1?keywords=effective+typescript&qid=1571345085&sr=8-1) <--  Effective Java/C++ style book
