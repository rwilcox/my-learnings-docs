#lang scribble/text
@(require "scribble-utils.rkt")

---
path: "/synthesis/technical_leadership"
title: "Synthesis:Technical Leadership"
---

# Table Of Contents

<!-- toc -->


# Managing Smart People

  * leadership based on perception: knows what to do, tells others
  * leadership based on ??? servant-leadership??:  take recommendations from those that know more, make decision, get out of Do-ers way

Problem with Problem Statements:

Are they really _problem statements_, or is it a _prescription_ statement?

# types of technical leadership

## technical leadership but you’re also a people manager ("officer")

### of 1-2 direct reports

### 3-4 direct reports

My advice here: also take a Technical person to be your trusted "get it done with the boots on thr ground" operator

But NOTE: this person still counts against your max network cap!!

### 6-7-+ direct reports

Read a leadership book. .

split your reports in a couple different areas

Try not to touch code (??)  too often

### 10+ directs

Create middle managers to get the number of your directs - including technical leaders that report to you - down to ~ 7. (Maybe factoring in potential growth of your  part of org/team, or potential contraction, )

At this point the network connections will start to bite
## technical leadership, you don’t have much technical skills, but the people you lead / manage have them


## technical leadership and you have no direct reports ("enlisted man")


### 3-4 reports in a tight group / sub team. You’re the tech lead for a small team or potentially sub team of a larger effort

### 4-6 reports in a tight group / sub team.

### across two teams

"I’m the interface between this team and the DevOps team”, (yes yes we’re all DevOps, but if you’re in a large enterprise I’m sure you have a DevOps team - it’a a common  cultural (mis)-implementation)

### across 4-6 teams

Even at this point, what is your role? See SDLC_Roles

### across 7 plus teams

### See also

  * Technical_Leadership_Plans_In_Enterprise

# SDLC ROLES <<SDLC_Roles>>

- [BOOKQUOTE]:
>
>Enterprise architects are assumed to be responsible for the enterprise, while technical architects are assumed to be responsible for the architecture of specific assets and engineering functions. Solution architects are presumed to handle the architecture of end-to-end solutions aligned either to products or business capabilities or both. These are role descriptions not job descriptions, which implies that a single individual may perform multiple roles.

- Principle Based Enterprise Architecture

# Types of SLA
- [ BOOKQUOTE]:
> availability simply means that the system is “up” and capable of handling end-user requests, while reliability includes factors like low error rates and ensuring data is not stale

- Principle Based Enterprise Architecture

# SDLC and business partners

@quote-highlight[
	#:title       "IT Enabled Business Change"
	#:author      "Dr. Sharm Manwani"
	#:page-number 14
	#:url         "https://learning.oreilly.com/library/view/it-enabled-business-change/9781902505916/9781902505916_ch02_sec01_02.html"]{
  1. Align business and IT goals
  2. Define business improvement
  3. Design Business Change
   4.Implement business change
   5.Deliver business benefits}


# Flowing Goals down

as you scale up both the number of
people and the technical spread of the services is that you will not longer
be able to keep tight enforcement on where all of the teams are. That's OK
though as it is somewhat the point of Microservices. What I see working
instead is the admiral-level view of the battlefield where you set
strategy and guidelines - then you use different means to ensure compliance
with those targets.

- A T H

## Q: How much control after all??

@quote-highlight[
	#:title       "Fundamentals of Software Architecture"
	#:author      "Mark Richards, Neal Ford"
	#:page-number 22
	#:url         "https://learning.oreilly.com/library/view/fundamentals-of-software/9781492043447/ch22.html"]{
* Team familiarity
How well do the team members know each other? Have they worked together before on a project? Generally, the better team members know each other, the less control is needed because team members start to become self-organizing.
  * Team size
How big is the team? (We consider more than 12 developers on the same team to be a big team, and 4 or fewer to be a small team.) The larger the team, the more control is needed
  * Overall experience
How many team members are senior? How many are junior? Is it a mixed team of junior and senior developers? How well do they know the technology and business domain? Teams with lots of junior developers require more control and mentoring, whereas teams with more senior developers require less control
  * Project complexity
Is the project highly complex or just a simple website? Highly complex projects require the architect to be more available to the team and to assist with issues that arise, hence more control is needed on the team. Relatively simple projects are straightforward and hence do not require much control.

  * Project duration
Is the project short (two months), long (two years), or average duration (six months)? The shorter the duration, the less control is needed; conversely, the longer the project, the more control is needed.}

## your area of responsibility

Are you leading a single sub team?
Leading A technical team responsible for a single end user product, but with many sub teams?
 responsible for coordinating two projects projects worth many sub teams?
A technical coordinating many / all the projects around the enterprise

This depends on how controlly you can get, and how "admiral Kirk" vs "Grand Moff Tarkin" you have to be

### see also

## pro tips

### pie in the sky goals are good, and also try to measure them

"10x faster software development" is a great goal... but in what ways? Else people will just complain that the goal is never met, even if things are objectively better / faster ("why are we not a faster feature factory?" "Because that’a not what it means...."

### Don't have too many people where you can't listen to them

Having too many people means you can't gather feedback from them as often as you should be able to. And you can't run your decisions past them to make sure you're not swooping in, dumping poop on them, and then swooping out.

### Gather people that know things you don't

You don't need to:
  * command and control
  * know everything <-- lean on people that have more experience (either tech wise OR in the culture/company!!) than you do

## Principals
- [BOOKQUOTE]:
>Principles are the architecture mission statements of what we want to achieve for end users and are not limited to a single division or product.

- Principle Based Enterprise Architecture

### has many golden rules

- [BOOKQUOTE]:
> which define how to achieve the mission, and the consequences of deviation. Golden rules read like the requirements statements for meeting the mission statement of the principles.

- Principle Based Enterprise Architecture

#### has a set of stories / epic

#### has many body of evidence stories of why you want to follow it

#### has measures / acceptance criteria about if the rule has been followed

# importance of asset owners

- [BOOKQUOTE]:
> The asset owner is responsible and accountable for all aspects of the asset lifecycle from ideation to operations. They may depend on others for services, but if the asset fails to meet its SLA, it’s the asset owner’s responsibility to fix it. If the asset goes down at 3 AM, it’s the asset owner’s responsibility, even if it was the disk array that failed, and the disk array has to be fixed by an operations group that does not directly report to the asset owner.

- Principle Based Enterprise Architecture

Asset owner (microservice group) needs to know who to call when some dep service goes down - they should act like the contact point because abstraction.

In product organizations this may be the product owner???? (This May or May not be a good idea...)

# See also

  * ArchitectureAgileSecurityModel

# MOI model of leadership

@quote-highlight[
	#:title       "Becoming a technical leader"
	#:author      "Gerald Weinburg"
	#:page-number 412
	#:url         "https://www.amazon.com/Becoming-Technical-Leader-Gerald-Weinberg-ebook/dp/B004J4VV3I/ref=sr_1_1?crid=FHTWINGGX9HB&dchild=1&keywords=becoming+a+technical+leader&qid=1597625292&sprefix=becoming+a+techical+leader%2Caps%2C668&sr=8-1"]{MOI model of leadership

  * M: motivation
  * O: organization
   * ideas / innovation}


# - [ BOOKQUOTE]: misc leaderahip

first job: esablizh a comfortzbld environment, which means geftinf acquanted with fhr new job, and particularly doing things that give both parties a chance to devvdlop trust for each other

# -[BOOKQUOTE]: Leadership time sucks

  1. Don't redo the work you're assigned to others-(or others have done in the past? - RW)
  2. Avoid technical arguments to prove your technical superiority
  3. Choose your prirotiries and don't wait for a crisis to organize your activities

## Make more time in the day

  1. avoid administration
  2. don't waste time trying to prove competence
  3. Don't waste time arguing about wasting time
  4. Pay attention to what you do when there's nothing to do
  5. Get at least 2 for the price of one
  6. Act as a review leader
  7. Act as an editor
  8. Be a tutor
  9. Let other people show you how smart they ae

# Managing flow of ideas

@quote-highlight[
	#:title       "Becoming a technical leader"
	#:author      "Gerald Weinburg"
	#:page-number 1624
	#:url         "https://www.amazon.com/Becoming-Technical-Leader-Gerald-Weinberg-ebook/dp/B004J4VV3I/ref=sr_1_1?crid=FHTWINGGX9HB&dchild=1&keywords=becoming+a+technical+leader&qid=1597625292&sprefix=becoming+a+techical+leader%2Caps%2C668&sr=8-1"]{managing flow of ideas

  * contribute a clever idea to the team
  * encouraging copying of useful ideas
  * elaborate on ideas that teammates contributed
  * drop ones own idea in favor of an idea that someone wants to develop
  * refuse to let an idea drop before everyone understands it
  * resist time pressure and take time to listen when other people explain their ideas
  * test ideas contributed by other people
  * withhold quick critics of teammates ideas in order to keep the ideas flowing
  * when crisising an idea make sure you are clear you are critiquing thr idea not the person
  * test your own ideas before offering them
  * when time and labor are short stop working on new ideas and just pitch in
  * encourage team to drop ideas that succeeded earlier but will not any longer because of change
  * revive a dropped idea when it will now work because of change
  * does the idea add to, reduce, or keep the same the amount of toil on the project? (Can it be refined to be automatable? But sure, simple things that don’t scale have a place too... just maybe not if you’be scaled) (-RW)
  * is it an idea that didn’t use to work, but now can? (-RW)}

# lessons form a task oriented style

@quote-highlight[
	#:title       "Becoming a technical leader"
	#:author      "Gerald Weinburg"
	#:page-number 1624
	#:url         "https://www.amazon.com/Becoming-Technical-Leader-Gerald-Weinberg-ebook/dp/B004J4VV3I/ref=sr_1_1?crid=FHTWINGGX9HB&dchild=1&keywords=becoming+a+technical+leader&qid=1597625292&sprefix=becoming+a+techical+leader%2Caps%2C668&sr=8-1"]{lessons form a task oriented style:

  1. when survival is concerned, there is no choice but to put people first
  2. if the job isn’t highly technical, the leader need not be competent, but can lead by fear
  3. people with strong technical backgrounds can convert any task into a technical task, thus avoiding doing work they don’t want to know
  4. leaders wh don’t care about people don’t have anyone to lead, unless their followers don’t have a choice
  5. no amount of caring for people will hold your audience if you have nothing to offer but pretend you do
  6. task oriented leaders tend to overestimate their own accomplishments
  7. very little work we do is really so important that it justifies sacrificing the future possibilities of the people doing the work
  8. when the work is complete, no leader can be absolutely sure that plans won’t go "aft algey”
  9. to be a successful problem solving leader, yoloorvqnizationi u fmust keep everyone’s humanness at the fore
  10. If you are a leader, the people are your work. there is no other work worth doing.}

@quote-highlight[
	#:title       "Becoming a technical leader"
	#:author      "Gerald Weinburg"
	#:page-number 2729]{three essential fucnctions of a problem solving leadership:
  1. defininv the problem
  2. managing the flow of ideas
  3. controllng the quality}


# leadership considerations

  * give your underlings leverage to affect change on the ground / take ownership of a thing
  * ^^^^ if you have done that consult with them before making decisions that affect these parts.  (If you do not your decisions likely won’t make sense / may be more of a change of direction than you thought)
  * include your enlisted men of rank, in addition to your officers, in your staff meetings
   * start with and prefer (although you may not be able to, given team culuture and maturity level) simple to inplemement ideas you can iterate on and replace later (use rapid experimentation ideas)
   * can YOU look up the answers to questions you want? Or, when pointed in the right direction, can you answer your own questions yourself?
   * ask specific questions with clear next action, to your people for best answers
   * tell them what you’re going to tell them, tell them, then tell them what you told them
   * empower them; ensure they are actually empowered; make sure they stay empowered; increase empowerment
   * ask questions, learn what it’a actually like for boots on the ground

## Management and technical leadership should be seperate

your manager likely can not be a tech lead. Your tech lead likely can not be a manager. Or at least for long or for scale.
Why? Both different temperment job AND those are both full time jobs at scale.
