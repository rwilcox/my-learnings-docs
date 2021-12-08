---
path: /learnings/ops_pets_not_cattle
title: 'Learnings: Ops: Pets Not Cattle (Thoughts)'
---
# <<Pets_Not_Cattle_Container_Instances>>

[History of Pets vs Cattle](https://cloudscaling.com/blog/cloud-computing/the-history-of-pets-vs-cattle/)
 
Provisioned VMs or Container instances (really doesn't matter) should be able to be shot in the head and immediately replaced.

They are cattle you manage, not pets you care about.

This can be automatically, or just someone doing it manually.

## But... <<Pets_Not_Cattle_Service_Debugging_Questions_Strategy>>

We want to be able to take time to examine an ill service / container. Maybe even a 5 minute eval, that asks the following questions

  * Is this somewhere where we'll ever know what happened, or is it just a box making random trouble?
  * Does this problem point to a place where we can grab a quick win and improve software quality - or apply automation - or does it not matter? (A fix that takes 2 hours that only saves 10 minutes a year is not worth doing...)
  * Is this a place where we have tech debt or non-cloud-native approach to something and the time's finally come for that tech debt to be paid?
  * Is this just one cattle getting sick, or is this a warning side of an epidemic that could affect all the containers?  
  * are we missing a tool? (ie a daemon that automatically increases disk space on an instance then sends an email out for people to audit during normal business hours?)
  
### Example:

If your containers only last for 4 hours, or 5 minutes, before they die for reasons, you want to make sure you can debug that reason - maybe making a single cattle a pet for a debugging session - to understand what's going on.

In this case it doesn't matter than you can spin up a new container automatically in 1 minute - something's wrong with your herd.

So, you may not want your container scheduler to kill a sick instance. You may want to just remove that instance from the load balancer (or be weighted to get an arbitrary maybe 0 amount of traffic), then give it a checkup.


## TL;DR

<<Pets_Not_Cattle_Epidemics>>

Pets vs Cattle, sure, but a cattleman watches for epidemics that could / do affect their entire herd.
