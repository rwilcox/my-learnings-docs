---
path: /learnings/aws
title: 'Learnings: AWS'
---
# Table Of Contents

<!-- toc -->

- [>](#)
  * [>](#)
  * [>](#)
    + [... and Memory Swap Space >](#-and-memory-swap-space-)
      - [See also:](#see-also)
    + [See also:](#see-also-1)
  * [>](#)
    + [Allows you to create auto DNS support (private and public names)](#allows-you-to-create-auto-dns-support-private-and-public-names)
      - [... or not using this, because the suck: >](#-or-not-using-this-because-the-suck-)
      - [Limits](#limits)
    + [And AZs](#and-azs)
  * [>](#)
    + [Docker Deploys](#docker-deploys)
    + [Non Docker Deploys](#non-docker-deploys)
    + [General Deployment Information](#general-deployment-information)
    + [Advanced Configuration](#advanced-configuration)
      - [... and microservice flocks](#-and-microservice-flocks)
    + [Logs](#logs)
      - [Types of log files](#types-of-log-files)
      - [Customizing log files](#customizing-log-files)
      - [... with Cloudwatch Logs as a destination](#-with-cloudwatch-logs-as-a-destination)
  * [>](#)
  * [>](#)
  * [>](#)
  * [>](#)
    + [Use Cases I like:](#use-cases-i-like)
  * [>](#)
    + [Neat Features](#neat-features)
    + [Custom Docker Builds in AWS CodeBuild](#custom-docker-builds-in-aws-codebuild)
    + [Limits:](#limits)
    + [and full Github Integration](#and-full-github-integration)
    + [Bitbucket Integration](#bitbucket-integration)
    + [Use cases I like:](#use-cases-i-like)
  * [>](#)
    + [ELB](#elb)
  * [>](#)
    + [>](#)
  * [>](#)
    + [APIs on Amplify](#apis-on-amplify)
      - [AWS also includes a FraphQL console to poke at the store using graphql queries / mutations](#aws-also-includes-a-fraphql-console-to-poke-at-the-store-using-graphql-queries--mutations)
  * [>](#)
  * [Creating a No Code Backend with DynamoDB, Cognito, DynamoDB and AWS Gateway](#creating-a-no-code-backend-with-dynamodb-cognito-dynamodb-and-aws-gateway)
    + [Notes on getting Dynomodb and API Gateway talking to each other](#notes-on-getting-dynomodb-and-api-gateway-talking-to-each-other)
      - [Mapping documents](#mapping-documents)
    + [API Gateway + Cognito and querying for user's documents](#api-gateway--cognito-and-querying-for-users-documents)
      - [Integration Request Mapping template for index actions (with ownership)](#integration-request-mapping-template-for-index-actions-with-ownership)
      - [Notes](#notes)
      - [Integration Response Mapping Template for index actions](#integration-response-mapping-template-for-index-actions)
      - [Creation / POST actions](#creation--post-actions)
    + [Notes on exposing API Gateway to the rest of the world (likely through Route 53)](#notes-on-exposing-api-gateway-to-the-rest-of-the-world-likely-through-route-53)
      - [And CORS](#and-cors)
    + [Operations](#operations)
    + [TODO BEFORE PUBLISHING](#todo-before-publishing)
    + [See also](#see-also)

<!-- tocstop -->

# <<Learning_AWS>>


## <<Learning_AWS_Route53>>


## <<Learning_AWS_EC2>>

### ... and Memory Swap Space <<Learning_AWS_EC2_Swap>>

From http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-store-swap-volumes.html:

> The c1.medium and m1.small instance types have a limited amount of physical memory to work with, and they are given
> a 900 MiB swap volume at launch time to act as virtual memory for Linux AMIs.

... but **only** those - EC2 instances not those seem to have no swap (!!??)

#### See also:

  * Learning_Ops_Unix_Controlling_Swappiness

### See also:

  * Learning_AWS_Good_DNS_Names_For_Instances

## <<Learning_AWS_VPCs>>

### Allows you to create auto DNS support (private and public names)

By default given DNS names will be `ip-private-ipv4-address.region.compute.internal`

(for non default VPC ???)

#### ... or not using this, because the suck: <<Learning_AWS_Good_DNS_Names_For_Instances>>

For better names:

  * [Chef: setting /etc/hosts everywhere to not require a DNS server](https://dodizzle.wordpress.com/2015/04/06/using-chef-to-automate-internal-hostnames-in-a-vpc/)
  * [Chef: use Route53 (assumes OpsWorks, but is portable)](http://hipsterdevblog.com/blog/2014/06/23/automatic-dns-records-using-route53/)
  * [Use a userdata script](http://scraplab.net/custom-ec2-hostnames-and-dns-entries/)

... or run your own bind server and create a Chef recipe to update that...

#### Limits

1024 packets per second per network card

### And AZs

AZs are presented to you called "Subnets". Note:

  * CIDR block for subnet (see Learning_Ops_Networking_CIDR_Blocks )
  * listed Availability zone

## <<Learning_ElasticBeanstalk>>

### Docker Deploys

### Non Docker Deploys

Upload a .zip of application, < 512MB.

Can use `eb deploy` to deploy current folder. Will always deploy latest commit, even if you have pending changes.

Extend ElasticSearch configuration by .ebextensions folder.

Can do super customized platform using AMIs + Packer


### General Deployment Information

Supported Types:

  * All at once
  * Rolling
  * Rolling with additional batch <-- rolls a new N instances so you don't lose N capacity as you deploy the new version to those N instances
  * Immutable

### Advanced Configuration

Can use menu in AWS console to Save Configuration (or use `eb config`)

Name this env.yaml in your top level folder name.

#### ... and microservice flocks

Called: "Environment Links"

KEY: (environment name)

value of key will be the cname to the environment with that name.

environment names and links let you create environment groups.

### Logs

[Default logs monitored by EB](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/AWSHowTo.cloudwatchlogs.html).

Undr Ruby this is /var/log/(nginx|http)/(error_log|access_log); /var/log/puma/puma.log (or /var/app/support/logs/passenger.log)

S3 upload (can) happen on logrotate.

#### Types of log files

[See also](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.logging.html):

  * tail    : gets last 100 lines of all files, packages up. S3 dest will delete after 15 minutes
  * Bundled : full log to S3
  * rotated : full log to S3 when a log rotation would happen

#### Customizing log files

Remember that AWS Log agent works like so:

config files for what to monitor are stored in /etc/awslogs/config/ <-- many configuration files, one file per file to monitor. (Normal `awslogs` operation)

Info about this:

  * [Official Sample](https://github.com/awslabs/elastic-beanstalk-docs/blob/master/configuration-files/aws-provided/instance-configuration/logs-streamtocloudwatch-linux.config)
  * [example application specific](https://stackoverflow.com/a/44430632/224334)


#### ... with Cloudwatch Logs as a destination


## <<Learning_AWS_ECR>>

Drawbacks / things need to worry about before using ECR:

  * Before pushing to ECR you need an Image Repository *created already* to store your docker image. One Repository = One Docker Image
    TERMINOLOGY:
      - Docker Registry: Docker Hub
      - Docker Repository: A collection of images with the same name but different tags (aka https://hub.docker.com/r/library/python/tags/ is a Repository)
      - Thus ECR Image Repository = Docker Repository

    ... the documentation _seems to_ imply differently, but experience seems to be one repository = one docker image ???
  * IAM roles apply on the repository level (only that granular)

Neat commands:

  * `aws ecr describe-repositories`
  *


## <<Learning_AWS_Building_Build_And_Release_Pipelines>>

AWS Code Pipeline: Build Pipeline creation

Pipelines contain steps like AWS CodeBuild, and others

## <<Learning_AWS_CodePipeline>>

CodePipeline: a lot of power hidden behind first interface!!!
At first blush looks limiting (SOURCE, BUILD, DEPLOY) but can hook up many more stages: ie multiple CodeBuild commands, direct push to OpsWorks or ECS, etc

Limits:
  * AWS CodePipeline does not currently support Bitbucket.
  * does not easily support LightSail(??)

Inputs:

  * Github
  * AWS S3
  * AWS CodeCommit

CodePipeline can trigger AWS CodeBuild as part of its steps.

NOTE: CodePipeline does __not__ support Bitbucket

Types of stages:

  1. Build     <-- trigger CodeBuild or Jenkins
  2. Approval  <-- Humans!
  3. Deploy    <-- to CodeDeploy, ECS, OpsWorks
  4. Invoke    <-- trigger a AWS Lambda function!!

Example Deploy pipeline -> ECS:
  1. (Code trigger)
  2. Code Build -> ECR
  3. Deploy via Cloudformation via new task definition revision

Because the CFN regenerated will pull the Docker image from ECR.

Example Deploy pipeline -> React:

- [TODO]: Think about this use of CodePipeline!!!!

## <<Learning_AWS_CodeDeploy>>

Deploy and run code arctifacts on a VM

Inputs:

  * Github
  * Bitbucket
  * S3

(Thus can do Heroku style deploys just with CodeDeploy)

Two deployment types:

  * in place
  * blue / green — requires EC2 instances with auto scale groups / and configured IAM (dynamic???)

  Requirements:

     * must have CodeDeploy agent installed

  During deploy CodeDeploy agent on box reads AppSpec.yml and executes instructions


Allows many hooks to mutate state of machine before you launch your software on it.

### Use Cases I like:

  1. Can use CodeDeploy to let your AWS Lambda functions have pre and post deploy hooks!!!!

  2. By using / abusing post / pre hooks, can use this as a poor man's Chef: ie installing Wordpress or a third party application on Ec2 instances.


## <<Learning_AWS_CodeBuild>>

Takes files in (github, bitbucket, s3) and (optionally) copies the file result of some build to S3.

Thus if your build process produces *artifacts*, you could use this to build/produce them. (Or if your pipeline tests and then produces Docker artifacts???)

Tracking Code Build step results: http://docs.aws.amazon.com/codebuild/latest/userguide/view-build-details.html

### Neat Features

  * "serverless"
  * per minute billing
  * can listen to Github, Bitbucket, S3 repos
  * Docker features (can build your app in the service's custom Docker image)
  * 5 minute build costs ~ 3cents

### Custom Docker Builds in AWS CodeBuild

if CodeBuild doesn't have version of language etc you need, can use own Docker image.

Can also use docker-in-docker - have used this to install docker compose and bring up a suite of required services (ie databases), each in their own seperate container.

### Limits:

  * AWS CodeBuild projects: 1,000
  * Max number of concurrent builds: 20 (varies based on instance size, but most are 20)


### and full Github Integration

Behaviors:

  * it should update commit / PR status when the build completes
  * it should link to the AWS CodeBuild result in the build status

CodeBuild **auto does this** if you set it up to trigger from Github (and make sure the CodeBuild app has permissions). Will update commit status with a pointer to the CodeBuild result!!!

### Bitbucket Integration

Behaviors:

  * it should update commit / PR status when the build completes
  * it should link to the CodeBuild result in the build status

CodeBuild does this, even for Bitbucket or Bitbucket Cloud. AKA: Bitbucket fully supported citizen!!!

### Use cases I like:

  1. Early early stage startups (5 cents a build, no $10-60/month min)


## <<Learning_AWS_LoadBalancers>>

Default ( < 10-30ish????? minutes ) of requests seem to be rate limited at 6K rps / 800-ishMB/second

Can call up account rep and ask to pre-warm.

Should be able to scale *LBs up to Web Scale traffic: aka all of ESPN.com is served off one ELB configuration in AWS.

### ELB

Allows SSL termination on chosen instance, not just at load balancer level

## <<Learning_AWS_Cloud9>>

### <<Cloud9InstallingJava8>>

  1. `$ sudo yum install java-1.8.0-openjdk-devel`
  2. `sudo alternatives --config java`
  3. `sudo yum remove java-1.7.0-openjdk-devel`

## <<Learning_AWS_Amplify>>

### APIs on Amplify

For graphql APIs can auto generate your code for you to talk back to AWS AppSync. Start with the graphql schema and it will generate :
  * CRUD queries,  mutations and subscriptions
  * provision databases with amplify push

  Can generate in javascript, typescript or Flow
 Can also use Cognito to create application specific users for your app. Including, for react, widgets for sign up and sign in.

#### AWS also includes a FraphQL console to poke at the store using graphql queries / mutations


## <<AWS_Cognito>>

Slows users to create sign ins with your application. provides a console to view all the users created, serarch through them, set the attributes of the username and password rules, customize the UI. can also use a lambda function to trigger when users are created etc etc

Can also use Google Auth time based one time passwords from the users auth app of choice.

Also [supports Sign In with Apple](https://aws.amazon.com/about-aws/whats-new/2019/11/amazon-cognito-now-supports-sign-in-with-apple/)

Also lets people sign in with their Facebook or Google account

## Creating a No Code Backend with DynamoDB, Cognito, DynamoDB and AWS Gateway

If your data model fits in a document database, you can

Advantages:

  * free
  * good for startups where you're optimizing either cost or code
  * API gateway can abstract away when you move to (a real full code solution) from having API gateway do all the transformation logic
  * Ooops Just Mapping Code

Concepts:

Resource -> Stage has many resources -> custom domain names map resources + stages to a URL / path exposed to the Internet.

### Setting up paths in API Gateway

API Gateway -> Custom Domain Mappings: where you can configure what path the API is under. Want all your APIs to be under `/rest/` or `/api` ? Set it in your custom domain name's API mapping, but this is optional (although likely a best practice - you don't know what non API related things your API gateway could serve)

### API Gateway setup

Resources - how to define your routes

Can nest resources - ie have a resource that is /documents/ and a sub resource in that which is v1, so your resulting routes will be example.com/documents/v1/

### Notes on getting Dynomodb and API Gateway talking to each other

[DynamoDB actions](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_Operations.html) (what you put in the Action section of the integration request)

Remember regardless of what ACTION the request comes in as, you need to send POST requests into Dynamo.

#### Mapping documents

[Resolver mapping template utility reference](https://docs.aws.amazon.com/appsync/latest/devguide/resolver-util-reference.html) looks like it's about AppSync, but these functions also seem to be there for API Gateway mapping documents.

[What's in the $context object anyway?](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-mapping-template-reference.html)


### API Gateway + Cognito and querying for user's documents

#### Integration Request Mapping template for index actions (with ownership)

Assumes that the DynamoDB document has a UserId field, which is populated with the Cognito username. You want to, on the "server side" ask for the documents (the logged in user) owns, for security reasons. Which involves some processing logic in the mapping document in the Integration Request:


Content-Type: `application/json`

```json
{
  "TableName": PUT_YOUR_TABLE_NAME_HERE_AS_A_STRING,
  "FilterExpression": "UserId = :val",
  "ExpressionAttributeValues": { ":val": {"S": "$context.authorizer.claims['cognito:username']"} }
}
```

(Yes, you need tho `{"S": ..}` stuff!)

You need to specify action. [AWS DynamoDB Actions API reference](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_Operations.html)

#### Notes

I _had to_ **explicitly** set my request's Content-Type to `application/json` to get the mapper to pick up what I was trying to do.

#### Integration Response Mapping Template for index actions

You'll need to process DyamoDB's results to a better format, as DynamoDB will return the attribute type where sterotypically REST apis would just return the value.

So `"foobar": {"S": "baz"}`. Which is very odd: not very RESTful, not very expected. You'll need to map the DynamoDB results back to something useful

In the Integration Response, the mapping template:

`"foobar": "$elem.SomeField.S"`

NOT returning the attribute type implementation detail will give us a more stereotypical API for our users (and if we rip up this endpoint with something less "no code").

This does mean you'll need to transform every field from your data source. Setting up a Model for your object type (on the left sidebar) will at least give you hints about what fields you need to process.

Since you'll need to loop over _multiple_ documents coming back from DynamoDB (it's an index page after all) you need to use a VTL loop. Putting these facts together...

```json
#set($inputRoot = $input.path('$'))
{
  "YOUR_OBJECT_TYPE_HERE": [
    #foreach($elem in $inputRoot.Items) {
      "user_id": "$elem.UserId.S",
      "title": "$elem.title.S"
      "type": "object"
    }#if($foreach.hasNext),#end
    #end
  ]
}

```

See that `hasNext` block here? Trailing commas are invalid JSON, so we must not include the for the last element. Use this `hasNext` trick to only include commas if there's more elements comming.

#### Creation / POST actions

Getting values from the post: `    "somefieldInDynamo": {"S": $input.json('$.someField')}`

For documentId I cheated and just used `    "DocumentId": { "S": "$context.requestTimeEpoch" }`. The Dynamodb design documents say to **not** do this for partition keys but I don't have that much of a choice with regard to auto-generating keys.

### Notes on exposing API Gateway to the rest of the world (likely through Route 53)

Work through [Routing Traffic to an Amazon API Gateway API by using your domain name](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-api-gateway.html)

In API Gateway under the custom domains, you can set up API mappings - mapping a URL with an API Gateway Resource you created.

#### And CORS

if you have an API gateway route you want to run locally, you'll likely just need to set the `Access-Control-Allow-Origin` header to `*` (not multiple domains, that doesn't seem to work, or I didn't know how to set it up correctly)

Under Actions there's an Enable CORS choice, which propegates your CORS settings to your routes. It doesn't seem to be stateful, but that's how you do it (I did not have luck just creating an OPTIONS route myself).

This Enable CORS seems to _not_ be  once and done thing, and does not apply to subresources. Keep a watch over your network opertions tab where you're calling API Gateway to see if you need to do it again, or on  different or new subset.

### Operations

Logging: the logging stuff, through to CloudWatch logs, is really good at seeing what your mapping documents are doing.

You may need to set up the IAM permissions correctly, [In the global API gateway Settings](https://stackoverflow.com/a/59057471/224334).

Q: What's the UX around this, or around this making it easy? Plus, there's a debug flag, right?

### TODO BEFORE PUBLISHING

Figure the answers to these questions out then integrate them into the article

Q: how do I hook up a route that passes everything through: ie I've stood up a lambda with POST/PUT/GET verbs and want /api/v1/foobar to always go to that? Is that easy? AND what about /api/v2 routing to ie a replacement Rails app?

A:

Q:
Q: what does canary deploys do / how to use that? ie want to be able to test this thing on prod before sending all the traffic to that point. Can do that with canary, somehow although the interface is not good.

A: turn on canary, then when you deploy a change and it lets you pick a stage. It will default to the canary version of that stage. When you are happy use promote in the canary's settings page.

[Canary deployments in API gateway blog entry from Amazon](https://docs.aws.amazon.com/apigateway/latest/developerguide/create-canary-deployment.html)

Q: how can I monitor that a deployment has really happened?

Q: can I use API Gateway to control traffic to my api (aka maintaince window)?

TODO: make one of those AWS arch diagrams: see mah, no step 3!

### See also

  * [Using Amazon API Gateway As A Proxy For DynamoDB](https://aws.amazon.com/blogs/compute/using-amazon-api-gateway-as-a-proxy-for-dynamodb/)

A less in depth version of this information. But it's a great summary!
