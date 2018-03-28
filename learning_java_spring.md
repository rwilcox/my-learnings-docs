---
path: "/learnings/java_spring"
title: "Learnings: Java: Spring"
---

# Spring Boot

## Getting Started

  * Spring-boot-cli (port availiable, installs spring program name)
  * IntrlliJ: Spring Intializer in new project window

### and Groovy

If you want to prototype something out with Groovy , you can use the spring CLI , Groovy and grab to even faster boot up a Spring app (package with spring jar command and sub command )

## and routes that  map for URLs-> methods

/mapping gives you the URL route, which bean, which method is called for the route/ method. Thanks Spring Actualizer

### with CLI

Can use CRaSH / spring-boot-starter-remote-shell the get CLI

Launch app and use SSH to connect to port number it tells you

Can run bean inspection and anything else you would be able to do through the endpoints (either mappings, health, etc rtc)

### pretty dashboard

Local host:8180 in a web client

https://github.com/codecentric/spring-boot-admin

## ... But security!?

Can secure spring actuator routes with Spring Security

## making it an init.d / systemd thing / 

<Configuration><executable>true</executable></configuration> <---- does that Bash thing where it prefixes the jar file with some Bash script (useful if you're not wrapping with Baliista or Docker or something....) <--- so can put this in /etc/services (??)

https://docs.spring.io/spring-boot/docs/current/reference/html/deployment-install.html

#  Actuators  <<Spring_Actuators>>

[List of Actuator Endpoints](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-endpoints.html)

Enable:
  * include `spring-boot-starter-actuator` to maven
  * OR `spring-boot-actuator` <-- (but maybe need some setup here??????)

See also:

  * Learning_Ops_Java_Spring
  
## Port number / path location

Set Spring Actuator to a different port with property value like so:

`management.port: 9001`
`management.context_path=/spring` <-- by default is just /


## Useful Endpoints

(can use spring security to lock these down!!)


### /bean

Describes every bean in context and every bean those beans are wired up with

### /env

Environment properties availiable to the app:

  * env variables
  * JVM properties
  * command line params
  * application.properties properties

any property name that ends with `password` or `secret` or `key` is auto starred out

### /metrics

Gives list of following built in metrics:

  * GC information
  * Memory
  * Heap
  * Class Loader
  * System (processor.uptime, instance.uptime, systemload.average)
  * Thread Pool
  * Tomcat session info
  * HTTP
  * etc etc
  
Can fetch only one metric by adding it to the URL: /metrics/gc.free <-- or whatever

### /health <<Spring_Actuators_Health>>

^^^ health response information can be customized: beans that implement `HealthIndicator` interface

many built in HealthIndicators: JmsHealthIndicator, `#{datastore}HealthIndicators`, MailHealthIndicator etc etc

(auto configured / conditional beans on the availability / use of the Spring Boot data store in question)

#### Health Endpoint and interactions with management.port

If `management.port` is set, the following is true:

  * `/health` is exposed on management.port
  * it contains sensitive information (ie disk space)

If *only* `server.port` is set (read: no `management.port`), the following is true:

  * `/health` is exposed on server.port <-- if management.security.enabled=false this will NOT contain sensitive information
   
### /git

[Can read from generated git.properties file on classpath to give information about what commit the running code is](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-endpoints.html#production-ready-application-info-git)


<<Java_Spring_Boot_JMX>>

## JMX

All actuator endpoints storied in `org.springframework.boot` domain.

See also:

  * Learinng_Ops_Java_JMX

## Often Used Properties:

| Property Name                          | Description / Notes                                                                                                | 
|:-------------------------------------- |:------------------------------------------------------------------------------------------------------------------ |
| management.security.enabled            | NOTE: do NOT turn this off without a management port: your actuators etc are then EXPOSED TO PUBLIC INTERNET!!!    |
| management.port                        | explicitly specify where management.port is (usually server.port + 1)                                              |


# [Reactive Spring Stack / Spring Web Flux](http://docs.spring.io/spring/docs/5.0.0.BUILD-SNAPSHOT/spring-framework-reference/htmlsingle/#web-reactive)

[Spring WebFlux over Spring MVC](http://docs.spring.io/spring/docs/5.0.x/spring-framework-reference/web.html#web-reactive)
^^^ both clients and server. So now have reactive web client.

This means it wouldn't be hard AT ALL to turn your reactive spring controller into a stream based API, instead of one-and-done.

Controllers should return [reactive container types](https://spring.io/blog/2016/04/19/understanding-reactive-types):

  * `Mono<>`object <-- serialize this one thing before sending up
  * `Single<>` object <-- same as `Mono<>`, but RxJava compatible type
  * `Flux<>` object <-- good for streaming requests
  * `Observable<>` object <-- same as `Flux<>`, but RxJava compatible types


See also:

  * Learning_Java_Rx

SpringMVC needs to know how long the stream should go on. Use the content type header for this: `application/json` for example is finite, a streaming video is "infinite". Set this via `@produces(


# using Pivotal Reactor

Uses http://projectreactor.io/
(Also powers a Clojure library and has wide support from major players)

#terms

## cold flux

Deosn't publish until subscriber connected
When connected, sub gets all events from beginning 

## hot flux

Published instant flux created
New subs just get most recent data

# Profiles
(Spring 3.1 feature)

To select which implementation of a bean you want in which environment

    @Configuration
    @Profile("dev")
    public class DevConfig() {
    	@Bean
    	public String EnvName() {
    		return "dev";
    	}
    }
    
    
    @Configuration
    @Profile("production")
    public class ProdConfig() {
    
    	@Bean
    	public String EnvName() {
    		return( "production - build {}".... )
    	}
    }
    
Control active profile:

  * context parameters on web service
  * JNDI entries
  * environmental variables
  * set `spring.profiles.active` property
  * set `spring.profiles.default` property
  * set `@ActiveProfile` annotation on integration test case
  
## and testing

# Mutliple qualifiers on beans

Can not do this - must create annotation for additional qualifiers

@Target({ElementType.FIELD, ElementType.METHOD, ElementType.PARAMETER, ElementType.TYPE, ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Qualifier
public @interface MyOrderQualifier {
}

@Target({ElementType.FIELD, ElementType.METHOD, ElementType.PARAMETER, ElementType.TYPE, ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Qualifier
public @interface MyUrlQualifier {
}

See: 
# <<Java_JUnit_SpringMVCTest>>

IF TESTING NON SPRING-BOOT SPRING:

	 <dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-test</artifactId>
		<scope>test</scope>
		<version>4.2.7.RELEASE</version>
	 </dependency>

IF TESTING SPRING BOOT:

	`spring-boot-starter-test` 


## Classes for testing Spring MVC:

  * MockMvc <-- create HTTP "requests" that are processed by test controller
  * MockMvcBuilders <--- builds you MockMvc instances
  * MockMvcRequestBuilders <-- builds you HTTP "requests" that are sent to the tested controller
     - MockHttpServletRequestBuilder   <--- simple requests
     - MockMultipartHttpServletRequestBuilder   <--- multipart requests
     
  * MockMvcResultHandlers  <--- provides asserts etc for checking HTTP response from controller
  
## Stand alone Spring config and Junit

>  If we want to use the web application context based configuration, we have to run our unit tests by using the SpringJUnit4ClassRunner class. 


## Example

Lesson Link: https://www.testwithspring.com/lesson/configuring-the-system-under-test/

		@Category(UnitTest.class)
		public class HelloControllerTest {
 
			private MockMvc mockMvc;
 
			@Before
			public void configureSystemUnderTest() {
				mockMvc = MockMvcBuilders.standaloneSetup(new HelloController())
						.build();
			}
		}
		
standaloneSetup will register one or more @Controller instances and configure the Spring MVC infrastructure programmatically

## Testing controllers with mock objects

See `StandaloneMockMvcBuilder` to specify intercepters, placeholderValues, locale resolvers etc etc

but probably should be minimal with these

> 
>    I configure the used ExceptionResolver if my application has error views that are rendered when a controller method throws an exception.
>    I specify the used LocaleResolver if a Locale object is injected into a method of the tested controller as a method parameter.
>    I specify the used ViewResolver if I don’t want that my unit tests use the InternalViewResolver that is used by the Spring MVC Test framework if no view resolver is configured.

# Spring Components

## Spring Roo: Rails Generate, (Rails Console)(???) for Spring
## Spring Framework (DI / IoC related highlights):
  
    See ~/Writing/whitepapers/SpringJustDependencyInjection.ooutline
      
    - AoC
    - Spring Security
    - Data Access
    - Convention over Configuration
    - IoC

  * Spring Test:
  
    - Sub Components:
    
      * 
    
    - Important Classes / Annotations:
    
      * [@ContextConfiguration](https://docs.spring.io/spring/docs/current/spring-framework-reference/html/integration-testing.html#testcontext-ctx-management-javaconfig) < --- does NOT set up logging or properties file
      * @MockEnvironment
      * @MockPropertySource
      * @ContextHierarchy
      * [@TestPropertySource](http://docs.spring.io/spring/docs/4.3.x/javadoc-api/org/springframework/test/context/TestPropertySource.html)
      * [ApplicationContextAware superclass](https://docs.spring.io/spring/docs/current/spring-framework-reference/html/integration-testing.html#testcontext-ctx-management)
          "an alternative is to inject the application context into your test class via @Autowired..."          
      * ReflectionTestUtils
    
    - With Spring Boot:
      "https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-testing.html"
      
      * [@MockBean](http://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-testing-spring-boot-applications-mocking-beans)
      * [@SpringBootTest](https://docs.spring.io/spring-boot/docs/current/api/org/springframework/boot/test/context/SpringBootTest.html)
          "technically in springframework.boot.test.context < -- sets up logging, config etc etc"
      
# Spring Core Container notes

## @Bean declaration bean names

Takes class name and lower cases first letter: TeamPlayer becomes teamPlayer

## scanning mutliple bases packages with @ComponentScan
    @ComponentScan(base packages={"com.what", "com.where"})


# Spring Cloud Stream

Abstracts over streaming / logging solutions

## Speing Cloud Data Flow

DSL for stream topologies
Scdf shell CLI tool

## Speing Cloud Contract

Sec/test/resources/contracts GROOVY scripts / DSL that specify request and response in groovy format

# HTTP Requests With Spring

## Spring 5: WebClient:

Built on netty. reactor

## Spring 4: 
