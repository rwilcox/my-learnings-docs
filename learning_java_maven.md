---
path: "/learnings/java_maven"
title: "Learnings: Java: Maven"
---

# And Maven <<Java_And_Maven>> <<Java_Maven>>

## And Dependencies <<Java_And_Maven_And_Dependancies>>

[jdeps: lets you see what classes your dependencies rely on](http://marxsoftware.blogspot.com/2014/03/jdeps.html)

## And Debugging

Can use built into maven `mvnDebug` command line tool to open debugger ports for Java so can attach with normal debugger.s

    $ mvnDebug test # <-- would let you attach a debugger during test runs

# <<Java_Maven_Saving_Releases_To_Nexus>>

## Why you should just use the deploy plugin for this:

so turns out Maven / Nexus REALLY wants you to use Maven to upload Java libraries.

Uploading just the .jar will mean that you can't download the .jar from Maven (like if you built a library).
If you upload the pom file by specifying it as a file - say in Jekin's nexusArtifactUploader - then you'll be able to specify just that version.

See [a pull request for the nexusArtifactUploader](https://github.com/jenkinsci/nexus-artifact-uploader-plugin/pull/13) to make this easier, but you can just specify this manually...

EXCEPT if your application uses to specfiy the library this will not work.

For this to work you need to update the [maven-metadata.xml file](http://maven.apache.org/ref/3.2.5/maven-repository-metadata/repository-metadata.html). [Confirmation on this topic from someone whom I'm guessing is a Sonatype/Nexus person?](https://support.sonatype.com/hc/en-us/articles/213465818/comments/203642978).

There doesn't seem to be any tool outside of Maven (maybe Gradle?) to update this file. Certainly no Jenkins plugin or CLI app that I could fine (Jan 2019).

## See also:

  * https://www.baeldung.com/maven-deploy-nexus
  * https://jfrog.com/blog/dont-let-maven-deploy-plugin-trip-you/
  * https://blog.packagecloud.io/eng/2017/03/09/how-does-a-maven-repository-work/


# Maven and Other Build Tools

  * Gradle_Interact_With_Maven
  * Scala_Interacting_With_Maven