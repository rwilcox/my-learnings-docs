# Microservices and SRE organization

> every microservice at Uber, we said, should be stable, reliable, scalable, fault tolerant, performant, monitored, documented, and prepared for any catastrophe
- S.Fowler

You may want to make these quantitative measurements somehow, perhaps with a rubric

The configurstion for a service just live with a service, allowing engineers to make configurstion changes to a layer below where they live (or configure their need for a redis server, or make sure a security cert is generated), without risking making a production wide change in a part of the systems they don't know about (or: "oh sure just go fuck with the central chef cookbooks...").

## on call incidents 

Stages of incident response:

  1. asses
  2. coordinate 
  3. mitigate
  4. Resolve
  5. follow up

# Distributed systems

## and root cause

- [BOOKQUOTE]: DevOps and Finance

> I said we need to get to the “root causes” here. Because (back to Allspaw again, from his 2011 Velocity presentation “Advanced PostMortem Fu and Human Error 101”):
>
>> There is no such thing as a root cause for any given incident in complex systems. It’s more like a coincidence of several things that make a failure happen.
>
>>    In hindsight, there often seems to be a single action that would have prevented the incident to happen. This one thing is searched for by managers when they do a root cause analysis. They hope to be able to prevent this incident from ever happening again. But if the incident was possible due to the coincidence of many events, it makes no sense to search for a singular root cause. This would lead to a false sense of security, as in a complex system there are too many ways an incident can possibly happen

# See also

  * DevOps_Thoughts_SRE_Team
