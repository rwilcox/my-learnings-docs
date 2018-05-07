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

# Jenkins server Operations <<Learning_Jenkins_Ops>>

## Configuration <<Learning_Jenkins_Ops_Configuration>>

[Jenkins Docker provides `install-plugins.sh`](https://github.com/jenkinsci/docker/blob/master/install-plugins.sh) and give a text file so have a Jenkins configured via code (not manual clicking).

Other configuration done in Groovy. (including plugin configuration!)

<<Learning_Jenkins_Ops_Scripting_Configuration>>

Groovy init script happens every server boot.

Can be separated out into separate scripts, can be tested using built in Groovy console.

Manage Jenkins -> Scripting Console to try these (changes will be in memory only).

### Job configuration <<Learning_Jenkins_Ops_Job_Configuration_File_Storage_Location>>
Source for much of this: _Extending Jenkins_

lives in `$JENKINS_HOME` each job with it's own folder and `config.xml` with the configurations for that job. (some other misc files too)

### ... and secrets

can use Consul/Vault for service discovery, secret storage

THEN use that in your Groovy init scripts (see Learning_Jenkins_Ops_Scripting_Configuration ) to ie do a curl and ask Vault for things and set it to env variable or write to a file, whatever.

## And Groovy Scripting <<Learning_Jenkins_Scripting>>

Can do a bunch of things via groovy scripting interface (and either putting them as init scripts or using the scripting console).

Like:

  * Creating a bunch of jobs/projects
  * maintenance tasks



#### See also

  * http://nicolas.corrarello.com/general/vault/security/ci/2017/04/23/Reading-Vault-Secrets-in-your-Jenkins-pipeline.html
  * https://wiki.jenkins.io/display/JENKINS/HashiCorp+Vault+Plugin

# Jenkins Creating Plugins <<Learning_Jenkins_Plugin_Creation>>

If have set up Maven settings.xml with Jenkins plugin repo, can do:

    $ mvn -U org.jenkins-ci.tools:maven-hpi-plugins:create

For archetype for Maven plugin.

`mvn package` creates a .hpi file: what you provide to Jenkins.

Bunch of helper stuff `mvn hpi:run` to ie boot a local dev copy of Jenkins so you can try out your plugin.

#### but what about extending existing plugins?

*Extension Points*: documented / auto created by Extension Indexer.

#### Getting started

Note: `@DataBoundConstructor`: annotating class with this means it'll be called when user selects this task/build type.

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

## <<Learning_Jenkins_Tools>>

[Jenkins Build tools](https://www.safaribooksonline.com/library/view/jenkins-the-definitive/9781449311155/ch04s06.html) are nifty ways admins can install tools your projects may require in order to be built.

Some plugins add additional tool types.
Tools can be dynamically 

Manage Jenkins -> Global Tool Configuration.

Tools can be installed on demand, or can point to existing install of software.

Jenkinsfiles can then declare they use those tools using `$TOOLNAME 'VERSION_IN_STRING`. Example: `tool 'node8.11'` (where I had previously installed a Node tool using the Node plugin and named it "node8.11").

ADDITIONAL SYNTAX:

`tool name: 'node8.11', type: 'SOMETHING_GOES_HERE'`

Not completely sure what type is here.
Q: maybe the "type" of the tool in `$JENKINS_HOME/tools` ?? ( ie is this the class in the plugin that `extend hudson.tools.ToolInstaller` ??)

### <<Learning_Jenkins_Tools_And_Agents>>

Each agent can specify their own locations for various Tools. Thus with a single name you can refer to ("wherever this tool may be on our agents")

Q: What tools and tool locations are on all my Nodes?

A: Maybe this Jenkins console shell script will help?
https://wiki.jenkins.io/display/JENKINS/Display+Tools+Location+on+All+Nodes



See also:

  * Learning_Jenkins_Declarative_DSL_Using_Tools

## Job Types <<Learning_Jenkins_Job_Types>>

### Freestyle

Gives build section where you enter a command to run

### Maven

Gives you blanks for a Root POM file and the goals to send to Maven

JENKINS can send artifact to Nexus

### Pipeline

can put build steps in job, or in file Jenkinsfile.

plugins called here need to support Pipelines

<<Learning_Jenkins_Scm_details>>

Configuration page:

  * Pipeline section: has two options: pipeline script; pipeline script from SCM. (LATTER one is what lets Jenkinsfiles be stored with the code repository.... 

Q: These details here is what Jenkins uses to do the auto check out of your project?
A: YES! These are using in `checkout scm` step.

#### And Security <<Learning_Jenkins_Pipelines_Security>>

#### Pipeline Libraries <<Learning_Jenkins_Pipelines_Libraries>>

Less sandbox requirements

### Multi configuration

When you need to run a series of tests ie in multiple OSes (or browsers)

### Folders

Can specify items shared by all jobs in the folder:

  * libraries (untrusted)
  * Pipeline model definitions
  * top level label to search for agents under
  * ACLs for all items in folder

### Multibranch pipeline project

creates new pipeline branches for new branches it sees in a (single) SCM repo

Can set specific properties for certain branch names

### Github Organization

Multibranch pipeline projects for arbitrary repos in a Github organization.

# JenkinsFile

Two modes: Declarative and Scripted pipelines.
(Scripted has more procedural code / DSL; )

## <<Learning_Jenkins_Jenkinsfile_Linter>>

Ways of triggering this:

  * SSHing to Jenkins _application_ itself then running 'declarative-linter'
  * Using Jenkins REST API
  * adding pipeline step that calls `validateDeclarativePipeline` (but umm inception problems????)

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

### See also:

  * Learning_Jenkins_Declarative_DSL_Embedding_Groovy
  * Learning_Jenkins_Declarative_DSL_Using_Tools
  * Learning_Jenkins_Declarative_DSL_Getting_Variables_Out
  * Learning_Jenkins_Declarative_DSL_Useful_API

### Declarative mode code editing tools

Has built in Snippet creator, MPW Commando style. In normal mode left sidebar should be a Pipeline Syntax link - this will let you select the pipeline step you want and will output copy-pasteable text with your parameters.

### <<Learning_Jenkins_And_Libraries_Of_Code>>

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

* stash / unstash <-- save some files and retrive them on the next stage which maybe you've set up to run on some other machine

### <<Learning_Jenkins_Declarative_DSL_Embedding_Groovy>>

#### In `script` stage

    pipeline {
      agent any
      stages {
        stage("Build") {
          steps {
            script {
              def currentDate = new Date() // only available in this script block!
            }
          }
        }
      }
    }

#### Free floating functions

    pipeline {
      agent any
      stages("Build") {
        steps {
          goJanetGo
        }
      }
    }

    def goJanetGo() {
      echo "Janet, bring me a cactus"
    }

( [Supported in post mid 2017 versions of Jenkins???](https://stackoverflow.com/a/47631522/224334), may be some restrictions ).

## <<Learning_Jenkins_Declarative_DSL_Using_Tools>>

Section of the declarative Jenkinsfile: [tools](https://jenkins.io/doc/book/pipeline/syntax/#tools).

    pipeline {
      agent any
      tools {
        maven 'maven-version-here'
      }
    }

This will be AUTO ADDED to any `sh` command's $PATH variable, so you don't _have_ to prefix PATH with it.

### <<Learning_Jenkins_Declarative_DSL_Using_Tools_Setting_Environment_Variables_With_Tool_Locations>>

... but maybe you're paranoid

    pipeline {
      agent any
      tools {
        maven 'maven-version-here'
      }

      environment {
        MY_MAVEN_HOME = tool 'maven-version-here'
      }

      steps {
        sh "$MY_MAVEN_HOME"
      }
    }

See also:

  * Learning_Jenkins_Tools
  * https://jenkins.io/blog/2017/02/07/declarative-maven-project/   <-- scroll down to the "Adding Tools to Pipeline" section


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

### about `sh`

Jenkins auto adds `set -e` to shell scripts.

### `isUnix()`

will return true if is unix, can be used in if statement or expression??)

### `fileExists`

    fileExists "build-overrides/thing"


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

## <<Learning_Jenkins_Running_Groovy_Code_From_SCM>>

Workflow Remote Loader plugin allows you to pull random code from SCM - then run it just like the `load` function

## <<Learning_Jenkins_Shared_Libraries>>

Source structure:

    resources/
    src/
        com/
            foo/
                myUtils.groovy
            myThing.groovy
    vars/
        globalVarsAndFunctionsThisLibraryIntroduces.groovy
        globalVarsAndFunctionsThisLibraryIntroduces.txt <-- adds snippet generator docs

src: added to classpath
resources: use with `libraryResource` step
vars: global vars or scripts accessible from pipeline scripts

**NOTE WHEN USING DECLARATIVE PIPELINE**: src/ directory does not work (May, 2017). So use `vars` area.

Pulled down from SCM repo. Legacy mode: git server served by Jenkins the server.

Can configure these at the global shared librares, or at the folder level.

# Jenkins Plugins I've used

## <<Learning_Jenkins_Plugins_NodeJS>>

[Node.js Jenkins Plugin](https://plugins.jenkins.io/nodejs)

### <<Learning_Jenkins_Plugins_NodeJs_Custom_NPMRC>>

Manage Jenkins (popup version) -> Managed Files -> Add New Config

With Node.js plugin, new file type is: npmrc
includes a template of a .npmrc file.

NOTE the **ID** (not name) of the configuration file (maybe change this to something human).

#### Using this in a pipeline

    pipeline {
      agent any
      steps {
        nodejs(nodeJSInstallationName: 'MY_NODEJS_TOOL_NAME_HERE', configId: 'ID_OF_THE_CONFIG_FILE') {
          sh "npm install"
        }
      }
    }

Node.js plugin will auto copy the managed file into the right place for npm and now settings from there (like `loggingLevel` or `registry` will be set appropriately).

# <<Learning_Jenkins_Building_For>>

## <<Learning_Jenkins_Building_For_Java>>

[Setting `JAVA_HOME`](https://support.cloudbees.com/hc/en-us/articles/204421664-Select-which-Java-JDK-to-use-in-Pipeline)

