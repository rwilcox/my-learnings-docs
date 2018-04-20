---
path: "/learnings/javascript_own_modules"
title: "Learnings: Javascript: Publishing Own Modules"
---

# <<NPM_Publish_Steps>>

Aka what stages are taken by npm when you ask it to publish or install something.

prepublish -> prepare -> prepublishOnly -> prepack -> pack -> postpack -> publish -> postPublish -> USER INSTALLS -> prepublish -> prepare -> preinstall -> install -> postinstall

[Source](https://docs.npmjs.com/misc/scripts).

## Doing stuff (only) before publishing it

NPM 3 introduces a new script field `prepublishOnly`. This script will only be run before actual publishing.

See also:

  * https://iamakulov.com/notes/npm-4-prepublish/
  * [https://github.com/npm/npm/issues/10074](NPM issue on creating / splitting out prepublish). Note: the noise about depreciating it a year or so after depreciating publish didn't actually happen.

## Doing (the same) stuff before publishing AND on package install

This is the behavior of the `prepublish` since [npm 1.1.71](https://github.com/npm/npm/commit/351304d28c2afcfae93de05b4c6bcf035054de3e). So prepublish isn't... just for prepublishing.

You should use `prepublishOnly` or `preinstall` instead. If you actually want to do the same thing two places use the new `prepare` script that does this.

## Testing your script flow out

`npm pack` <-- does everything but the sending to the repo.

# `<<NPMPackageFieldsToSet>>`
 
## Making sure you don't publish a closed source package to a public registry

Two options: set `"private": true` OR specify the repo:

    { 
      publishConfig: {
          registry: "https://MY.PRIVATE.REGISTRY.EXAMPLE.COM"
      }
    }
    
( can also do `npm install --registry=....` or `npm config set registry https://MY.PRIVATE.REGISTRY.EXAMPLE.COM` )

# <<NPM_Modules_And_Dependancies_Kinds>>

Three kinds of dependancies: regular dependancies, dev dependancies, and peer dependancies.

  * regular: Stuff your package uses but you don't expose that in interfaces to the outside world.
  * dev: Stuff you need for dev-ing your package (but not elsewhere)
  * peer: Stuff your packages uses **and exposes this dependancy to the rest of the world**
  
Peer dependancies often happen in libraries that implement common Express middleware, where you are modifying the Express application object. In this case, you want to make sure you're using the same version of Express as the application _you're_ being included into, because maybe you're modifying their `app` object. In this case you don't want to be using a different version (ie the internal object may look different from your perspective, etc ec).

See also: 

  * https://lexi-lambda.github.io/blog/2016/08/24/understanding-the-npm-dependency-model/
  * https://bytearcher.com/articles/loading_modules_with_require/
  * https://blog.safia.rocks/post/169267758290/node-module-deep-dive-module

# <<NPM_Modules_And_Transative_Dependancies>>

The following diagram is a pre NPM 3 version of how Node treated transative dependancies. It still does something like this, but things are flatter now (unless there's a conflict).

                my_app/
            +----+index.js
    found! |          `const e = require("express")`
            |     node_modules/
            +-----> express/
                    index.js
                +---+  `const u = require("underscore")`
        found!   |   node_modules/
                +---> underscore/
                        index.js
                    +-----+ `const p = require("some_peer_dependency")`
      NOT HERE! UP! |          +
                    +>         |    
                               |
            +------------------+
    found!  |
            +---->  some_peer_dependency/
                    index.js

Because of this history / ability, transative dependancies are less of an issue here: a module can pull in rambda and it can be a totally different version than the rambda you have, as the file resolution order (in this pre npm 3 naive scenario) goes:

  1. Is there a peer node_modules folder to your current file / directory? EXIT: we found. Not? GOTO 2
  2. `cd ../`
  3. GOTO 1.

See also:

  * https://felixrieseberg.com/npm-v3-is-out-and-its-a-really-big-deal-for-windows/
