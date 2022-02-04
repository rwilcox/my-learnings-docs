---
path: /learnings/gradle
title: 'Learnings: Gradle'
---
# Table Of Contents

<!-- toc -->

- [About Gradle](#about-gradle)
- [Using Gradle](#using-gradle)
  * [Gradle Wrapper](#gradle-wrapper)
  * [Neat command line flags](#neat-command-line-flags)
- [Files](#files)
- [Dependencies](#dependencies)
  * [Dependency management](#dependency-management)
    + [and transitive dependency management](#and-transitive-dependency-management)
      - [See also](#see-also)
    + [and a version catalog](#and-a-version-catalog)
      - [See also](#see-also-1)
  * [Configurations](#configurations)
- [Tasks](#tasks)
  * [Task Sample](#task-sample)
    + [Notes about using doFirst and doLast](#notes-about-using-dofirst-and-dolast)
- [in Kotlin mode](#in-kotlin-mode)
- [Gradle Interacting with Java](#gradle-interacting-with-java)
  * [operability aspects](#operability-aspects)
  * [Java specific configuration types and transitioning thereof](#java-specific-configuration-types-and-transitioning-thereof)
    + [See also:](#see-also)
- [>](#)
  * [Pull dependancies out of pom.xml and dynamically add them to the gradle build](#pull-dependancies-out-of-pomxml-and-dynamically-add-them-to-the-gradle-build)
- [Making your own Gradle plugins (and or buildSrc)](#making-your-own-gradle-plugins-and-or-buildsrc)
  * [And Kotlin version issues](#and-kotlin-version-issues)
- [Build Scan](#build-scan)
- [Plugins](#plugins)
  * [Writing your own](#writing-your-own)
    + [Task plugin](#task-plugin)
- [Gradle Object mode](#gradle-object-mode)
  * [See also](#see-also-2)
- [Lifecycle](#lifecycle)
  * [Initialization:](#initialization)
    + [init.gradle and other init scripts](#initgradle-and-other-init-scripts)
  * [Configuration](#configuration)
  * [Execution](#execution)
  * [See also](#see-also-3)
- [Build Cache](#build-cache)
- [Multi project builds with Gradle](#multi-project-builds-with-gradle)
- [Misc workflow / developer experience tips for people using your Gradle build scripts](#misc-workflow--developer-experience-tips-for-people-using-your-gradle-build-scripts)

<!-- tocstop -->

# About Gradle

frequent releases: every 6-8 weeks

# Using Gradle

gradle init will create a basic project for you after prompting you to ask some questions.

Listing tasks `gradle tasks` . **BUT** see Gradle_Tasks_And_The_CLI_Task_List

Listing dependency tree: `gradle dependencies` (or `gradle dep`)

## Gradle Wrapper

`gradlew` is the wrapper - recommended you use the wrapper (it makes sure everyone on the same project is using the same version of Gradle). It will automatically download the correct Gradle version if you don't have it.

gradlew(.bat), `gradle` folders are both checked into source control (yes even the .jar) binary file


## Neat command line flags

`--console=plain` <-- assume a stupid TTY (ie like not clearing running task inventories via curses)

-p can use this to override properties specified in gradle.properties files on CLi



`--warning-mode all`  <-- turns on warnings for plugins etc for this task run (but potentially loud)


# Files

  * build.grade(.kts) <-- delegate to org.gradle.api.Project. Is build script
  * settings.gradle(.kts) <-- delegate to org.gradle.api.initializaton.Settings. slightly before the build.gradle script aka some things can _only_ be modified here
  * gradle.properties <— items defined in here can be accessed as properties by settings.gradle or build.gradle files. Can live in root of project or home dir

# Dependencies

May vary based on what language plugin you're using Gradle with

Note: Gradle handles SNAPSHOT versions of libraries a different way than released libraries: they are marked as changed and only cached for a (defined or default) TTL.

Can also depend on other projects ie in a multi project build `implementation project("mysubproject")` in the dependencies block


## Dependency management

Can manage dependencies for JVM languages, _plus_ Swift and C++ builds.

Can also use the project dependencies plugin and have it output an HTML version of gradle deps

### and transitive dependency management

default: highest version number wins

you can use rich version constraints to control that a bit

The dependency blocks are also closures too where you can exclude transitive deps if you need

#### See also

  * Gradle_Transitive_Deps_And_Implementation_Deps

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
  	implementation(libraries.groovy-core)
```

Versions can use a simple string or a Gradle [rich version](https://docs.gradle.org/current/userguide/rich_versions.html#rich-version-constraints)

You can also import a TOML file from an external location ala file!!!!!!!!! (Practically this could let you reuse the catalog of the main build for `buildSrc` but also wonder if this would be useful in a multi repo/one microservice per repo/enterprise or org wide standard catalog somehow???

For the later you could create a custom [version catalog plugin](https://docs.gradle.org/current/javadoc/org/gradle/api/plugins/catalog/CatalogPluginExtension.html) and publish / use that in affected microservices.


#### See also

  * [Gradle documentation on [version catalogs](https://docs.gradle.org/current/userguide/platforms.html)

## Configurations

configurations are also a way to label (and group) dependencies. Configuration types may be provided by plugins.

# Tasks

single automic piece of work for a build, composed of actions.

have groups, and dependencies (semantic relationship: A produces something, B consumes it)

You can skip actions in a task by throwing a `StopExecutionException` which will skip further executions.

You can also skip a Task - for example if you have tasks that normally depend on a list of tasks, you can skip some of those dependent task by doing `taskObject.enabled = false`.

using `-x` on the command line will also disable various tasks.

See [skip several tasks in Gradle quickly](https://medium.com/android-news/skip-several-tasks-in-gradle-quickly-dcd0a11c3487)

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

### Notes about using doFirst and doLast

> When declaring an ad-hoc task — one that doesn’t have an explicit type — you should use Task.doLast{} if you’re only declaring a single action.

[Source](https://docs.gradle.org/current/userguide/authoring_maintainable_build_scripts.html#sec:declaring_tasks)

## Displaying tasks in gradle task

<<Gradle_Tasks_And_The_CLI_Task_List>>

`gradle tasks` by default only shows you tasks assigned to a task group.

**TO SEE ALL TASKS**: `gradle tasks --all` . [Source](https://docs.gradle.org/current/userguide/command_line_interface.html#sec:listing_tasks)

**TO SEE A CUSTOM TASK IN GRADLE TASKS CLI LIST:**

set `group` and you'll likely want to set `description`

```
task hi {dependsOn: ‘someOtherTask’} {
  group 'MY_SUPER_BUILDING_GROUP'
  description 'this is a human description of what this tasks does and will appear in gradle tasks list'
}
```

[Baeldug: gradle custom task](https://www.baeldung.com/gradle-custom-task)

# in Kotlin mode



# Gradle Interacting with Java

<<Gradle_Interact_With_Java>>

Built in Java plugin for this

main and test conventions, jUnit and testNG, javaDocs.

Other JVM languages usually inherit from Java plugin

can set source and resources dir (uses the Maven defaults but [you _can_ customize this](https://docs.gradle.org/current/userguide/java_plugin.html#sec:changing_java_project_layout)).

## operability aspects

[creating fat jars](https://imperceptiblethoughts.com/shadow/). You could also somewhat put this together yourself by setting the manifest in the jar task and copy in the dependencies files from the build folder.

## Java specific configuration types and transitioning thereof

<<Gradle_Configuration_Api_vs_Implementation>>, <<Gradle_Java_Dependency_Types>>

api / implementation <-- different labels for dependancies given by plugins

difference:

  * api - does changing this version mean your CONSUMERS care (ie yes it's part of the API people need to care). ONLY supported when using the Java library plugin
  * implementation - private API detail <—

  <<Gradle_Transitive_Deps_And_Implementation_Deps>>

 NOTE: using an implementation type this means transitive dependencies will NOT be shared if another project in a multi project build tries to include your project (they need to declare their own dependency on it!!!)

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

Plugins are reusable Gradle logic (libraries) that can provide their own tasks

Standard dist includes a bunch of plugins. For these you don't need to specify the version of the plugin, because what Gradle ships with is what it ships with

https://plugins.gradle.org

## Writing your own

### Task plugin

```groovy

class MyTask extends DefaultTask {
  @TaskAction  // <-- the method that's called at Gradle execution time. DefaultTask has only ONE TaskAction method!
  void sayHello() {

  }

}

```

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

Phase where dependencies are resolved

## Execution

  * Execute (subset of) tasks

  In this lifecycle the script object has  (delegate of Project)

anything in a `doFirst` or `doLast` block happens HERE.

## See also

  * [Gradle Documentation on Lifecycle](https://docs.gradle.org/current/userguide/build_lifecycle.html)

# Build Cache

Backs Gradle’s incremental build functionality

TODO: document me

# Multi project builds with Gradle

Sub projects can have dependencies on (sibling projects for example)

Can configure  a project from any other project - cross project configuration

# Misc workflow / developer experience tips for people using your Gradle build scripts

if you set something in gradle.properties and use that in your build script this means you could _override this on the command line_. (Vs having a hard coded value users can't easily change)
