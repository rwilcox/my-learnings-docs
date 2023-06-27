---
path: /learnings/learning_google_cloud
title: Learning Google Cloud
---
# Table of contents

<!-- toc -->

- [Terraform and GCP](#terraform-and-gcp)
  * [Debugging HTTP 400 errors from a terraform apply](#debugging-http-400-errors-from-a-terraform-apply)

<!-- tocstop -->

# Terraform and GCP

`<<Terraform_Google_Cloud>>`

## Debugging HTTP 400 errors from a terraform apply

  * are you using labels? See GCP_Label_Restrictions <-- values outside of the given range are known to throw HTTP 400 errors
  * [Do you have a valid location? aka did you typo something?](https://stackoverflow.com/a/74645988/224334)
  * are you missing a field that's required in the API schema but not defined as such in the TF documentation? (Good luck finding that one...)
