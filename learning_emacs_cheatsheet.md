---
path: "/learnings/emacs_cheatsheet"
title: "Learnings: Emacs: Cheatsheet"
---

# Getting things done (without keyboard shortcuts)

## M-x: calling interactive mode functions

if you want to call something without using the menu or keyboard commands

## M-: calling elisp functions directly

aka normally you would need to wrap elisp calls in `(interactive)` but here you can just call things


# Going to top of buffer

ESC <   <-- top

ESC >   <-- bottom

# delete whole line

C-Shift Backspace

# delete from here to end of line

C-k

OR `M-x kill-whole-line`

# Buffers
## Renaming buffers

M-x rename-buffer RET name RET

note Buffer menu won't refresh - click over to another window and click back I think that will work

## What path is the current buffer?

M-: buffer-file-name

# line numbers

M-x display-lines-numbers-mode

## In the current window open a buffer by name

C-X b



# Zoom

M-x text-scale-increase
M-x text-scale-decrease

# Filtering Lines

## I know what I want to KEEP

*Go to the top of your buffer!!!!*

M-x keep-lines

in minibuffer enter your regex

## I know what I want to DELETE

*Go to the top of your buffer!!!*

M-x flush-lines

in minibugger enter your regex

# Splits

M-x split-window TAB

## Deleting sprits

M-x delete-window

(when the one you want to close is the currently active one)

# Switching languages and mode

M-x *-mode

shows you all the modes you can choose from

M-x markdown-mode

turns the buffer - saved or not - into a Markdown syntax highlighted buffer

# Column / rectangle selection

C-x SPC

now you can NOT use the mouse to select your text, must use (arrow?) keys to select it

# Deleting duplicate lines

M-x delete-duplicate-lines
