---
path: "/learnings/helm"
title: "Learning Helm"
---

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


## v2 Vs v3
  
### Differences in required supporting infrastructure

  V2: Helm -> Tiller pod -> k8s cluster
  
  V3: helm -> k8s cluster via role based access controls
  
### User Facing Differences

#### Chart name <<Helm_Name_Differences_In_V2_V3>>

In Helm 2: unless you provided a `--name` parameter, Helm created adjective-noun names for releases. 

In Helm 3 this now uses the name of the chart, or what you override with `--name-template`_OR_ `--generate-name`


# Helm chart storage (different types of repositories)



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

## See also:

  * Helm_Development_Checking_Your_Created_Chart
  *

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


## tests??!!



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
