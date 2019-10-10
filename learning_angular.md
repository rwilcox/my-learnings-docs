---
path: "/learnings/learning_angular"
title: "Learnings: Angular"
---

# General Angular Information
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

Protractor (which bundles up Chrome, Firefox by way of WebDriver and/or Selenium)

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
  
