---
path: "/learnings/chef"
title: "Learnings: Chef"
---

# Table Of Contents

<!-- toc -->

<<ChefPhilosophy>>
=============

Cookbooks for applications, recipes for components
(per http://peterjmit.com/blog/a-better-workflow-with-chef-and-vagrant.html)



<<ChefEcosystem>>
===================

Three parts for full stack DevOps:

  1. Chef Provisioning: Create the instances etc you run this stuff on
  2. Chef Configuration Management: Configure those machines
  3. Chef Deploy / Delivery: Run your application on those machines!!!!!

Puppet makes you bring your own tools to the table for items 1 and 3. Which may be awesome, may be kind of suck
(right now? Leaning towards kind of suck????) EXCEPT that thing about keeping your deployment and infrastructure configuration
concerns SEPERATE

- [REVIEW]: Wait, what is Chef Swarm ?????
