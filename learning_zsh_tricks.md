---
path: /learnings/zsh_tricks
title: 'Learnings: ZSH: Tricks'
---
Introduction
===================

I've seen many blog entries on why zsh is great for interactive console use. It is!

Zsh also has some really good tools for writing shell scripts.

vared
-------------

 vared -p "Enter issue number: " ISSUE_NUMBER
 
 
${(q)text_that_is_now_quoted}
-----------

Appending (only unique!) items to $PATH
-------------

In zsh `$PATH` is actually a representation of the `path` shell variable.

    typeset -U path  
    path+=($PROJECT_PATH/node_modules/coffee-script/bin/)
    path+=(~/.nvm/v0.8.23/bin/)

Source: http://unix.stackexchange.com/questions/62579/is-there-a-way-to-add-a-directory-to-my-path-in-zsh-only-if-its-not-already-pre
