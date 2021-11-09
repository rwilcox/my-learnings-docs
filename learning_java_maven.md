---
path: /learnings/java_maven
title: 'Learnings: Java: Maven'
---
# Table Of Contents

<!-- toc -->

- [And Maven > >](#and-maven--)
  * [And Dependencies >](#and-dependencies-)
  * [And Debugging](#and-debugging)
- [>](#)
  * [incrementing the major/minor/patch versions](#incrementing-the-majorminorpatch-versions)
  * ["I know exactly what I'm going to set this to"](#i-know-exactly-what-im-going-to-set-this-to)
- [>](#)
  * [Why you should just use the deploy plugin for this:](#why-you-should-just-use-the-deploy-plugin-for-this)
  * [Different ways / scenarios to use the deploy plugin](#different-ways--scenarios-to-use-the-deploy-plugin)
    + [Regular releases](#regular-releases)
      - [Basic basic CLI](#basic-basic-cli)
      - [with maven's built in release SDLC plugins](#with-mavens-built-in-release-sdlc-plugins)
      - [Being more clever with Maven variables](#being-more-clever-with-maven-variables)
    + [Snapshot releases](#snapshot-releases)
      - [basic basic CLI](#basic-basic-cli)
  * [See also:](#see-also)
- [Tooling around Maven for large / weird projects](#tooling-around-maven-for-large--weird-projects)
- [Maven and Other Build Tools](#maven-and-other-build-tools)

<!-- tocstop -->

# And Maven <<Java_And_Maven>> <<Java_Maven>>

## And Dependencies <<Java_And_Maven_And_Dependancies>>

[jdeps: lets you see what classes your dependencies rely on](http://marxsoftware.blogspot.com/2014/03/jdeps.html)

## And Debugging

Can use built into maven `mvnDebug` command line tool to open debugger ports for Java so can attach with normal debugger.s

    $ mvnDebug test # <-- would let you attach a debugger during test runs

# <<Java_Maven_Managing_Version_Numbers_Manually>>

## incrementing the major/minor/patch versions

This may or may not be a good idea, you might want to do `mvn release:prepare` but if you don't like working at that level of abstraction...

`mvn build-helper:parse-version versions:set -DnewVersion='${parsedVersion.majorVersion}.${parsedVersion.minorVersion}.${parsedVersion.nextIncrementalVersion}' versions:commit`

That `nextIncrementalVersion` is the thing that can be moved anywhere in the major.minor.patch levels to increment that version.

`versions:set` and `versions:commit` are two different parts of the [maven versions plugin](https://www.mojohaus.org/versions-maven-plugin/usage.html). commit means this change is for real and delete the previously created backup/just in case file.

This will **NOT** commit the resulting pom.xml file.

## "I know exactly what I'm going to set this to"

`mvn versions:set -DnewVersion=1.0.1-SNAPSHOT versions:commit`


# <<Java_Maven_Saving_Releases_To_Nexus>>

## Why you should just use the deploy plugin for this:

so turns out Maven / Nexus REALLY wants you to use Maven to upload Java libraries.

Uploading just the .jar will mean that you can't download the .jar from Maven (like if you built a library).
If you upload the pom file by specifying it as a file - say in Jekin's nexusArtifactUploader - then you'll be able to specify just that version.

See [a pull request for the nexusArtifactUploader](https://github.com/jenkinsci/nexus-artifact-uploader-plugin/pull/13) to make this easier, but you can just specify this manually...

EXCEPT if your application uses to specfiy the library this will not work.

For this to work you need to update the [maven-metadata.xml file](http://maven.apache.org/ref/3.2.5/maven-repository-metadata/repository-metadata.html). [Confirmation on this topic from someone whom I'm guessing is a Sonatype/Nexus person?](https://support.sonatype.com/hc/en-us/articles/213465818/comments/203642978).

There doesn't seem to be any tool outside of Maven (maybe Gradle?) to update this file. Certainly no Jenkins plugin or CLI app that I could fine (Jan 2019).

## Different ways / scenarios to use the deploy plugin

### Regular releases

aka non snapshot / you are incrementing major/minor/patch level versions.

#### Basic basic CLI

    mvn deploy -Dmaven.test.skip=true -DaltDeploymentRepository=mavenRelease::default::YOUR_PERSONAL_NEXU_HERE

note you will have to run `mvn versions:set` yourself, BUT this might be a good thing if you don't like what `mvn release:prepare` (below) does for you.

#### with maven's built in release SDLC plugins

Maven has a couple plugins that try to do it all for you.

`mvn release:prepare` which will do some checks; increment your pom.xml version; tag and push this work.

`release:perform` will deploy this to your Nexus.

This workflow is best [described on baeldung](https://www.baeldung.com/maven-release-nexus).

Automating the more complicated part (where Maven's release plugins try to get interactive with you):

    Release:Clean release:prepare release:perform -DreleaseVersion=YOUR_RELEASE_VERSION -DdevelopmentVersion=YOUR_DEVELOPMENT_VERSION

#### Being more clever with Maven variables

You could use a `revision` property to hold the current version of the thing, like so

    <project>
        ...
        <version>${revision}</version>
        <properties>
            <revision>1.0.0-SNAPSHOT</revision>
        </properties>
    </project>

then override it on the command line like `mvn -Drevision=2.0.0-SNAPSHOT clean package`

clever tip from [Maven - Maven friendly CI](https://maven.apache.org/maven-ci-friendly.html). **NOTE**: `revision`, `sha1`, `changelist` are SPECIAL, this is not a general feature! (requires Maven 3.5 release date Q1 2017)

BUT this seems to require an addition step, the flatten-maven-plugin. (See this [SO answer](https://stackoverflow.com/a/60615450))

Because, in summary:

> There will be problems with using your library as a dependency and publishing to shared artifact repository (e.g. Maven Central) because your pom.xml doesn't match the artifact version.

(So you have to use the flatten plugin as a post processing step)

BUT these methods would likely well support a workflow where you **eschew semantic versioning** (ie leaning into git commit or date based versioning).

### Snapshot releases

#### basic basic CLI

    mvn version:set -DnewVersion=MY_ARTIFACT_VERSION_I_GOT_FROM_POM.XML_SOMEHOW-SNAPSHOT-SOME_UNIQUE_NUMBER
    mvn deploy
    mvn versions:revert


## See also:

  * https://www.baeldung.com/maven-deploy-nexus
  * https://jfrog.com/blog/dont-let-maven-deploy-plugin-trip-you/
  * https://blog.packagecloud.io/eng/2017/03/09/how-does-a-maven-repository-work/


# Tooling around Maven for large / weird projects

Redhat's [PME - pom manipulation extension](https://release-engineering.github.io/pom-manipulation-ext/) has helpful rewriting tools for project versions, multi-module projects, or including a Groovy based preprocessor for pom.xml files.

# Maven and Other Build Tools

  * Gradle_Interact_With_Maven
  * Scala_Interacting_With_Maven

