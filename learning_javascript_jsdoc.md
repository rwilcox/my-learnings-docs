---
path: /learnings/javascript_jsdoc
title: 'Learnings: Javascript: JSDoc'
---
# Table Of Contents

<!-- toc -->

- [Q: How can I link to a typedef in another file >](#q-how-can-i-link-to-a-typedef-in-another-file-)
  * [The Good Way](#the-good-way)
  * [and global modules / files not explicitly given a module](#and-global-modules--files-not-explicitly-given-a-module)
  * [a work around to force a typedef to be a global even if it's inside a module](#a-work-around-to-force-a-typedef-to-be-a-global-even-if-its-inside-a-module)
  * [Really forcing the issue with an identifier](#really-forcing-the-issue-with-an-identifier)
- [>](#)
  * [Good articles on this](#good-articles-on-this)
  * [Components involved](#components-involved)
    + [JSDoc >](#jsdoc-)
      - [Using built in JSDocs ways of linking object declarations together](#using-built-in-jsdocs-ways-of-linking-object-declarations-together)
        * [Even the global tricks like not namespacing things or making things global?](#even-the-global-tricks-like-not-namespacing-things-or-making-things-global)
      - [Using Clever Typescript ways to create a type then import the typedef: They don't work (with pure jsdoc)](#using-clever-typescript-ways-to-create-a-type-then-import-the-typedef-they-dont-work-with-pure-jsdoc)
        * [Github Issues / PRs around this:](#github-issues--prs-around-this)
      - [A plugin to the rescue: jsdoc-plugin-typescript](#a-plugin-to-the-rescue-jsdoc-plugin-typescript)
    + [ESLINT](#eslint)
      - [ESLINT + JSDoc checking](#eslint--jsdoc-checking)
    + [Micosoft Typescript / Javascript Language server](#micosoft-typescript--javascript-language-server)
      - [Use a more recent version of TypeScript?](#use-a-more-recent-version-of-typescript)
        * [Issues / PR that avoids the JSDoc import mess by doing it natively in TS](#issues--pr-that-avoids-the-jsdoc-import-mess-by-doing-it-natively-in-ts)
  * [See also](#see-also)

<!-- tocstop -->

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


## a work around to force a typedef to be a global even if it's inside a module

If you have properly put everything in a `@module` you can force a particular declaration to be put in the global namespace anyway. This would allow you to sacrifice a bit of namespace purity for ease of use (because you can just use the name, as if it was part of a global module).

Example

       /**
        * @global
        * @typedef MyTypdef
        * @property {string} name
        */

## Really forcing the issue with an identifier

See ESLint_Forcing_Import_Of_Some_Identifier


# <<Javascript_Typechecking_With_JSDoc>>

We can use JSDocs + some typescript magic to achieve this.

## Good articles on this

  * [my pinboard tag on typechecking in javascript](https://pinboard.in/u:rwilcox/t:javascript_typechecking/)

## Components involved

### JSDoc <<Javascript_JsDocs_And_Typescript_For_Typechecking>>

You may - and in fact I really want - to not break `jsdoc` generation when doing this. There are several problems with this currently (May 2019).

#### Using built in JSDocs ways of linking object declarations together

Also broken: [IntelliSense thinks the module: literal is a filename](https://github.com/microsoft/TypeScript/issues/30893)

##### Even the global tricks like not namespacing things or making things global?

Nope.

#### Using Clever Typescript ways to create a type then import the typedef: They don't work (with pure jsdoc)

This:

  1. Breaks running jsdoc, because it doesn't know what to do with the Typescript syntax in the middle of the declaration
  2. Looks kind of weird: you have to essentially stub every declaration from another file that you want to use.

See a good explanation of the "import type" trick and where it breaks down:

##### Github Issues / PRs around this:

  * https://github.com/microsoft/TypeScript/issues/14233#issuecomment-438192702 <-- good example of the "typedef import" usage trick... and the error you get from jsdoc when you do it
  * https://github.com/microsoft/TypeScript/issues/14377#issuecomment-400464783 <-- breaks regular people trying to run jsdoc from command line. (Solutions proposed break normal jsdoc runs).

#### A plugin to the rescue: jsdoc-plugin-typescript

[jsdoc-plugin-typescript](https://www.npmjs.com/package/jsdoc-plugin-typescript) lets us put typescript in our JSDoc, so we can do the Clever Typescript thing.

    /**
    * @typedef { import('./a').Team} Team
    */

    /**
    * Display the team
    *
    * @param {Team} team the team to display for
    */
    function displayTeam(team) { ... }

It has only two (relatively minor problems):

  1. when it expands the typescript the type, in the rendered JS, is not hyperlinked anymore (but the type appears inline in the module page, not requiring people to go find it, so that's a win).
  2. Requires(?) jsdoc 3.6
  3. requires typedef stubs. (Placing the typescript inline in the `@param` declaration doesn't seem to work)

But it has some major ADVANTAGES:

  1. eslint, even with [eslint-plugin-jsdoc](https://www.npmjs.com/package/eslint-plugin-jsdoc) seems to be relatively happy with the typescript in the stub declaration
  2. Typechecking / IntelliSense totally works!

[See it is in use / I made a sample repo](https://github.com/rwilcox/blog_sample_code_jsdoc_with_typescript_checking/blob/master/b.js#L4)

### ESLINT

You're likely running eslint in your project, so you have to make sure that any code you write stays valid. Because you're not really writing Typescript, you can't go down that route entirely

#### ESLINT + JSDoc checking

You are running [eslint-plugin-jsdoc](https://www.npmjs.com/package/eslint-plugin-jsdoc), right?

### Micosoft Typescript / Javascript Language server

#### Use a more recent version of TypeScript?

https://stackoverflow.com/a/50255744/224334

Can use the command prompt in VCS to select Typescript version: make sure this is > 2.9???

... which my work if both the source and caller location are in the same jsDoc module...

##### Issues / PR that avoids the JSDoc import mess by doing it natively in TS

  * https://github.com/microsoft/TypeScript/pull/28162 for a potential implementation of this??

Because if TS had native support you would be able to do TS-like typechecking, even / especially if you could set your declarations (or whatever) to global.



## See also

  * Typescript_Typechecking_With_JsDoc_Annotations
  * https://stackoverflow.com/a/55767692/224334 <-- set up Visual Studio Code to include all the files.. but doesn't seem to work for typedefs?????

