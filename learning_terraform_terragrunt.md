---
path: /learnings/terraform_terragrunt.md
title: 'Learnings: Terraform: Terragrunt'
---
# Table Of Contents

<!-- toc -->

- [Linting etc](#linting-etc)
  * [terragrunt files](#terragrunt-files)
  * [formatting terraform files in a terragrunt project](#formatting-terraform-files-in-a-terragrunt-project)
  * [with tflint](#with-tflint)
- [Handling all the extra output from terragrunt](#handling-all-the-extra-output-from-terragrunt)

<!-- tocstop -->

# Linting etc


## terragrunt files

`terragrunt hclfmt` <-- this _only_ lints/updates .hcl files, _not_ .tf files

## formatting terraform files in a terragrunt project

`terraform fmt -recursive`. You don't even (seemingly need to) avoid .hcl folders.

Also have `-check` parameter you can pass which will fail on non-compliant source...

## with tflint

run it in the root of any folder that has `.tf` files. Yes this means iterating through the files in your project and running it only in certain files (it does not correctly recurse down)

# Handling all the extra output from terragrunt

does setting [terragrunt-log-level](https://terragrunt.gruntwork.io/docs/reference/cli-options/#terragrunt-log-level) `--terrgrunt-log-level warn` help?

But also, don't set it too high or [you'll swallow logs for Terraform itself](https://github.com/gruntwork-io/terragrunt/issues/1626)

Terragrunt also caches things in a .terragrunt-cache folder in your terragrunt folder (.terragrunt-cache/some-hash-that-will-be-random-idk/). Including the plan file that TerraFORM generates. This plan file will be named with what you told terraGRUNT to name it via its `--out` parameter.

So `find` that file, and run [terraform show](https://developer.hashicorp.com/terraform/cli/commands/show) on it
