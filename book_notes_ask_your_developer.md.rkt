#lang scribble/text
@(require "scribble-utils.rkt")

---
path: "/book_notes/ask_your_developer"
title: "Book Notes: Ask Your Developer"
---

@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
        #:is-book?     't
	#:page-number 39 ]{Once you've divided and subdivided the business into small teams that specialize in particular areas, offering microservices for each other to use, with well documented interfaces and pricing that represents the true costs of delivering those services - well, why develop all those microservices internally? Why develop your own development to microservices that you coud instead buy from other companies?

... So your developers start plugging in pieces from specialist provides, and boom - you have a software supply chain.}

@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 119]{

But running experiments doesn't work unless you're able to follow up with the winners in a meaningful way. At Twillio we've made this mistake before. We've started an experiment and seen it succeed, only to keep considering it an experiment for too long, and not give it the funding to explode like the market wanted it to. We didn't properly water the sapling...

You should remember to hold back resources to give needed rocket boosters to the winning experiments.}

@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 119]{
During the rapid iteration phase of an experiment, it's useful to check in with the team on a weekly, or  perhaps biweekly, basis to help guide the experiment based on the rapid pace of learning.}

@quote-note[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 127
	#:original-highlight "Therefor, why not take as many swings [experiments] as you can?"]{You don't want an R&D department, you want a (department??) that ensures all teams **can** do R&D:

  * cultural enablement
  * tech enablement (<-- not "to deploy this requires 10 sprints and two approval boards")
  * tech leadership enablement
  * sprint time
  * platform recognition (?)}

@quote-note[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 127
	#:original-highlight "Therefor, why not take as many swings [experiments] as you can?"]{"DevOps isn't a role, it's a mindset" yet every company creates a DevOps team or a DevOps center of excellence.... (R&D isn't a department either...)}

@quote-note[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 132
	#:original-highlight "[You need] autonomy, mastery, purpose [and ability]"]{Ability: too many gates or knowledge explosion to release an experiment (or never getting autonomy beyond "things PO's don't care about").

Potentially part of autonomy, but theoretical & practical autonomy == very different.}

@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 136]{"How are you doing to give developers autonomy to create software when you don't even trust them to change the channel on a TV?"}

@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 139]{Kaya was seeking mastery. The very best developers, young or otherwise, are always hoping to be pushed, to learn, and to grow. They want to get better at what they do, and to find mentors that will help them develop}


@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 157]{[on running open project reviews] To keep the meeting from devolving into chaos, only a few essential people are given permission to speak, which Chris calls the "read/write permission". Everyone else is considered read only, and can just observe. Once in a while, a "read only" attendee might ask for "read/write" permission to ask a question or contribute an idea.

The "read only" policy represents a bif part of the open, learning environment, a way for everyone in the company to learn from others but still have a functioning meeting.

The goal is to address one of the shortcomings of "two pizza team" approach, which is that when you have a large number of small teams (our product side alone has 150 teams) they all start to run a thousand different directions and it can be difficult for any single team to know what the others are doing. But some inititives require multiple small teams to contribute code. Each team often has dependencies on other teams. So they need to keep tabs on each other. The OPR approach lets teams get a quick check-in on other teams and stay up to date with what they're doing.}

@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 169]{But I believe the most valuable form of leadership is by doing, and that's up to leaders to let their people run things. Look for projects where the stakes are low, where a leader-in-training can screw up a few non-critical things without doing much harm and become a better leader in the process.}

@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 192]{
[The RAPID framework for making decisions] created as a tool by Bain to clarify decisions (accountablility) assigning roles to five key roles in any decision (Recommend, Agree, Perform, Input, Decide).

... efficacy breaks down when there's this other, silent role in it - V (Veto)}

@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 195]{A typical thing for companies to say is, "Ok, you have a business unit here, and then we have an engineering team in the company here, and they have an interface" - the "interface" he's skeptical of refers to Product Requirements Document (PRD). Documents (PRDs), Kanban tasks, or other systems of work of throwing work over the wall.}

@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 248]{
At Facebook, as at many companies, it's common to spend upwards of 30 percent, and many times north of 50 percent, of the total development budget on infrastructure and platforms.}

@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 254]{So Jason and his team created a checklist of best practices called the Operational Maturity Model (OMM). It consists of six categories of excellence: documentation, security, supportablity, resiliency, testability, and privacy.}

@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 262]{This may be part of why I'm often asked how we prevent duplicative work in our small, empowered teams culture. My answer is: we don't.

... Perfect synchronization necessarily removes autonomy and accountability.}

@quote-highlight[
	#:title       "Ask Your Developer"
	#:author      "Lawson"
	#:page-number 266]{"Platforms are a force multiplier", Jason says. "It's like a fulcrum. For every dollar I put in I can return five dollars."

... Instead of [a service taking 40 days to develop+deploy] Instead Jason grabbed two platform engineers, and they automated a bunch of steps in our deployment process. Their work slashed development time in half - from 40 days to 20 days.}
