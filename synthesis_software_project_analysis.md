---
path: /learnings/synthesis_software_project_analysis
title: 'Syntheisi: Project Analysis'
---
# Table Of Contents

<!-- toc -->

- [analysis of software in the repository itself](#analysis-of-software-in-the-repository-itself)
- [analysis of software across microservice herd](#analysis-of-software-across-microservice-herd)
- [Analysis of libraries in a project](#analysis-of-libraries-in-a-project)
- [sources](#sources)

<!-- tocstop -->

# analysis of software in the repository itself

  * three types of metadata: comments, comments in PRs, and comments / work in the Jira ticket structure
  * unused or badly used package module imports
  * squashed warnings
  * code flow etc etc


# analysis of software across microservice herd

  * library dependencies (esp on other libraries)
  * class dependencies inside a service <-- not really soo soo much if it's <5k lines
  * required downstream services
  * how many services need modification to implement a user story (aka: need to modify five services and get  another team involved will bring down your velocity and border on just having distributed spaghetti
        -  jira tickets: to implement a feature how many jira tickets does it take? How long to complete all tickets? What repos / PRs were created as part of that whole change set?
  * technical sprawl
  * lines of code or indentation based complexity: where are the most complex files per repo, and per project? Doe these files move a lot, and why?
  * places where only a single owner makes changes to a microservice or who knowledge areas: likely creating bus factor here!
  * mocks per unit tests — likely how non testable the code is (or you’re not using constructor based DI well enough....)
  * average LOC in files in (repo, project), where are the outliners
  * average number of git commits affecting file - where are the outliers / places where the service or project churns?
  * total LOC across ALL microservices in the herd - how much distributed code ARE you dealing with?
  * does a bunch of service shave the same or similar names files in say utils? Aka is there a library we can extract?

# Analysis of libraries in a project

  * what library depends on what (internal) library
  * transitive library de-taggler <-- especially YARN!!!!


# sources

  * software design X-rays
  * GToolkit
