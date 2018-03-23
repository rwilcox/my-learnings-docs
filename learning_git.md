---
path: "/learnings/git"
title: "Learnings: Git"
---

Git is pretty neat, and lets you think about source code management in totally different ways. Go Git!

# Git Branches (and stuff)

## Remote Branches

	$ git checkout -b BRANCH_NAME_THAT_YOU_WANT_LOCALLY --track origin/REMOTE_BRANCH_NAME


Which will pull down the remote branch (found at origin/REMOTE_BRANCH_NAME) into the locally named branch BRANCH_NAME_THAT_YOU_WANT_LOCALLY.

(Technically there's nothing special about origin - it's just the name of the remote tracking branch you're using. This is explained later...)

Then git pull to get the code...

## "Take a mod from that branch and put it over here"

(aka: pull a commit from the trunk into a release branch)

Use git-cherry-pick to "Cherry-pick" ''just'' one commit out of a branch to put it in the current checkout:


	$ git cherry-pick -n SHA1


(Replace SHA1 with the SHA1 hash for that commit you see in git log)

When you're feeling confident you can remove the -n training wheels. That just says "Do not automatically commit the cherry pick".

## "Push this work up to the branch"

Now your work is on your local machine, but you have to move it up to the remote server's branch.


	$ git push origin BRANCH_NAME_THAT_YOU_HAVE_LOCALLY:REMOTE_BRANCH_NAME


By default a "git push origin" command will post your changes up to the remote server to origin/BRANCH_NAME_THAT_YOU_HAVE_LOCALLY, which you might not want. So we add the LOCAL:REMOTE parameter to explicitly state what branch it goes to remotely (neither LOCAL nor REMOTE parameters need origin/. If your remote branch is origin/release1.0, all you need is the release1.0 part)

## "Make a copy of the current checked out branch up on the server, and name it..."

You want to make a new branch


	$ git push origin BRANCH_NAME:NEW_BRANCH_NAME

## Remote related error messages


	$ git push origin BRANCHNAME
	ksh: git-receive-pack: not found


This error is caused by the current machine (the push-er) not being able to access git-receive-pack on the remote machine (the pushed-to) because git-receive-pack isn't on the PATH for the user the client logs in under.

'''Solution''': figure out what the path for git-receive-pack on that remote machine and give it to git explicitly like so:


	$ git push origin BRANCHNAME --receive-pack=/opt/local/bin/git-receive-pack
	....


	$ git checkout -b wreal_soft_launch_2008121 --track origin/soft_launch_2008121
	fatal: git checkout: updating paths is incompatible with switching branches/forcing
	Did you intend to checkout 'origin/soft_launch_2008121' which can not be resolved as commit?


'''Solution''': 

	$ git fetch

I think this problem is related to git not having the remote branch names on hand, so a git fetch gets those and lets you check them out... I think

See also: [http://www.skrinakcreative.com/wp/?p=175 This problem at skrinakcreative]

## Normal Branches 

Pulling changes in the master up into your current branch (in your branch):

	$ git rebase master

Pulling changes in the branch to the master (from the trunk/master branch)

	$ git merge branchname


You can create a git branch on top of a dirty working copy and have a branch created with those (dirty) changes.

# Understanding git commands

## From Remotes (aka: remote tracking branches)
Commands like git-pull and git-push are in the following format:

  $ git-pull REMOTE-NAME BRANCH-NAME


When you clone a git repo, git-clone actually creates a remote tracking branch (named "origin", by default) and checks out the initial branch equal to the remote's currently active branch. (http://www.kernel.org/pub/software/scm/git/docs/git-clone.html Reference) (Yes, this is dense English). BUT you can use git-clone -o NAME ... to override the default NAME of "origin". Or you can let git-clone to its thing and edit .git/config yourself with the new name.

By default git-pull and git-push know what remote tracking branch you're on now, and what regular branch, but if you want to be pedantic (or want to override something for some reason) that is the syntax. See the "pushing your changes up to Git-hub" section for an example.

But these optional parameters mean you can be tracking '''many''' remote branches at one time... like tracking the main git remote branch, and also a (say) remote branch on your desktop machine for the work you've done there but not pushed up to the main remote branch yet.

# Oft Used Git Commands

  * git stash / git stash apply <-- "get my unsaved changes out of the way, so I can push or pull/OK, put my changes back" 
  * git checkout FILE <-- will revert any modifications to FILE made since the last commit (so it's like svn revert FILE)

# Git via Email

Git is distributed - which means there doesn't have to be one centralized server. One (very low-tech, but very simple) way to do this to just email git diffs back and forth - telling people exactly what you changed in one commit (or a series of commits, or whatever). Which might just be Good Enough For Right Now... or good enough for your situation.

To package your changes up:

	$ git commit                              #commit your changes to the repo
	$ git-format-patch HEAD^    

The git-format-patch command says ("package the differences from the last revision to HEAD up in mailbox-style format). (Check out the rubinius link below for what the ^ means)

Now send your email away

On the receiver side:

	$ git-am MAILBOX_FILE_YOU_GOT_VIA_EMAIL

Which imports the commit you got via the mail... and commits it to your repo. It'll look (in git-log) like ''they'' made the commit!

Thanks to the [http://rubinius.lighthouseapp.com/projects/5089/using-git Rubinius documentation on git] for help with git-format-commit!

NOTE: I wouldn't do this for any real length of time, nor with more than say 2 developers... but it might just keep your dev team truck'n when the central server dies.

## If Your Patch Doesn't Apply
[If errors about whitespace, see this blog article](http://www.winksaville.com/blog/linux/git-applying-patches/)

# GIT-SVN

git-svn is our preferred way to use Subversion

## Handling svn:externals with git-svn

git-svn doesn't have native support for svn:externals. But there are a number of third-party tools to fill the gap:

  * [git-svn-clone-externals](http://github.com/andrep/git-svn-clone-externals/tree/master) It makes you put the checking scripts in the same folders as the externals (making it a PITA that way), BUT it includes nice utility scripts that check to see if you have any unpushed changes/uncommitted changes OR if your externals are out of date.
  * [git_svn_externals](http://github.com/sushdm/git_svn_externals/) Has differences from the above script in the following ways: (1) will recurse the directory and find folders with svn:external properties (instead of needing you to place the script correctly) (2) will update all these external repositories when ran at the top level directory again and (3) is compatible (similar directory structure and approach) to the git-svn-clone-externals script above (meaning you can use the more advanced git-svn-check-unpushed and git-svn-externals-check scripts from the former.
  * [gsc](http://yergler.net/blog/2009/07/21/git-svn-and-svnexternals/gs) Python utility that does the same. Disadvantage is that it bakes in assumptions about trunk/branches/tags, which may not always be the case with my projects.

## Including branches and trunk too (standard SVN layout)

[SVN Branches in git](http://www.jukie.net/~bart/blog/svn-branches-in-git). In a nutshell: tell git svn clone where the trunk and branches directory is (or use git svn clone $URL --stdlayout). Then read the article.


# Pushing Your Changes

## Up To GitHub

	$ git diff   
	$ git commit -a -s    # -a = sync index and (??) -s = sign off on changes
	$ git push origin master # send thosue changes up to github


## To a local file system repo

[git repositories on local FS](http://blog.costan.us/2009/02/synchronizing-git-repositories-without.html)

= Git Documentation / Tutorials =

[A Git introduction by the CS department at cmu.edu](http://www.cs.cmu.edu/~410/doc/git-intro.html)

(some parts specific to their setup, but after the first "installing git" part it's good)

[GitMagic is a *great* bit of git documentation!](http://www-cs-students.stanford.edu/~blynn/gitmagic/index.html)

[Git Guide for SourceMage (in Q&A format)](http://wiki.sourcemage.org/Git_Guide)

[Handling conflicts in Git](http://weblog.masukomi.org/2008/07/12/handling-and-avoiding-conflicts-in-git)

= Useful Third Part Git Tools =

[Git-wtf](http://git-wt-commit.rubyforge.org/): gives information on how your current repo differs from the remote repo, and the merged state of your branches

[Sequential Revision Numbers in Git](http://blogs.codewise.org/wrf/article/sequential_revision_numbers_in_git)

# Merging

Merging can be, umm, fun.

## Reverting a file to your state (premerge) or their state (premerge)

	
   $ git checkout --ours somefile.txt
OR
   $ git checkout --theirs somefile.txt


# Super Advanced Git commands (Rewritting history)

[Get rebase for picking apart commits explained](http://www.jukie.net/~bart/blog/20081112150409)

[git diff with a remote repo](http://pjps.tumblr.com/post/96756489/git-diff-with-a-remote-repository)

[Merging Two Git Repos](http://blog.futureshock-ed.com/2009/01/how-to-merge-to-repositories-on-mac-os.html)

[Removing a commit in an un-pushed repo](http://kerneltrap.org/mailarchive/git/2007/1/31/237312)

## Splitting out mashed up commits that are on another branch

    ( create your new branch, or get on master or whatever)
    $ git cherry-pick -e SHA1
    $ git reset HEAD~1


Now you are at a point where you would normally git add files to the commit.
Now craft your commit with git add -p or GitX or whatever, and make your commits.

## How to move a commit from master to a branch

  $ git branch experimenting
  $ git reset --hard HEAD~1   # HEAD~1 should be the commit you want to move over


## How to cherry-pick a commit from another repo
(Thanks to this blog entry: [Using Git To Pull in A Patch From A Single Commit](http://blog.mhartl.com/2008/07/01/using-git-to-pull-in-a-patch-from-a-single-commit/)

  git fetch REPO branchname 
      #where REPO can be the location of an on-disk repo, or a 'remote' name
  git cherry-pick SHA1


# Doing Git magic on the command line
http://www.elctech.com/tutorials/untangle-your-git-commits-with-git-add---patch how to add individual chunks from command line/interactively

Arild Shirazi said, on this front:

	$ git add -p foo
	$ git commit foo


is WRONG

the right way to do it

	
	$ git add -p foo
	$ git commit


as soon as you specify a directory of file for the commit, it ignores the partial (hunk) to commit, and goes ahead and commits the whole file

# Integration/fitting into WDS patterns

## Integrating with vimdiff
[How to integrate into vimdiff](http://technotales.wordpress.com/2009/05/17/git-diff-with-vimdiff/)

== Integrating Git information into builds ==
[Git and XCode build script (also has alternative versions and a Hg shell script too!)](http://www.cimgf.com/2008/04/13/git-and-xcode-a-git-build-number-script/)


## Understanding Internals

See also:

  * [Safia Abdalla: learning more about commits are represented](https://blog.safia.rocks/post/172170673860/learning-more-about-how-commits-are-represented-in)