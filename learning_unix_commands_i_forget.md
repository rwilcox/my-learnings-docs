---
path: /learnings/unix_i_forget
title: 'Learning: Unix: Commands I forget'
---
This is a list of unix commands that are fairly simple, but I always forget how to construct them.

# Soft Link



    sudo ln -s ~/Dev/SaveMe/osx10206 ~/Backups/currentOSX

                   (source)                (destination)


# Using mutt to open another user's mailbox



    sudo mutt -f /var/mail/USERNAME




# Listing only Folders in a directory


    ls -p | grep "/"


# Locating only files/folders NAMED (something)


    locate '*/bin'


(because doing `locate bin` will also find files ''inside'' bin)

# Showing line numbers in grep



    grep -n sometext somefile


# Seeing how big each folder in a directory structure is



    du -ck | sort -n


-c = recurse with running tally

-k = sorted

# How many lines are in this folder of text files??

    find . -name '*.md' | xargs wc -l




