---
path: /learnings/javascript_lodash
title: 'Learnings: Javascript: Lodash'
---
# Table Of Contents

<!-- toc -->

- [Lodash Utilities](#lodash-utilities)
- [How I'm replacing Lodash](#how-im-replacing-lodash)
  * [`defaultTo`](#defaultto)
  * [`isNull`](#isnull)
  * [Lodash's iteration methods](#lodashs-iteration-methods)

<!-- tocstop -->

# Lodash Utilities

# How I'm replacing Lodash

## `defaultTo`

Lodash: returns the variable OR the default value

`someVar ?? "a default"`

## `isNull`

Lodash: checks to see if a value is null or undefined

`!!!b`

[!! returns if a value is convertable to a boolean type](https://stackoverflow.com/a/9284677/224334). Which is great - because even `false` can be converted.

But we want to see values that can't be - `undefined` and `null` to be exact. So get the `!` version of this.

Yes this feels weird - I don't think I like it.

## Lodash's iteration methods

I liked lodash's iteration methods because they took care of null variables. Oh well...

`(myList ?? []).collect( (f) => f+1 )`
