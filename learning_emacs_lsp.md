---
path: /learning_emacs_lsp
title: 'Learning Emacs: LSP'
---
# Javascript / Typescript

This works better / is probably more supported than even `js2-mode`, as it does JSX better.

`M-x lsp` to activate this. You want ts-ls, not js-ts-ls as the latter seems to not be supported?

Q: Can I get a function definition list?
A: KINDA! `M-x lsp-ui-imenu` gives you a sidebar of tree structure of your code (may include more than functions)

Q: What about js2-mode?
A: Turn on `lsp` over `js2-mode` for backend javascript. For React let lsp run over js-jsx-mode ????


# Rust

## My notes

Need to use `M-x rustic-mode` or a hook to turn on the neat stuff.

`M-x lsp-find-defintion` jump to defintion.

## See also:

  * [Rust with Emacs](https://robert.kra.hn/posts/2021-02-07_rust-with-emacs)
  * [LSP support for rust in emacs](https://zerokspot.com/weblog/2020/10/18/lsp-support-for-rust-in-emacs/)
