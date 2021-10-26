#lang scribble/text
@(require "scribble-utils.rkt")

---
path: /learnings/helm
title: Learning Helm
---
# Table Of Contents

<!-- toc -->

- [Intro / Why](#intro--why)
  * [components](#components)
    + [helm client / CLI interesting facts](#helm-client--cli-interesting-facts)
  * [v2 Vs v3](#v2-vs-v3)
    + [Differences in required supporting infrastructure](#differences-in-required-supporting-infrastructure)
    + [User Facing Differences](#user-facing-differences)
      - [Chart name >](#chart-name-)
- [Helm chart storage (different types of repositories)](#helm-chart-storage-different-types-of-repositories)
  * [using repositories from the CLI](#using-repositories-from-the-cli)
  * [public access](#public-access)
  * [A static site](#a-static-site)
  * [nexus](#nexus)
    + [ECR](#ecr)
    + [chart museum](#chart-museum)
- [Deployments](#deployments)
  * [Attributes](#attributes)
  * [environmental variables for a deployment](#environmental-variables-for-a-deployment)
  * [Reverting a deploy](#reverting-a-deploy)
  * [Removing a microservice completely from the cluster](#removing-a-microservice-completely-from-the-cluster)
- [Hooks](#hooks)
  * [See also](#see-also)
- [Templates](#templates)
  * [falsiness in template language](#falsiness-in-template-language)
  * [template includes](#template-includes)
    + [How you create a block you're going to include](#how-you-create-a-block-youre-going-to-include)
    + [How you call it: with the template tag](#how-you-call-it-with-the-template-tag)
    + [How you can call it: with the include tag](#how-you-can-call-it-with-the-include-tag)
  * [Values / The Template Nature](#values--the-template-nature)
  * [See also:](#see-also)
- [Release](#release)
- [Developing](#developing)
  * [making a new chart](#making-a-new-chart)
    + [interesting files](#interesting-files)
  * [Making sure your template works (local machine development) >](#making-sure-your-template-works-local-machine-development--)
  * [version numbering](#version-numbering)
  * [manually creating a chart artifact](#manually-creating-a-chart-artifact)
  * [deploying a chart](#deploying-a-chart)
  * [tests??!!](#tests)
- [Introspecting a repository](#introspecting-a-repository)
  * [searching for an artifact / chart in a repository](#searching-for-an-artifact--chart-in-a-repository)
  * [get previously stored template](#get-previously-stored-template)
    + [Helm v2](#helm-v2)
    + [Helm v3](#helm-v3)
  * [Get K8s resources created by a chart](#get-k8s-resources-created-by-a-chart)
    + [Helm 3](#helm-3)
- [Operating](#operating)
- [Charts that depend on other charts](#charts-that-depend-on-other-charts)
  * [On Sub Charts](#on-sub-charts)
    + [Global values and charts](#global-values-and-charts)
  * [Dependent Charts](#dependent-charts)
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

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Helm contains a template function that enables you to look up resources in the Kubernetes cluster. The lookup template function is able to return either an individual object or a list of objects}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Helm charts can be cryptographically signed and verified}

## v2 Vs v3

### Differences in required supporting infrastructure

  V2: Helm -> Tiller pod -> k8s cluster

  V3: helm -> k8s cluster via role based access controls

### User Facing Differences

#### Chart name <<Helm_Name_Differences_In_V2_V3>>

In Helm 2: unless you provided a `--name` parameter, Helm created adjective-noun names for releases.

In Helm 3 this now uses the name of the chart, or what you override with `--name-template`_OR_ `--generate-name`

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{In Helm 2, "friendly names" were generated using adjectives and animal names. That was removed in Helm 3 due to complaints that release names were unprofessional.}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{In Helm 3, naming has been changed. Now instance names are scoped to Kubernetes namespaces. We could install two instances named mysite as long as they each lived in a different namespace.}


# Helm chart storage (different types of repositories)

## notes

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Chart repositories do, however, present a few key challenges:
  * They have no concept of namespaces; all charts for a repo are listed in a single index
  * They have no fine-grained access control; you either have access to all charts in the repo or none of them
  * Chart packages with different names but the exact same raw contents are stored twice
  *  repository index can become extremely large, causing Helm to consume a lot of memory}


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

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Chart Releaser, or cr, is a command-line tool that leverages GitHub releases for hosting chart packages. It has the ability to detect charts in a Git repo, package them, and upload each of them as artifacts to GitHub releases named after the unique chart version.}

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

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{In other words, --set values override settings from passed-in values files, which in turn override anything in the chart’s default values.yaml file.}


## See also:

  * Helm_Development_Checking_Your_Created_Chart
  *

## Using Helm as a preprocessor for something else

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Sometimes you want to intercept the YAML, modify it with your own tool, and then load it into Kubernetes. Helm provides a way to execute this external tool without having to resort to using helm template. The flag --post-renderer on the install, upgrade, rollback, and template will cause Helm to send the YAML data to the command, and then read the results back into Helm. This is a great way to work with tools like Kustomize.}

## Looking up very dynamic values from k8s

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Helm contains a template function that enables you to look up resources in the Kubernetes cluster. The lookup template function is able to return either an individual object or a list of objects}


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

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Helm provides the optional ability for each chart to provide its own schema for its values using JSON Schema. JSON Schema provides a vocabulary to describe JSON files. YAML is a superset of JSON, and you can transform content between the two file formats. This makes it possible to use a JSON Schema to validate the content of a YAML file.}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{When you run the commands helm install, helm upgrade, helm lint, and helm template, Helm will validate the values against what it finds in the values.schema.json file.}

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

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{You may run into the situation where you are creating multiple similar charts—charts that share a lot of the same templates. For these situations, there are library charts.
}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{It provides a blueprint that is meant to be overridden by the caller in a chart that includes this library. mylib.configmap is a special template. This is the template another chart will use. It takes mylib.configmap.tpl along with another template, yet to be defined, containing overrides, and merges them into one output. mylib.configmap uses a utility function that handles the merging and is handy to reuse.}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{When a child chart has declared an export property, its contents can be imported directly into a parent chart.}

## tests

### built in integration / environment validation unit tests

(Sometimes also called "helm hook test")

Stored in `templates/test`.

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Tests typically live in the tests subdirectory of the templates directory. Putting the tests in this directory provides a useful separation. This is a convention and not required for tests to run.}

It's just another k8s pod. Will not get deployed as a service, but the exit code of the command is checked for non-zero exit.

For example, a test can check that the webservice server your pod _should_ have launched _did_ launch.

Can be ran during deployment process lifecycle.

Interesting notes: because it's a separate pod definition, you don't have to use the docker container your normal application uses. You could use busybox and call `wget`, you could write a custom binary and put it in the container, whatever. [Example](https://stackoverflow.com/a/63512937/224334)

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{In Helm version 2 there was a hook named test-success for running tests. Helm version 3 provides backward compatibility and will run this hook name as a test.}


### actual unit tests

See Helm plugin [helm-unittest](https://github.com/quintush/helm-unittest) where you can test your post processed YAML (ie making sure one of your if conditions resulted correctly, or whatever)

### Chart Testing

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Chart Testing can be installed and used in various ways. For example, you can use it as a binary application on a development system or in a container within a continuous integration system. Learn more about using and setting it up for your situation on the project page.
}

See also:

  * [Builtin quality for Helm charts: unit testing to the rescue](https://medium.com/@gcavalcante8808/builtin-quality-for-helm-charts-unit-testing-to-the-rescue-2cb9d5c1ddc8)


### debugging WTF went wrong with your chart

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Helm provides tools designed to ease debugging. Between helm get manifest and kubectl get, you have tools for comparing what Kubernetes thinks is the current object with what the chart produced. This is particularly helpful when a resource that should be managed by Helm was manually edited outside of Helm (e.g., using kubectl edit).}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{While --dry-run is designed for debugging, helm template is designed to isolate the template rendering process of Helm from the installation or upgrade logic.}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{The template command performs the first four phases (load the chart, determine the values, render the templates, format to YAML). But it does this with a few additional caveats:

  * During helm template, Helm never contacts a remote Kubernetes server.
  * The template command always acts like an installation.
  * Template functions and directives that would normally require contacting a Kubernetes server will instead only return default data.
  * The chart only has access to default Kubernetes kinds.}

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

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Each release record contains enough information to re-create the Kubernetes objects for that revision (an important thing for helm rollback).}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{helm uninstall command has a flag called --keep-history. Normally, a deletion event will destroy all release records associated with that installation. But when --keep-history is specified, you can see the history of an installation even after it has been deleted:}


## Best Practices

@quote-note[
		#:original-highlight "the recommendation is to put in resource limits and then turn them into comments."	
	#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Wait couldn’t you set them to (Dev machine minimum) and ??? have helm —set them on big boy targets (knowing that, practically speaking, QA resource allocations will != prod)}

# In a microsevice's CI/CD process

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{there is an upgrade shortcut available that will just reuse the last set of values that you sent:

`$ helm upgrade mysite bitnami/drupal --reuse-values`}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{The --reuse-values flag will tell Helm to reload the server-side copy of the last set of values, and then use those to generate the upgrade}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{One recommendation for using --wait in CI is to use a long --timeout (five or ten minutes) to ensure that Kubernetes has time to resolve any transient failures.}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{ --atomic flag instead of the --wait flag. This flag causes the same behavior as --wait unless the release fails. Then, instead of marking the release as failed and exiting, it performs an automatic rollback to the last successful release. In automated systems, the --atomic flag is more resistent to outages, since it is less likely to have a failure as its end result. }

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{ --wait will track such objects, waiting until the pods they create are marked as Running by Kubernetes.}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{But with --wait, the success criteria for an installation is modified. A chart is not considered successfully installed unless (1) the Kubernetes API server accepts the manifest and (2) all of the pods created by the chart reach the Running state before Helm’s timeout expires.}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{The helm upgrade --install command will install a release if it does not exist already, or will upgrade a release if a release by that name is found. Underneath the hood, it works by querying Kubernetes for a release with the given name. If that release does not exist, it switches out of the upgrade logic and into the install logic.}


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

## Dependent Charts

charts.yml file:

`dependencies` key: give name, version and repository

`helm dependency update` <-- updates dependencies

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{When you want to control if a single feature is enabled or disabled through a dependency, you can use the condition property on a dependency}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{When a child chart has declared an export property, its contents can be imported directly into a parent chart.}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Dependencies are specified in the Chart.yaml file. The following is the dependencies section in the Chart.yaml file for a chart named rocket:}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{When a chart has dependencies listed under the dependencies field in Chart.yaml, a special file named Chart.lock is generated and updated each time you run the command helm dependency update. When a chart contains a Chart.lock file, operators can run helm dependency build to generate the charts/ directory without the need to renegotiate dependencies.}

## Starters

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Starters, or starter packs, are similar to Helm charts, except that they are meant to be used as templates for new charts.}


@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{Any Helm chart can be converted into a starter. The only thing that separates a starter from a standard chart is the presence of dynamic references to the chart name in a starter’s templates.}

@quote-highlight[#:title "Learning Helm"
  #:author  "N/A"
  #:page-number 0]{To specify a custom starter, you can use the --starter option when creating a new chart:}


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
