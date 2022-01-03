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

<!-- tocstop -->

# Using Gradle

Listing tasks `gradle tasks`


# Dependencies

May vary based on what language plugin you're using Gradle with


## Java project declaration typesDeclaring dependencies in Java projects with the Java Plugin

[Documentation](https://docs.gradle.org/current/userguide/java_plugin.html#tab:configurations)

Most important / useful configurations:

| configuration name  | notes                             |
|:--------------------|:----------------------------------|
| `implementation`    | duh                               |
| `compileOnly`       | duh, but compile phase _only_     |
| `testImplementation`| only for tests                    |
| `testCompileOnly`   | compileOnly but only for tests    |
|


# Configurations

A configuration represents a group of artifacts and their dependencies.

Both consuming and producing.

# Tasks

single automic piece of work for a build

# in Kotlin mode



## See also

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
