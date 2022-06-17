---
path: /learnings/emacs_cheatsheet
title: 'Learnings: Emacs: Cheatsheet'
---
# Table Of Contents

<!-- toc -->

- [Getting things done (without keyboard shortcuts)](#getting-things-done-without-keyboard-shortcuts)
  * [M-x: calling interactive mode functions](#m-x-calling-interactive-mode-functions)
  * [M-: calling elisp functions directly](#m--calling-elisp-functions-directly)
- [Going to top of buffer](#going-to-top-of-buffer)
- [delete whole line](#delete-whole-line)
- [delete from here to end of line](#delete-from-here-to-end-of-line)
- [Buffers](#buffers)
  * [Renaming buffers](#renaming-buffers)
  * [What path is the current buffer?](#what-path-is-the-current-buffer)
- [line numbers](#line-numbers)
  * [In the current window open a buffer by name](#in-the-current-window-open-a-buffer-by-name)
- [Zoom](#zoom)
- [Filtering Lines](#filtering-lines)
  * [I know what I want to KEEP](#i-know-what-i-want-to-keep)
  * [I know what I want to DELETE](#i-know-what-i-want-to-delete)
- [Splits](#splits)
  * [Deleting sprits](#deleting-sprits)
- [Switching languages and mode](#switching-languages-and-mode)
- [Column / rectangle selection](#column--rectangle-selection)
  * [without CUDA mode being on](#without-cuda-mode-being-on)
  * [with CUDA mode](#with-cuda-mode)
- [Deleting duplicate lines](#deleting-duplicate-lines)
- [Parans](#parans)
- [Typing commands](#typing-commands)
  * [Interactive Commands](#interactive-commands)
  * [Quickly call random lisp code](#quickly-call-random-lisp-code)

<!-- tocstop -->

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

# Frames

## Renaming Frames

M-x set-frame-name RET your-name-here-whatever RET

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
