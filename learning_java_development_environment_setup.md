---
path: /learnings/java_development_environment_setup
title: 'Learnings: Java Development Environment Setup'
---

Tips tricks for managing Java development environments, especially if we're going to be running two Java versions (1.8 + current) for the rest of the '20s

# Install / Select which version of Java to run now


  * [SDKMan](https://sdkman.io/install)
  * [jenv](https://www.jenv.be/)


`SDKMan` does a _lot_, can install Java versions and other JDK based languages. `jenv` **only** manages `JAVA_HOME` - you must install Java versions yourself, then point `jenv` to those installs.

`SDKMan` works very hard to figure out what package manager you like best, and use that to install what you asked for. (At least in the past it supported both homebrew and macports...)


# MacOS dirty tricks

`/usr/libexec/java_home --version` gives you (the value for `JAVA_HOME`).

You could likely replace most of `jenv` with a simple shell script

`export JAVA_HOME=$(/usr/libexec/java_home --version=1.8)`
