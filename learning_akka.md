---
path: /learnings/akka
title: Learning Akka
---
# Table Of Contents

<!-- toc -->

- [>](#)
- [thoughts on when to use Akka](#thoughts-on-when-to-use-akka)
  * [in SEDA](#in-seda)
- [When to use Akka: Futures for Concurrency, Actors for State](#when-to-use-akka-futures-for-concurrency-actors-for-state)
- [Messgae sending patterns in Akka](#messgae-sending-patterns-in-akka)
  * [Ask pattern](#ask-pattern)
  * [tell pattern](#tell-pattern)
    + [(This is called the pipe pattern)](#this-is-called-the-pipe-pattern)
    + [forward pattern](#forward-pattern)
- [message sending abstractions](#message-sending-abstractions)
  * [Pool / router](#pool--router)
  * [dispatchers](#dispatchers)
    + [default dispatcher](#default-dispatcher)
- [Akka Cluster](#akka-cluster)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

# <<Learning_Akka>>

Akka really meant for Scala: can use it with Java but super verbose and really wants you to putt other things like partial functions that are hard in Java

# thoughts on when to use Akka

>For quite a while, I was of the opinion that it's better to not use Actors if you don't have either:
>
>State and concurrency; or
Distribution
If you aren't using Akka for remoting or you aren't using Akka for concurrent access to state by encapsulating state in Actors, then it may not be obvious what the benefits are compared to stateless classes that are asynchronous and non-blocking.

>However, I believe this is because I was writing Actor code with poor designs. It is true that if you have no state, an asynchronous API is simpler than using Ask with Actors. However, if you are designing with the "Tell Don't Ask" principle, then you can have code that is simpler, better performing, and can be easier to debug when using Actors.

## in SEDA

As an overriding architecture to enable Staged Event Driven Architecture (SEDA)???!!! Work gets passed from actor to actor, not raw executors?????


# When to use Akka: Futures for Concurrency, Actors for State

    Public class myActor extends akka.actor.AbstractFSM<S, D>

# Messgae sending patterns in Akka

## Ask pattern

>When you ask an Actor, Akka actually creates a temporary Actor in the Actor system. The sender() reference that the Actor replies to becomes this temporary Actor

## tell pattern

Requires you to pass a reference to the actor you want to send the reply to, then sending different types of messages for request and response for a message

### (This is called the pipe pattern)

Can also manually create an extra actor aka for response callback composing

### forward pattern

> The intermediate Actor hands off the message, or possibly a new one, but the original sender is passed with the new message.

# message sending abstractions

## Pool / router

Load balancer for messages, can use round robin, smallest mailbox, scatter / gather, consistent hashing, others

## dispatchers

Control where work assigned to actor etc runs (i.e. Can be pinned to a thread, run on same thread as called - aka awesome for testing , or just use the default one)

One strategy here is to separate work of different importance or scaling characteristics into separate dispatchers, to make sure one set of actors don't resource starve another set (for example)

### default dispatcher

Don't block

# Akka Cluster


# Book Recommendations

  * [Akka In Action](https://www.amazon.com/Akka-Action-Raymond-Roestenburg/dp/1617291013/ref=as_li_ss_tl?keywords=akka&qid=1555868048&s=gateway&sr=8-1&linkCode=ll1&tag=wilcodevelsol-20&linkId=f0c85d9bd6f4d078277b7d1e92c860a2&language=en_US)
  * [Learning Akka](https://www.amazon.com/Learning-Akka-Jason-Goodwin/dp/1784393002/ref=as_li_ss_tl?keywords=learning+java&qid=1555872074&s=books&sr=1-21-spons&psc=1&linkCode=ll1&tag=wilcodevelsol-20&linkId=d1ca778a840a51bdb7d41b8139a1c122&language=en_US)
