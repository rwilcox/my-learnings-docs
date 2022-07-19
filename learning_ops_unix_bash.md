---
path: /learnings/ops_unix_bash
title: 'Learnings: Ops: Unix: Bash'
---
# Table Of Contents

<!-- toc -->

- [>](#)
  * [>](#)
- [>](#)
- [>](#)
  * [See also](#see-also)
- [>](#)
  * [See also:;](#see-also)
- [`${}` vs `$() vs backticks`](#-vs--vs-backticks)
- [See also:](#see-also)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

# <<Learning_Ops_Unix_Bash>>

## <<Learning_Ops_Unix_Bash_Defaults_For_Variables>>

    FOO=${FOO:-default_val_here}

or

    : ${FOO:=default_val_here}

## `${}` vs `$() vs backticks`

`$()` == two backticks. This is command substitution. [Source](https://unix.stackexchange.com/a/165637/193798)

`${}` does the following things:

  1. expand variable `${varHere}` <-- varHere
  2. expanding array elements, as in ${array[42]}
  3. using parameter expansion operations, as in ${filename%.*} (remove extension)
  4. expanding positional parameters beyond 9: "$8 $9 ${10} ${11}"

[Source](https://stackoverflow.com/a/8748880/224334)

## globs

### replicating zsh double-star glob

[zsh documentation about this](https://zsh.sourceforge.io/Doc/Release/Expansion.html#Recursive-Globbing)

While bash has this functionality (in the last decade...), `ash` seems to not?

`find $1 -name '*.txt' | grep '.txt' > /dev/null` <-- gives you a 0 if files found, a 1 if no files found

#### See also

  * apparently this is a feature of Bash 4 (2010-ish)? see (this SO answer)[https://unix.stackexchange.com/a/197382/193798]
  * and a [more comprehensive answer across all shells](https://unix.stackexchange.com/a/62665/193798)

# <<Learning_Ops_Unix_Bash_Interactively>>

    $ r -1 # re-executes the last command you entered
    $ r -1 | vi # … yup, piping works here too

    $ !-1  # fills in your next command prompt with your previously executed command (you typoed it or whatever)
    $ sudo !-1 # your previous command now has sudo prepended! (thanks Sam!)
    $ !sudo     # runs the last command that started with sudo (thanks Nicholas!)

    $ $_ # executes the result of the previous command (Thanks, Adam!)

# <<Learning_Ops_Unix_STD_AS_File>>

STDOUT, STDERR, STDIN are files too.

Some programs need you to specify `-` as a parameter if you are passing stdin into the program. NO MORE!!

    $ ls | diff /dev/fd/stdout my_old_listing

## See also

  * _The Linux Programming Interface_ , Chapter 5.11

# <<Learning_Ops_Unix_Process_Substitution>>

Q: what if you need to pipe the STDOUT of multiple commands? or send the output of a command into another command that doesn't support stdin (and you don't want to use `/dev/fd/stdout`)?

(At implementation level uses fd (file descriptors) in supported OSes, else uses named pipes.)

    diff <(ls my_dir)>  <(ls some_other_dir)>

## See also:;

  * Bash Advanced Scripting Guide
  * Z Shell Manual


# See also:

  * Learning_My_Unix_Tools

# Book Recommendations

  * [The Linux Programming Interface](https://www.amazon.com/Linux-Programming-Interface-System-Handbook-ebook/dp/B004OEJMZM/ref=as_li_ss_tl?crid=22DZRQ0BQORP1&keywords=the+linux+programming+interface+2nd+edition&qid=1555896803&s=books&sprefix=the+linux+programming+inter,stripbooks,343&sr=1-1&linkCode=ll1&tag=wilcodevelsol-20&linkId=412000e8f684ee3cb4b728e72aa2cfb7&language=en_US)
