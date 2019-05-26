---
path: "/learnings/javascript_eslint"
title: "Learnings: Javascript: ESLint"
---

# <<ESLint_Forcing_Import_Of_Some_Identifier>>

You can use the (undocumented) `global` declaration if you have to

    /* global history, location, console */

    console.log('hello') // this will lint properly even because we pulled in the console

Really should only be required if you didn't import an identifier any other way (like you're using a browser built-in, or you're doing something tricky with types).
