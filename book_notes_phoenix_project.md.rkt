#lang scribble/text
@(require "scribble-utils.rkt")

---
path: "/book_notes/phoenix_project"
title: "Book Notes: Phoenix Project"
---

# Table Of Contents

<!-- toc -->

# On Management

  * removing barriers that rob people of pride of ownership (see Deming, _Out Of The Crisis_ page 77)

## And Risk Management

## By Firefighting

if everything is a high priority management screaming email then (a) nothing is a priority and (b) PROBLEMS.

### See also

  * Youdon, _Death March_ p 192: Risk Management

## See also

  * Deming, _Out Of The Crisis_, Chapter 5: How to Help Managers
  * Juran, _Juran On Quality_, p152: Thoughts on measuring mananger's performance

# On Brent

  * Bus Factor!
  * Free Electron. See Lopp's _Managing Humans_ p167, OrganizationalThoughts__FreeRadicals
  * Knowledge Kingdom Builder (?)
  * "10x" developer
  * Work in Progress Constraint
  * Star Worker: see DeMarco's _Slack_ page 106

# On Process / Work

## On constraints

@quote-highlight[
	#:title       "The Pheonix Project"
	#:author      "Kim, Behr, Spafford"
	#:page-number 71]{How can we manage production if we don't know what the demand, priorities, status of work in process, and resource availability are?}

## On mananging constraints <<Book_Notes_Phoenix_Constraints>>

@quote-highlight[
	#:title       "The Pheonix Project"
	#:author      "Kim, Behr, Spafford"
	#:page-number 162]{There is a very small number of resources (people, machines or materials) that dictate the output of the entire system.

  1. Identify the constraint
  2. Exploit the constraint (make sure that your constraint is now allowed to waste any time)
  3. Subordinate the constraint (_Theory of Constraints_)}

### See also

  * Deming, _Out Of Crisis_, page 339 : On Capacity Planning
  * Manufacturing Production Control Departments

## On a "Change"

@quote-highlight[
	#:title       "The Pheonix Project"
	#:author      "Kim, Behr, Spafford"
	#:page-number 81]{a 'change' is any activity that is physical, logical or virtual to applications, databases, OSes, networks, or hardware that could impact services being delivered.}

Also should only go _one_ way (towards Prod, not down from it!!!)!


## On "IT Operations"

@quote-highlight[
	#:title       "The Pheonix Project"
	#:author      "Kim, Behr, Spafford"
	#:page-number 91]{Your job as VP of IT Operations is to ensure that fast, predictable, and uninterrupted flow of pallend work that delivers value to the business while minimizing the impact and disruption of unplanned work, so you can provide a stable, predictable and secure IT service.}

## On categories of work

@quote-highlight[
	#:title       "The Pheonix Project"
	#:author      "Kim, Behr, Spafford"
	#:page-number 158]{four categories of work:

  1. business projects
  2. internal projects
  3. changes
  4. unplanned work}

## On Size of a Change

@quote-highlight[
	#:title       "The Pheonix Project"
	#:author      "Kim, Behr, Spafford"
	#:page-number 285]{In any system of work, the theoretical ideal is single-piece flow, which maximizes throughput and minimizes variance. You get there by continously reducing batch sizes}


## See also

  * DeMaro, _Slack_ Chapter 8: Agressive Deadlines

# On Agile

## See also

  *Juran, _Juran On Quality_, Chapter3: Quality and Identify Customers

# Three Ways

@quote-highlight[
	#:title       "The Pheonix Project"
	#:author      "Kim, Behr, Spafford"
	#:page-number 91]{The First Way helps us understand how to create fast flow of work as it moves from Dev into IT Ops, because that's what between the business and the customer.

The Second Way shows us how to shorten and amplify feedback loops, so we can fix quality issues at the source and avoid rework.

The Third Way show us how to create a culture that simultaneously fosters experimentation, learning towards failure, and understanding that repitition and practice are prerequisits towards mastery.}

## Digging into First Way

@quote-highlight[
	#:title       "The Pheonix Project"
	#:author      "Kim, Behr, Spafford"
	#:page-number 91]{Jimmy's problem with the auditors shows he can't distinquish work that matters to the business vs what doesn't.

Being able to take needless work out of the system is more important that being able to put more work into the system (sometimes).

You need to know what matters to the acheivement of the business objectives, whether it's projects, operatios, strategy, compliance with laws, regulations, security or whatever.}


@quote-highlight[
	#:title       "The Pheonix Project"
	#:author      "Kim, Behr, Spafford"
	#:page-number 175]{We are starting to master the First Way. We're curbing the handoffs of defects to downstream work centers, managing the flow of ork, setting the tempo by our constraints, and based on our results from audit and from [Sales?], we're understanding better than we even have what's important and what's not.}

### See also

  * Deming, _Out Of Crisis_, p 371: "System defined by management"

# On Incidents

## See also

  * _Site Reliability Engineering_ p 164: Better Managed Incident Procedure / Incident Command System

# On DevOps

## Getting to 10 deploys a day

@quote-note[
	#:title       "The Pheonix Project"
	#:author      "Kim, Behr, Spafford"
	#:page-number 296]{Need the following things:

  1. Ops Patterns:
    - rolling restart deployments
    - CD tooling (package up -> automatic or easy deploy to QA environment etc)
    - quick reaction rollback tools

  2. Identify constraints
    - see Book_Notes_Phoenix_Constraints
    - QA <-- if each deploy requires QA time to complete and team doesn't have dedicated QA resource...
    - meta question: in which statedo your tickets spend the most time (where is the most cycle time?)
    - Product signoff workflow required?

  3. If this seems impossible how about daily, nightly builds that QA can test first thing in the morning? Yourdon _Death March_ p 190. "Still far from goal but beats 'once a month' by 20x..."}

### See also

  * Juran, _Juran on Quality_, p 257
  * Deming, _Out of Crisis_, p 88 (Stewhart Improvement cycle ??)
