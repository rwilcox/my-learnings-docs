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

## get previously stored template

    helm fetch $repo/$artifactName—version=$arifactVersion—untar

## Making sure your template works (local machine development)

  * `helm lint`
  * `helm template` <-- renders the Helm chart as a k8s resource. You could use this to ensure you're telling k8s to do what you think you're telling it

# Values / The Template Nature

can specify in three locations (precedence):
  * parent chart
  * values.YAML
  *—set parameters

[source](https://v3-1-0.helm.sh/docs/chart_template_guide/values_files/)


# Operating



# Helmfile

   Can deploy multiple charts in a herd.

   See [declaratively running helm charts using helmfile]([https://medium.com/swlh/how-to-declaratively-run-helm-charts-using-helmfile-ac78572e6088)
   
   Can select various sections you want to act on with selectors
   
   Can also use template helmfile subcommand to see rendered k8s charts
