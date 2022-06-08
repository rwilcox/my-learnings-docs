---
path: /learnings/terraform_terragrunt.md
title: 'Learnings: Terraform: Terragrunt'
---

# Table Of Contents

<!-- toc -->

# Linting etc


## terragrunt files

`terragrunt hclfmt` <-- this _only_ lints/updates .hcl files, _not_ .tf files

## formatting terraform files in a terragrunt project

`terraform fmt -recursive`. You don't even (seemingly) avoid .hcl folders.

Also have `-check` parameter you can pass which will fail on non-compliant source...

## with tflint

run it in the root of any folder that has `.tf` files. Yes this means iterating through the files in your project and running it only in certain files (it does not correctly recurse down)
