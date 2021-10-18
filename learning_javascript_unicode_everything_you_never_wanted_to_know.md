---
path: /learnings/javascript_unicode_everything_you_never_wanted_to_know
title: 'Learnings: Javascript: Unicode Everything you never wanted to know'
---
# Table Of Contents

<!-- toc -->

- [>](#)
  * [Getting real length of a string in Node](#getting-real-length-of-a-string-in-node)
  * [See also](#see-also)
- [More fun: Emojis and modifiers and other wildness](#more-fun-emojis-and-modifiers-and-other-wildness)

<!-- tocstop -->

<<Learning_Javascript_Unicode>>
=======================================


Javascript natively uses [UCS-2 exposing but likely UTF-16](https://mathiasbynens.be/notes/javascript-encoding) character encoding at a language level. Which means it runs out of characters after the 65k range, which means high order characters are done by looking at the _second_ charcter to see more.

SO: if you are looking up the number, use `codePointAt()` instead of `charCodeAt()`, as the former natively supports this higher order character work.

Technically this likely means that if you are typing to get `.length` of a string with a high unicode character, then it might not match what you expected (ie one character) because JS "followed the spec and gave you UCS-2 semantics". [Source](https://mathiasbynens.be/notes/javascript-encoding#comment-2)

Getting real length of a string in Node
---------------------------------------------

First, read [javascript has a unicode problem](https://mathiasbynens.be/notes/javascript-unicode).

Could implement it like so:

	function countSymbols(string) {
		return Array.from(string).length;
	}

See also
---------------------------------------------

  * [Let's talk about Javascript string encoding](https://kevin.burke.dev/kevin/node-js-string-encoding/)
  *

More fun: Emojis and modifiers and other wildness
======================================================================

Key words:

  * color modifiers
  * zero width joiners

  * https://eng.getwisdom.io/emoji-modifiers-and-sequence-combinations/
  * https://thekevinscott.com/emojis-in-javascript/

