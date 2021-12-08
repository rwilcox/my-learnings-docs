---
path: /learnings/learning_graphql
title: Learning GraphQL
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

See also:

  * LearningGraphQL_Apollo_Schema_Download

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

# Validating that the GraphQL client schemas validate (and stay validating) with the server capabilites / queries

## Validation as a static step `<<Learning_GraphQL_Validation_CLI>>`

First, download the graphQL IDL/SDL file

[get-graphql-schema](https://github.com/prisma/get-graphql-schema) looks like a good tool to download this in [GraphQL SLD](https://www.prisma.io/blog/graphql-sdl-schema-definition-language-6755bcb9ce51/) format

    $ get-graphql-schema https://somegrapql.api.example.com > schema.graphql


Then validate your queries against the schmea validator using [graphql-validator](https://github.com/creditkarma/graphql-validator)

This validator requires the schema to be in SDL, not JSON, format.

    $ graphql-validator -s schema.graphql 'my_graphql_queries/**/*.graphl'

(make sure to use quotes: you acutally **don't** want the shell interpreting those quotes).

# Using Apollo client libaries to interact with GraphQL based server

[Apollo](https://www.apollographql.com/) - from the Meteor people - are some good GraphqL tools.

## warnings about anonymous operations

Apollo, and its CLI tools, may give warnings about not supporting anoymous operations.

In fact, this is not just a warning, but your queries will fail validation if they are anoymous, even if they pass other GraphQL query validation steps.

You **MUST** give your queries names. While most of the time you can write

    query {
        getCars() {
            name
        }
    }

With Apollo you **must** write it as so


    query getCurrentUserCars {
        getCars() {
            name
        }
    }

(Noticed we have named the query??)


Source:

  * https://github.com/apollographql/apollo-cli/issues/344#issuecomment-411110005


## Apollo CLI

`npm install apollo` <-- replaces other tools like apollo-code-gen

### Generating Code using Apollo CLI

Some type based languages (TypeScript, Flow, Swift) will require / want you to add types to the data you get back, for type checking.

Remember that GraphQL the server specifies the things it can accept, and the client specifies the things it wants from the availiable types.

Meaning that if we have a "list the current user's cars" query. A particular screen in the client application may only care about the car's names.

Imagine this query can be created like so:

    query getUserCars{
        getUsersCars() {
            name
        }
    }

This is a client side query. Our client application (an Angular 5 based application, for example) will want typesafty around that query.

Put this client side query in a seperate file and pull it into your program somehow so it is sent to the server. See Learning_GraphQL_Validation_CLI

#### First, download the generic schema from the GraphQL server ( <<LearningGraphQL_Apollo_Schema_Download>> )

    $ apollo schema:download --endpoint https://api.graph.cool/simple/v1/example-project schema.json

#### Secondly, use that schema against the .graphql queries your application uses

    $ apollo codegen:generate --schema=schema.json --target=swift --queries=./graphql.queries/*.graphql graphql

This will generate types for you, in this case in `graphql/Types.graphql.swift`


#### See also

  * Graph.cool lets you extend the schema in the source code.  [Per](https://github.com/apollographql/apollo-cli/issues/344#issuecomment-371530068). 
  * ["when a graphQL file contains no operation definitions types.swift is empty"](https://github.com/apollographql/apollo-cli/issues/211).
