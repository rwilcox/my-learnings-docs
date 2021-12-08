---
path: /synthesis/management_agile
title: 'Synthesis: Management: Agile'
---
# Table Of Contents

<!-- toc -->

- [- [BOOKNOTES]: Managers Path On Team Lead](#--booknotes-managers-path-on-team-lead)
- [On Processes](#on-processes)
- [why a leader should write code >](#why-a-leader-should-write-code-)
  * [see also](#see-also)
- [empowerment model](#empowerment-model)
  * [do I have the authority to do one of the following items with a decision in my team (that I need help with?? / thats in my bounded area of responsibility)](#do-i-have-the-authority-to-do-one-of-the-following-items-with-a-decision-in-my-team-that-i-need-help-with--thats-in-my--bounded-area-of-responsibility)
  * [And how that affects leadership](#and-how-that-affects-leadership)
- [team knowledge models](#team-knowledge-models)
- [servant leadership](#servant-leadership)
- [Your company is awesome (but is "Company Culture" a lie?) (http://www.confreaks.com/videos/4179-rmr2014-your-company-is-awesome-but-is-company-culture-a-lie)](#your-company-is-awesome-but-is-company-culture-a-lie-httpwwwconfreakscomvideos4179-rmr2014-your-company-is-awesome-but-is-company-culture-a-lie)
- [-[BOOKNOTES]: Agile performance Holarchy](#-booknotes-agile-performance-holarchy)
- [Retrospectives](#retrospectives)
- [And things that actually take longer than a sprint](#and-things-that-actually-take-longer-than-a-sprint)
  * [sprint themes](#sprint-themes)

<!-- tocstop -->

# - [BOOKNOTES]: Managers Path On Team Lead

> The tech lead role is not a point on the ladder, but a set of responsibilities that any engineer may take on once they reach the senior level. This role may or may not include people management, but if it does, the tech lead is expected to manage these team members to the high management standards of RTR tech. These standards include:

#  On Processes

@quote-highlight[
	#:title       "The Manager's Path"
	#:author      "Camille Fournier"
	#:page-number 0
	#:url         "https://learning.oreilly.com/library/view/the-managers-path/9781491973882/ch03.html"
	] {
As a new tech lead, be careful of relying on process to solve problems that are a result of communication or leadership gaps on your team. Sometimes a change in process is helpful, but its rarely a silver bullet, and no two great teams ever look exactly alike in process, tools, or work style. My other piece of advice is to look for self-regulating processes. If you find yourself playing the role of taskmastercriticizing people who break the rules or dont follow the processsee if the process itself can be changed to be easier to follow. Its a waste of your time to play rules cop, and automation can often make the rules more obvious.
}


# why a leader should write code <<Managers_Writing_Code>>

@quote-highlight[
	#:title       "The Manager's Path"
	#:author      "Camille Fournier"
	#:page-number 5
	#:url         "https://learning.oreilly.com/library/view/the-managers-path/9781491973882/ch05.html"
	] {
> Why bother writing any code if all youre doing is small stuff? The answer is that you need to stay enough in the code to see where the bottlenecks and process problems are. You might be able to see this by observing metrics, but its far easier to feel these problems when youre actively engaged in writing code yourself. If the build is really slow or deploying code takes too long or on-call is a nightmare, youll feel it in the difficulties you, an experienced engineer, have in knocking out trivial programming tasks
}
## see also

  * Dual_Roles_That_Might_Work_Manager_Developer

# empowerment model

employee empowerment model that includes three degrees of empowerment.3
  1. The first level encourages employees to play a more active role in their work.
  2. The second level asks employees to become more involved with improving the way things are done
  3.. The third level enables employees to make bigger and better decisions without having to engage upper management. The third level is key for an Agile culture.

## do I have the authority to do one of the following items with a decision in my team (that I need help with?? / thats in my  bounded area of responsibility)

tell, sell, consult, agree, advise, inquire, and delegate.

- Jurgen Appelo / Managing for Happiness (??)

## And how that affects leadership

- [BOOKNOTES]:

> Without leadership at all levels, frameworks such as Scrum and XP are just defined processes that force people to act as directed.

- From: Big Agile

# team knowledge models

  * T shaped skills
  * lightning bolt (where teams / people have primary, secondary and tertiary skills)
  * paint drip skills

# servant leadership

Servant Leadership, Robert K. Greenleaf and Larry C. Spears share ten attributes of servant leadership: listening, empathy, healing, awareness, persuasion, conceptualization, foresight, stewardship, commitment to grow people, and building community.

Your company is awesome (but is "Company Culture" a lie?) (http://www.confreaks.com/videos/4179-rmr2014-your-company-is-awesome-but-is-company-culture-a-lie)
========================

Model for happiness (PERMA):

  * Positive Emotion
  * Engagement
  * Relationships  <-- must have trust to have good relationships
  * Meaning
  * Achievement

Developers want to work on challenging, innovative projects that are complex but autonomous and finite (ideally with a clear relationship between work and reward)
(hey look these can be categorized under the above categories!!)

Potential formula:               `E + M == A == (more) P`
the inverse, by math properties: `A - (E + M) == nil == SAD KITTEN`


Retrospective questions:

  * Does PO respond to requests in a responsible timeframe?
  * Does the PO appreciate and value the work done by the developing team?
  * Does the PO follow, within reason, the process defined by the dev team?
  * Is the PO pleasant to work with in general?
  * Do we, as developers, have the resources needed to move the project forward?

By actively praising the values we want in the culture (helpfulness, etc) we shape company culture
the inverse, by math properties: you get what you praise

# -[BOOKNOTES]: Agile performance Holarchy

- Leading:
  * visioning
  * valuing
   * enabling
- Envisioning:
   * defining
   * road mapping
   * clarifying
- Providing:
  * equipping
  * contributing
  * partnering
- Crafting:
  * solving
  * delivering
  * planning
- Teaming:
  * organizing
  * growing
  * governing
- Affirming:
  * confirming
  * understanding


- From: The Big Agile

# Retrospectives

- [BOOKNOTES]:
> Use the Functional Retrospective to capture experiences and best practice by functional group, including managers, engineers, developers, architects, and more.

- From: The Big Agile

So: retrospective for the team about how it work together, but sometimes also ave a retrospective of just developers, just QA people, just POs etc. Especially if you have multiple teams going at a time

This migt help find issues that you can fix at a larger level tha just the team level (organization fixes).

- [BOOKNOTES]:

Maintenance and strengthening of Agile values are best conducted informally, rather than “top down.”

- From: Big Agile

# And things that actually take longer than a sprint

## sprint themes

What I love using for my projects is a rotation of: feature, fix, harden.
Each of the three representing an individual sprint so that the PO can show
an actual roadmap to their business partners that has work prioritized
around the theme itself. Predictable is good and that clarity helps teams
organization around what to actually work on.

- A T H
