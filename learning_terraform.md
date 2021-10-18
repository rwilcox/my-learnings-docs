---
path: /learnings/terraform
title: 'Learnings: Terraform'
---
# Table Of Contents

<!-- toc -->

- [Example](#example)
  * [Variables](#variables)
- [modules](#modules)
- [Random Notes](#random-notes)
- [CLI](#cli)
- [String Interpolated Values](#string-interpolated-values)
- [Getting data out of your stack](#getting-data-out-of-your-stack)
- [Lifecycle blocks](#lifecycle-blocks)
- [Storing terraform cluster state](#storing-terraform-cluster-state)
- [Teams and Terraform](#teams-and-terraform)
  * [PR Review](#pr-review)
- [Questions](#questions)
  * [- [REVIEW]: Q: How does immutable infrastructure play with mutable data stores (ie how do you make sure you don't lose the data in your RDS???)](#--review-q-how-does-immutable-infrastructure-play-with-mutable-data-stores-ie-how-do-you-make-sure-you-dont-lose-the-data-in-your-rds)
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

## Variables

If you din’t provide a default for a variable terraform will prompt you for one interactively **or** you can provide one by exporting end variblisbles follow pattern sampled here: TF_VAR_instance_size

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



# Lifecycle blocks

Can use these to control how / when terraform destroys replaced resources
(ie: `create_before_destroy`)


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

# Book Recommendations

  * [Terraform up and running](https://www.amazon.com/Terraform-Running-Writing-Infrastructure-Code-dp-1491977086/dp/1491977086/ref=as_li_ss_tl?_encoding=UTF8&me=&qid=1555897684&linkCode=ll1&tag=wilcodevelsol-20&linkId=4bccd7eb621e692a978599bfdf8302cc&language=en_US)

