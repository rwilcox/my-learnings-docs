---
path: "/learnings/operations_microservices"
title: "Learnings: Operations: Microservices"
---


# what Microservices requires from organization

> In well-designed, sustainable microservice ecosystems, the microservices are abstracted away from all infrastructure. They are abstracted away from the hardware, abstracted away from the networks, abstracted away from the build and deployment pipeline, abstracted away from service discovery and load balancing. 

- S.Folwer

## culture of controlling the code review of all the Microservices

> Putting good code review procedures into place, and creating an engineering culture where both code review is taken seriously and developers are given adequate time to focus on reviewing their teammates’ code is the first step toward avoiding these kinds of failures
- S. Folwer

-[REVIEW]: Think about this when a team of 7 is responsible for 3- or 10 or 24 services

## on call policies to prevent burnout of development staff 

Ie 2 person on at all time, no more than a week, maybe force off people with high anxiety states.

Or work towards reducing alertinoe toil for on call / reduce flow breaking alerts for dumb stuff

   
# Well how many requests a second does it need?

## qualitative growth metrics 

Business growth of a segment of your business will drive use of the Microservice swarm serving that business need.

Your esports division starting to take off, or launch? Business growth of that market (or if you know there's an ad push coming, or we can forecast based on a BA's up-and-to-the-right  graph).

Aka: what's the growth of the overall product, and what will they mean for traffic for your service?

## quantitative growth metrics
Hardware requirements AND software  arch decisions are dependant in this number

Hoe do you determine it? Questions to answer:
  * What are the upstream clients on this service? One request per user serving? Ten requests per user serving? One request every time a user opens the app (ie it's not optional that a user hits that service). one request a sign up? What's the metrics for upstream clients or demands/SLAs for existing downstream services
  
  or maybe upstream services are not often used - ie for business partners vs consumers users of your site.
  
  But also informed by the qualitative metric considerations above.
  
## and how much can one instance do?

How much traffic can a single deploy of your service handle? Whst's it's min memory requirementss?

How many opportunities dies your service have for scaling? Will just throwing an ELB in front of it work, or do you need to architect your larger Microservice so you can split apart the tire raft into multiple Microservices joined together with a messaging bus? Or ie Kafka consumer groups?

What is the scaling velocity of the service? Ie after 5,000 requests / 5 instances of the app we find we're overheating Mongo and need to add a new replica to *that*. / pure horizontal scaling or does it need to be scaled vertically?

## another word for this activity: value stream mapping [arcitecture diagram]

> Value stream mapping [in dev, artitecture diagram] helps gain a big picture idea of how a patient goes through the hospital from the first phone call to discharge. It can also help map out processes of employees. Simply stated, a value stream map is a visual representation of all the activities in a process from start to the end, for what is generally called a product family. The director helps create value stream maps, which are used to identify defects or waste for improvement at the unit level. For example, think of a patient that presents to the clinic for a routine physical. From the time that the patient walks in the door and is greeted by the registrar to the time the patient walks out the door with their new plan of care is an entire product family. Each step in that process, including making the appointment, insurance verification, health care questionnaire and paperwork, rooming, physician exam, ordering lab tests, and completion of the visit, is mapped to identify both value and nonvalue-added components.6 Nonvalue-added components are those that do not improve value for the patient.

- Quality Managment in a lean health care organization

Refactor non value add steps out !!!

# SLA /

SLA of your application code is affected by downstream services if you're not careful. Or a dependant Microservice is actually up only 89% of the time, if you naively call that device then your error budget is dependant on theirs.
- S.Fowler
 

# [Microservices Architecture](https://www.youtube.com/watch?v=2rKEveL55TY)  <<Microservices_Architecture_TalkVideoNotes>>
============

Bayes-ian Microservice Rules:

  1. You can run two versions of the same service at the same time
  2. Only one service per deployment

Services becomes disposable (!!!)

events are more important than entities (????)

Principals of microservices:

  1. AS SMALL AS POSSIBLE!!! IDEALLY ~< 100 LoC
  2. multiple versions acceptable
  3. self exaluation monitoring of each service
  4. Publish "interesting" data - if your service thinks it's interesting publish it
  5. "old" service tends to be 6 months old, even on "applications" that have been up for 2+ years
  6. Accept you can't test / understand the system, write tests around business metrics
  
THeory: we plan for applications to be around for 10 years, in practice they're usually around for 17

Systems communication via pub-sub

# arch patterns for resilient distributed systems (video / conference talk I watched)

From medical industry: safety critical systems always operating on edge of failure (as you're maximizing your resources!): cook and Rasmussen 

Engineering resistance requires a model of safety based on mentoring, responding adapting and learning

Buile suyport for contious mainatince; reveal control of system to operotors
know it’s goitg to get used in woys you didin’&0t intend
thinx obout configuration as interfaces

mvp needs to include metrics and monitoring from thE ops sid

Key insighto from google’s chubby paper: engineers don’t plan for avail, concensesus, prumary elections, fIlures, their own bugs OR the future. They olso don’T understand distributed systems

Unknown unknows: prevented by cognitive diversity: it may be unxnown to you but someone with more or different experience may know that there’s a problem: reducing yoer unknowns!!!

Optimization a can also make less redundant
Rank your services on what can be dropped, killed or deferred
Need to iron out your release process: or else you just are making chaos 
Alerts need to link to something actionable!!!! 
Standards in interfaces are a good thing (esp configurations!)

# Netflix and availability (coneference video I watched)

With heartbeat: with network partitions then that makes it a local thing:  can your current mode see that instance? Maybe the network  has partitioned in such a way the service discovery machine can see the instance but your calling instance can not

OR your network has portioned in such a way that ONE of your service discovery nodes has partitions from your instances and replicates the bad data - and incorrectly missing nodes - across your service discovery workers... So now all your instances are "down" even though they are up

Availibility  is doubtful: but unavailability is the sure thing

Also: paranoid question: what happens if services discovery is unavailable???
     If unavailable only: then you wouldn't know about new nodes, but you would know about the availiable ones..... 
     
Service discovery has STRONG availability requirements!!! But you still have to pay the CAP therum!!!!
In most cases choosing A > C for service discovery is correct

Can we create a  coorientation free service discovery???:
   * use a connection oriented ordered and reliable protocol.. For the whole lifecycle of the instance(s)!!!
   * would need to send heartbeats from both directions....
   * the connection will break.. but so go ahead and establish a new connection, although your new connection may be to another machine. So you might have some conflicts
   * conflict resolution
   * we know that in general all instances usually don't fail together... - jus this worker is wrong
   
   V2 of Netflix Eureka does all this!!!
   
