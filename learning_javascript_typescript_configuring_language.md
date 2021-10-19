---
path: /learnings/javascript_typescript_configuring_language
title: 'Learnings: Typescript: Configuring Language'
---
# Table Of Contents

<!-- toc -->

- [Configuring Language](#configuring-language)
  * [And the CLI](#and-the-cli)
    + [running individual files through the compiler (playground style)](#running-individual-files-through-the-compiler-playground-style)
      - [a (bad) solution](#a-bad-solution)
        * [making a bad solution slightly not so bad](#making-a-bad-solution-slightly-not-so-bad)

<!-- tocstop -->

# Configuring Language

Ways of configuring:

  * tsconfig.json
  * compile time parameters passed to `tsc`
  * [triple-slash directives](https://www.typescriptlang.org/docs/handbook/triple-slash-directives.html): top of the file embed XML inside Javascript comments? But if you're doing this you're already in the weird...

... but apparently the triple-slash directives aren't supported by everything? A bit confused here...

## And the CLI

### running individual files through the compiler (playground style)

Running a single file through `tsc` will NOT pick up the options specified in `tsconfig.json`.

This makes the following use cases pretty annoying:

  * override a project's entrypoint with your own, for experimentation purposes
  * have a series of typescript files in a directory to show different aspects of the language
  * you are a beginning developer, or testing something out, and don't want to set up the entire project directory structure with proper entrypoint

#### a (bad) solution

I solved this by adding commands for my playground in my package.json's `script` section and manually setting the compile options I would have set in the `tsconfig.json` file as command line parameters.

This obviously doesn't work very well (at all) from a DRY perspective, but my other option (adding to the `#!` line and treating the .ts files as shell scripts) ALSO was no good (especially since I may be running the scripts on Windows).

##### making a bad solution slightly not so bad

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



