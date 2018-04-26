---
path: "/learnings/jenkins"
title: "Learnings: Jenkins"
---


# Installing Jenkins on RHEL box

First, install Java 8... (see Cloud9InstallingJava8)

  1. Execute commands on: https://pkg.jenkins.io/redhat-stable/
  2. `$ sudo service jenkins start`
  3. In /etc/sysconfig/jenkins set `JENKINS_LISTEN_ADDRESS` to 127.0.0.1 (see: https://community.c9.io/t/cant-preview-in-aws-c9/23340/2)
  4. ???????


# <<Learning_Jenkins_Config_File_Location>>

    /etc/sysconfig/jenkins

See also:

  * https://stackoverflow.com/a/28481692/224334  <-- where this file is on the other distros

`JENKINS_LISTEN_ADDRESS` <-- defaults to 0.0.0.0

# Jenkins Concepts

## Master Node

has access to all data, config, options etc.
Not recommended you run jobs here

## (Build) Agents (Nodes)

Only a lightweight Jenkins agent installed here

### Admin

On master: Manage Jenkins -> Manage Nodes -> New Node form.

## Executor

How many concurrent jobs can be run on that (agent)

# JenkinsFile

Two modes: Declarative and Scripted pipelines.
(Scripted has more procedural code / DSL; )

## Scripted Model

Example:

    node("finder_label") {
      stage('Source') {
        git 'git://example.com/repo.git'
      }

      stage('Build') {
        sh "make build"
      }
    }

## Declarative Model
(Blue Ocean UI's editor and display meant to work with this better)

Example:

    pipeline {
      agent { label: "finder_label" }
      stages {
        stage("Source") {
          steps {
            git 'git://example.com/repo.git'
         }
        }

        stage("Build") {
          steps {
            sh "make build"
          }
        }
      }
    }

If need to break out to actual imperative scripts, two ways:

    pipeline {
      agent {}
      stages {
        stage("Build") {
          steps {
            script {
              def currentDate = new Date() // only availiable in this script block!
            }
          }
        }
      }
    }

<<Learning_Jenkins_And_Libraries_Of_Code>>

Can also break these out into libraries

    @Library("GeneralUtils")
    pipeline {
      agent {}
      stages {
        stage("Build") {
          steps {
            myLibraryFunction()
          }
        }
      }
    }

# DSL

## <<Learning_Jenkins_Useful_DSL_API>>

stash / unstash <-- save some files and retrive them on the next stage which maybe you've set up to run on some other machine

## <<Learning_Jenkins_Declarative_DSL_Getting_Variables_Out>>

(in a script step...)

    env.MY_VALUE = 1+2

## <<Learning_Jenkins_Declarative_DSL_Useful_API>>

### conditionals

<<Learning_Jenkins_Deploy_On_Master_Push>>

    pipeline {
      agent {}
      stages {
        stage("Deploy Build") {
          when {
            expression { params.BRANCH_NAME == "master" }
          }

          steps {
            echo "I only deploy on changes to master!"
          }
        }

        stage("Release") {
          when {
            allOf {
              expression { params.BRANCH_NAME == "master"}
              expression { params.BUILD_TYPE == "release" }
            }
          }
        }
      }
    }

# Libraries and external code

## <<Learning_Jenkins_Running_Groovy_Code_From_Files>>

./build-scripts/test.groovy

    def myFn(what) {
      echo "HI!"
    }

    return this

Jenkinsfile
    pipeline() {
      stages() {
        stage("Build") {
          script {
            def module = load "build-scripts/test.groovy" // cwd is checked out project root
            module.myFn 'hi'
          }

        }
      }
    }

