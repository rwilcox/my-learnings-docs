---
path: "/synthesis/managing_agile_teams"
title: "Synthesis: Managing Agile Teams"
---

# Which Agile process is the best:

  * Agile Maturity Model: <http://news.ycombinator.com/item?id=3562486>
  * Your goal - keep your team happy, productive and meeting business needs in a timely and sustainable manner: <http://www.quora.com/Which-Agile-methodology-Scrum-Lean-XP-Kanban-is-considered-the-best-practice-and-why/answer/Ryan-Wilcox?srid=om8>
  * Agile does not mean "no processes":
  * We call it a sprint, but it's not a 100 meter dash directly after a 100 meter dash directly after 100 meter dash...:

# Developer Frustrations:

  * Why so Micromanagement-ey?: <http://news.ycombinator.com/item?id=3467532>
  * Why so Deathmarch-ey: <http://news.ycombinator.com/item?id=3425474>
  * Specify Behavior, not implementation, to programmers: <http://rwilcox.tumblr.com/post/3526739371>
  * Behavior driven development creates artifacts for the whole team, not just developers (it's not just about "stupid developers and their stupid tests that take so much time"): <http://rwilcox.tumblr.com/post/14165991970>
  * On giving your programmers context for the system/functionality piece they are working on (as much context as you have): <http://blog.wilcoxd.com/blog/2011/02/01/lesson-from-w-edward-deming-on-software/>
  * The Always On smell and personal costs: `Agile_Smell_AlwaysOnAvailably_And_Weekday_Hours`
  * Do your developers know what "core functionality" they are shipping this release?:  
  * Why your agile coach should not be a developer: Your_Agile_Coach_Should_Not_Be_A_Developer
  * Bugs: AgileAndBugFixing
  * Struggling: <http://rwilcox.tumblr.com/post/24090100242/struggling-or-working-to-avoid-blame>

# Product Owner:

  * Product owner should not have sole ownership over the backlog: <http://news.ycombinator.com/item?id=3047574>
  * Why one product owner is important: <http://rwilcox.tumblr.com/post/526968706>
  * The product owner should not be the direct customer: 
  * I want to measure velocity on a daily basis!: <http://www.quora.com/How-can-we-track-the-progress-of-development-on-a-daily-basis/answer/Ryan-Wilcox>
  * Using burndown charts effectively: <http://www.reddit.com/r/agile/comments/q4av3/burndown_charts_are_antiagile_because_working/c3uvn13>
  
# Management:
  * Metrics for Agile Teams: <http://www.quora.com/What-are-good-metrics-to-use-to-measure-the-performance-of-a-team-using-Agile-software-development-methodology/answer/Ryan-Wilcox>
  * Finding and keeping good people: <http://rwilcox.tumblr.com/post/15433814955/the-talent-crunch-not-where-you-expect-it>
  * Why turnover numbers and overwork presents problems for the entire organization: <http://news.ycombinator.com/item?id=3549185>
  * Why so turn-over-ey: <http://news.ycombinator.com/item?id=2781266>
  * How do you know if you have a good programmer?: <http://rwilcox.tumblr.com/post/3702442847>
  * On story points as a programmer metric: <http://rwilcox.tumblr.com/post/878296423>
  * On story points vs hourly estimates: <http://rwilcox.tumblr.com/post/20427889323>
  * Planning Poker: Resolving disperate point estimates
  * The date/scope debate (or: your entire agile team and the pateto principal): <http://blog.wilcoxd.com/blog/2010/07/12/the-datescope-debate/>
  * The Mythical Man Month really does apply to you team: 
  * Your business must have the mindset that it can adapt too, and not just come up with excuse after excuse why it can't. See this thread, where the guy seems to make every excuse in the book about why the org is how it is: <http://www.quora.com/Agile-Development/Whats-the-best-way-to-deal-with-performance-issues-in-an-agile-team>
  
# Performance

  * https://twitter.com/bcantrill/status/1216492121198215168?s=21 — what DO you ask if traditional quarterly / bi-yearly / yearly reviews are no good?

# Customer Frustrations:
  * "what do you mean you don't know how much it will cost?!?"
  * "what do you know, you don't know when it'll be done?"

# Team Size <<Managing_Agile_Team_Size>>

Rule of thumb is "two pizza team" or "6 +/- 3"

**BUT**, to quote scrum guide:

>  The Product Owner and Scrum Master roles are not included in this count unless they are also executing the work of the Sprint Backlog.

So, a cross-functional example team:

  * Scrum Master (A)
  * Product Owner  (B)
  * BA (C)
  * Project Manager ?
  * 1: QA (D)
  * 1: mobile (E)
  * 1: web (F)
  * 1: backend (G)
  * 1: backend (H)
  * 1: mobile (I)
  * 1: web (J)
  * 1: backend (K)

If you include the SM+PO+BA you onlf get down to _maybe_ H. But that leaves you with:

  * no backups
  * still a very small team
  * where is developer's ability to grow / lead in the small / in the team? Especially with orgs that say "we want to see you performing at the level required for your new role for 6-12 months before we give it to you". (_is_ that possible in your teams?)

With say 3 of each part of the stack you both have backups, some ability for a developer to be shown as a leader across the team (or sneak into other areas in the stack).

It's not a great, but compare the two teams when you include the SM/PO in the work.

(Now yes, I do believe that the POs work should be visible on the board for others to see - downwards transparency - but not estimated, because only one person knows the work, vs 2-3).

(But this is around 12? people at the larger extreme.)

## See also:

  * [TopTal article on scum team size](https://www.toptal.com/product-managers/agile/scrum-team-size)
  * [Scrum Guide on team size](https://www.scrumguides.org/scrum-guide.html#team-dev)

# dual people roles

## dual roles that might work

### developers that are architects

  (?)

### managers that write code sometimes

boy howdy this is hard. In one way see Managers_Writing_Code. on the other hand, you can’t work on something critical path and you also can’t be inthe situation where people are afraid to code review your code as well as it should be because you’re the boss (power imbalance!!). 

On the judging hand, a [Gemba walk](https://kanbanize.com/lean-management/improvement/gemba-walk/) is a thing. Or a Gemba pair programming session: let your developer drive and DON’T say anything. Or, don’t ask questions about the code / design, as questions around the environment they work on: the code is almost a discardable artifact in this type of scenario. (But it might not be enough? Or you may Peter Principle this(?) so careful(?). )

On the fourth hand, there’a a difference between managing 3 people and 7 people and 12 people..

<<Dual_Roles_That_Might_Work_Manager_Developer>>

## dual roles that don’t work

### Tech leads that are scrum masters or even coaches <<Dual_Roles_That_Do_Not_Work_Dev_Coach>>

  it may be hard for others outside the team to know if you are being a cranky developer or if you are representing a legit team complaint. 
  

####  See also

 *  Your_Agile_Coach_Should_Not_Be_A_Developer

### People managers that are architects

can be too far away from day to day code bits; means design could "win" by default; splits focus; might tramble on actual architects without org chart power if you say need > 1 for your team, or > 1 people manager for your team because team is so large ( / middle manager overconfidence). 

Are you winning because your idea is the best / actually viable, or are people falling into trap of Highrst Paid Person’s Opinion?


# Additional Reading -
Is your company addicted to urgency? <http://www.articledashboard.com/Article/The-Tyranny-of-Urgency-Addiction/845890>
How to manage brilliant people: <http://www.computerworld.com/s/article/317362/How_to_Manage_Brilliant_People>

Dave bock wants to write forward (said on twitter feb 22)
