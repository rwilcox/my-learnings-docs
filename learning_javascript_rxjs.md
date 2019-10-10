---
path: "/learnings/javascript_rxjs"
title: "Learnings: Javascript: RxJS"
---

# What

[RxJS](https://rxjs.dev/).


RxJS 6.0 released April 2018.

Ideas based on Reactive design patterns using the ReactiveX patterns and terminologies. This means it's familiar to developers who have done reactive development across say RxJava, AND is very familiar for developers who like to use functional patterns in their code.

ReactiveX operates on discrete values that are emitted over time.

Good Documentation:

  * website
  * learnrxjs.io
  * RxJS In Action, from Manning <-- but covers RxJS 5 syntax
  * Building Reactive Websites with RxJS, from Prag Bookshelf

# Why

The ReactiveX Observable model allows you to treat streams of asynchronous events with the same sort of simple, composable operations that you use for collections of data items like arrays. 
 
Super useful in Javascript where sync patterns and async patterns have pretty significant implications. Just the other day had to refactor a fair bit of code where I had assumed all operations would be sync (stupid)... but then I had to introduce an operation that wasn't anymore.

## Better control

  * async scheduling
  * easy retry functionality
  * cancellability
  * lazy / less intermediate collection objects <-- can deal with infinit lists of events (count from 0 to infinity and combine the first 5, give me every event the user will do and give me every time they type e)

# Terminology

  * Consumers
  * Producers
  * Observables  <-- "Rather than calling a method, you define a mechanism for retrieving and transforming the data, in the form of an “Observable,” and then subscribe an observer to it, at which point the previously-defined mechanism fires into action with the observer standing sentry to capture and respond to its emissions whenever they are ready.". Composed of (my words):
   	- originating data source 
	- pipeline
	- output / subscriber
  * subscribers
  * Subjects <-- both a subscriber and a consumer, AND publishes to MANY observers

# Producers in RxJS

Two different kinds: hot and cold (like RxJS).

hot: always emits events, listening or not.
cold: doesn't start emiting until you listen


	```javascript
	import { from } from 'rxjs'
	
	let data = [1, 2, 3]
	let source = from( data )
	let res = source.pipe( filter(e => e % 2 == 0 ) )
  
	// res will be another observer here / our filter will not be called

	res.subscribe( v => console.log(v) )
	// only NOW will we start processing the events from 
	```

Some sources are default hot, like events.

# Consumers in RxJS

## Interacting with rest of Javascript world

### to/From javascript collections

	// RxJS v6+
	import { from } from 'rxjs';
	
	const source = from([1, 2, 3, 4])

works for strings, records, arrays...

### To/From Promises

	// rxJS v6+
	import { from } from 'rxjs'
	
	const source = from( someAsyncMethod() )

### To/From Events

	// rxJS v6+
	import { fromEvent } from 'rxjs'
	
  
# RxJS 5 vs 6

## syntax to compose pipelines has changed

Old

	```javascript
	import { map, filter, catch } from 'rxjs/operators'
	source
		.map( x => x.title )
		.filter( x => x.legth > 10 )
		.catch( err => console.log(err) )
	```
	
New

	```javascript
	
	import { merge, filter, catchError } from 'rxjs'
	source.pipe(
		map( x => x.title),
		filter( x => x.length > 10 ),
		catchError( err => console.log(err) )
	)
	```

# development helping paradigms

## Seperate: Producer, pipeline and subscribers 

This seperation means better testing: ability to throw different data in, and then test on the other end

## marble diagrams


# Schedulers

## Kinds

## Limiting potential concurrency

### with mergeMap

Can pass a second paramter to it, the concurrency parameter, which will make sure # number of inner subscriptions don't happen more than X in parallel

### with concatMap

docs: "does not subscribe to the next observable until the previous one completes"

Projects each source value to an Observable which is merged into an output observable, in a serialized fashion, waiting for each to complete before merging the next

	```javascript
	
	let urls = [...]
	let o = from(urls).pipe(
		// ok, but don't do these all at once, that might DDOS some server...
		concatMap( currentURL => { 
			from( axios.get(currentURL) )
		})
	)
	```

## changing schedulers 


#  Hot vs Cold Observables


# Interesting Operators


## Functional style Methods

  * iif
  * filter
  * find
  * skip
  * partition
  * flatMap / mergeMap
  * tap <-- side effect zone!!!


##

# User Stories I care about

## cancellable streams

## nested streams(?)

## streams and multiple sources

## errors in the streams

## refocterobility

    _.forEoch(f => syncMuthod)

But whot if that method becomes async? potenntiolly o bit ofrefoctoring to make callers async no

## Completion

  * <-- wait for all of these to be done
  * <-- wait for all these to be done, successful or not
  * *


# See also

  * [Learn RxJS](https://www.learnrxjs.io/)
  * [RxViz](https://rxviz.com/) <-- uses RxJS 6 syntax
  * [my rxjs tags](https://pinboard.in/u:rwilcox/t:rxjs/)
  * [official documentation](https://rxjs-dev.firebaseapp.com/guide/overview)
  

