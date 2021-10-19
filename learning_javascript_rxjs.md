---
path: /learnings/javascript_rxjs
title: 'Learnings: Javascript: RxJS'
---
# Table Of Contents

<!-- toc -->

- [What](#what)
- [Why](#why)
  * [Better control](#better-control)
- [Terminology](#terminology)
- [Producers in RxJS](#producers-in-rxjs)
- [Consumers in RxJS](#consumers-in-rxjs)
  * [subscribing to a producer](#subscribing-to-a-producer)
  * [Interacting with rest of Javascript world](#interacting-with-rest-of-javascript-world)
    + [to/From javascript collections](#tofrom-javascript-collections)
    + [To/From Promises](#tofrom-promises)
    + [To/From Events](#tofrom-events)
- [RxJS 5 vs 6](#rxjs-5-vs-6)
  * [syntax to compose pipelines has changed](#syntax-to-compose-pipelines-has-changed)
- [development helping paradigms](#development-helping-paradigms)
  * [Seperate: Producer, pipeline and subscribers](#seperate-producer-pipeline-and-subscribers)
  * [marble diagrams](#marble-diagrams)
  * [every item in the pipeline takes an input observable and returns an output observable](#every-item-in-the-pipeline-takes-an-input-observable-and-returns-an-output-observable)
- [Schedulers](#schedulers)
  * [Kinds](#kinds)
  * [Limiting potential concurrency](#limiting-potential-concurrency)
    + [with mergeMap](#with-mergemap)
    + [with concatMap](#with-concatmap)
  * [changing schedulers](#changing-schedulers)
- [Hot vs Cold Observables](#hot-vs-cold-observables)
- [Interesting Operators](#interesting-operators)
- [User Stories I care about](#user-stories-i-care-about)
  * [streams and multiple sources](#streams-and-multiple-sources)
  * [errors for the whole stream](#errors-for-the-whole-stream)
  * [catching errors in the pipeline](#catching-errors-in-the-pipeline)
  * [retrying when errors happen](#retrying-when-errors-happen)
  * [merging obserables when 1 fails](#merging-obserables-when-1-fails)
  * [refactorability](#refactorability)
  * [backpressure](#backpressure)
    + [Wrap it in a mergeMap wint concurrency of one](#wrap-it-in-a-mergemap-wint-concurrency-of-one)
    + [lossy methods](#lossy-methods)
    + [getting the next value only if you're ready for it](#getting-the-next-value-only-if-youre-ready-for-it)
- [See also](#see-also)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

# What

[RxJS](https://rxjs.dev/).

RxJS 6.0 released April 2018.

Ideas based on Reactive design patterns using the ReactiveX patterns and terminologies. This means it's familiar to developers who have done reactive development across say RxJava, AND is very familiar for developers who like to use functional patterns in their code.

ReactiveX operates on discrete values that are emitted over time.

Good Documentation:

  * [RxJS.dev](https://rxjs.dev/)
  * learnrxjs.io
  * RxJS In Action, from Manning <-- but covers RxJS 5 syntax
  * Building Reactive Websites with RxJS, from Prag Bookshelf

# Why

The ReactiveX Observable model allows you to treat streams of asynchronous events with the same sort of simple, composable operations that you use for collections of data items like arrays.

There's consistancy here: observable creators, and operators, alwayso return observables.

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

In Reactive terms these are called Observables.

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

## subscribing to a producer

	```javascript
		createdObservable.subscribe(
			next => console.log('current value of the stream'),
			err => console.error('will be called if there is an error'),
			() => console.log('the stream is complete')
		)
	```

You can also pass a class that implements this interface

		class ObserverInterface {
			next(value) {

			}
			error() {

			}
			complete() {

			}
		}

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

  * https://rxmarbles.com/
	* [RxViz](https://rxviz.com/)  <-- write code, get a marble diagram generated for you...

## every item in the pipeline takes an input observable and returns an output observable

pipeline is a series of observables getting consumed and creating more observables, until the end.

(youch).

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

Same as RxJava. See Reactive_Hot_vs_Cold

# Interesting Operators


| Observable Method | What it does                                                                                                                                                                |
|:----------------- |:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iif               |  subscribe to the first or second observable based on condition                                                                                                             |
| filter            | emit values that pass the condition                                                                                                                                         |
| find              | emit the first item that passes the predicate (then complete the Observer)                                                                                                  |
| skip              | skips the provided number of emitted values                                                                                                                                 |
| partition         | split one observable into two based on predicate (could use this to seperate out successful events and error conditions, for example...)                                    |
| flatmap/mergeMap  | This operator is best used when you wish to flatten an inner observable but want to manually control the number of inner subscriptions.                                     |
| tap               | side effect zone!!!                                                                                                                                                         |
| zip               | after all observables are finished, emit the entire array                                                                                                                   |
| merge             | emits items that are the result of every observable. Completes only when all have completed                                                                                 |
| concat            | subscribes to observables in order as previous completes                                                                                                                    |
| concatMap         | map values emitted to an inner obserable, subscribe and emit in order (translate an object into a observable)                                                               |
| forkJoin          | when all observables complete, emit the last value for each                                                                                                                 |


# User Stories I care about

## streams and multiple sources

Athe RxJS documentation says these are combination operators:

  * forkJoin
  * merge
  * zip
  * race

some others may be useful here

## errors for the whole stream

errors that occur in the stream are propegated down to any observers, finally resulting in a call to the error "callback".

(ie errors `throw`n in the body of an operator)

## catching errors in the pipeline

`catchError` will only call the function when the previous item in the pipeline errors.

```javascript
		from( [0] ).pipe(
			map( curr => {throw new Error('boo!') } ),
			catchError( err => {
				console.error(err)
				return 'maybe a default value here?'
			})
		)
```

Because `catchError` doesn't have to happen directly after the operator that fails this gives you some options. Maybe you make a network request and grab some data out for display. Do those as two seperate operations in the pipelie, then put your `catchError` there, with a "could not get" message. Then put - whatever text you have - to the correct component.

(or something like that, of course)


## retrying when errors happen

this approach of using an operator and optionally calling the function is used for `retry` and `retryWhen` operators.

## merging obserables when 1 fails

Two things to take into consideration:

  1. once a pipeline fails it is not called / used again. This may be a factor if you are watching a stream and ie sending HTTP requests
  2. some operations around combining operators will error if any of the observables you are joining fail

```javascript
	let pretendHttpRequest = from([1]).pipe(
					map( () => {throw new Error('sad!')} ) ,
					catchError( e => of(e) )
					// ^^^ here I chose to convert this from an throwed excption to
					// an object we are passing around that happens to be an exception
					// later on we can check for `isinstance Error` and map results
					// appropriately
		)
	let pretendTwo = from([42])

	forkJoin(pretendHttpRequest, pretendTwo ).pipe(
		map( curr => `${curr}, Ryan` ),
		tap( curr => console.log(curr) ),
		catchError( err => console.error(err))
	)

```

But did you se our pretendHttpRequest we wrapped it up in a pipe and used catchError to catch the exception / error that would have come out?

## refactorability

In regular ol JS you have this problem:

    _.forEach(f => syncMuthod)

But what if that method becomes async? potentially a bit ofrefoctoring to make callers async (especially if you have a deep call tree assuming sync..)

## backpressure

### Wrap it in a mergeMap wint concurrency of one

might work to keep the upstream operators from sending you data too fast

although this is not reolly backpressure as it is making the hihwoy go down to one lane.

### lossy methods

debounce, sample, throttle

although this is backpressure os mcuh as a spam filter is: ignore stuff we don't want to deal with

### getting the next value only if you're ready for it

You may be able to abuse `Subject` to do this. Interesting and maybe promising prototype code: [Lossless Backpressure in RxS](https://itnext.io/lossless-backpressure-in-rxjs-b6de30a1b6d4)

# See also

  * [Learn RxJS](https://www.learnrxjs.io/)
  * [RxViz](https://rxviz.com/) <-- uses RxJS 6 syntax
  * [my rxjs tags](https://pinboard.in/u:rwilcox/t:rxjs/)
  * [official documentation](https://rxjs-dev.firebaseapp.com/guide/overview)

# Book Recommendations

  * [RxJS In Action](https://www.amazon.com/RxJS-Action-Paul-P-Daniels/dp/1617293415/ref=as_li_ss_tl?keywords=RxJS+in+Action&qid=1570748058&sr=8-1&linkCode=ll1&tag=wilcodevelsol-20&linkId=929629a486c6ced551f7aeb7075e22be&language=en_UShttps://amzn.to/2nwrymm)



