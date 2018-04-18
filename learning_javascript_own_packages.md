---
path: "/learnings/javascript_own_modules"
title: "Learnings: Javascript: Publishing Own Modules"
---

# <<NPM_Publish_Steps>>

prepublish -> prepare -> prepublishOnly -> prepack -> postpack -> publish -> postPublish -> USER INSTALLS -> prepublish -> prepare -> preinstall -> install -> postinstall

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
