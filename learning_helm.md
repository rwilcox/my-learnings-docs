---
path: /learnings/helm
title: Learning Helm
---
# Table Of Contents

<!-- toc -->

- [Intro / Why](#intro--why)
  * [components](#components)
    + [helm client / CLI interesting facts](#helm-client--cli-interesting-facts)
  * [misc](#misc)
  * [v2 Vs v3](#v2-vs-v3)
    + [Differences in required supporting infrastructure](#differences-in-required-supporting-infrastructure)
    + [User Facing Differences](#user-facing-differences)
      - [Chart name >](#chart-name-)
- [Helm chart storage (different types of repositories)](#helm-chart-storage-different-types-of-repositories)
  * [notes](#notes)
  * [using repositories from the CLI](#using-repositories-from-the-cli)
  * [public access](#public-access)
  * [A static site](#a-static-site)
  * [nexus](#nexus)
    + [ECR](#ecr)
    + [chart museum](#chart-museum)
    + [Screw it, a folder on your local machine](#screw-it-a-folder-on-your-local-machine)
- [Deployments](#deployments)
  * [Attributes](#attributes)
  * [environmental variables for a deployment](#environmental-variables-for-a-deployment)
  * [Reverting a deploy](#reverting-a-deploy)
  * [Removing a microservice completely from the cluster](#removing-a-microservice-completely-from-the-cluster)
- [Hooks](#hooks)
  * [See also](#see-also)
- [Templates](#templates)
  * [falsiness in template language](#falsiness-in-template-language)
  * [Container Types in template language](#container-types-in-template-language)
    + [Dealing with arrays with dictionaries inside them](#dealing-with-arrays-with-dictionaries-inside-them)
  * [Object Traversal In Template language](#object-traversal-in-template-language)
  * [template includes](#template-includes)
    + [How you create a block you're going to include](#how-you-create-a-block-youre-going-to-include)
    + [How you call it: with the template tag](#how-you-call-it-with-the-template-tag)
    + [How you can call it: with the include tag](#how-you-can-call-it-with-the-include-tag)
  * [Values / The Template Nature](#values--the-template-nature)
  * [See also:](#see-also)
  * [Using Helm as a preprocessor for something else](#using-helm-as-a-preprocessor-for-something-else)
  * [Looking up very dynamic values from k8s](#looking-up-very-dynamic-values-from-k8s)
- [CLI bits](#cli-bits)
  * [Passing complex objects through --set](#passing-complex-objects-through---set)
- [Release](#release)
- [Developing](#developing)
  * [making a new chart](#making-a-new-chart)
    + [interesting files](#interesting-files)
  * [Making sure your template works (local machine development) >](#making-sure-your-template-works-local-machine-development--)
  * [version numbering](#version-numbering)
  * [manually creating a chart artifact](#manually-creating-a-chart-artifact)
  * [deploying a chart](#deploying-a-chart)
  * [Subclassing and chart libraries](#subclassing-and-chart-libraries)
  * [tests](#tests)
    + [built in integration / environment validation unit tests](#built-in-integration--environment-validation-unit-tests)
    + [actual unit tests](#actual-unit-tests)
    + [Chart Testing](#chart-testing)
    + [debugging WTF went wrong with your chart](#debugging-wtf-went-wrong-with-your-chart)
- [Introspecting a repository](#introspecting-a-repository)
  * [searching for an artifact / chart in a repository](#searching-for-an-artifact--chart-in-a-repository)
  * [get previously stored template](#get-previously-stored-template)
    + [Helm v2](#helm-v2)
    + [Helm v3](#helm-v3)
  * [Get K8s resources created by a chart](#get-k8s-resources-created-by-a-chart)
    + [Helm 3](#helm-3)
- [Operating](#operating)
  * [Making and Tracking cluster changes](#making-and-tracking-cluster-changes)
  * [Best Practices](#best-practices)
- [In a microsevice's CI/CD process](#in-a-microsevices-cicd-process)
- [Charts that depend on other charts](#charts-that-depend-on-other-charts)
  * [On Sub Charts](#on-sub-charts)
    + [Global values and charts](#global-values-and-charts)
    + [and Chart.yaml](#and-chartyaml)
  * [Dependent Charts](#dependent-charts)
  * [Starters](#starters)
- [Helmfile](#helmfile)
- [See also](#see-also-1)

<!-- tocstop -->

# Intro / Why

Automate Version handling, rollback, installation

Templatize k8s resources, search and reuse templates

## components

  * helm client (CLI)
  * charts — application configuration definitions
  * repositories — where charts are stored
  * release — chart instances loaded into k8s

### helm client / CLI interesting facts

Can be extended with plugins

## misc


> Helm contains a template function that enables you to look up resources in the Kubernetes cluster. The lookup template function is able to return either an individual object or a list of objects
> 
> - From Learning Helm by N/A on page 0 ()


> Helm charts can be cryptographically signed and verified
> 
> - From Learning Helm by N/A on page 0 ()

## v2 Vs v3

### Differences in required supporting infrastructure

  V2: Helm -> Tiller pod -> k8s cluster

  V3: helm -> k8s cluster via role based access controls

### User Facing Differences

#### Chart name <<Helm_Name_Differences_In_V2_V3>>

In Helm 2: unless you provided a `--name` parameter, Helm created adjective-noun names for releases.

In Helm 3 this now uses the name of the chart, or what you override with `--name-template`_OR_ `--generate-name`


> In Helm 2, "friendly names" were generated using adjectives and animal names. That was removed in Helm 3 due to complaints that release names were unprofessional.
> 
> - From Learning Helm by N/A on page 0 ()


> In Helm 3, naming has been changed. Now instance names are scoped to Kubernetes namespaces. We could install two instances named mysite as long as they each lived in a different namespace.
> 
> - From Learning Helm by N/A on page 0 ()


# Helm chart storage (different types of repositories)

## notes


> Chart repositories do, however, present a few key challenges:
> * They have no concept of namespaces; all charts for a repo are listed in a single index
> * They have no fine-grained access control; you either have access to all charts in the repo or none of them
> * Chart packages with different names but the exact same raw contents are stored twice
> *  repository index can become extremely large, causing Helm to consume a lot of memory
> 
> - From Learning Helm by N/A on page 0 ()


## using repositories from the CLI

Helm provides search and repo add commands for selecting different repos, searching them and getting a specific  helm chart.

## public access

Helm publishes a public one [Helm official stable charts](https://artifacthub.io/).

You could use hemp fetch to get the public ones, inspect and install from your file system.

## A static site

[perhaps hosted via GitHub pages](https://faun.pub/how-to-host-helm-chart-repository-on-github-b76c854e1462)

Just configure your helm CLI to have a registry that points to (the site)

just need a index.yaml file! `helm repo index .` generates this!

You can also use the raw.github URL to the repository, and add that as a remote with Github user and password


> Chart Releaser, or cr, is a command-line tool that leverages GitHub releases for hosting chart packages. It has the ability to detect charts in a Git repo, package them, and upload each of them as artifacts to GitHub releases named after the unique chart version.
> 
> - From Learning Helm by N/A on page 0 ()

## nexus

OCI compatible ?

### ECR

OCI compatible ?


### [chart museum](https://chartmuseum.com)

Installation options:

  * Download a chart museum binary
  * docker image
  * Helm chart

Can point storage to S3, GCP, Azure Blob storage, local file system, etc.


OCI compatible ?

### Screw it, a folder on your local machine

(great for writing charts, then seeing how it applies with an actual service)

set your Chart.yaml 's dependencies `repository` field to `file://../in-development-charts-or-whatever/my-specific-chart-folder-yes-you-need-this/`

# Deployments

Can see these via helm ls.

When a Helm chart is installed becomes a release (this is a Helm standard object type)

## Attributes

  * **Revisions**: number of times you’ve deployed the service to this cluster  (this is NOT the artifact version number AND is reset say with a new cluster)

  * **name**: for more info see Helm_Name_Differences_In_V2_V3


## environmental variables for a deployment

Vs changing these one by one in k8s pods

## Reverting a deploy

`helm rollback $artifactName $revision`

## Removing a microservice completely from the cluster

`helm delete --purge $name`

# Hooks

possibilities:

  * preinstall
  * post-install
  * pre-delete
  * post-delete
  * pre-upgrade
  * post-upgrade
  * pre-rollback
  * post-rollback

just a yaml file with

    metadata:
        annotations:
            "helm.sh/hook": "pre-install"

Hooks can be a part of deployments in addition to having the same lifecycle for Kubernetes Jobs (See Kubernetes_Jobs).

You can _also_ do multiple jobs associated with a hook! Just use weight to make sure to set the `hook-weight` annotation to different values to control which goes first.

## See also

  * K8s_Init_Containers
  *

# Templates

can run values through various operations, like quote and upper.

    {{ quote .Value.some.value.here }}

[List of built in functions](https://helm.sh/docs/chart_template_guide/function_list/)

Can for example even look up attributes from the running k8s cluster!

Uses template functions from [Sprig template library](https://masterminds.github.io/sprig/)

Pipe character to send values into another function

Can use "with" to drill into a nested values object without navigating the object graph every time in a certain scope (Pascal has a similar syntax feature)

Variables are assigned by Pascal / Smalltalk assignment syntax

    {{- $var := "foo" -}}


{{- — do not print the results from this
-}} — do not print out a new line

## falsiness in template language

Falsely:
  * Boolean false
  * numeric zero
  * empty string
  * nil
  * empty collection

## Container Types in template language

### Dealing with arrays with dictionaries inside them

If you have a values.yaml objecting looking like this:
```yaml

myArrayOfDictionaries:
  - nameOrWhateverTheValueIs: foobar
  - nameOrWhateverTheValueIs: second item in the array
```

the following idiom is your friend

```{{- with (first .Values.myArrayOfDictionaries) }}
{{ .NameOrWhateverTheValueIs }}
{{- end }}
```

You could also do `{{- with ( index .Values.myArrayOfDictionaries 3 ) }}` to get the fourth item in the dictiona


## Object Traversal In Template language

In deeply or optionally nested objects you may get a lot of `nil pointer evaluating interface {}.someField` messages. See [Helm issues about traversing deeply nested objects](https://github.com/helm/helm/issues/8026)

The [empty](https://helm.sh/docs/chart_template_guide/function_list/#empty) function, for example, will error if something on the object path is nil. It may also error in _very_ odd places (I would have thought .Values.globals exists by default, but nope(?)).

Two ways to handle this:

`{{ empty (.Values.myDictionary | default dict).myField }}` <-- this will correctly not error and return empty for `myField` if the traversal fails.

`dig "myDictionary" "myField" .Values)` ( [documentation](https://masterminds.github.io/sprig/dicts.html) ). **BUT** `dig` only works on Dictionary objects, it will not work on arbitrary objects that use the dot accessor for field access (aka: arbitrary objects)

## template includes

 _filename.tpl — traditionally starts with underscore

 ** but** using built in objects in these templates might not work like you expect! Need to pass root context at the template call site

### How you create a block you're going to include

    {{- define "template_name" }}
    foobar: baz
    {{- end }
    }

### How you call it: with the template tag

     {{- template "template_name" .}}

(. can also be $)

`template` is relatively literal include mechanism - you must make sure you do the whitespace alignment properly across the two files

### How you can call it: with the include tag

    {{ include "template_name" . | indent 4 }}


## Values / The Template Nature

can specify in three locations (precedence):
  * parent chart
  * values.YAML
  *—set parameters

[source](https://v3-1-0.helm.sh/docs/chart_template_guide/values_files/)


> In other words, --set values override settings from passed-in values files, which in turn override anything in the chart’s default values.yaml file.
> 
> - From Learning Helm by N/A on page 0 ()


## See also:

  * Helm_Development_Checking_Your_Created_Chart
  *

## Using Helm as a preprocessor for something else


> Sometimes you want to intercept the YAML, modify it with your own tool, and then load it into Kubernetes. Helm provides a way to execute this external tool without having to resort to using helm template. The flag --post-renderer on the install, upgrade, rollback, and template will cause Helm to send the YAML data to the command, and then read the results back into Helm. This is a great way to work with tools like Kustomize.
> 
> - From Learning Helm by N/A on page 0 ()

## Looking up very dynamic values from k8s


> Helm contains a template function that enables you to look up resources in the Kubernetes cluster. The lookup template function is able to return either an individual object or a list of objects
> 
> - From Learning Helm by N/A on page 0 ()

# CLI bits


## Passing complex objects through --set


an array where each element is a dictionary

`-set 'mything.globals.myArrayOfDictionaries[0].myField=myValues' --set 'mything.globals.myArrayOfDictionaries[1].myField=myValueForArrayItemTwo' `

[source of some of this documentation](https://newbedev.com/helm-passing-array-values-through-set)

Alternative: maybe just [put the extra values in a seperate file and include them?](https://github.com/helm/helm/issues/4807#issuecomment-431447235)

# Release

This is a built in object you can refer to in the Jinja templates!

# Developing

## making a new chart

`helm create $name`

creates the skeleton of what you need

### interesting files

  * values.schema.json <-- OPTION schema for values in values.yaml file!!!
  * crds <-- custom k8s resources
  * templates <-- templates + values = k8s resources
  *


> Helm provides the optional ability for each chart to provide its own schema for its values using JSON Schema. JSON Schema provides a vocabulary to describe JSON files. YAML is a superset of JSON, and you can transform content between the two file formats. This makes it possible to use a JSON Schema to validate the content of a YAML file.
> 
> - From Learning Helm by N/A on page 0 ()

[See excellent blog post on this](https://austindewey.com/2020/06/13/helm-tricks-input-validation-with-values-schema-json/)


> When you run the commands helm install, helm upgrade, helm lint, and helm template, Helm will validate the values against what it finds in the values.schema.json file.
> 
> - From Learning Helm by N/A on page 0 ()

## Making sure your template works (local machine development)  <<Helm_Development_Checking_Your_Created_Chart>>

  * `helm lint`
  * `helm template` <-- renders the Helm chart as a k8s resource. You could use this to ensure you're telling k8s to do what you think you're telling it
  * `helm install --dry-run` <-- same as `helm template` (?)
  *


## version numbering

charts.yaml:
  * `version` attribute, which is the chart version. Per convention should be incremented every time you change something, including the app version

  * `appVersion` attribute: version number of the application being deployed

## manually creating a chart artifact

`helm package chartName` <-- makes a .tar file for this with the correct version number appending.

You could theoretically use `curl` to upload this to the chart repository (but you likely don't want to directly do that...)

## deploying a chart

the Helm Push plugin is a good solution here. can run this after a helm package, or have the push plugin do it for you...

## Subclassing and chart libraries


> You may run into the situation where you are creating multiple similar charts—charts that share a lot of the same templates. For these situations, there are library charts.
> 
> - From Learning Helm by N/A on page 0 ()


> It provides a blueprint that is meant to be overridden by the caller in a chart that includes this library. mylib.configmap is a special template. This is the template another chart will use. It takes mylib.configmap.tpl along with another template, yet to be defined, containing overrides, and merges them into one output. mylib.configmap uses a utility function that handles the merging and is handy to reuse.
> 
> - From Learning Helm by N/A on page 0 ()


> When a child chart has declared an export property, its contents can be imported directly into a parent chart.
> 
> - From Learning Helm by N/A on page 0 ()

## tests

### built in integration / environment validation unit tests

(Sometimes also called "helm hook test")

Stored in `templates/test`.


> Tests typically live in the tests subdirectory of the templates directory. Putting the tests in this directory provides a useful separation. This is a convention and not required for tests to run.
> 
> - From Learning Helm by N/A on page 0 ()

It's just another k8s pod. Will not get deployed as a service, but the exit code of the command is checked for non-zero exit.

For example, a test can check that the webservice server your pod _should_ have launched _did_ launch.

Can be ran during deployment process lifecycle.

Interesting notes: because it's a separate pod definition, you don't have to use the docker container your normal application uses. You could use busybox and call `wget`, you could write a custom binary and put it in the container, whatever. [Example](https://stackoverflow.com/a/63512937/224334)


> In Helm version 2 there was a hook named test-success for running tests. Helm version 3 provides backward compatibility and will run this hook name as a test.
> 
> - From Learning Helm by N/A on page 0 ()


### actual unit tests

See Helm plugin [helm-unittest](https://github.com/quintush/helm-unittest) where you can test your post processed YAML (ie making sure one of your if conditions resulted correctly, or whatever)

### Chart Testing


> Chart Testing can be installed and used in various ways. For example, you can use it as a binary application on a development system or in a container within a continuous integration system. Learn more about using and setting it up for your situation on the project page.
> 
> - From Learning Helm by N/A on page 0 ()

See also:

  * [Builtin quality for Helm charts: unit testing to the rescue](https://pinboard.in/u:rwilcox/b:1a1911796101)


### debugging WTF went wrong with your chart


> Helm provides tools designed to ease debugging. Between helm get manifest and kubectl get, you have tools for comparing what Kubernetes thinks is the current object with what the chart produced. This is particularly helpful when a resource that should be managed by Helm was manually edited outside of Helm (e.g., using kubectl edit).
> 
> - From Learning Helm by N/A on page 0 ()


> While --dry-run is designed for debugging, helm template is designed to isolate the template rendering process of Helm from the installation or upgrade logic.
> 
> - From Learning Helm by N/A on page 0 ()


> The template command performs the first four phases (load the chart, determine the values, render the templates, format to YAML). But it does this with a few additional caveats:
> * During helm template, Helm never contacts a remote Kubernetes server.
> * The template command always acts like an installation.
> * Template functions and directives that would normally require contacting a Kubernetes server will instead only return default data.
> * The chart only has access to default Kubernetes kinds.
> 
> - From Learning Helm by N/A on page 0 ()

# Introspecting a repository

## searching for an artifact / chart in a repository

    helm search $repo/$artifactName

As Helm keeps a local cache of repositories, you may need to manually `helm repo update` before these queries return expected results...

By default `helm search` only returns latest version of an artifact in the repository. Use `helm search -l` to list all artifact coordinates.


## get previously stored template

### Helm v2

    helm fetch $repo/$artifactName --version=$arifactVersion --untar


### Helm v3

        helm pull $repo/$name --version=$artifactVersion --untar


## Get K8s resources created by a chart

### Helm 3

        helm get manifest $repo/$releaseName


# Operating

## Making and Tracking cluster changes


> Each release record contains enough information to re-create the Kubernetes objects for that revision (an important thing for helm rollback).
> 
> - From Learning Helm by N/A on page 0 ()


> helm uninstall command has a flag called --keep-history. Normally, a deletion event will destroy all release records associated with that installation. But when --keep-history is specified, you can see the history of an installation even after it has been deleted:
> 
> - From Learning Helm by N/A on page 0 ()


## Best Practices


> the recommendation is to put in resource limits and then turn them into comments.
> - From Learning Helm by N/A on page 0 ()

My thoughts: Wait couldn’t you set them to (Dev machine minimum) and ??? have helm —set them on big boy targets (knowing that, practically speaking, QA resource allocations will != prod)

# In a microsevice's CI/CD process


> there is an upgrade shortcut available that will just reuse the last set of values that you sent:
> `$ helm upgrade mysite bitnami/drupal --reuse-values`
> 
> - From Learning Helm by N/A on page 0 ()


> The --reuse-values flag will tell Helm to reload the server-side copy of the last set of values, and then use those to generate the upgrade
> 
> - From Learning Helm by N/A on page 0 ()


> One recommendation for using --wait in CI is to use a long --timeout (five or ten minutes) to ensure that Kubernetes has time to resolve any transient failures.
> 
> - From Learning Helm by N/A on page 0 ()


>  --atomic flag instead of the --wait flag. This flag causes the same behavior as --wait unless the release fails. Then, instead of marking the release as failed and exiting, it performs an automatic rollback to the last successful release. In automated systems, the --atomic flag is more resistent to outages, since it is less likely to have a failure as its end result. 
> 
> - From Learning Helm by N/A on page 0 ()


>  --wait will track such objects, waiting until the pods they create are marked as Running by Kubernetes.
> 
> - From Learning Helm by N/A on page 0 ()


> But with --wait, the success criteria for an installation is modified. A chart is not considered successfully installed unless (1) the Kubernetes API server accepts the manifest and (2) all of the pods created by the chart reach the Running state before Helm’s timeout expires.
> 
> - From Learning Helm by N/A on page 0 ()


> The helm upgrade --install command will install a release if it does not exist already, or will upgrade a release if a release by that name is found. Underneath the hood, it works by querying Kubernetes for a release with the given name. If that release does not exist, it switches out of the upgrade logic and into the install logic.
> 
> - From Learning Helm by N/A on page 0 ()


# Charts that depend on other charts

## On Sub Charts

You can put dependencies in the `charts/` folder. Like `charts/my-sub-dependency-chart`

From within the parents values.yml you can interject values into the subchart.

Like so

```yaml

my-sub-dependency-chart:
  keyToOverride: value
```

(values are passed to the subchart as the bare key, no namespace)

### Global values and charts

use the `global` key in the parents values.yml and the name will be the same everywhere, in the subcharts and the parent chart.

### and Chart.yaml

[can not read parent .Chart value from subchart](https://github.com/helm/helm/issues/3307)

> A subchart is considered "stand-alone", which means a subchart can never explicitly depend on its parent chart.
> For that reason, a subchart cannot access the values of its parent.

[source](https://helm.sh/docs/chart_template_guide/subcharts_and_globals/)

when I tried this in a template file I was only able to access fields on `.Chart` where they were in the (current) chart, ie not exported from the parent chart.


## Dependent Charts

charts.yml file:

`dependencies` key: give name, version and repository

`helm dependency update` <-- updates dependencies


> When you want to control if a single feature is enabled or disabled through a dependency, you can use the condition property on a dependency
> 
> - From Learning Helm by N/A on page 0 ()


> When a child chart has declared an export property, its contents can be imported directly into a parent chart.
> 
> - From Learning Helm by N/A on page 0 ()


> Dependencies are specified in the Chart.yaml file. The following is the dependencies section in the Chart.yaml file for a chart named rocket:
> 
> - From Learning Helm by N/A on page 0 ()


> When a chart has dependencies listed under the dependencies field in Chart.yaml, a special file named Chart.lock is generated and updated each time you run the command helm dependency update. When a chart contains a Chart.lock file, operators can run helm dependency build to generate the charts/ directory without the need to renegotiate dependencies.
> 
> - From Learning Helm by N/A on page 0 ()

## Starters


> Starters, or starter packs, are similar to Helm charts, except that they are meant to be used as templates for new charts.
> 
> - From Learning Helm by N/A on page 0 ()



> Any Helm chart can be converted into a starter. The only thing that separates a starter from a standard chart is the presence of dynamic references to the chart name in a starter’s templates.
> 
> - From Learning Helm by N/A on page 0 ()


> To specify a custom starter, you can use the --starter option when creating a new chart:
> 
> - From Learning Helm by N/A on page 0 ()


# Helmfile

   Can deploy multiple charts in a herd.

   See [declaratively running helm charts using helmfile]([https://medium.com/swlh/how-to-declaratively-run-helm-charts-using-helmfile-ac78572e6088)

   Can select various sections you want to act on with selectors

   Can also use template helmfile subcommand to see rendered k8s charts


# See also

  * [waytoeasylearn tutorial on Helm](https://www.waytoeasylearn.com/learn/helm-introduction/)
  * [learning Helm O'Reilly book](https://www.amazon.com/Learning-Helm-Managing-Apps-Kubernetes/dp/1492083658)
  * [Awesome List For Helm](https://github.com/cdwv/awesome-helm)
  * [My pinboard t:helm](https://pinboard.in/u:rwilcox/t:helm)
