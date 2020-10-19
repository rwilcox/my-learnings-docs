---
path: "/learnings/microservice_the_hard_parts_nfjs_training"
title: "Learnings: Microservices: The Hard Parts (NFJS)"
---

You likely want to couple microservice approaches with Domain Driven Design.

This allows you to control change and ownership

# Dealing with code reuse

Potential ways of dealing with this

## code replication

  * good for static code
  * removes any dependencies between services
  * BUT bad: code changes due to bugs or added functionality
  * difficult to expand
  
## Service consolidation

... just make your microservices bigger if you have some small part of your herd that does the same things

if a change to a microservice ALSO requires a change in 3 other microservices (code changes, deploys) that may mean that you really have one, course grained, microservice

## shared library

  * low code viotility
  * ability to version changes
  * easy to expand (add additional classes)
  * BAD versioning is hard and communicating changes is hard
  * hetrogenous code bases <-- 5 different auth libraries for the 5 different languages you use

thing about larger shared libraries: means every microservice in your herd needs a change, even if it doesn't rely on this

thing about fine grained libraries: now you potentially have a mess for managing and now everyone has to manage potentially (all) of those libraries BUT you have the ability to split out parts so that parts that change often (and _hopefully_ only some of the microservice needs the part that change a lot).

### Best practices / approaches for communicating changes across teams:


teams own a domain, and have a service domain owner architect. (which may also end up caring about a domain AND a some shared libraries across the herd)

From Mark:

  * shared service team likely not great (RW: but, culture...)
  * assign libraries to a sub-team, and give that to the service domain owner / architects
  * use tooling to notify the listeners about a new version of a repo was pushed to the registry so people can listen to those change

#### - [REVIEW]: think about this

developer in team A wants a change. Communicates to their service domain owner, which then goes to the service domain owner for that library, the developers talk, then the change goes out, a new version is pushed to the artifact registry, service owners are notified through that automated notification system, and action happens


### ... how do you communicate the deprecations?

## shared services

  * high code volatility
  * polyglot code
  * BAD versioning is difficult
  * BAD performance issues due to latency, security
  * BAD availability / fault tolerance issue
  * BAD greater chance of breaking things
  
  
# Microservice granularity

## Granulatity drivers

  * service functionality
  * code volatility  <-- maybe one part changes, but the others don't
  * scalability, throughput or mean time to start
  * fault tolerance
  
## Granularity factors

  * database transaction requirements
  * data dependencies
    - if service b and service c need to talk to EACH OTHER AND BACK TO EACH OTHER to complete a customer request
  * the more we have services tied together regardless of protocol, this is not great / introducing less fault tolerance
  * 1:N queries
  * performance due to latency

iterate, look at drivers, map factors, look at dependencies
  
# data sharing

Hmmmmm.... if you know the rules and maybe share a database table, maybe that's a smell that your services might actually be a single microservice that you've gone too far on.


Q that may help: someone who writes the data may actually own it. (This may or may not make it more obvious if you have two people wanting to write it...)

# what is the easiest way to communicate workflow


stamp coupling: returning all the data, but your service really wants JUST that one part of the data

could use a field filter,  <-- still have the contract, you're just not returning all the data

use GraphQL to declare the fields / structure you want. 

# Contracts

clients provide executable code that the services use to create automated tests to make sure if the thing is per _the parts of the specs the client actually use_.

PACT consumer driven contracts.

- [REVIEW]: https://docs.pact.io/


# microservice orchestrator pattern

saga a single state transaction that spans multiple services

# Scenarios

## 1: Dealing with code reuse: where do you put authorization? In a service or a library? (there are some constraints in the workbook)

api layer:

as service:

  * adds 100ms to each request
  * service will run HOT: especially if one request turns into 1:N microservice requests as a single request turns into many requests in the herd
  * but single point
  * doesn't matter languages
  * libraries mean you have a rolling deprecation schedule, not an instant "everyone is using the new thing"
  * .... but you DO have a built in circuit breaker to say Okta if your herd is so busy it starts to DDOS the provider / contract...

  
api library:
  * you only have two languages, potentially (depending on culture) this may be a thing that is constant (or maybe not). If culture has high number of languages, or it's very flexible with introducing new languages, this is hard.
  * reduce latency
  * managing this is the same cost of managing every other library


## 2: Service Granulatity: 4 methods of payment: should create a single payment service or seperate service for each payment type?

my thoughts:

This rings a lot of my message bus / Kafka bells. (Assuming Kafka is an accepted tech in the org). Can create a different messages to microservices, then wait for the join at the orchestrator. (Especially if you have replayability). OR you can wait for N HTTP 200 status codes.
N payment types per order

payment is required to place order

microservices, with message queue at the end so we can join the different results and wait for all the results to get in. (Yes, Kstreams). If no kstreams then have HTTP status codes and all must return 200.

Why: different integrations can be factored out to different teams (doing vendor integration after vendor integration is....... dull)

(although, dealing with partial errors is harder). Either these services need to have rollback functionality or you commuincate the "request $X via METHOD" as a message queue itself, so message can be played back later?

## 3: Service Granularity (Notifications Service)

I would fudge a bit: create a notification service that maybe does SMS and mail (it can hitch a ride), but email is unstable. Create a share nothing email sending service and have the notification service look up the templates in a single db

OR make an "electronic notification" service, and have the letter one be the special one, as it requires CMS.

If you have 
notification service, with email being a slightly seperate service.


# 4: Sharing distributed data (Gift card)

who owns the data:

profile service: this is an attribute of the customer, the customer's balance. Else you have to sum the total of the customer's orders to arrive at the user's s positive balance

Need data a notification (even SQS) to note that a gift card has happened, and the customer profile service can listen to that notification.


# 5: product catalog

use of the services: you want to know how much the shipping will be on an item before you order it ("can I afford this item plus shipping?") and packing is done only on backend when order ends - after all the cart abandonment - so is much less traffic.
  