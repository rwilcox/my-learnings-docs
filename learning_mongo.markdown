---
path: "/learnings/mongodb"
title: "Learnings: Mongodb"
---

# Updating fields of a document in Mongo

    db.users.update({"_id": "0000000000001"}, {$set: {role_level: 10}})
    
Will just update the `role_level` field in the found record **NOT** anything else)