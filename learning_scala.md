---
path: "/learnings/scala"
title: "Learnings: Scala"
---

# Scala

          var capital = Map("US" -> "Washington", "France" -> "Paris")

   
       val x: HashMap[Int, String] = new HashMap[Int, String]()
 
   Or
   
       val x = new HashMap[Int, String]()
 

# interactive REPL
  
      $ Scala
      
     $ Scala demo.scala
 
#  Variables:
 
   * Val - const
   * var - let ("ready for writing")
 
# syntax
   * semicolons optional (but rules about "semicolon inferience")
   * any method call can be used in "operator mode":
         j append myNewThing
         j appendTwo (myNewThing, secondThing)
    * can leave off parens on empty method calls 
    * == checks for value equality, eq checks for references equality
 
## declarations

     val msg3: String = "Hello yet again, world!"
     
     Val msg3 = "hello again"
 
 
## recommendation
 
   reach for immutability first

# Function
 
   
       def max(x: Int, y: Int): Int = {
           if (x > y) x
           else y
         }
 
  Notes:
    * variable: Type
    * implicit returns (most situations????)
    * can leave off return type if it's super obvious, also braces if it's one line
 
## method syntax


		def thingy( arg1: String, arg2: Int ): String = {

		}


## lambda  syntax

    Arg1 => statement
    
    (Arg1: String) => statement
 
  _ can be parameter(s) "blank". you can use this to build up partially applied functions
  

### syntax (defining a function literal)

    val r = ( a : Int )  => { "out" }
    
    
     val r : ( Int ) => String  = ( a ) => { "out" }
 
 
    
### as closures
 
  Vsriables csptured as references, thus readwrite in Swift pariance (but if outer reference reassigned variable in block still points to data)
 
### named parameters
 
  Csn use name of variable as keyword parameters
 
### method references

If statement takes one arg, and calls function that also only takes one arg, can do

    Arts.foreach(statement)

### calling methods

can leave off parens if =< 1 parameter

# Generics
  
  Array[String]
  
# Arrays

MyArray(0) = "Yo" <--- not [], 

Technically Scala's Areay type overrides 'apply' to achieve this!

Mutable

# operator silliness

## right vs left operators

Operator acts in the object to its left, unless the method name ends with :

Thus 10 / 5 = 2 but 10 /: 5 = 0.5

# Nil

With a capital N

# mutable CSS immutable data structures

Just in different namespaces. so could write code like so

    Import Scala.collection.mutable
    Import Scala.collections.immutable
    
    Val a = Mutable.Map()
    
    
    
# Class

## (Primary) constructor syntax:

    class Thing(fName : String, lName: String) {

    }

Note that parameters passed in this way are NOT fields

    class Thing(fName : String, lName: String) {
        val firstName = fName
    }



Default access level is public (can use keyword private)

Can not have static members
If need static members this is "object". Read as "singleton object" .  class + (singleton) object = "companion object " (must be in same source file)

Method parameters are const 

> The Scala compiler will compile any code you place in the main body of the class in the primary constructor

## Auxiliary constructors

Auxiliary constructors created by def this(.....) [access primary constructor by this(parameters defined to class declaration)]


# main method in Scala

    object Summer {
      def main(args: Array[String]) = {
      }
    }
 
## Wait, what about getters / setters

"Uniform access method" <-- accessing methods should look like fields, and vs versa.

So could call with syntax that look like direct member access, but can refactor this later to be methods.

(Technically Scala is generating methods for you and calling them, but doesn't matter)

### but I really need it for beans

    class Thing(@BeanProperty val fName: String)

`val` does not create us a setter, because immutable.

## extending classes (even ones you don't own)

    implicit class MyStringAdditions(val s: String) {
        def happyMethod = ...
    }

but need to put this in another class or in a package.

## and mixins

They're called traits

    Class mything extends String, MyTrait
    
   OR
   
     class mything extends String with MyTrait
     
   
   can define methods, keep state
   
   traits gave a type hierarchy too: can define sub classes of a trait and override methods of supertrait or call supertrait implementairon of method
   
### on instatiation too!!
   
   Not just at class definition time, but if you decide some instance of this thing needs to have some trait mixed in "just this once" you CAN.
   
  
## Lazy Member Variables


    class DatabaseConnector( string dbURL ) {
    
    	lazy var dbConnection = createDBConnection()
    	def createDBConnections(): DBConnection = {
    		//...
    		
    		connection
    	}
    }
## Case Classes

Features:

  * parameters to constructor are val -> fields.
  * auto implements `toString`, `hashCode`, `equals` for properies (deep comparisons too)
  * auto creates copy method <-- useful "give me an object like this object, but with one or two fields having different values"

Anti features:

  * can not be subclassed
  
# Pattern Matching

like better switch/case statements : can also use for nil checks

(Mostly) compares whole objects: thus the case object makes sense as the equals operator is auto populated with values from fields).

# Implicits



# Tuples

    val t1: (Int, String) = ( 1, "two" )

# and the JVM

JVM boot up avoided by daemon fsc you pass file names to compile to it.

# literal types

## strings

Triple quotes. white space can be trimmed off by using stripMargin ability

### Special Prefixes

  * `s`: `s"Hello ${woldVar}"`: string interpolation.

### and multi line strings when you want to indent but your output can't be


Use strip margin and this syntax

    var foo = """line one
                |line two""".stripMargin

## symbols

'Thing

#iteration

## generator 

> for (file <- filesHere)

### generator + filter

> for (file <- filesHere if file.getName.endsWith(".scala"))

Nested <- means you'll have one loop happen then the next

# Currying

Built in currying!!!

    def doThings( firstName : String )( secondName : String ) : String = {
    	"${firstName}  ${secondName}"
    }

	 doThings("Ryan")("Wilcox")
	 
	 
this matters for DSL creation


    def doThings( firstName : String) ( dynamicConstructor : ( string ) => bool ) = {
    	...
    
    }
    
    doThings("Ryan") { => "Wilcox " }
    
## Equality

  * value types: numeric equality
  * reference types: `equals`
  * boxed or auto boxed numbers: `equals`
  *
  *
# With Maven

    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <configuration>
          <source>1.6</source>
          <target>1.6</target>
        </configuration>
      </plugin>
      <plugin>
        <groupId>net.alchim31.maven</groupId>
        <artifactId>scala-maven-plugin</artifactId>
        <version>3.2.1</version>
        <executions>
          <execution>
            <goals>
              <goal>compile</goal>
              <goal>testCompile</goal>
            </goals>
          </execution>
        </executions>
        <configuration>
            <launchers>
                <launcher>
                  <id>sample</id>
                  <mainClass>com.wilcox.DockerEnvMain</mainClass>
              </launcher>
          </launchers>
          <args>
            <!-- work-around for https://issues.scala-lang.org/browse/SI-8358 -->
            <arg>-nobootcp</arg>
          </args>
        </configuration>
      </plugin>
    </plugins>
 

## And runnable jars

      <properties>
        <scalaVersion>2.12.0</scalaVersion>
        <scalaBinaryVersion>2.12</scalaBinaryVersion>
      </properties>
      <dependencies>
          <dependency>
            <groupId>org.scala-lang</groupId>
            <artifactId>scala-library</artifactId>
            <version>${scalaVersion}</version>
          </dependency>


## Neat maven tools

    $ mvn scala:console

# GENERICS


  * type erased at runtime, like Java
  * declarations using [], not <>

# packages / importing code

Similar rules to Java, except import blah.* -> import blah._

can appear anywhere in program
Can be VARIABLES, not just static class path
# casts

    myEmployee.asInstanceOf[Person]

coupled with 

    myEmployee.isInstanceOf(Employee)

both methods on `Any`, the global superclass of Scala objects

like Java could throw `ClassCastException`

## idomatic scala:

consider using a pattern match with a type parameter instead.

## casts that are just conversions

Couple different ways to do this in Scala, best(?) way seems to be using implicit classes and having those define new `asThinger`, `asArk `, `asString` methods for the destination class.

(Q: so `as` is the prefix, not `to` ???)

https://www.javacodegeeks.com/2014/07/explicit-implicit-conversion.html

## with third party libraries

with shapeless you can use / implement `cast` method, which gives you more power.

# testing

  * ScalaTest
    - flatSpec : it should "have a height equal to the passed value" in {
        val ele = elem('x', 2, 3)
        ele.height should be (3)
      }
      
  LOOKS AWESOME!!
  also FeatureSpec that implemts given / when / then syntax 

# TODO: to figure out

  * new statement with {} does ?????!!!
  * generics story
  * more functional stuff ??
  * `    val compatibilityResult: (Boolean, String) = checkCompatibility(vertexConstraint, head.constraints)`

# Book Recommendations

  * [Programming in Scala](https://www.amazon.com/Programming-Scala-Comprehensive-Step-Step-ebook/dp/B01EX49FOU/ref=as_li_ss_tl?keywords=scala&qid=1555896987&s=books&sr=1-3&linkCode=ll1&tag=wilcodevelsol-20&linkId=c4788b692e7d71dcf32298243b9e7571&language=en_US)
  * [Functional Programming in Scala](https://www.amazon.com/Functional-Programming-Scala-Paul-Chiusano/dp/1617290653/ref=as_li_ss_tl?keywords=scala&qid=1555896987&s=books&sr=1-4&linkCode=ll1&tag=wilcodevelsol-20&linkId=43ba5d9668e75d1aca4c02de6ae1b990&language=en_US)
  * [Programming Scala](https://www.amazon.com/Programming-Scala-Scalability-Functional-Objects-ebook/dp/B00QJDYKH6/ref=as_li_ss_tl?keywords=scala&qid=1555896987&s=books&sr=1-19&linkCode=ll1&tag=wilcodevelsol-20&linkId=aa957f77a0fdd45e946c3ea1a05a53db&language=en_US)
