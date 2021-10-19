---
path: /learnings/smalltalk
title: 'Learnings: Smalltalk'
---
# Table Of Contents

<!-- toc -->

- [Slack Syntax on a postcard](#slack-syntax-on-a-postcard)
  * [Explaination of that code block](#explaination-of-that-code-block)
  * [1. `exampleWithNumber: x anotherParameter: z`](#1-examplewithnumber-x-anotherparameter-z)
  * [2. ` `"A method that illustrates every part of Smalltalk method syntax..... "`](#2--a-method-that-illustrates-every-part-of-smalltalk-method-syntax-)
  * [3. `| y |`](#3--y-)
  * [4. `false ifFalse: `...](#4-false-iffalse-)
  * [4. (continued) `ifFalse: [ 'hello' ]`](#4-continued-iffalse--hello-)
  * [4. (continued): .](#4-continued-)
  * [5. `y := self size + super size.`](#5-y--self-size--super-size)
- [6. `#($a #a "a" 1 1.0).`](#6-%23a-%23a-a-1-10)
  * [7. ` do: [:each | | localVariableInAClosure |`](#7--do-each---localvariableinaclosure-)
  * [9. `^x < y`](#9--x--y)
- [Smalltalk Philosophy](#smalltalk-philosophy)
- [Fun things to see](#fun-things-to-see)
  * [playground](#playground)
    + [and the object inspector](#and-the-object-inspector)
    + [GTInspector](#gtinspector)
  * [Gofer](#gofer)
- [Alternative implantations](#alternative-implantations)
  * [GNU Smalltalk](#gnu-smalltalk)
  * [Squeak](#squeak)
  * [VA Smalltalk](#va-smalltalk)
  * [Amber Smalltalk](#amber-smalltalk)
- [Idioms](#idioms)
  * [Complex things to a string](#complex-things-to-a-string)
- [Learning Resources](#learning-resources)

<!-- tocstop -->

# Slack Syntax on a postcard

    1 exampleWithNumber: x anotherParameter: z
    2    "A method that illustrates every part of Smalltalk method syntax
        except primitives. It has unary, binary, and keyboard messages,
        declares arguments and temporaries, accesses a global variable
        (but not an instance variable), uses literals (array, character,
        symbol, string, integer, float), uses the pseudo variables
        true, false, nil, self, and super, and has sequence, assignment,
        return and cascade. It has both zero argument and one argument blocks."
    3    | y |
    4    true & false not & (nil isNil) ifFalse: [self halt].
    5    y := self size + super size.
    6    #($a #a "a" 1 1.0)
    7        do: [ :each | | localVariableInAClosure |
    8            Transcript show: (each class name);
                        show: ' '].
    9    ^x < y

## Explaination of that code block

## 1. `exampleWithNumber: x anotherParameter: z`
creates a new method, takes parameter x. Call it like:

`exmpleWithNumber: 42 anotherParameter: 43.`

“named keyword arguments” like Objective-C (Objective-C stole these from Smalltalk)

## 2. ` `"A method that illustrates every part of Smalltalk method syntax..... "`

comments are in double quotes

## 3. `| y |`

declare local variables in the top of a section of code, in between pipe characters

## 4. `false ifFalse: `...

very very few control structures in Smalltalk (even method definitions are actually method calls on objects!). For example, if statements are implemented as method calls on boolean

## 4. (continued) `ifFalse: [ 'hello' ]`

the [] nonsense is a Smalltalk block… aka closure / anon function. In smalltalk, in blocks, the last statement is returned as the result of the block

## 4. (continued): .

lines terminated by `.` (not `;`)

## 5. `y := self size + super size.`

`:=` is the assignment operator, like Pascal. Here we’re calling the `size` method on `self` (aka `this`), and the same method on `super` aka the superclass this class inherits from

# 6. `#($a #a "a" 1 1.0).`

here we create an array. There’s two ways to do an array in Smalltalk, this is one of them

Space delimited item definitions

## 7. ` do: [:each | | localVariableInAClosure |`

`do` takes a closure. The closure will be passed one parameter (which we all `each` here.). That closure declares one local variable, `localVariableInAClosure`.

It looks kind of odd, but it *is* consistent...

The results of the last statement in a closure is the return value of that closure.

## 9.  `^x < y`

unlike a block, methods need to explicitly return something. the `^` is the return statement

# Smalltalk Philosophy

(the awesome(??) thing about Smalltalk is that it’s image, not file based. Most Smalltalks integrate a window manager, code editor and saves state. Thus when you open Pharo Smalltalk you end up in essentially a desktop environment. Of course, we know that individual files for a program won out, but in Smalltalk the code lives in the image - so source control as we know is… there in Pharo, but more like a bridge then anything else
but as long as you save your image both window positioning AND instance data for non-garbage collected objects are PERSISTED for you
thus why I like it for a dev workbench - saving state is _cheap_, and everything lives together aka all my scripts are strewn out inside the image, not strewn out inside the file system

# Fun things to see

## playground

### and the object inspector

### GTInspector

## Gofer

##

# Alternative implantations

## GNU Smalltalk

Billed as "Smalltalk foe those who can type", doesn’t include a UI or browser.

## Squeak

MIT backed implementation, the backend for a number of interesting projects (Scratch, Seaside.

## VA Smalltalk

Commercially supported Smalltalk. about $7,000 per license

## Amber Smalltalk

Smalltalk image based... but on the web.

# Idioms

## Complex things to a string

    |s t|
    t := Time now asDateAndTime .
    s := String new writeStream.
    s << t dayOfWeekName.
    s << ','.

    s contents.

# Learning Resources

  * http://ceronio.net/2017/07/first-steps-with-pharo-smalltalk/
   * [Pharo by example](https://ci.inria.fr/pharo-contribution/job/UpdatedPharoByExample/lastSuccessfulBuild/artifact/book-result/PharoTour/PharoTour.html)



