---
path: "/learnings/domain_driven_design"
title: "Learnings: Domain Driven Design"
---

DDD tactical patterns: Aggregates, Services, Value Objects, Events Domains, Subdomains, Bounded Contexts

# Bounded Contexts <<Learning_DDD_Bounded_Context>>

An explicit boundary within which a domain model exists.

Is often the case that two different domain models include same terms. Place a bounded context to isolate different responsibilities of that same object. (User, or Account, may be used in different contexts in different models or in different parts of the workflow: an unverified account, to an account where there's some kind of partner or B2B relationship, to an account story of a shipment that went good/bad/ugly.

Embrace the fact that differences always exist and apply Bounded Contexts to separately delineate each domain model where differences are explicit and well understood.

Q: How large is a Bounded Context? Large enough to only capture the complete Ubiquitous Language of the isolated business domain, and no larger.

Contains: Modules, Aggregates, Events, Services

Only single team should work on a bounded context (ie don't try to split the bounded context up across two teams)

# Domains


Generic Subdomain: captures nothing special to the business but is required for the overall business solution

Supporting subdomain: 

Ideally want to align subdomains with bounded contexts


## problem space

parts that need to be developed to deliver a new core domain. Examining subdomains that already exist and ones that are needed.

### steering questions

  1. What is the name and vision of the strategic Core domain?
  2. What concepts should be considered part of the strategic core domain?
  3. What are the necessary Supporting subdomains and the generic subdomains?
  4. Who should do the work in each area of the domain?
  5. Can the right teams by assembled?

## solution space

one or more bounded contexts, a set of specific software models. Solution spaces are specific solutions to the problem ... space.

maybe problem space of the domain is "login / auth" and the solution space is, "just use Facebook for now". But the solution to this problem (vendor!) is seperate from finding that you have a problem in the first place (login).

### steering questions

  1. What software already exists, and can it be reused?
  2. What assets need to be acquired or created?
  3. How are all of these connected to each other, or integrated?
  4. What additional integrations will be needed?
  5. Given the existing assets and those that need to be created, what is the required effort?
  6. do the strategic intitiative and all supporting projects have a high probability of success, or will any one of them cause the overall program to be delayed or fail?
  7. What are the terms of the Ubiquitous Languages involved completely different?
  8. Where is there overlap and sharing of concepts and data between bounded contexts?
  9. How are shared teams and/or overlapping concepts mapped and translated between Bounded Contexts?
  10. Which bounded context contains the concepts that address the core domain and which of the tactical patterns will be used to model it?
  - Implementing domain-driven design
