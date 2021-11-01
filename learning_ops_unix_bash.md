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
- [See also:](#see-also)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

# <<Learning_Ops_Unix_Bash>>

## <<Learning_Ops_Unix_Bash_Defaults_For_Variables>>

    FOO=${FOO:-default_val_here}

or

    : ${FOO:=default_val_here}

# <<Learning_Ops_Unix_Bash_Interactively>>

    $ r -1 # re-executes the last command you entered
    $ r -1 | vi # … yup, piping works here too

    $ !-1  # fills in your next command prompt with your previously executed command (you typoed it or whatever)
    $ sudo !-1 # your previous command now has sudo prepended! (thanks Sam!)
    $ !sudo     # runs the last command that started with sudo (thanks Nicholas!)

    $ $_ # executes the result of the previous command (Thanks, Adam!)

# <<Learning_Opn_Unix_STD_AS_File>>

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



