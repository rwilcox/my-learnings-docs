---
path: "/learnings/ops_unix_bash"
title: "Learnings: Ops: Unix: Bash"
---


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
    
    
# See also:

  * Learning_My_Unix_Tools
