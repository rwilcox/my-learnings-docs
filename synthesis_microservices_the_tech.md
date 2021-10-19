---
path: /synthesis/microservices_the_tech
title: 'Synthesis: Microservices: The Tech'
---
# Problems with microservices

## Service Discovery

Service Discovery with cheap instances:

  * [Consul](https://www.consul.io/)
  
## Service Discovery BY HUMANS!!!!!

Need to answer questions:

  1. Is there an API that already does what I want?
  2. What is the team responsible for the API? Standard way for Ops / Monitoring to identify this
  3. Who is using my API so I know who to tell I'm depreciating it?
  4. standard way to document request params + responses of hese APIs (random Word documents that may or may not be on the wiki!= discoverable documentation!)
  5. What team do I call for support / how do I page them when their shit is broken?


<<ServiceDiscovery_Onboarding_New_Employees>>

  * "Welcome Mat" for new employees <-- includes pointer to the service discovery document

## Service Deployment

Don't want a dozen teams deploying their own systems their own way (some will suck). Provide PaaS for microservice deployment with standard quality of service practices.  

Provide a very enticing golden path for teams to push to operationalized services. (But know that some can't walk down that path)
  
### Mean time to new service deployment

you need to provide a rapid, golden path for deploying applications that a team can use to deploy an app quickly.
This number needs to go down until it's as close to 0 as possible.

One way monolyths grow: when getting a servicer instance to split this thing into two services is EXPENSIVE.
(ie if it takes 4 months to deploy a server, fuck yeah I'll shove everything into one app)

# points

## Use patterns you have already drilled

/ build on existing patterns

Fractals are cool

## sometimes: shut up and hear how things are really being run






