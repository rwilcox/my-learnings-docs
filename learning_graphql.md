---
path: "/learnings/learning_graphql"
title: "Learning GraphQL"
---

# how GraphQL APIs are set up

The base of your GraphQL graph is a schema that holds the following things:

  1. Queries
  2. Mutations
  3. Subscriptions

All possible mutations, queries etc must be declared in this root object.

_by this we mean that you can't just query random object types like you can in a relational database_. Because you know the object/class exists does not mean you can just `SELECT *` on it arbitrarily. (You must use the graph).


## digging into OO design in GraphQL

queries can specify object schema (optionally) by using 'fragment' sections of graphql query.

can also create interface whece you don't care what kind of object is returned but you know they mill all have same couple fields

# introspection / a simple query

    query { 
         __schema {  
               types {  
                       name 
                       description    
                }  
        }
    }


or better

    query roots {
         __schema {    
             queryType        {  ...typeFields    }
             mutationType     {  ...typeFields    }    
             subscriptionType {  ...typeFields    }  
        }
    } 
    fragment typeFields on __Type {  
       name
       fields { 
        name
       }
    }


## Sending GraphQL commands via curl

Is interesting because JSON doesn't support multiline strings.

Thus, you may need to join your strings into one before sending it.

    POST https://somegrapql.api.example.com
    content-type: application/json

    {"query": "query roots { __schema {    queryType {      ...typeFields    } mutationType {      ...typeFields    }    subscriptionType {      ...typeFields    }  } } fragment typeFields on __Type {  name  fields {    name  }} "} 


# on server side

## resolvers

every field needs one

# See also:

  * _Learning GraphQL_

# Using graph.cool to provide GraphQL backend

[Graph.cool](https://www.graph.cool/) is a self hosted GraphQL Backend As A Service.

It can be deployed on their infrastructure, and they also provide a command to spin up a cluster of Docker containers locally.

    $ /usr/bin/graphcool local up


`... local up` seems to use Docker Compose to do this, but I couldn't locate if they write / save the generated files anywhere.

It does however create a docker network: `local_graphcool`.

    $ npm install 

    $ graphql deploy --target local

## Graph.cool introspecting

GraphQL appears to use GraphQL to store and keep track of services. The root of Graph.cool is the following endpoint, which you can query via graphql (POST to the following endpoint) or view a web based playground if you GET it in a browser.

http://localhost:60000/system

In fact, to debug issues in graphql you may have to turn on debug mode, note the executed queries, and manually execute them yourself.

    $ DEBUG="*" graphql deploy --target local

Which will spit out GraphQL queries. Running these queries against the playground may help understand what's going on.

# Using Apollo client libaries to interact with this

Apollo - from the Meteor people - are some good GraphqL tols.

## Apollo CLI

`npm install apollo` <-- replaces other tools like apollo-code-gen

