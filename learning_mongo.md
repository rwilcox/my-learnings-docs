---
path: /learnings/mongodb
title: 'Learnings: Mongodb'
---
# Table Of Contents

<!-- toc -->

- [Updating fields of a document in Mongo](#updating-fields-of-a-document-in-mongo)
- [>](#)

<!-- tocstop -->

# Updating fields of a document in Mongo

    db.users.update({"_id": "0000000000001"}, {$set: {role_level: 10}})

Will just update the `role_level` field in the found record **NOT** anything else)

# <<Learning_Mongo_Geo_Queries>>

Indexing data:

  * 2dsphere index: $geoNear via GeoJson or coordinate pair
  * 2d       index: coordinate pair

