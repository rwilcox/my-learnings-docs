---
path: /learnings/javascript_typescript_compiler
title: 'Learnings: Javascript: Typescript: Compiler'
---
# Table Of Contents

<!-- toc -->

- [Typescript Compiler](#typescript-compiler)
  * [compiler definition talk about typescript](#compiler-definition-talk-about-typescript)
    + [Open vs closed types](#open-vs-closed-types)
  * [Compiler Behavior and you](#compiler-behavior-and-you)
    + [Runtime constructs vs Compile time constructs](#runtime-constructs-vs-compile-time-constructs)
    + [Excess property checking](#excess-property-checking)
  * [Places where the compiler can help you](#places-where-the-compiler-can-help-you)
    + [reducing the amount of types you actually have to write](#reducing-the-amount-of-types-you-actually-have-to-write)
      - [potential way to lint places where you don't have to write types](#potential-way-to-lint-places-where-you-dont-have-to-write-types)
  * [Wrting code to give more hints to the compiler](#wrting-code-to-give-more-hints-to-the-compiler)
    + [any vs unknown](#any-vs-unknown)
    + [declare more variables as const](#declare-more-variables-as-const)
    + [Always annotate return type](#always-annotate-return-type)

<!-- tocstop -->

# Typescript Compiler

## compiler definition talk about typescript

### Open vs closed types

- [BOOKNOTES]:
> “sealed” or “precise” type, and it cannot be expressed in TypeScript’s type system. Like it or not, your types are “open.”
- From: Effective Typescript

## Compiler Behavior and you

### Runtime constructs vs Compile time constructs

- [BOOKNOTES]:
> Some constructs introduce both a type (which is not available at runtime) and a value (which is). The class keyword is one of these.
- From: Effective Typescript

### Excess property checking

- [BOOKNOTES]:
> When you assign an object literal to a variable or pass it as an argument to a function, it undergoes excess property checking.
- From: Effective Typescript

- [BOOKNOTES]:
> When you assign an object literal to a variable with a declared type, TypeScript makes sure it has the properties of that type and no others:
- From: Effective Typescript
- [TODO]: wite me

## Places where the compiler can help you

- [BOOKQUOTE]:
> There are some situations where you can leave the type annotations off of function parameters, too. When there’s a default value, for example:
- From: Effective Typescript

### reducing the amount of types you actually have to write

#### potential way to lint places where you don't have to write types

check out the eslint rule no-inferrable-types


## Wrting code to give more hints to the compiler

### any vs unknown

- [BOOKQUOTE]:
> unknown is appropriate whenever you know that there will be a value but you don’t know its type
- from: Effective Typescript

### declare more variables as const


- [BOOKQUOTE]:
> Because x cannot be reassigned, TypeScript is able to infer a narrower type without risk of inadvertently flagging errors on subsequent assignments.

- From: Effective Typescript


### Always annotate return type

- [BOOKQUOTE]:
> When you annotate the return type, it keeps implementation errors from manifesting as errors in user code.
- From: Effective Typescript

- [BOOKQUOTE]:
> This is a good reason to consider including explicit return type annotations, even when the return type can be inferred. It prevents an any type from “escaping.”
- from: Effective Typescript



