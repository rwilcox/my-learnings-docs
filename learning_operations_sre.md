---
path: "/learnings/learning_operations_sre"
title: "Learnings: Operations: SRE"
---

# Site Reliability Engineering Highlighted Passages

  * Google places a 50% cap on the aggegate "ops" work for all SREs <-- or "toil", see below
  * If more than 2 events occure regularly per on-call shift, problems can't be investigated througly and engineer are sufficently overwealmed to prevent them from learning from these events
  * Monitoring should never require a human to interprete any part of the alerting domain
  * Thee types of monitoring output:
    - alerts
    - tickets
    - logging
  * MTTR: throughout and recording best practices ahead of time in a 'playbook' produces roughly a 3x improvement in MTTR as compared to the strategy of "winging it"
  * measuring service risk: instead of using metrics around uptime, we define avaiiability in terms of request success rate
  * Many factors to consider when assseing the risk tolerence of services, such as the following
    - what level of availiability is required?
    - do diff types of faiures have diff effects on the service?
    - how can we use the serivce cost to help ocate a service on the risk continuum?
  * target levels of availiability:
    - what level of service will the user expect?
    - does the serice tue directly to revenue (either our revenue or the customer's revenue)?
    - is this a paid service, or is this free?
    - if there are competitors in the marketplace, what level of service do those competitors provide?
    - is this service targetted at consumers, or enterprises?
  * measure typical background error rate of ISPs as failing between 0.01% and 1%
  * error budget thoughts:
    - the main benefit of an error budget is that it provides a common intcentive that allows both product development and SE to focus on finding the right balance between innovation and reliability.
    - this outcome relies on the SRE team having the authority to actually stop launches if the SLO is broken
  * services tend to fall into a few broad categories in terms of the service level indicators they find relevent:
    - user facing services
    - storage systems
    - big data systems
    - all systems should care about correctness
  * service level objectives:
    - start by thinking about what your users care about, not what you can measure
    - the rate at which SLOs are missed is a useful indicator for the user-percieved health of a service
    - defend the SLOs you pick if you can't win a conversation about priorities by quoting a particula SLO, it's probably not worth having that SLO.
    - it's better to choose a loose target that you tighten than to choose an overly strict target that has to be relaxed when you discover it's unattanable.
    - in order to set realistic expectations for your users, you might consider using one of the following tatics:
      - keep a safety margin
      - don't overachive
  * Toil
    - toil is the kind of wor tied to a production system that tends to be manual, repetative, automateable, tactical, devoid of enduring value, and that scales lineraly as a service grows.
    -  work of reducing toil and scaling up services is the "engineering" in SRE: novel and intrinsically requires human judgement. Creates a perminent improvement in your service, and is guided by strategy
  * golden signals:
    - latency
    - traffic
    - errors
    - saturation
  * paging:
    - importantt to think about every page that happens today distracts a human from improving the system for tomorrow
    - conside whether the overall level of paging leads towards a healthy, appropriately availiable system with a healthy, viable team and long term outlook.

  * SRE maslow's pyramid:
    - product
    - development
    - capacity planning
    - testing + release procedures
    - post mortem / root cause analysis
    - incident response
    - monitoring

  * balancing on call:
    - no more than 25% can be spent on call, leaving aother 25% on other types of operational, non proect work
    - thus we can derive that minimum number of engineers needed for an on-call duty from a single-site team is either: assuming week long shifts, each engineer is on call (primary or secondary) for one week a month.

# Inventory / discovery of owners by operators / owner / SRE  <<InventoryOfAssetsAndOwners>>

Identify ownership of:

  * Resource inventory <-- virtual, physical or cloud systems used to deploy an asset. "Who owns or cares about this AWS service?"
  * software inventory <-- in software asset management, especially deployed vendor software
  * deployed microsvices / assets <-- who owns this serice / who can I talk to about this thing?

Concepts from _Principle Based Enterprise Architecture: A systematic approach to enterprise Architecture_


# Failure Recovery

  1. Have you accounted for your services going down? (ie what if your user login service goes down, or your ID generation service??)
  2. Have you accounted for a service calling a service and THAT service fails? Needs to essentially unwind the stack and eventually report some kind of error to the end user
  3. If you stack up events waiting for a service to come back, how to you make sure you don't DDoS OTHER parts of your system when way higher than normal requests come in (as the previously down service comes back online)??
  
### Retries in the time of failure

  1. What happens when you try, have to do a re-try, but then the system gets around to handling your original request?
    ie: are your services idempotent enough?? See LanguageOfTheSystem
