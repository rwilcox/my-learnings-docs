---
path: "/learnings/java_concurrency"
title: "Learnings: Java: Concurrency"
---

# <<Java_Concurrency>>


## <<Java_Concurrency_Memory>>

See also:

  * Learning_Java_Hotspot_Memory_Zones_And_Threads
  
## <<Java_Concurrency_Load>>

Q: how much are any one particular thread or executioner group actually using the CPU, vs waiting for sync IO/network? Profile this: this will tell you how much you can cheat WRT CPU core count...

## <<Java_Concurrency_Synchronized_Keyword>>

can be a method declaration

    public void syncronized addIt(int i) { MyClass.a += i;}

Can also do it as a block in a method

    public addIt(int i) {
        logger.info("into");
        syncronized(Myclass.class) {
            Myclass.a += i;
            }
        }
        
## <<Learning_Java_Concurrency_TROUBLE>>

### and volatile keyword

OS may cache value of a variable shared across threads. volatile will make sure to read this from memory instead
- [Source]: high performance apps with Java 9

#### avoiding volatile

  *Atomic... classes for adding stuff
  * ComcurrentHahMap, ArrayList, etc —- more efficient than wrapping self
  
  
### and fairness

Manually creating / waiting on a lock ReentrantLock can pass "fair" flag, which will make sure to give priority access to longest waiting requestor.


