---
path: "/learnings/javascript_cool_snippets"
title: "Learning Javascript Cool Snippets"
---


# Dropping the first couple elements from an array then keeping the rest

        let a = ['jun', 'junk', 'thing one', 'thing two']
        let [,, ...goodThings] = a 
        console.log(goodThings)  // will be ['thing one', 'thing two']

