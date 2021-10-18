---
path: /learnings/gradle
title: 'Learnings: Gradle'
---
# Table Of Contents

<!-- toc -->

- [Using Gradle](#using-gradle)
- [>](#)
  * [Pull dependancies out of pom.xml and dynamically add them to the gradle build](#pull-dependancies-out-of-pomxml-and-dynamically-add-them-to-the-gradle-build)

<!-- tocstop -->

# Using Gradle



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

