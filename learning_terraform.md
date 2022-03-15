---
path: /learnings/terraform
title: 'Learnings: Terraform'
---
# Table Of Contents

<!-- toc -->

- [Example](#example)
- [Variables](#variables)
- [Lifecycle blocks](#lifecycle-blocks)
- [modules](#modules)
- [Random Notes](#random-notes)
- [CLI](#cli)
- [String Interpolated Values](#string-interpolated-values)
- [Getting data out of your stack](#getting-data-out-of-your-stack)
- [Storing terraform cluster state](#storing-terraform-cluster-state)
- [Teams and Terraform](#teams-and-terraform)
  * [PR Review](#pr-review)
- [Questions](#questions)
  * [- [REVIEW]: Q: How does immutable infrastructure play with mutable data stores (ie how do you make sure you don't lose the data in your RDS???)](#--review-q-how-does-immutable-infrastructure-play-with-mutable-data-stores-ie-how-do-you-make-sure-you-dont-lose-the-data-in-your-rds)
- [Build and Release Tools](#build-and-release-tools)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

# Example

    resource "aws_instance" "example" {
        ami = "ami-112347"
        instance_type = "${var.instance_size}"
    }

    resource "dns_simple_record" "example" {
        domain = "example.com"
        name = "test"
        value = "${aws_instance.example.public_ip}"
        type = "A"
    }

    variable "instance_size" {
        description = "what size of resource to create"
        type = "string"
        default = "t2.micro"   // <-- no default? terraform apply will ask you for value
    }

# Variables

Ways to define this:

  * variable block with default
  * variable block BUT you didn’t provide a default for a variable, so terraform will prompt you for one interactively
  * you have a variable block but the values of the variables are loaded from a variable definition file
  * during `terraform` invocation, with the `-var` CLI parameter
  * you can provide one by exporting env variables follow pattern sampled here: `TF_VAR_instance_size`

# Lifecycle blocks

  * `create_before_destroy`
  * `prevent_destroy`
  * `ignore_changes`  <-- you can provide a list of FIELDS here that Terraform will ignore changes to the real infra, which may (in some resources!) trigger a replament event

In most cases this is not required but could be because [your provider isn't round-tripping the values correctly](https://stackoverflow.com/q/68574608/224334) cough cough GCP cough cough

[Documentation](https://www.terraform.io/language/meta-arguments/lifecycle)

# modules

Can share code via modules, can also pass variables into these modules



# Random Notes

  * Terraform immutable infrastructure tool ????????
  * masterless

# CLI

    $ terraform plan    # <-- what's going to happen
    $ terraform apply   # <-- do it!
    $ terraform graph   # <-- what your dependency graph looks like (outputs in GraphViz format)
    $ terraform destroy # <-- destroys all resources terraform created

# String Interpolated Values

These follow a namespace type path: `"${TYPE.NAME.ATTRIBUTE}"`

Creates an implicit dependency.

# Getting data out of your stack

    output "public_ip" {
       value = "${aws_instance.example.public_ip}"
    }


Will be outputted at end of terraform apply, in own section. OR `terraform output $VARIABLE_NAME`.

Can read previous / different runs by using remote state store to store these, and use "data ’terraform_remote_state’”  declarations to point to saved data store (can be on S3). **note** this is read only!!!


# Storing terraform cluster state

Terraform Remote State Storage (`terraform remote config`). Can go S3

... but does not provide locking. Yay race conditions!

Ways around:

  * build server terraform applys
  * Terraform Enterprise
  * Terragrunt <-- stores semaphore in DynoDB

# Teams and Terraform

## PR Review

Review:

  * Code diffs
  * `terraform plan` output should be included in the PR also, we humans can eval what would change

# Questions

## - [REVIEW]: Q: How does immutable infrastructure play with mutable data stores (ie how do you make sure you don't lose the data in your RDS???)

Could use safety `lifecycle` value: `prevent_destroy`

# Build and Release Tools

  * [tfschema](https://github.com/minamijoyo/tfschema) looks promising, but doesn't seem to interact with terragrunt correctly

# Book Recommendations

  * [Terraform up and running](https://www.amazon.com/Terraform-Running-Writing-Infrastructure-Code-dp-1491977086/dp/1491977086/ref=as_li_ss_tl?_encoding=UTF8&me=&qid=1555897684&linkCode=ll1&tag=wilcodevelsol-20&linkId=4bccd7eb621e692a978599bfdf8302cc&language=en_US)
