---
path: /learnings/applescript_snippets
title: 'Learning AppleScript: Snippets'
---
# Table Of Contents

<!-- toc -->

- [Snippets](#snippets)
  * [Droplet Idiom](#droplet-idiom)
- [Information on using Applescript to Zip files ==](#information-on-using-applescript-to-zip-files-)

<!-- tocstop -->

# Snippets

## Droplet Idiom

The droplet idiom gives you two things. First, the script can handle when the user _doesn't_ drop something on to the application. Secondly, by always passing a list to main(), we let main deal with the multiple file part... but the on run handler also has to pass its parameter to main() as a list (which we do) to avoid errors.

It could be constructed a different way - having main handle only one file at a time, and on open() being responsible for calling main() N times. (Different Strokes For Different Folks)


    on main(fileList)

      	repeat with each in fileList
    	    --fill me in!
      	end repeat
    end main

     on run {}
     	main({choose file})
     	--main( { alias "..."} )  -- fill alias quotes with a file for testing
     end run

     on open (fileList)

     end open


# Information on using Applescript to Zip files ==
[http://listserv.dartmouth.edu/scripts/wa.exe?A2=ind0805&L=MACSCRPT&T=0&F=&S=&P=4802 Use gzip tar instead of zip...]



