---
path: /learnings/gradle
title: 'Learnings: Gradle'
---
# Table Of Contents

<!-- toc -->

- [Using Gradle](#using-gradle)
- [Dependencies](#dependencies)
  * [Java project declaration typesDeclaring dependencies in Java projects with the Java Plugin](#java-project-declaration-typesdeclaring-dependencies-in-java-projects-with-the-java-plugin)
- [Configurations](#configurations)
- [Tasks](#tasks)
- [in Kotlin mode](#in-kotlin-mode)
  * [See also](#see-also)
- [>](#)
  * [Pull dependancies out of pom.xml and dynamically add them to the gradle build](#pull-dependancies-out-of-pomxml-and-dynamically-add-them-to-the-gradle-build)
- [Making your own Gradle plugins (and or buildSrc)](#making-your-own-gradle-plugins-and-or-buildsrc)
  * [And Kotlin version issues](#and-kotlin-version-issues)

<!-- tocstop -->

# About Gradle

frequent releases: every 6-8 weeks

# Using Gradle

`gradlew` is the wrapper - recommended you use the wrapper (it makes sure everyone on the same project is using the same version of Gradle). It will automatically download the correct Gradle version if you don't have it.

gradlew(.bat), `gradle` folders are both checked into source control (yes even the .jar) binary file

Listing tasks `gradle tasks`

 Listing dependency tree: `gradle dependencies` (or `gradle dep`)

## Neat command line flags

`--console=plane` <-- assume a stupid TTY (ie like not clearing running task inventories via curses)

-p can use this to override properties on CLi

# Files

  * build.grade(.kts) <-- delegate to org.gradle.api.Project. Is build script
  * settings.gradle(.kts) <-- delegate to org.gradle.api.initializaton.Settings. slightly before the build.gradle script aka some things can _only_ be modified here
  * gradle.properties <— items defined in here can be accessed as properties by settings.gradle or build.gradle files. Can live in root of project or home dir

# Dependencies

May vary based on what language plugin you're using Gradle with

## Dependency management

Can manage dependencies for JVM languages, _plus_ Swift and C++ builds.

### and transitive dependency management


### and a version catalog

Instead of declaring a dependency using a string notation, can use a variable name.

Really good when you have multiple projects in a build but they all - say - have common versions of common libraries.

Can declare in code, in dependencyResolutionMangament.versionCatalogs OR in libs.versions.toml file.

Example of syntax:

```toml
[versions]
groovy = "3.0.5"

[libraries]
groovy-core = { module = "org.codehaus.groovy:groovy", version.ref = "groovy" }

```

Use this like:

```
Versions can use a simple string or a Gradle [rich version](https://docs.gradle.org/current/userguide/rich_versions.html#rich-version-constraints)

You can also import a TOML file from an external location ala file!!!!!!!!! (Practically this could let you reuse the catalog of the main build for `buildSrc` but also wonder if this would be useful in a multi repo/one microservice per repo/enterprise or org wide standard catalog somehow???

For the later you could create a custom [version catalog plugin](https://docs.gradle.org/current/javadoc/org/gradle/api/plugins/catalog/CatalogPluginExtension.html) and publish / use that in affected microservices.


#### See also

  * [Gradle documentation on [version catalogs](https://docs.gradle.org/current/userguide/platforms.html)

## Configurations

configurations are also a way to label (and group) dependencies. Configuration types may be provided by plugins.

# Tasks

single automic piece of work for a build

have groups, and dependencies (semantic relationship: A produces something, B consumes it)

## Task Sample

    task hi {dependsOn: ‘someOtherTask’} {
      // can config ie task desc and group here
      // dependsOn can be an array or a closure too (which must return a string or an array of tasks. Ie you have a filter task or dynamically created tasks…)…

      doLast {
        // stuff for execution can go here. Can have many doLasts or doFirsts
      }.doLast {
        // can chain these things too!!
      }
    }

These get put into the project object so you can access it there


# in Kotlin mode



# Gradle Interacting with Java

<<Gradle_Interact_With_Java>>

Built in Java plugin for this

main and test conventions, jUnit and testNG, javaDocs.

Other JVM languages usually inherit from Java plugin

## operability aspects

[creating fat jars](https://imperceptiblethoughts.com/shadow/)

## Java specific configuration types and transitioning thereof

<<Gradle_Configuration_Api_vs_Implementation>>, <<Gradle_Java_Dependency_Types>>

api / implementation <-- different labels for dependancies given by plugins

difference:

  * api - does changing this version mean your CONSUMERS care (ie yes it's part of the API people need to care)
  * implementation - private API detail

Unless you're writing a library for public consumption, probably everything will be an `implementation`.

Most important / useful configurations:

| configuration name  | notes                                                          |
|:--------------------|:---------------------------------------------------------------|
| `implementation`    | you probably want this                                         |
| `compileOnly`       | duh, but compile phase _only_. Deprecated a bit see below.     |
| `testImplementation`| only for tests                                                 |
| `testCompileOnly`   | compileOnly but only for tests                                 |
|

**in transition currently:** java library plugin replaced some of these

compile: split into implementation and api. See Gradle_Configuration_Api_vs_Implementation

testCompile became testImplementation


### See also:

  * [Gradle explains api vs implementation](https://docs.gradle.org/current/userguide/java_library_plugin.html#sec:java_library_configurations_graph)
  * [Documentation](https://docs.gradle.org/current/userguide/java_plugin.html#tab:configurations)
  * [compile vs compileOnly vs compileInclude](https://liferay.dev/blogs/-/blogs/gradle-compile-vs-compileonly-vs-compileinclude)

# <<Gradle_Interact_With_Maven>>

Sometimes you may like Gradle as a development tool but have enterprise standarization on Maven.

You can, however, get the best of both worlds through these hacks

## Pull dependancies out of pom.xml and dynamically add them to the gradle build

[Source](https://gist.github.com/jashatton/3237323/forks)

    dependencies {
        def pomXml = new XmlSlurper().parse('pom.xml')

        def pomDependencies = pomXml.dependencies.dependency
        pomDependencies.each { dependency ->

            def dependencySpec = "${dependency.groupId}:${dependency.artifactId}:${dependency.version}"
            println "dynamically adding ${dependencySpec} from pom.xml"

            if (dependency.scope == 'test') {
                dependencies.add 'testCompile', dependencySpec
            } else {
                dependencies.add 'compile', dependencySpec
            }
        }
    }

# Making your own Gradle plugins (and or buildSrc)

## And Kotlin version issues

<<Kotlin_Gradle_BuildSrc>>

If you are [using buildSrc to abstract imperative logic](https://docs.gradle.org/current/userguide/organizing_gradle_projects.html)

In [Gradle 7.3.3 Gradle plugins target Kotlin 1.4 for compatibility reasons](https://docs.gradle.org/7.3.3/userguide/compatibility.html).

Except that version - since Kotlin 1.6 is out as of the time of this writing - is deprecated with a compiler warning (Which isn't good if you run -Wall)

For now the best thing to do is to turn off -Wall in your buildSrc build.gradle.kt file, which hopefully shouldn't affect the rest of your project.

Github issues in Gradle repo about this:
  * ["Please remove fixed Kotlin runtime version limitation in Gradle"](https://github.com/gradle/gradle/issues/16345).
  * ["Upgrade embedded Kotlin to 1.6.10"](https://github.com/gradle/gradle/issues/19308)

# Build Scan

build + `--scan`

will be prompted, you can add something to your settings.gradle to automate accepting

# Plugins

Standard dist includes a bunch of plugins. For these you don't need to specify the version of the plugin, because what Gradle ships with is what it ships with

https://plugins.gradle.org


# Gradle Object mode

  * Script
  * Project
  * Gradle
  * Settings
  * Task
  * Action

Project object provides an [.ext property](https://docs.gradle.org/current/dsl/org.gradle.api.plugins.ExtraPropertiesExtension.html) you can add arbitrary stuff to
project

## See also

  * [Gradle Docs on these core types](https://docs.gradle.org/current/dsl/#N100CA)


# Lifecycle

These map to a (built in) Gradle build script

## Initialization:

  * configure environment (init.gradle, gradle.properties)
  * find projects and build scripts (settings.gradle too)

### init.gradle and other init scripts

Can contain enterprise wide servings ie where to download the enterprise’s plugins

$GRADLE_HOME/init.d/

Init.gradle In this lifecycle the script object has  (delegate of Gradle)
Settings.gradle In this lifecycle the script object has  (delegate of settings)

## Configuration

  * evaluate all build scripts (build.gradle)
  * this is where the task execution DAG is created
  * build object model

Settings.gradle In this lifecycle the script object has  (delegate of Project)

## Execution

  * Execute (subset of) tasks

  In this lifecycle the script object has  (delegate of Project)

## See also

  * [Gradle Documentation on Lifecycle](https://docs.gradle.org/current/userguide/build_lifecycle.html)
