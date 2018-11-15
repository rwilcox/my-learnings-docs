---
path: "/learnings/splunk"
title: "Learnings: Splunk"
---

# Splunk Common Information Models

If you write your own log outputs to match one of the CIM models then you can write dashboards / reports easier.

Has good definition around the following (application related! topics):

  * Performance Metrics
  * Web Access Events
  * Application State Changes (start / stop, logging level changes)
  * Alerts

Has not good definitions around:

  * Regular application debug logging events <-- people usually just abuse Alerts



## Parsing incoming data

See [CIM Manual: Validate your data against the data model](http://docs.splunk.com/Documentation/CIM/4.11.0/User/UsetheCIMtonormalizedataatsearchtime#6._Validate_your_data_against_the_data_model).

Basically: 

  * data comes in
  * you can create aliases for field names that aren't quite right or whose data type is wrong
  * field names / schema are right it should auto find it.

## See Also

  * http://docs.splunk.com/Documentation/CIM/4.11.0/User/Overview

# Data Extractions

## See Also

  * https://www.hurricanelabs.com/blog/splunk-case-study-indexed-extractions-vs-search-time-extractions