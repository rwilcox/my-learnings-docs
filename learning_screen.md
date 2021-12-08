---
path: /learnings/screen
title: 'Learnings: Screen'
---
I have the biggest man-crush on screen.

[Screen Survival Guide (SO)](http://stackoverflow.com/questions/70614/gnu-screen-survival-guide)

[Screen cheat sheet - including how to do splits!](http://www.neophob.com/2007/04/gnu-screen-cheat-sheet/)

[Linux Screen Tutorial and How-To](http://www.rackaid.com/resources/linux-screen-tutorial-and-how-to/)

# Sharing Screens with Coworkers

[A linux.com article shows you how to do this](http://www.linux.com/archive/feature/56443). Article in a brief instant:

You (username: bob):

	$ screen -S easy_to_remember_session_name
	Control-A :multiuser on
	Control-A :acladd other_person_short_login_name
	Control-A :acladd root  # <-- in case other person is using sudo screen -x...

They:

	screen -x bob/easy_to_remember_session_name
	   OR
	sudo screen -x bob/easy_to_remember_session_name


# Use of scroll buffer

  * [Hooking up scroll buffer copy/paste to OS X clipboard](http://rwilcox.tumblr.com/post/1628081194)
  * [More tricks for the scroll buffer](http://www.samsarin.com/blog/2007/03/11/gnu-screen-working-with-the-scrollback-buffer/)
  * [Make scrollbars work with screen (instead of needing to use the scrollback buffer)](http://superuser.com/questions/138748/how-to-scroll-up-and-look-at-data-in-gnu-screen/177407#177407)

# Splitting what you see into regions

Splits in GNU Screen are useful.

## Vertical Splits on OS X

  1. Install screen from Macports. Macports includes the "vertical split" patch.
  2. Now Control-A, V will give you a vertical split.

To resize these you have to select the leftmost one and: Control-A : (to enter command mode)

    : resize -30

You have to do this on the left most (right will not work)
