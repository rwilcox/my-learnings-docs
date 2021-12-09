---
path: /learnings/java
title: 'Learnings: Java'
---
# Table Of Contents

<!-- toc -->

- [Dev Environment Tools >](#dev-environment-tools-)
  * [Make all the folders in a Java module namespace](#make-all-the-folders-in-a-java-module-namespace)
- [Iteration >](#iteration-)
  * [Enhanced for loop](#enhanced-for-loop)
- [Instance Initializers / Initializer Blocks >](#instance-initializers--initializer-blocks-)
    + [Using Initializer Block when instantiating an object](#using-initializer-block-when-instantiating-an-object)
    + [Initializer Blocks with Instance Objects](#initializer-blocks-with-instance-objects)
    + [Static Initializer Blocks](#static-initializer-blocks)
    + [And Anon Inner Classes](#and-anon-inner-classes)
- [(Faking) Initialization Blocks when creating instances of Object](#faking-initialization-blocks-when-creating-instances-of-object)
  * [What is going on?](#what-is-going-on)
- [New in Java 9](#new-in-java-9)
  * [stream](#stream)
- [Oracle 1Z0-808 Course Prep >](#oracle-1z0-808-course-prep-)
- [Casting](#casting)
  * [Static Casting](#static-casting)
  * [Dynamic Casting](#dynamic-casting)
- [Development Environment in Docker : >](#development-environment-in-docker--)
  * [Doing it yourself](#doing-it-yourself)
  * [IntelliJ Instructions on this](#intellij-instructions-on-this)
- [See also:](#see-also)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

# Dev Environment Tools <<Learning_Dev_Env_Tools>>


## Make all the folders in a Java module namespace

    function packagePathToFolderPath() {
        mkdir -p $1/main/java
        cd $1/main/java

        mkdir -p $(echo $2 | sed -e 's/\./\//g')
    }

    $ packagePathToFolderPath $PROJECT_DIR/src com.wilcoxd.myapp.things


# Iteration <<Learning_Java_Iteration>>

## Enhanced for loop

    String[] things = ["One", "Two", "three"]
    for ( String currentThing : things) {

    }

Works over anything that implements `Iterable`

# Instance Initializers / Initializer Blocks <<Learning_Java_Initialization_Blocks>>

Called at the time the instance's variable initializers are evaluated (after superclass construction, before constructor body).


[SO Question/Answer on this](https://stackoverflow.com/q/804589/224334)

### Using Initializer Block when instantiating an object

    HashMap<String, String> h = new HashMap<String, String>(){
    	h.put("key", "value");
    }

### Initializer Blocks with Instance Objects


    class Thing {
    	String myName;
    	{
    		myName = "Yo";
    	}
    }


### Static Initializer Blocks

    class Thing {
    	static String myName;

    	static {
    		myName = "Hello world";
    	}
    }


### And Anon Inner Classes

Have to use this instead of constructors, because don't have constructors (no names!)


# (Faking) Initialization Blocks when creating instances of Object

Example:

    public void main(String[] args) {
    	HashMap<String, String> a = new HashMap<String, String>() {
    		{
    		put("key", "value");
    		}
    	};

    }

## What is going on?

Technically is creating an anon class derived from specified class (outer braces)
AND THEN using an initializer block

See also:

  * http://wiki.c2.com/?DoubleBraceInitialization
  * https://stackoverflow.com/a/31829153/224334 <-- explains what I said above
  * https://stackoverflow.com/a/27521360/224334 <-- why this might be a bad idea (class explosion in your classloader, potential memory leaks)


# New in Java 9

##@Depreciated <-- has problem: when? Or is there just s better way?

New attributes:
  * ForRemoval <---- it' going away
  * since <--- when it's considered old

Warnings can be set to warn on since, etc etc

## stream

  Stream.ofNullable(objOrMaybeNullWhoKnows)  <--- makes a stream of the object, or maybe an empty stream because the object might be null

# Oracle 1Z0-808 Course Prep <<Learning_Java_Associate_Cert_1Z0-808>>


# Casting

## Static Casting

  Integer myThing = ( Integer )( param );

## Dynamic Casting

	Integer myThing = Integer::cast( param );

# Development Environment in Docker : <<Learning_Java_Docker_Development_Debugging_Environment>>

## Doing it yourself

`CMD /usr/share/maven/bin/mvnDebug exec:java` <-- this exposes a port and you can point a debugger to this image host

## IntelliJ Instructions on this

[Debugging Java in a Container via IntelliJ](https://www.jetbrains.com/help/idea/2017.2/debugging-a-java-app-in-a-container.html)


# See also:

  * Learning_Ops_Java_Docker
  * Learning_Ops_SRE_Java

# Book Recommendations

  * [Effective Java](https://www.amazon.com/Effective-Java-Joshua-Bloch-ebook/dp/B078H61SCH/ref=as_li_ss_tl?keywords=learning+java&qid=1555872017&s=books&sr=1-3&linkCode=ll1&tag=wilcodevelsol-20&linkId=f7467f209c4b04accb9e30edc2a9f6aa&language=en_US)
  * [Learning Java](https://www.amazon.com/Learning-Java-Bestselling-Hands-Tutorial-ebook/dp/B00DDZPC9I/ref=as_li_ss_tl?keywords=learning+java&qid=1555872183&s=books&sr=1-4&linkCode=ll1&tag=wilcodevelsol-20&linkId=7d67429d6cdacca154464214588452ae&language=en_US)
