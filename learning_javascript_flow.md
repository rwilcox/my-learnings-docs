---
path: "/learnings/javascript_flow"
title: "Learnings: Javascript: Flow Transpiler"
---

# <<Learning_Javascript_Flow>>

[Flow](http://flow.org) is Facebook's transpiler that adds (just) compile time type checking to Javascript.

    function concat( a: string, b: string ): string {
      return a + b
    }

    concat("hello", " world"); // <-- compiles! 
    concat("hello", 42)  // <-- will not, even though Javascript would have auto-cast it to work...>

Goals: precision, speed.

## <<Learning_Javascript_Flow_Objects_Classes_And_Types>>

Objects are structurally typed: objects with same field names and field types are considered the same.

Classes are nominally typed: because they have different names they are not the same.

Can make <<Learning_Javascript_Flow_Interfaces>> by making an object have the method signatures you want, like so

    type Consumer = {
      apply(value: string): void;

    }

    class myRunner {
      apply( value: string): void;
    }

    class SecondRunner {
      apply( value: string): void;
    }

    let test: Interface = new SecondRunner()

Note: Flow has a utility type for functional interfaces / higher level functions.

## <<Learning_Javascript_Flow_Going_Immutable>>

### <<Learning_Javascript_Flow_Going_Immutable_ReadOnlyObjects>>

Because objects are checked by structure, we don't have to cast into a read only type:

    type Props = {
        name: string,
        age: number,
    };

    type ReadOnlyProps = $ReadOnly<Props>;

    function render(props: ReadOnlyProps) {
        const {name, age} = props;  // OK to read
        props.name = "hi"            // Error when writing
    }

    let mine : Props = {name: "hello", age: 42}
    render( mine )

## <<Learning_Javascript_Refinements>>

When you're in an `if` statement you know the thing you just checked for is true: you have a more refined view of your object now.

Flow takes this a step further: if you pass a value into a function in your if statement, Flow can't know if that function has mutated its value or not. (One way to get around this is to do a copy).

## <<Learning_Javascript_Flow_Optionals>>

    function concat( a: string, b: ?string, c: string) {

    }

    concat("a", "b", "c"); // compiles
    concat("a", null, "bobby") //compilers!!!

## <<Learning_Javascript_Flow_Function_Parameters>>

### Optional Parameters

    function concat( a: string, b: string, c?: string) {

    }

    concat( "hello", "world", " "); // works!
    concat("hello", "world"); // works!!

### Parameter must be one of (this choice of items)

    function concat( a: string, b: string, joiner: " " | ", ") {

    }

    concat("hello", "world", " ") // compiles!
    concat("hello", "world", "!") // errors!

## <<Learning_Javascript_Flow_And_Promise>>

Promises are annoying, and I had to jump into the Flow source code to understand them.

    let output: Promise<string> = new Promise( (resolve, reject) => resolve("hi") )
    
That will compile if you are not using [the flow plugin for ESLINT](https://github.com/gajus/eslint-plugin-flowtype). It will throw a linter error if you are, because `resolve` and `reject` don't have type annotations.

### Using typed promise callbacks to ensure correct ordering

If you are like me and:

  1. you want to use the flow plugin for ESLint
  2. ... or... you want to avoid confusing the ordering of these two function callbacks
  
Then there is a solution here. It _is_ a lot of typing, so I'm not 100% sure about it, but it does compile (and, more importantly, fail if you have the orders mixed up!)

    type PromiseResolveType<R> = (Promise<R> | R) => void;
    type PromiseRejectType     = (error: Error) => void;
    
    let output: Promise<string> = new Promise( (resolve: PromiseResolveType<string>, reject: PromiseRejectType) => { ... } )

This took a bit of looking, and in fact browsing the Flow open source code to figure out what the Promise type declaration 
