---
path: /learnings/learning_angular
title: 'Learnings: Angular'
---
# Table Of Contents

<!-- toc -->

- [General Angular Information](#general-angular-information)
  * [async patterns](#async-patterns)
    + [asyncpipe - `{{ blahblah | async}}`](#asyncpipe----blahblah--async)
  * [async as](#async-as)
  * [order of callbacks:](#order-of-callbacks)
- [Architecture / Organization](#architecture--organization)
  * [Style Guides](#style-guides)
  * [Ways to talk to each other](#ways-to-talk-to-each-other)
    + [EventEmitter](#eventemitter)
      - [NOTE: Angular doesn’t offer an API to support event bubbling. (Have to use native DOM events for that)](#note-angular-doesnt-offer-an-api-to-support-event-bubbling-have-to-use-native-dom-events-for-that)
    + [@Input, @Output](#input-output)
  * [Actually making loosely coupled components: Mediator pattern](#actually-making-loosely-coupled-components-mediator-pattern)
    + [or just seriously use >](#or-just-seriously-use--)
      - [Main concepts](#main-concepts)
  * [and routes](#and-routes)
  * [and pulling DI provider items from component / library modules in the main app](#and-pulling-di-provider-items-from-component--library-modules-in-the-main-app)
  * [Network communication](#network-communication)
- [Directives](#directives)
- [RxJS](#rxjs)
  * [Using DI in Angular](#using-di-in-angular)
    + [See also](#see-also)
    + [Example @Component](#example-component)
  * [gotchas](#gotchas)
    + [can not use a Typescript interface as a DI type for the provided parameter](#can-not-use-a-typescript-interface-as-a-di-type-for-the-provided-parameter)
- [Testing Angular Applications](#testing-angular-applications)
  * [Configuring Karma for CI servers](#configuring-karma-for-ci-servers)
    + [Using headless Chrome with Karma](#using-headless-chrome-with-karma)
    + [Actually running it...](#actually-running-it)
  * [Unit Tests](#unit-tests)
    + [Shahow Tests](#shahow-tests)
    + [selecting DOM elements](#selecting-dom-elements)
    + [routing tests](#routing-tests)
    + [Overriding DI](#overriding-di)
      - [See also](#see-also-1)
    + [Testing Async code / network requests](#testing-async-code--network-requests)
      - [Faking tests to seem sync](#faking-tests-to-seem-sync)
      - [Using `HttpClientTestingModule`](#using-httpclienttestingmodule)
- [End To End / Integration Tests](#end-to-end--integration-tests)
  * [Using Headless Chrome with Protractor](#using-headless-chrome-with-protractor)
  * [Questions](#questions)
    + ["Can we run this on Jenkins etc?"](#can-we-run-this-on-jenkins-etc)
    + [Open questions:](#open-questions)
      - [Docker image with Protractor](#docker-image-with-protractor)
    + [Q: Can you use Selenium and/or Selenium Grid to run protractor created tests?](#q-can-you-use-selenium-andor-selenium-grid-to-run-protractor-created-tests)
    + [can I run multiple browsers in my test?](#can-i-run-multiple-browsers-in-my-test)
  * [Using Pupetter With Protractor](#using-pupetter-with-protractor)
    + [See also:](#see-also)

<!-- tocstop -->

# General Angular Information

## async patterns

### asyncpipe - `{{ blahblah | async}}`

Will only do the filter when the observable has some value.

## async as

Gives you a large object that you can route the value from the subscription into variable

## order of callbacks:
  0. Constructor
  1. `ngOnChanges`
  2. `ngOnInit`
  3. `ngDoCheck`  <-- each pass of change detector
  4. `ngAfterContextInit` <-- after child component state inited and projection complete
  5. `ngAfterContentChecked`
  6. `ngAfterViewInit`
  7. `ngAfterViewChecked`
  8. `ngDestroy`

to pull those in inherit from interface that is the name without the Ng `implements DoCheck` for example


# Architecture / Organization

Can separate project out into root Application and modules. (The add the component to the root application ‘s manifest and use the directives from the module(s) you imported)

Gyou could organize your modules by feature, or by component, maybe even by domain in a domain driven design approach.

## Style Guides

  * [File Naming/Location Style Guide](https://angular.io/guide/styleguide#application-structure-and-ngmodules)

## Ways to talk to each other

  * event emmitter
  * Subject <-- RxJS
  * BehaviorSubject <-- rxjs

### EventEmitter

- [BOOKNOTE]:

> You’ll notify the parent about the latest prices by emitting custom events via the @Output property of the component.

- Angular Component with Typescript
`@Input`: lets you speciff essentially HTML attributes when you instantiate your compontent in an HTML template

`@Output` : way to send events _up_, from child -> parent (). (Repmember, one way data flow. To send data up you need to use events.)


#### NOTE: Angular doesn’t offer an API to support event bubbling. (Have to use native DOM events for that)

### @Input, @Output

## Actually making loosely coupled components: Mediator pattern

(Mediator handles @Ouput events from one component and sends them as @Input attributes into another).

(Could make this an injectable service too...)

### or just seriously use  <<Angular_NgRx>>

It’s redux but for Angular

And this time with RxJS backing it - subscribe the the store.

1. action
2. Effect
3. Reducer
4. (The Store)
5. Selectors

#### Main concepts
## and routes

Routes are defined on a component / module level. export routes with `forChild` to do this.

By default / generator routes live in `routing.module.ts`

## and pulling DI provider items from component / library modules in the main app

- [BOOKQUOTE]:

> If a module is loaded eagerly, its providers can be used in the entire app, but each lazy-loaded module has its own injector that doesn’t expose providers. Providers declared in the @NgModule() decorator of a lazy-loaded module are available within such a module, but not to the entire application. L

-  Angular Development with Typescript (Ed 2)
## Network communication

Usually you'll stash all your HttpClient stuff into a service.

Can use Http Interceptors to add special things to the request, etc etc.


# Directives

  1. Componets
  2. Structural Hirectives
  3. Attribute Directives

# RxJS


## Using DI in Angular

### See also
  * [Angular 7 and DI](https://medium.com/@tomastrajan/total-guide-to-angular-6-dependency-injection-providedin-vs-providers-85b7a347b59f)

### Example @Component

(the "new / fancy" Angular 7+ `providedIn` syntax doesn't work here, for reasons...)

    @Component( {
        selector: 'foobar',
        providers: [
            { provide: ContactService, useValue: aContactService }

        ]
    })
    export class ContactEditComponent {
        constructor(contactIn: ContactService) {
            this.contact = contactIn
        }
    }

## gotchas

### can not use a Typescript interface as a DI type for the provided parameter

Because types son’t really exist / are removed by the compiler. use abstract classes instead (really) and your classes that conform to that interface should just inherit from that base class.


# Testing Angular Applications

First: tools:
  * unittests: jasmine / Karma
  * integration tests: Protractor


[Official Angular documentation on testing](https://angular.io/guide/testing)

## Configuring Karma for CI servers

### Using headless Chrome with Karma

add karma-chrome-launcher to devDependencies

### Actually running it...

`$ npm run karma run`

###

## Unit Tests

### Shahow Tests

tost component one level deep: don't render child componets

### selecting DOM elements

    import { By } from '@amgular/platform-broswera

    By.css('#hero_text')  // by directive too! .directive function

### routing tests

`RouterTestingModule`

### Overriding DI

    TestBed.configureTestingModule({
        declarations: [ContactEditComponent, FavoriteIconDirective],
        // ^^^^ components you are using go here
        imports: [
            AppMaterialModule,
            FormsModule
        ],
        // ^^^^ array of modules that the component you are testing requires

        providers: [{provide: ContactService, useValue: contactServiceStub}]
        // ^^^ override DI. (here we inject a mock - using the same provider mechansim as our component declared
    });

#### See also

  * [an excellent article explaining both how all these options work AND how tests work with it](https://offering.solutions/blog/articles/2018/08/17/using-useclass-usefactory-usevalue-useexisting-with-treeshakable-providers-in-angular/)
  * [more on testing and DI in Angular](https://medium.com/@ali.dev/how-to-angular-unit-testing-components-pipes-services-directives-a65c2fff581f)

### Testing Async code / network requests

#### Faking tests to seem sync

You can use [fakeAsyc](https://angular.io/api/core/testing/fakeAsync) which enables you to write async code *without* having to deal with Jasmine's `done` callback.

#### Using `HttpClientTestingModule`

Angular builds in a module for mocking HTTP requests

this also automatically does `fakeAsync` work, so you don't have to call `done`.

(Also note `HttpClient` is an RxJS Obserable, so those rules apply.)

# End To End / Integration Tests

Protractor (which bundles up Chrome, Firefox by way of WebDriver and/or Selenium).
Firefox and and Chrome can support direct connections, without going though Selenium server, but all the other browsers you’ll have to use that.

## Using Headless Chrome with Protractor

[protractor tests on headless chrome](http://www.webdriverjs.com/execute-protractor-tests-on-headless-chrome-browser/)

## Questions

### "Can we run this on Jenkins etc?"

### Open questions:

  * does Protractor end to end tests require the angular server running? (would potentially require a backend running) <-- how to replicate that???
  * if it does, how to have port isolation to allow multiple end to end tests to run on the same Jenkins build agent (assume no build agent in separate Docker container isolation fanciness)
  *

#### Docker image with Protractor

Because you need Firefox, Protractor, etc.

See how [Grubhub does it with Docker containers](https://bytes.grubhub.com/end-to-end-testing-with-docker-71008dca11a0).

Their setup got me thinking an interesting thought: do we use Docker compose or something to run the angular project in "one" container or along side the container to achieve isolation???

also points to their headless chrome container they use

### Q: Can you use Selenium and/or Selenium Grid to run protractor created tests?

A: It seems so:

  * [instructions from TestingBot on how to do that](https://testingbot.com/support/getting-started/protractor.html)

### can I run multiple browsers in my test?

  A: yes. set multiCapabilities

## Using Pupetter With Protractor

  Very easy: just point protractor towards the exec path from Puppetter?

### See also:

  * https://medium.com/@danharris_io/how-to-setup-angular-e2e-tests-on-vsts-ci-be0872f9dc31

