---
path: /learnings/emacs
title: 'Learnings: Emacs'
---
# Table Of Contents

<!-- toc -->

- [Editing Javascript in emacs](#editing-javascript-in-emacs)

<!-- tocstop -->

# Editing Javascript in emacs

# Calc Mode
<<Emacs_Calculations_Calc>>

I like [literate-calc-mode](https://github.com/sulami/literate-calc-mode.el) for most things, and in fact use it to keep track of monthly bills.

But sometimes I want to run quick calculations where getting the answer is more important than showing the work.

Calc mode to the rescue

Formulas can either be on a single line of between delimiters: blank lines or LaTeX math delimiters ($, $$), `@` (TexInfo), and a few others.

*note*: the blank lines delimiters mean there needs to be a blank line above and below the expression

```

10 - 5

```

place your cursor into the formula and M-x calc-embedded-update-formula.

```

5

```

now inside a line: `$$ 10 - 5 $$ ` $$ 5 $$

You can also create variables, with `:=`

` $$ budget := 500 $$ `

This is a bit trickier. In the region you need to M-X calc-embedded, then M-x calc-embedded again to get out

Now you can use this variable in your update formula call, like so: ` $$ budget - 100 $$` which returns ` $$ 400 $$`.

Now, what if I'm computing things but want to keep the initial formula? Use ` =>`

`$$ 500 - 400 => $$` results in `$$ 500 - 400 => 100 $$`. In fact, if I subtract 300 instead and run the calculations, Emacs updates the answer once I run `M-x calc-update-formula`

# Find and Replace in Folders

Use `swiper-all`, type your expression, press `M-q` for the replacement, ENT, `y` replaces one and goes on to the next, `n` skips, `!` replaces all

[Source](https://emacs.stackexchange.com/a/58779)
