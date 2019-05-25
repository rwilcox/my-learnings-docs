---
path: "/learnings/javascript_jsdoc"
title: "Learnings: Javascript: JSDoc"
---

# Q: How can I link to a typedef in another file <<JSDoc_Linking_To_Typedefs_Or_Classes>>

## The Good Way

https://github.com/jsdoc/jsdoc/issues/969#issuecomment-87486794

    a.js
      /**
       * @module MyModule
      */

       /**
        * @typedef MyTypdef
        * @property {string} name
        */

    b.js
      /**
       * @method foobar
       * @param { module:MyModule~MyTypedef } opt options or initial config values
       */
       function foobar(opt)

`~` means "instance"  `.` means static object


## and global modules / files not explicitly given a module

Typedefs (and other functions?) that aren't explicitly part of a module are put in the global namespace.

Thus if you access these from other files you don't need special syntax for your rendered jsdocs to link to them.

## a work around

If you have properly put everything in a `@module` you can force a particular declaration to be put in the global namespace anyway. This would allow you to sacrifice a bit of namespace purity for ease of use (because you can just use the name, as if it was part of a global module).

Example

       /**
        * @global
        * @typedef MyTypdef
        * @property {string} name
        */

# <<Javascript_Typechecking_With_JSDoc>>

We can use JSDocs + some typescript magic to achieve this.

## Good articles on this


## Current (May 2019) problems with this

### Using Clever Typescript ways: They don't work

No good syntax to import declarations made in other files???

See a good explanation of this problem: https://github.com/microsoft/TypeScript/issues/14233#issuecomment-438192702

#### <<Javascript_JsDocs_And_Typescript_For_Typechecking>>

See https://github.com/microsoft/TypeScript/issues/14377#issuecomment-400464783

^^^^ breaks regular people trying to run jsdoc from command line. (Solutions proposed break normal jsdoc runs).

See https://github.com/microsoft/TypeScript/pull/28162 for a potential implementation of this??


- [TODO]: does https://www.npmjs.com/package/jsdoc-plugin-typescript work or can we make it work for this????

### Using built in JSDocs ways of linking objects together

Also broken: [IntelliSense thinks the module: literal is a filename](https://github.com/microsoft/TypeScript/issues/30893)

#### Even the global tricks like not namespacing things or making things global?

Nope.

## See also

  * Typescript_Typechecking_With_JsDoc_Annotations
  * https://stackoverflow.com/a/55767692/224334 <-- set up Visual Studio Code to include all the files.. but doesn't seem to work for typedefs?????
