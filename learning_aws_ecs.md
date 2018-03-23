---
path: "/learnings/aws_ecs"
title: "Learning AWS: ECS"
---

# <<Learning_AWS_ECS>>

Abilities:

  * Possible to plug into Meso???? and other third party schedulers
  * Mix and match instance types
  * auto integrates with EC2 instance types
  * Integrates with other AWS services: EB, etc etc

ECS somewhat like Google Container Service, in GCloud

### ECS Components

  * Cluster: Group of container instances that act as a single computing resource
    - Group of container instances acting as a single resource
    - Tasks get scheduled here
    - Can mix and match instance types
    - instances can not join multiple clusters

  * Container Agent: background app running on container instance: connects container instance to container cluster, 
  * Container Instances: EC2 instance that is part of a cluster
    - can be totally Amazon AMI based, or can be your own AMIs (Amazon open sources this tool. Have docker images etc in addition to bare instance tools)
    - container instances can do a startup script: in that startup script you could copy over the ECS config file from your bucket and configure the VM
    - 

  * Task definition: how the Dockerfiles in your cluster should be run. JSON file, sort of like Docker Compose file +++:
    - controls one or more containers with optional volumes
    - applications can use one or more task definitions
    - grouped containers run on the same instance <---- ie if your service declares multiple tasks those tasks will always run together on instances for that task
    - also contains hint about memory usage, max CPU usage
    - grouped into task definition families???
    - if you're using ECR, use the ECR repository path in the image location (defaults to Docker Hub)
    - ... but are short running _unless_ you put them in a service(???)
    - Useful CLI commands:
    
      * `aws ecs register-task-definition --cli-input-json file://my_task_definition.json`
      * `aws ecs run-task --cluster wherever --task-definition my_task_definition --count=1`
      
    - TL; DR:
    
      * can contain many docker processes in itself (called `ContainerDefinitions` )
      * is union of container definitions + resource configurations for that group of 
    
  * Service:
    - 
    -
    -
    - TL; DR:
    
      * only have one task definition
      * but can scale that task definition multiple times
      * union of task + count + load balancers + network config + ECS cluster name

  * Schedulder: determines where a service should live based on current resources
    - 3 ways to schedule a task
    - can use third party scheduler
    - can hook up with an ELB
    
    - Running vs Starting Tasks:
    
      * `StartTask` lets you pick where to run a task <-- maybe when you have a task that requires high CPU and you have a high CPU instance in your cluster just for high CPU services
      * `StartTask` lets you bring your own scheduler <--- OSS tutorials point to using Mesos / Marathon
      *
    
    
  * ECS CLI: 
	- can generate configuration template you could check into SCM and then play back later:
	  ` $ aws ecs create-service --generate-cl-skeleton > myclusterconfig.json.tmpl`
	  to play back:
	  ` $ aws ecs create-service --cli-input-json file://my_cluster_config.json`

#### Task placement

Can be bin packed based on memory, spread evenly, or random dist

ECS is also smart enough to not place multiple instances on the same host if your ECS Tasks have [static host port maps defined](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-service.html#basic-service-params).

### ECS and Deployment/Operations  <<AWS_ECS_Deployment>>
  
#### ECS Deployment and command line



#### and Docker Compose <<AWS_ECS_Docker_Compose>>
  
Can use ecs-cli compose -file to specify cluster using only Docker compose file(??) - *Spring in Action*

[YES](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/cmd-ecs-cli-compose.html)

Will create task definitions by using Docker Compose files

##### ECS Tasks vs ECS Services

ECS Tasks: managed via `ecs-cli compose ....`
^^^^^^ so if you want to run a migration, use this form of the command (and specify `rake db:migrate` or whatever as the command via the command line)

ECS Services: managed via `ecs-cli compose ... service ...`
^^^^ so when you want to run your app forever, use this

##### Basic Shell Script To Do This

    ecs-cli up --keypair $AWS_KEY_PAIR --capability-iam --size 2 --instance-type t2.micro --vpc vpc-xxxxxxx --subnets subnet-123abc,subnet-321cba
    # ^^^^^^^ will create the ECS Cluster if it doesn't already exist!!!
    
    ecs-cli compose --file api/docker-compose.yml service up \
                    --target-group-arn $PROD_TARGET_GROUP_ARN \
                    --container-name api \
                    --container-port 8080 \
                    --role ecsServiceRole \
    # will create *ECS Services* from Docker Compose files             
    # ^^^^^^^^ will shut down copies of old containers automatically!!! See screenshotted logs from: https://serradev.wordpress.com/2017/05/11/cluster-of-docker-containers-in-aws-ecs-via-gitlab-pipelines/
    	
    ecs-cli compose --file api/docker-compose.yml service scale 2

### ECS Launch Types

  * EC2 launch type:
  * Fargate launch type

### Declaring resources required by your task

#### Memory

Memory needs declared via on of:

  * Cloudformation task declaration
  * [API](http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html?shortFooter=true#ECS-Type-ContainerDefinition-memoryReservation).


ie  `memoryReservation` is soft limit and `memory` is hard limit.

#### CPU

Declared in one of:

  * CloudFormation task declaration 
  * [CPU](http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html#ECS-Type-ContainerDefinition-cpu)
  
Units formula: `vCPU cores for instance type * 1024`.

So 256 = 1/4th of one CPU core. 1024 = 1 CPU core, etc etc.

### Scaling ECS Clusters

#### Autoscaling

Read blog article: 
  * [AWS Tutorial: (Scaling) Container Instances with Cloudwatch Alerts](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch_alarm_autoscaling.html)
  * [Application Auto Scaling with Amazon ECS](https://stelligent.com/2017/09/26/application-auto-scaling-with-amazon-ecs/)
  * [Scale your cluster automatically](http://garbe.io/blog/2016/10/17/docker-on-ecs-scale-your-ecs-cluster-automatically/)
  * 

#### Deploying a task that will over-subscribe your ECS cluster

(On EC2 cluster type) Deploying a task that requires 2GB memory but your cluster only has 1GB free?

Set your autoscaling group to fire off at say 75% of memory allocated. Thus when you deploy your penultimate service it will say, "Memory utilization high - we only have 70% memory free.". Then auto scale group will add another host to fulfill the auto scale contract.

Thus when you go to deploy your service that requires 2GB of memory, your cluster actually has 3GB - or 9CB - free for usage.


## And Docker Considerations

### docker run --init support

`docker run --init` sets ENTRYPOINT to be a built-in simple INIT scheduler.

Set [InitProcessEnabled](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-taskdefinition-linuxparameters.html)

## And Environmental Variables / Instance Data

### Reading Data (Environmental Variables, instance information, etc) from host <<Learning_AWS_ECS_Host_Environmental_Variables>>

IE if you want to read `HOST`, or `AWS_PROFILE`, or environmental variables you set up while AMI baking

You can - even from inside the container - make a request to the [EC2 Instance Metadata API](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html)

Perhaps even abstracting this call away in some kind of API / `Component` that knows how to trigger itself based on an environmental variable you pass into the Task definition ??

Additional provided metadata comes in via the `userdata` block of creating an EC2 instance. [Bootstrapping Container Instances with EC2 User Data](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/bootstrap_container_instance.html)

## Secrets configuration management

  * [aws-secrets](https://www.promptworks.com/blog/cli-for-managing-secrets-for-amazon-ec2-container-service-based-applications-with-amazon-kms-and-docker)

## And Disk Space / Stateful Services  <<AWS_ECS_Stateful_Services>> <<AWS_ECS_DiskSpace>>

### Disk storage

If your Docker container is not read only - ie it needs to write some kind of temporary data for itself - then you may have disk space considerations.

ECS uses volumes the following way:

  * layers (images, containers) are stored on /dev/xvdcz     <-- aka an extra 22GB(?) EBS vol
  * data written in containers is stored on /dev/xvda  <-- the boot volume, an 8GB(?) volume

See also:

  * [AWS Documentation on ECS storage](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-ami-storage-config.html)
  * [Github bug on aws-ecs-client that TL;DRs this documentation](https://github.com/aws/amazon-ecs-agent/issues/312)

  
## Docker Volume Management

Q: [10 GB limit for Docker volumes on ECS???](https://aws.amazon.com/premiumsupport/knowledge-center/increase-default-ecs-docker-limit/)
