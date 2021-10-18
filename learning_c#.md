---
path: /learnings/csharp
title: 'Learnings: Csharp'
---
# Table Of Contents

<!-- toc -->

- [variable declarations](#variable-declarations)
  * ["pointers" in method declarations](#pointers-in-method-declarations)
- [classes](#classes)
  * [virtual methods](#virtual-methods)
- [casts](#casts)
- [Strings](#strings)
- [properties](#properties)
- [initializing objects](#initializing-objects)
- [checked variables](#checked-variables)
- [control flow](#control-flow)
  * [foreach](#foreach)
- [method syntax](#method-syntax)
- [Null Handling](#null-handling)
  * [null coalscing operator](#null-coalscing-operator)
  * [null conditional](#null-conditional)
- [TODO:](#todo)

<!-- tocstop -->

# variable declarations

    string thing

## "pointers" in method declarations

Parameters in C# are pass by "value": even if the copied value is a copy of an address pointer.

Thus, if you want to assign something to an incoming parameter, you need the `ref` keyword


    void MyMethod( ref string outString ) {
        outString = "hi"
    }

    string userName = "temp"
    MyMethod(ref userName)

Problem: `userName` variable needs to be initialized (compiler doesn't know you're just writing to it).


    void MyMethod( out string outString ) {
       out = "hi"
    }

    string userName
    MyMethod( userName )

**NOTE:**: method using out parameters must assign all `out` parameters!!!

# classes

Features:

   * single inheritence
   *

    public class Employee : Person {

    }

## virtual methods

Defaults to nonvirtual (???)

For virtual behavior need both `virtual` on base class and `override` on subclass.

# casts

C style casts

# Strings

    @"this is a literal string \ this will show up like a backslash not escape character"


    $"indicates that {variables} will be interpreted"

# properties

> In other words, a property has the behavior of special methods called setters and getters, but the syntax for accessing that behavior is that of a field.

# initializing objects

Can initilize fields at object construction time, with handy syntax:

(C# 3.0)

    Employee n = new Employee("Ryan", "Wilcox") {
        jobTitle = "Software Engineer",
        salary = "$"
    }


# checked variables

Will throw an exception if you try to overflow the variable type

This can be controlled by compiler OR by checked {} and unchecked {} variable block scopes

# control flow

## foreach

# method syntax

    public void name(TYPE varName)

# Null Handling
## null coalscing operator

"if this value is blank use that one": `a ?? b`

## null conditional
C# 6.0

    varThatCouldBeNull?.something


#preprocessors

Yes, C# has them.

Operations:

  * #if
  * #define
  * #error
  * #warning
  * #pragma
  * #line <-- override what line number is reported by the compiler in case or error or warning (!!!!!!)

# TODO:

Q: Is the following how C# does annotations??

    [TestMethod]
    public void message() {
        1 + 1
    }

