---
path: "/learnings/helm"
title: "Learning Helm"
---

# Intro / Why

# Helm chart storage

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

## Attributes

  * **Revisions**: number of times you’ve deployed the service to this cluster  (this is NOT the artifact version number AND is reset say with a new cluster)

  * **name**: is the adjective-noun style, not the artifact name


## environmental variables for a deployment

Vs changing these one by one in k8s pods



# Values / The Template Nature

can specify in three locations (precedence):
  * parent chart
  * values.YAML
  *—set parameters

[source](https://v3-1-0.helm.sh/docs/chart_template_guide/values_files/)


# Operating

## get previously stored template

    helm fetch $repo/$artifactName—version=$arifactVersion—untar

## deleting a deployment


# Helmfile

   Can deploy multiple charts in a herd.

   See (declaratively running helm charts using helmfile)[https://medium.com/swlh/how-to-declaratively-run-helm-charts-using-helmfile-ac78572e6088]
   
   Can select various sections you want to act on with selectors
   
   Can also use template helmfile subcommand to see rendered k8s charts
