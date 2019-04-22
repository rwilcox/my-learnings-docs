---
path: "/learnings/aws_cloudformation"
title: "Learning AWS: CloudFormation"
---

# <<Learning_AWS_CloudFormation>>

### Very Template

    ---
    AWSTemplateFormatVersion: "2010-09-09"  <-- currently only version (Nov 2017)

    Description:                            <-- human description
      String

    Metadata:                               <-- can add config tasks for cfn-init-helper here!
      template metadata

    Parameters:                             <-- specify stack parameters, default or allowed values
      ParameterLogicalId:
        Type: DataType                     <-- String, Number, List<$WHATEVER>, CommaDelimitedList, 
                                               AWS::EC2::AvailabilityZone::Name, AWS::EC2::Image::Id
                                               AWS::EC2::Instance::Id, AWS::EC2::KeyPair::KeyName, 
                                               AWS::EC2::SecurityGroup::GroupName, AWS::EC2::SecurityGroup::Id,
                                               AWS::EC2::Subnet::Id, AWS::EC2::Volume::Id, AWS::EC2::VPC::Id,
                                               AWS::Route53::HostedZone::Id
        
        NoEcho: true                      <-- don't echo this value back
        Description: ""                   <-- human name
        
        

    Mappings:                      <-- if you wanted a set of values based on region, you can use this
      set of mappings

    Conditions:              <-- sets a boloean / value you can refer to later to conditionally create resources
      set of conditions

    Transform:               <-- use AWS Serverless Application model here (AWS SAW)
                             <-- can also do AWS::Include transform to include libraries
      set of transforms

    Resources:               <-- only required section!!!
      set of resources

    Outputs:                <-- lets you mark values for import into other stacks
      set of outputs

### Parameters

If you use the AWS Management Console, AWS will pre-populate AWS specific param types with values

If you use CLI you can't

#### Listing AWS Parameters via CLI

    $ aws get-template-summary 
      --template-body or --template-uli   # <-- url must point to an S3 bucket
      --stack-name                        # <-- name or stack ID of stack
      --cli-input-json
      --generate-cli-skeleton
      
### Mappings

#### Using mappings / finding things put in a map

    AWSTemplateFormatVersion: "2010-09-09"
    Mappings: 
      RegionMap: 
        us-east-1: 
          "32": "ami-6411e20d"
          "64": "ami-7a11e213"
        us-west-1: 
          "32": "ami-c9c7978c"
          "64": "ami-cfc7978a"
	Resources: 
	  myEC2Instance: 
		Type: "AWS::EC2::Instance"
		Properties: 
		  ImageId: !FindInMap [RegionMap, !Ref "AWS::Region", 32]
		  InstanceType: m1.small

### Conditions

Here's an example of using an environment parameter you pass in to control resources for that deployment environment.

      Parameters: 
        EnvType: 
          Description: Environment type.
          Default: test
          Type: String
          AllowedValues: 
            - prod
            - test
          ConstraintDescription: must specify prod or test.

      Conditions:
        CreateProdResources: !Equals [ !Ref EnvType, prod ]
        
      Resources:
        EC2Instance:
          Type: "AWS::EC2::Instance"
          Condition: CreateProdResources
          Properties:
            ImageId: "ami-20b65349"

### Includes

  * it's a pre-processor:
    - you can not mix JSON and YAML
    - processor resolves transforms first, then processes the template
    
  * can not have multiple AWS::Include transforms at both top level and embedded in section


### Important CloudFormation Functions

  * Fn::FindInMap
  * Ref
  * Fn::GetAtt       <-- get an attribute from a resource in the template
  * Fn::ImportValue  <-- get values exported from another stack (some restrictions apply)
  * Fn::GetAZs
  * Fn::Join
  * Fn::Split
  * Fn::And
  * Fn::Equals
  * Fn:If
  * Fn::Not
  * Fn::Sub          <-- subs variables in an input string with values you specify. You can use this to construct commands or output values that may not be avail until you construct the stack (but also could use it just to `cat`)

### Concepts

#### running something on instance startup

    Type: "AWS::EC2::Instance"
    Properties:
      UserData:
        Fn::Base64:
          Fn::Join:
          - "-"
          - - '#!/bin/bash'
            - apt-get update
            - apt-get upgrade -y
            - apt-get install apache2 -y

or can...

    Type: "AWS::EC2::Instance"
    Properties:
      UserData:
        Fn::Base64: !Sub |
          #!/bin/bash
          apt-get update
          apt-get upgrade -y
          apt-get install apache2 -y

#### running something on instance startup that requires introspection

Use some of the tools built into the Amazon AMI or installable via yum: `cfn-init`, `cfn-get-metadata`.

(Can also use something like `cfn-hup` to poll for changes and do action...)

Example: 
In `UserData` of resource do something like this: if you have a list of packages to install you've hidden in metadata for a resource...

`/opt/aws/bin/cfn-init -v --stack { "Ref" : "AWS::StackName" } --resource WebServerInstance --configsets InstallAndRun --region { "Ref" : "AWS::Region" }`

#### A resource that needs information from another resource

      Resources:
        EC2Instance:
          Type: "AWS::EC2::Instance"
          Properties:
            ImageId: "ami-20b65349"
        
        LB:
          Type: "AWS::ElasticLoadBalancing::LoadBalancer"
          DependsOn: "EC2Instance"
          Instances:
            - !Ref EC2Instance
          
          # now imagine the following attribute (doesn't actually exist). Need to get an attribute of an already created resource
          PrivateIPs: 
            - !GetAtt EC2Instance.PublicIp  


[DependsOn documentation](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-dependson.html?shortFooter=true)

### Custom Resources

Cloud Formation calls resource implemented following ways:

  * implemented on SNS topic
  * AWS lambda function [ARN](http://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)
  
On request CF includes info like request type and pre-signed S3 URL where custom resource sends responses too.

Send response of SUCCESS or FAILURE to pre-signed S3 URL. Can also provided pre-named pairs.

### Running / Managing CloudFormation Templates

#### On AWS: StackSets

Stacks = template + parameters for template + additional parameters, per region.

Can receive notification of build complete based on SNS
  
##### UI

Can create stack set, and upload template via file upload, point to S3 resource, use premade template.

##### CLI

First do:
    $ aws cloudformation create-stack-set  --stack-set-name ... --template-url https://s3.amazonaws.com/....yml --parameters= WhateverKey=value,OneMore=thing

Then add stack instances...

    $ aws cloudformation create-stack-instances --stack-set-name=... --regions=... --cli-input-json...

#### Tips

  * Be sure that global resources (S3, IAM) don't conflict if created in > 1 region
  * Remember stack set has single template and parameter set
  * For testing: create a test stack set with template and a test account you can test this on (then destroy resource after testing)
  
#### Limits  
  * StackSets don't currently support transforms
  * 20 stack sets in admin account, max 50 stack instances per stack set


### Cloudformation Thoughts / Tips

  * Not immutable infrastructure
  * Attempts to be idempotent (does not apply to some resources)

### Documentation notes

In the documentation the sections of the CloudFormation templates may be documented on seperate places, click the monospaced name that doesn't look like a link but really is to see the documentation for that.

## Introspecting the Cloudformation resources

### from an EC2 instance (ie port mans )  =[SERVICE_DISCOVERY]

[list metadata from Cloudformation](http://brillozon.com/devops/2015/04/29/making-aws-metadata-available-on-ec2/)

# See Also

  * [rwilcox: Ansible / Cloudfomation Integration Treatise](https://github.com/rwilcox/ansible_cloudformation_integration_treatise)

# Book Recommendations
