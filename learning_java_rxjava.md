---
path: /learnings/java_rxjava
title: 'Learnings: Java: RXJava'
---
# Table Of Contents

<!-- toc -->

- [>](#)
- [Interface Observable](#interface-observable)
  * [Hot vs cold flux >](#hot-vs-cold-flux--)
    + [Cold flux](#cold-flux)
    + [Hot Flux](#hot-flux)
- [Observable (producer) notes](#observable-producer-notes)
- [RxJava and concurrency strategy >](#rxjava-and-concurrency-strategy-)
  * [Schedulers](#schedulers)
  * [Summary](#summary)
- [Consumers and Producers in RxJava >](#consumers-and-producers-in-rxjava-)
  * [Consumer Strategy (subscribe)](#consumer-strategy-subscribe)
    + [the implicit concurrency in `flatmap`](#the-implicit-concurrency-in-flatmap)
      - [why use `flatMap`](#why-use-flatmap)
  * [Producer Strategy (onNext/onCompleted/onError)](#producer-strategy-onnextoncompletedonerror)
- [Consumer Functional Interface](#consumer-functional-interface)
  * [Interesting methods](#interesting-methods)
  * [`subscribe`](#subscribe)
  * [Customizing](#customizing)
    + [creating own custom operators](#creating-own-custom-operators)
      - [Tips](#tips)
      - [See also:](#see-also)
  * [How these operators actually work: `lift`](#how-these-operators-actually-work-lift)
- [Outstanding Classes](#outstanding-classes)
- [Backpressure](#backpressure)
  * [RxJava 1](#rxjava-1)
  * [RxJava 2](#rxjava-2)
- [See also](#see-also)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

# <<Learning_Java_Rx>>

See also:

  * ProjectReactorTypesToRxJavaTypes

# Interface Observable

    interface Observable {
    	Subscription subscribe(Observer s)
    }

    interface Observer<T> {
    	void onNext(T t)
    	void onError(Throwable t)		// <-- terminal event
    	void onCompleted()				// <-- terminal event

    	void unsubscribe()
    	void setProducer(Producer p)
    }


Observable operations are *synchronous*

## Hot vs cold flux  <<Reactive_Hot_vs_Cold>>

### Cold flux

    /* point a */ Observable<T> someData = Observable.create( /*Subscription */ s -> {
        someAsyncCall(args, data -> {
            s.onNext(1);
            s.onCompleted();
        })
    })

    /* point b */

    someData.subscribe( /* T */ value -> {   /* Consumer functional interface that gives you the T type you passed */
        System.out.println( value )
    })
    /* point c */

Note: Observable will not start at point b here, it will start on subscription (so actually point c-ish).

But it means you can set up your reactive data processing and then subscribe when you're ready

### Hot Flux

Source produces the events, but none of the operators happen until someone actually subscribes.

# Observable (producer) notes

Have helped function to wrap try/catch+onError around: Obserable.fromCallable( -> ...)

`Observe.create( -> someMethod )` is called once per subscribe


# RxJava and concurrency strategy <<Learning_Java_Rx_Concurrency_Parallel_Execution_Schedulers>>

At any point before subscribing, can do `.subscribeOn` and provide a `Scheduler` instance. (Can use provided ones, or `ExecutorService`).

Then the `create` lambda is executed in the context of the schedule

... but these are low level tools...

## Schedulers

  * `Schedulers.newThread` <-- no thread pool, thread created and destroyed
  * `Schedulers.io` <-- like ThreadPoolExecutor, but really really is meant for tasks that perform IO
  * `Schedulers.computation` <-- CPU bound tasks, will limit "thread pool" to # of actual cores, queue will "just" keep backing up if needs > resources
  * `Schedulers.from` <-- takes subclass of `Executor`
  * `Schedulers.test` <-- lets you play with the clock ie for testing

Can also put these on `observeOn` instead of just `subscribeOn` ie if you need to be on the main thread to update a UI.

Can switch observe on in the middle of a chain if you need to Ie switch threads the results of it all is displayed on.

## Summary

With blocking Observables:

  * Observable without any Scheduler works like single threaded blocking program
  * Observerable with single `subscribeOn` like doing work in background thread
  * Observable using flatMap where internal Observable has a `subscribeOn` like ForkJoinPool where each substream is a fork and flatMap is the safe join phase.


With non blocking Observables: knowing how they are combined and when subscription occures


# Consumers and Producers in RxJava <<Learning_Java_Rx_Subscribers_Observable_Producer_Consumer>>

## Consumer Strategy (subscribe)

  * filter and map are sync executed on the thread that emits the events

### the implicit concurrency in `flatmap`

`flatMap` consumers can return an `Observable`. Because it's an  `Observable` it can wrap a concurrent operation, or not.
flatMap subscribes to those observables returned and quasi-joins that into a single output stream.

Thus this provides easy wrappers for concurrent operations.

Can also use flatMap to apply backpressure on an operation.


#### why use `flatMap`

  * result of transformation in `map` must be an Observable. (ie long running or async operation)
  * one to many transformation

## Producer Strategy (onNext/onCompleted/onError)

Unless required by some operator RxJava doesn't implicitly run your code in any thread pool.

Events can never be emitted concurrently. By this I mean you can not have multiple threads and emit to the same Subscription.

Error handling strategy: let caller / RxJava chain creator worry about it


# Consumer Functional Interface

## Interesting methods

| Observable Method | What it does                                                                                                                                                                |
|:----------------- |:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| zip               | waits until your N Observable parameters *all* complete, then function called result happens                                                                                |
| merge             | Your subscription will be fired when data down *any* Observable parameters happens                                                                                          |
| unsubscribe       | What it says on the tin                                                                                                                                                     |
| just              | creates Observable instance that emits one value to all future subscribers                                                                                                  |
| cache             | will subscribe to an Observable and cache the events for later reply into Subscriptions                                                                                     |
| refCount          | the create method('s lambda) is called only once per many subscriptions. When count -> 0 it `unsubscribes`                                                                  |
| share             | does a `publish().refCount()`                                                                                                                                               |
| publish           | returns a `ConnectableObservable`                                                                                                                                           |
| doOnNext          | <-- way to insert logging etc into your operator pipeline                                                                                                                   |
| flatMap           | a stream can returned 1 or more bits of data. Side effect: will not group output streams: ([S,M,S]                                                                          |
| concatMap         | a stream can return 1 or more bits of data, but these are grouped by originating streams ([S,S,M])  . BUT no concurrency / parallelism at all wrt asynchronous work         |
| empty             | useful when you don't care about the results of a stream (maybe you only care about completion, not onNext progress)                                                        |
| combineLatest     | emits a pair every time any events from a stream happens, and if has to joins the current value with the last value from the other stream                                   |
| withLatestFrom    | like combineLatest but you can control which stream matters more                                                                                                            |
| scan              | return accumulated values as they come in                                                                                                                                   |
| reduce            | at the end of the stream produce the result of accumulation                                                                                                                 |
| collect           | abstraction over reduce with same restrictions about end of stream                                                                                                          |
| onErrorResumeNext | pass control to another Publisher rather than invoking onError if error                                                                                                     |


## `subscribe`

  * can pass a lambda called `onNext`
  * can pass a lambda called `onNext`, `onError`, `onComplete`
  * can pass a implementor of `Observer` which `@overrides` `onNext`, `onError`, `onComplete` methods, if needs data based functor

## Customizing

### creating own custom operators
Use `Transformer`, really a `Functional< Observable<T>, Observabl<R> >`.0

    private <T, R> Transformer<T, R> onlyPickOdd() {
    	return new Transformer<T, R>() {
    		@Override

    		public Observable<R> call(Observable<T> observable) {
    			....
    		}
    	}

    }

or, with lambda syntax (but with less clarity...)

    private <T, R> Transformer<T, R>  onlyPickOdd() {
    	return upstream -> upstream.zipWith(...).map(...)
    }


#### Tips

  1. Pass downstream `Subscriber` as a constructor argument to the new `Subscriber` when creating own operators, to avoid places where you stop listening but don't tell upward subscribers to stop too.


#### See also:

  * http://blog.danlew.net/2015/03/02/dont-break-the-chain/

## How these operators actually work: `lift`

Modify a top level observer: aka in a chain of operators, travel to the top of the Observable change and modify the original subscriber

Technically can write operator chains like so:

    Obeservable.range(1, 1000)
               .lift(new OperatorFilter<>(x -> x % 3 == 0 ) )
               .lift( new OperatorDistinct.<Integer>instance() )


# Outstanding Classes

  * Single
  * Completable            <-- "yes, it completes, but doesn't actually *return* anything
  * Observer implements Subscriber
  * ConnectableObservable  <-- always creates at least one subscriber (even if count == 0 or count == WAY_HUGE_MANY). Can force subscription
  * BlockingObserver       <-- really just a transitional class: for non-reactive projects: but blocks until Observer completely fulfilled

# Backpressure

## RxJava 1
Can sample observable,  can batch up events  for downstream processors

Some operators have built in (actual) backpressure

Your custom operators can implement onStart / your constructor and ask for how many elements to be given up front (all is default)

But if operators totally ignore backpressure requests, can use  operator onBackpressureBuffer or onBackpressureDrop to front bad data sources. onBackpressureBuffer can be given a limit and a callback to call if buffet exceeds those limits

If really need can use SyncOnSubscribe class - this has useful methods re backpressure etc.

## RxJava 2

Flowable — implements batching up events Iin slightly better way than RXJava 1

Can create instances of this and set properties / strategies, then listen to your subscriber

Flowable.generate lets you create backpressure respecting Observables. (Or higher level method, Flowable.fromIterator)

Processor — like an Subject, but for Flowables

# See also

  * http://rxmarbles.com/
  * [Rx Design Guidelines](https://blogs.msdn.microsoft.com/rxteam/2010/10/28/rx-design-guidelines/)

# Book Recommendations

  * [Reactive Programming with RxJava](https://www.amazon.com/Reactive-Programming-RxJava-Asynchronous-Applications-ebook/dp/B01LZQGIIC/ref=as_li_ss_tl?keywords=java+rxjava&qid=1555871313&s=books&sr=1-5-catcorr&linkCode=ll1&tag=wilcodevelsol-20&linkId=3c88549ab929ec56bdc3519c33959818&language=en_US)

