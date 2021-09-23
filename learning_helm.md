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
  * repositories— where charts are stored
  * release— chart instances loaded into k8s
  
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

[perhaps hosted via GitHub pages??](https://faun.pub/how-to-host-helm-chart-repository-on-github-b76c854e1462)

Just configure your helm CLI to have a registry that points to (the site)

## nexus

### ECR


### chart museum

There’a a chart for chart museum 



# Deployments

Can see these via helm ls. 

When a Helm chart is installed becomes a release (this is a Helm standard object type) 

## Attributes

  * **Revisions**: number of times you’ve deployed the service to this cluster  (this is NOT the artifact version number AND is reset say with a new cluster)

  * **name**: for more info see Helm_Name_Differences_In_V2_V3


## environmental variables for a deployment

Vs changing these one by one in k8s pods

## Reverting a deploy

## Removing a microservice completely from the cluster

`helm delete --purge $name`

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

## tests??!!


# Introspecting a repository

## searching for an artifact / chart in a repository

    helm search $repo/$artifactName
    
As Helm keeps a local cache of repositories, you may need to manually `helm repo update` before these queries return expected results...

## get previously stored template

### Helm v2 

    helm fetch $repo/$artifactName --version=$arifactVersion --untar


### Helm v3

	helm pull $repo/$name --version=$artifactVersion --untar
	
	
## Get K8s resources created by a chart

### Helm 3

	helm get manifest $repo/$releaseName


# Operating


# Helmfile

   Can deploy multiple charts in a herd.

   See [declaratively running helm charts using helmfile]([https://medium.com/swlh/how-to-declaratively-run-helm-charts-using-helmfile-ac78572e6088)
   
   Can select various sections you want to act on with selectors
   
   Can also use template helmfile subcommand to see rendered k8s charts
