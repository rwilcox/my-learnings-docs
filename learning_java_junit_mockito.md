---
path: /learnings/java_junit_mockito
title: 'Learnings: Java: jUnit: Mockito'
---
# Table Of Contents

<!-- toc -->

  * [>](#)
    + [Mocks vs Stubs vs spys](#mocks-vs-stubs-vs-spys)
      - [Stubs](#stubs)
      - [Mocks](#mocks)
      - [Spy](#spy)
- [>](#)
  * [Syntax Examples](#syntax-examples)
  * [`Mockito.mock` information:](#mockitomock-information)
  * [Easy @Mock Annotation](#easy-mock-annotation)
  * [Dealing with methods that return null](#dealing-with-methods-that-return-null)
    + [Null methods that we need to have a custom lambda implementation of...](#null-methods-that-we-need-to-have-a-custom-lambda-implementation-of)
  * [methods where we don't care what the passed parameter is](#methods-where-we-dont-care-what-the-passed-parameter-is)
  * [Mocking a class where you want all methods to themselves return mocks](#mocking-a-class-where-you-want-all-methods-to-themselves-return-mocks)
    + [Mocking an entire method chain - aka you've super broken Demeter's Law](#mocking-an-entire-method-chain---aka-youve-super-broken-demeters-law)
  * [Overriding implementation of specific methods](#overriding-implementation-of-specific-methods)
    + [Overriding implementation of specific methods, of an instance](#overriding-implementation-of-specific-methods-of-an-instance)
  * [Verifying mock methods called](#verifying-mock-methods-called)
  * [Overriding implementation of specific method with custom code](#overriding-implementation-of-specific-method-with-custom-code)

<!-- tocstop -->

# <<Java_JUnit_Stubs>>

  * must implement interface or subclass and override required methods of interface/class

## Mocks vs Stubs vs spys

> Stubs are useful when we want to control the behavior of the replaced dependencies.
> Mocks are useful when we want to control the behavior of the replaced dependencies and verify the interactions that
>  happen between the system under test and the mock in question.
> Fakes are useful when we want to replace a problematic dependency with a test double that acts like the real thing.
>  In other words, we don’t want to configure the response that is returned when a method of our test double is invoked
>  and we don’t want to verify the interactions between the system under test and our test double.



### Stubs

> Because we cannot verify that an interaction happened between the system under test and a stub, we should use stubs
> in situations where we don’t have to verify that the system under test actually invoked a method of a stub.

### Mocks

TOTALLY FAKE OBJECTS

> Because we can verify that an interaction happened between the system under test and a mock, we should use mocks
> in situations where we want to verify that the system under test actually invoked a method of our mock object.

### Spy

CAN SPY ON REAL OBJECTS!!!!

> First, we need to verify the interactions between the system under test and our test double, and we don’t know how
> many times the target method is invoked or what values should be passed as method parameters. Because we cannot
> specify our expectations and verify interactions by using a mock object, our only option is to use a spy.



# <<Java_JUnit_Mockito>>

Overview:

  * Has old Given/When syntax
  * AND new BDD like syntax
  * Mockito provides a custom test runner that would create our mocks for us with annotations, but ehhhh.... custom test runner = not ideal

Limitations:

  * can not mock private methods??
  * can not mock final??
  * can not mock static methods??
  * anon inner classes

PowerMockito for these????

Good reference on Mockito: https://dzone.com/refcardz/mockito

## Syntax Examples

Old And Busted:

    when( instance.method() ).thenReturn(1)

New Hotness (BDD) [BDDMockito](https://static.javadoc.io/org.mockito/mockito-core/2.8.9/org/mockito/BDDMockito.html):

    given( instance.method() ).willReturn(1)
    doNothing( ).given( instance ).voidMethod()


## `Mockito.mock` information:

  * by default returns null for all methods implemented by that class
  * _can_ provide a default answer for all(????) methods called. Not a great idea, but....

## Easy @Mock Annotation

    public class ArkShip {
      @Mock Hyperdrive engine;

    }

NOTES:

  1. When using this annotation need `MockitoJUnitRunner` as the `@RunWith` annotation over the test class
  2. OR manually call `MockitoAnnotations.initMocks(this)` to inject the dependancies.

## Dealing with methods that return null

    doNothing().when( myMock ).myMethod( ... )

### Null methods that we need to have a custom lambda implementation of...

		doAnswer( invocation -> this.count++).when( mock ).myMethod( ... );

## methods where we don't care what the passed parameter is

    when( myMock.myMethod( any( String.class ) ) ).thenReturn( 42 );

## Mocking a class where you want all methods to themselves return mocks

In case where you're mocking out a fluent API:

    myThing.someMethod(0).increment()

In test code:

    Spaceship destiny = mock( Spaceship,

### Mocking an entire method chain - aka you've super broken Demeter's Law

Example that shows how deep stub works:

    Foo mock = mock(Foo.class, RETURNS_DEEP_STUBS);
    // note that we're stubbing a chain of methods here: getBar().getName()

    when(mock.getBar().getName()).thenReturn("deep");

    // note that we're chaining method calls: getBar().getName()
    assertEquals("deep", mock.getBar().getName());

## Overriding implementation of specific methods

		import org.junit.Before;
		import org.junit.Test;

		import static com.testwithspring.task.TestDoubles.stub;
		import static org.assertj.core.api.Assertions.assertThat;
		import static org.mockito.BDDMockito.given;

		class WhateverTest {
			private TaskRepository t;

			@Before
			public void createStub() {
				t = stub(TaskRepository.class);
			}

			@Test
			public void shouldReturnValue() {
				given(t.count()).willReturn(1);

				// or make it throw an exception
				given(t.findById(1L)).willThrow(new NotFoundException());

				assertThat( t.count() ).isEqualByComparingTo(1);
			}
		}

Can also use `willAnswer` API to provide custom implementations with a lambda.

### Overriding implementation of specific methods, of an instance

Use `spy`: this will only mock the methods you tell it about.

    ArrayList<String> s = org.mockito.Mockito.spy( new ArrayList<String>() );
    org.mockito.Mockito.doReturn( 42 ).when( s ).size();


## Verifying mock methods called

		import org.junit.Before;
		import org.junit.Test;

		import static com.testwithspring.task.TestDoubles.stub;
		import static org.assertj.core.api.Assertions.assertThat;
		import static org.mockito.BDDMockito.given;

		class WhateverTest {
			private TaskRepository t;

			@Before
			public void createStub() {
				t = stub(TaskRepository.class);
			}

			@Test
			public void shouldReturnValue() {
				verify(t).countMethod()
			}
		}

## Overriding implementation of specific method with custom code

May need to use special maven dep:


		<dependency>
			<groupId>info.solidsoft.mockito</groupId>
			<artifactId>mockito-java8</artifactId>
			<version>0.3.1</version>
			<scope>test</scope>
		</dependency>


        given(repository.count(1L)).willAnswer(invocation -> {
        	return 42;
        } );

# <<Kotlin_Mockito>>

## Example Usage:

`whenever( someInstance.someMethod(parameterNameOne = mockitoParameterMatcher)).thenReturn(somePrimative)`

(don't use when Mockito function as that's a keyword in Kotlin. You can, but encase it with backticks then it looks awkward)

## Example Verify it was called

`verify(someInstance).someMethod(parameterNameOne = expectedValue)`

## WTF getting weird errors like Kotlin realizing a thing is null at runtime

are you using your `someInstance` is a `mock<SomeClass>()`, or might it be a `SomeClass()` aka not actually a mock object?

## Verifying methods that have default parameters

use `anyOrNull` matcher.

`verify(someInstance).someMethod(parameterName = anyOrNull)`
