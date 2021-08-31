---
path: "/synthesis/microservices_in_the_enterprise"
title: "Synthesis: Microservices: In The Enterprise"
---

# (Potential) Source Material

| Book Name                                                        | Read | Notes Extracted | Additional Notes                       |
|------------------------------------------------------------------|------|-----------------|----------------------------------------|
| omplex application architecture                                  | Y    | N               | in `Goodreader/Project_Related`        |
| Microservice Patterns                                            | Y    | N               |
| Driving Technical Change                                         | Y    |                 |
| Elastic Leadership: Growing self organizing teams                |      |                 |
| Architeting for Scale                                            |      |                 |
| Microservices for the Enterprise                                 |      |                 |
| Enterprise API Management                                        |      |                 |
| Software Design X-Rays                                           | Y    |                 | Safari
| An Executives Guide to software quality in an Agile organization | Y    | N               |
| Cloud Native Transformation                                      |  y   |                 |
| microservices in action                                          | Y    | N               |
| Reinventing the Organization                                     | Y    | N               |
| Microservice Architecture                                        | Y    | N               |
| Advaned Microservices                                            |      |                 |
| Complete Application Architecture                                |      |                 |
| Tao of Microservices                                             |      |                 |
| Patterns for decentralized Organization                          |      |                 | in `GoodReader/Technical_Leadership`  |
| The Digital Transformation Playbook                              | Y    | N               | Kindle
| The Tecnology Fallicy                                            |      |                 |
| Software Engineering at Google                                   | Y    |                 | Safari




# Driving Tech / Tools

## Starter Kit

- [BOOKNOTE]: On starter kit
> This cloud native “starter kit” of materials should include tool configurations, version-control repository, CI/CD pipelines, example applications for practice, target platform description, trainings,
- From Cloud Native Transformation


# Leadership

Problem statement: you have a project composed of many indivudally maintained serices, across many sub-teams. (Because each microservice is so small maybe each team has 6, or maybe it's a serverless architecture).

So you potentially have lots of litle programs maintained by "lots" of small little teams. See Managing_Agile_Team_Size

How do you handle the following patterns

## setting the standards

At the beginning what languages do you support? Do you have teams already to go or do you have a time where you can scale from 1-MANY?


## developer starter kit

Do you need to update a microservice’s developer starter kit?

How do you distribute this?

## Knowledge share of common tools / frameworks



## avoid / mitigating a bit Conway’a law


## How do you keep everything up to date with the latest third party dependencies?

## Do you know the characteristics of the microserice herd?

## architecture across the herd (?)

### Q: how does your team or sub-teams interact with other parts of the enterprise? (Likewise how do they interact with you?)

(Aka: so you have SMAs our solution architects or )

# About Plans <<Technical_Leadership_Plans_In_Enterprise>>

Characteristics of good plans:

  * obvious next actions for teams
  * clear
  * not a draft, or a _plan_ to make a plan
  * business value is clear (even if this is "faster features" or "better security".... but hopefully not too often)

## Required changes

Do you have a process for rolling out a manditory change ALONG A TIMELINE. Like:

  * a microsevice API is going away or changing API formats
  * language updates <-- ie how would you enforce the herd to get off Python 2-> 3? Java 1.7 -> 1.8
  * changes to Dockerfiles or DevOps configurations


## campaigns to reduce toil

How do you have the larger team’a behavior/ "you used to do a workflow this way, now you do this one thing once and do half the steps"

## New Patterns / best practices recommendations / architectural plans

How do you propegate patterns that aren't required but that help the teams, that are an evolution from what currently exists?

OR are things like, "We're going to make it obvious that business can easily have THIS feature." Like the enterprise has the technical infrastructure laid down for business metrics gathering, there is easy developer support for the thing... the business leaders just need to make user stories that use this new ability in business relevant places.

These plans are - from the architect mindset - optional ("use this to help your users, or if you don't have a business use case I don't care") AND don't have a deadline BUT are of course clear and have obvious next steps etc

# Ownership

Knowing ownership up front is good for when the pager goes off or Ops wants to have a talk with you :)

Ownership problems:

  1. What if team moves on to other responsibilites? Do they also take along their previous baggage (survey says: probably not)
  2. What if they are disbanded or layed off?
  3. What if they are so good at their jobs the number of microservices they own. Hopefully the older ones will be more stable than labile, so that the team can continue to function without have to accumulate bandwidth(team members?) at the same rate that it accumulates services...
