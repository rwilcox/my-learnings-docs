---
path: "/learnings/emacs_cheatsheet"
title: "Learnings: Emacs: Cheatsheet"
---

# Going to top of buffer

ESC <   <-- top

ESC >   <-- bottom

# delete whole line

C-Shift Backspace

OR `M-x kill-whole-line`

# Renaming buffers

M-x rename-buffer RET name RET

note Buffer menu won't refresh - click over to another window and click back I think that will work

# line numbers

M-x display-lines-numbers-mode

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

C-X 3: split right

C-X 2: split bottom

## Deleting sprits

M-x delete-window

(when the one you want to close is the currently active one)

C-X 0


# Switching languages and mode

M-x *-mode

shows you all the modes you can choose from

M-x markdown-mode

turns the buffer - saved or not - into a Markdown syntax highlighted buffer

# Column / rectangle selection

## without CUDA mode being on

C-x SPC

now you can NOT use the mouse to select your text, must use (arrow?) keys to select it. AND it won't show just the region you selected.

## with CUDA mode

C-RETURN

now use arrow or character movement keys to define your region. It will highlight the columnar selection.

See also [CUDA Rectangle selection shortcuts](http://trey-jackson.blogspot.com/2008/10/emacs-tip-26-cua-mode-specifically.html)


# Deleting duplicate lines

M-x delete-duplicate-lines

# Parans

C-M-f forwards to next opening paran

# Typing commands

## Interactive Commands

M-x

## Quickly call random lisp code

M-:

