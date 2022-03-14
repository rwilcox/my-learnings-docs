---
path: /learnings/learning_time_series_database_druid
title: Learning Druid
---

# Design of Druid Data Structure

Each record in Druid:
  * timestamp
  * dimensions
  * metrics

Dimensions are bits of data that relate to the topic at hand. For example, building an analytics tool, would be:

  * browser type
  * page URL

Druid can then allow you to group records with distinct timestamps into a time series and let's you see to see how many times in an hour a particular URL was visited by Firefox.

And that eventually the cardinality of that will increase as you group more and more records together: the metrics part will be aggregated together as they now "cover" the same time period. (Logically. Physically these may reside in seperate segments). ie Druid's idea of what "the same timestamp" is is Waayyyyy more flexible and different from what ie Postgres or Java thinks of as the same timestamp.

(This is the granularity)


> but yeah my understanding is that any time it’s creating a segment chunk it will kind of by nature merge any data with matching timestamp and dimensions

- DG

# Ingest

Can ingest from multiple data sources

Can also apply ingest side filters, transforms and un-nestle data

# Watching

## Performance Tuning of Druid Cluster at High Scale @ ironSource

[video](https://www.youtube.com/watch?v=_co3nPOh7YM&t=1s)

## Operating Druid

[video](https://www.youtube.com/watch?v=_co3nPOh7YM&t=1s)
