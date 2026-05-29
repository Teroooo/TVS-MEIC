# Introduction to Software Testing

## What is product quality?

```
Quality, simplistically, means that a product should meet its specification
```

This is problematical for software systems:
- Some requirements are difficult to specify in an unambiguous way
- Software specifications are usually incomplete and often inconsistent 
- **The quality compromise:** we cannot wait for specifications to improve before paying attention to quality, and procedures must be put into place to improve quality in spite of imperfect specification

Fitness for purpose, value to use

Quality = expectations - delivery

## Investing in software testing

Project managers view testing as a necessary evil that occurs at most only at the end of the project

- Costs money
- Takes too long 
- Creates hostility between the team and the other teams
- **spend as little as possible**

However, smart managers invest in testing, WHY?
- It increses the quality of product
- Reduces the time to develop the product
- It saves money

## Quality Cost

**Cost of performance:** all costs associated with planning and running tests (and revisions) just one time and activities that promote good quality (code reviews, training, ...)

**Costs of nonconformance:**

- Costs due to internal failures (before release)
    - Cost of isolating, reporting and regression testing bugs (found before the product is released) to assure that they're fixed
- Costs due to external failures (after release)
    - If bugs are missed and make it through to the customers, the result will be costly product support calls, possibly fixing, retesting, and releasing the software, and - in a worse case-scenario -- a product recall or lawsuits
    - Angry clients

```The later the Defect is detected, the more cost it brings```

### Quality is free!

- Development software example:
    - Each release contains 1000 bugs on average
    - Developers found 250 during development
    - Cost of internal bug: 10€
    - Cost of external bug: 1000€

- Scenario without test team:
    - Cost of quality = 10 * 250 + 750 * 1000 = 752.500€

- Scenario with test team
    - Test team costs 70.000€ and bugs found by test team cost 100€
    - Testers found 350 bugs and users 400
    - Cost of quality = 70.000 + 10 * 250 + 100 * 350 + 400 * 1000 = 507.500€

## How much does a bug cost?

Study made by IBM in 2008
- X : a normalized unit of cost


- Design : 1X
- Implementation : 5X
- Integration : 10X
- Beta Testing : 15X
- After Release : 30X

## Object oriented terms

| Client       | A class (object) that sends a message to anotherclass (object) |
|--------------|----------------------------------------------------------------|
| Server       | A class (object) that answers to a message sent by a client    |
| Cluster      | A group of classes that support some common purpose            |
| Member       | A method or instance variable                                  |
| Accessor     | A method that does not change the state of an object           |
| Modifier     | A method that can change the state of an object                |
| UT M/C/O/SUT | Under Test Method/Class/Object/System Under Test               |

## Introduction

Testing is a 2 step process:
 
1. Design tests by analysing SUT
2. Execute the tests
    - Manual
    - Automatic


Manual Testing:
- Low implementation cost
- Repetitive
- Boring
- Error-prone
- Slow
- High execution cost

Automatic Testing:
- High implementation cost
- Low execution cost
- Fast

## What is software testing?

A problem in systems engineering
- Automatic Testing is mainly about the development of automated system
- Design and implementation of a special kinf od software system

Often Software Testing equals to Find Bugs
- However, there are tests that do not reveal failures

Better definition:
- Software testing is the process of executing a software system to determine whether it matches its specification in its intended environment
    - Testing => running a program
    - A specification is crucial: Defines correct behaviour so that incorrect behaviour is easier to identify (Incorrect behaviour = software failure)
    - Specification should represent the expectations of the client

## When does a software bug occur?

The software doesn't do something that the product specification says it should do

The software does something that the product specification says it shouldn't do

The software does something that the product specification doesn't mention

More?

The software doesn't do something that the product specification doesn't mention but should

The software is difficult to understand, hard to use, slow, or - in the software tester's eyes - will be viewed by end users as just plain not right

## Types of tests

Depend on scope and/or goal of testing

**Unit test**
- Scope: a relatively small executable, a class, a method or a cluster of interdependent classes
- Goal: to show that the target of the test works has required

**System Test**
- Scope: Complete integrated application
- Focus on the capabilities and characteristics that are present only with the entire system
- Tests may be functional (input/output), performance and stress or load

**Integration Testing**
- Scope: a complete system or subsystem of software
- Can be difficult, Place objects in the states required by the test, Some classes not developed yet

**Regression Testing**
- Changes often break working code
- Rerun tests of version n-1 on version n before testing anything new
- Which tests? All of them may take too much time.

## How did those bugs escape testing?

Many reasons

The user executed untested code (**Code that is not tested does not work!**)

Different order of execution of the statements

Untested combination of input values

The user's operating system was never tested

Environment conditions not tested

...

## The limits of testing

Passing a test is not enough to show the absence of bugs
- If f(x) returns a correct result when x = 123 does not mean that it returns a correct value for all values of x.
- Moreover, if we run f(123) in different conditions it can return an incorrect value.
- Even doing many test for different values of x does not mean that f(x) works correctly for all values of x

Proof of correctness is equivalent to exhaustive testing

## The input/output space

Number of input and output combinations for trivial programs is surprinsingly large

For typical programs is astronomical

For typical systems is beyond comprehension

## Fault sensitivity and Coincidental correctness

Best bugs?
- Those that cause a failure every time they execute

However, most bugs are not like that

Fault sensitivity
- The ability of code to hide faults from a test suite
    - Executing buggy code not always expose the bug

Coincidental correctness
- Buggy code can produce correct results for some inputs
- Have x + x instead of x * x
- Same result for x = 0 or  x = 2

## How to design test cases?

Black box (behaioral) testing
- Uses expected responsabilities of IUT to design tests
- Tests are design independently of the language or algorithm used in IUT

White box testing
- Also relies on source code analysis to develop tests

Fault-based testing
- Purposely introduces faults into code to test
- Then check if those faults are detected by the test suite

Best approach: Mix black box and white box
1. Black box testing
2. Measure coverage of test suite improve using white box

How to design test cases in a rational way?
- Number of places to look for bugs is infinite

Solution
- Model the IUT
- Consider its fault model
    - A fault model identifies relationships and components of the SUT that are more likely to have faults
- Generate test cases based on the fault model
    - Apply a test strategy
- Add test cases based on code analysis, suspicious and error-guessing
- Develop expected results for each test case

## Specification of a test case

Test Case = a test of something
- In OO, corresponds to invoke a given method on an object

Specification of a test case includes:
- The method to test
- The initial state of the system
    - initial state of the object being invoked (OUT)
    - and maybe some othe global variables
- Input test values
    - Includes the parameters of the MUT
- The expected output
    - Includes returned value (if any)
    - Expected result state of the invoked object
    - And (maybe) expected state of parameters
    - And (maybe) expected state of global variables
    - ...

## Test Exection

Test execution typically follows several steps:
1. Establish that the IUT is minimally operational
2. Execute the test suite(s)
- If the result of executing a test case
    - Is equal to the expected result -> pass
    - Is not equal to the expected value -> no pass
        - Reveals a bug and therefore is a successful test

3. Use a coverage tool
4. If necessary, develop additional tests
5. Stop testing when coverage goal is met and all tests pass

## Absolute limitations of testing

Dijkstra: "Program Testing can be used to show the presence of defects, but never their absence"
- Proof of correctness is equivalent to exhaustive testing

Testing cannot verify requirements
- Incorrect or incomplete requirements may lead to spurious tests

Expected output for certain test cases might be hard to determine

---

# Implementing Test Cases

## Test case implementation

Popular unit-testing frameworks in Java:
- JUnit
- TestNG

TestNG was inspired by JUnit
- It provides some distinctive functionalities
    - Gap reduced with JUnit 5
- It works for functional and higher levels of testing

## What is TestNG?

Automated testing framework

NG = Next Generation

Similar to JUnit (especially JUnit 4 and 5)

Not a JUnit extension (but inspired by JUnit)

Designed to be better than JUnit, especially for higher levels of testing

Created by Dr. Cédric Beust (of Google)

## Implementation of a Test Case

``Test case = a test of something``

To implement a test case, you need to know its specification:
- The Input
    - Includes the parameters, initial state of the object being invoked, and maybe some other global variables
- The Method to test
- The Expected Output
    - Includes returned value (if any), expected result state of the invoked object, and (maybe) expected state of parameters

## Properties of an implemented test case

Test a single condition of the IUT
- Do not try to exercise the same method several times to save implementation time
- Follow the AAA pattern

Independent
- Should not depend on the outcome of the previous test case

Self-cleaning
- Returns the system's state to initial state

Documented
- Test goal should be clear and understandable
    - Document the test method or
    - Use a good test method name

Accurate
- Agrees with documentation

Reasonable probability of catching a defect

Repeatable
- Can be used to perform the test over and over
- It is completely automated

Simple and clear to understand
- It should be small
    - No more than 10-15 LOC excluding setup/tear down

Fast


## AAA Pattern

**Arrange-Act-Assert**

Each testing method should group its code into three fucntional sections:

- **Arrange** all necessary preconditions and inputs
    - Instantiate object under test and set up test data
- **Act** on the method under test
    - Invoke method under test on object under test
- **Assert** that the expected results have ocurred
    - Check that result after invocation is equal to expected result

Application of this patter is orthogonal to the testing framework

## AAA Advantages

Ensure testing a single condition of the IUT

Makes the test code easier to read
- Clearly separates what is being tested from the setup and verification steps

Avoids some test errors
- Assertions intermixed with "Act" code
- Test methods that try to test too many different things at once

## TestNG Assertions

TestNG: similar to JUnit 4
- assertEquals and assertNotEquals
- assertNull and assertNotNull
- assertSame and assertNotSame
- assertTrue and assertFalse
- fail

TestNG assertEquals(...) assertion signatures are different than JUnit's
- JUnit: [msg,] expected, actual
- TestNG: actual, expected [, msg] 

## TestNG Engine

@BeforeClass - before test class methods
@BeforeMethod - before test methods methods
@AfterMethod - after test methods methods

Other annotations:
- @BeforeSuite
- @AfterSuite
- @BeforeGroups
- AfterGroups

@AfterClass - after test class methods

@Test(expectedExceptions = NullPointerException.class) instead of try-catch
- If exception does not occur, test is marked as a failure
- Makes tests more concise, making the test case more readable and understandable
- Can accept more than one exception:
    - @Test(expectedExceptions = { T1.class, ... })
- However, not checking
    - state of system/out after exception
    - error message of the exception object
- How to handle the invocation of a method that should not throw an exception
    - place fail() inside catch block

## Parameterized Tests

Sometimes, there are several similar test cases, each having a different combination of the input parameters and corresponding expected output

How to implement these test cases?

First solution: copy/paste approach
- Not ideal

**Best solution:** the testing framework shoud make this simple

## Parameterized Tests in TestNG

Based on data providers
- It is a method that returns ``Object[][]``
    - First dimension size is the number of times the test method will be invoked
    - Each row must be compatible with the parameter types of the test method
- Or returns ``Iterator<Object[]>``
    - A lazy version of the previous approach
- Use @DataProvider(name="nameOfDataProvider")
- Data provider method can know the name of test method

Assign a data provider to a test method
- @Test(dataProvider = “nameOfDataProvider”)

```Java
@DataProvider
private Object[][] getMoney(){
 return new Object[][] {
 {new Money(4, "USD"), new Money(3, "USD"), 7},
 {new Money(1, "EUR"), new Money(4, "EUR"), 5},
 {new Money(1234, "CHF"), new Money(234, "CHF"), 1468}};
}
@Test(dataProvider = "getMoney")
public void shouldAddSameCurrencies(Money a, Money b, int expectedResult) {
 // Act
 Money result = a.add(b);
 // Assert
 assertEquals(result.getAmount(), expectedResult);
}
```

## Test Groups

A group contains any number of test methods
- Groups can span classes

Each test method can be tagged with any number of groups:
- @Test // no groups
- @Test (groups = “group1”) 
- @Test (groups = { “g1”, “g2”, ... })

Groups can also be externally defined (TestNG xml configuration file)

It is possible to have a group of groups

A group is identified by a unique string (don't use white space)


TestNG community suggests hierarchical names from more general to less
- database.table.CUSTOMER or alarm.severity.cleared
- Design group names so that you can select them with prefix patterns

```Java
@Test(groups = { “goldenRegression" })
public class All {
 @Test(groups = { “regression" })
 public void method1() { }

 public void method2() { ... }
}
```
You can execute tests belonging to a group

## Dependency testing in TestNG

Make sure that execution of a test case is made only if a given test case was executes with success before

TestNG uses dependOnMethods or DependOnGroups to implement the dependency testing
- If the dependent method fails, all the subsequent test methods will be skipped, not marked as failed
- Imposes a test execution order

Usually, bad practice for unit testing

But very important for system and integration testing
- Fail fast
    - Run full system tests only if smoke test passed

It is important in final report

Test methods not executed due to a dependency:
- Marked as SKIP
- Not as Failed

## Concurrency

Execute a test method several times using one or more threads

```java
@Test(threadPoolSize = 3, invocationCount = 20)
public void concurrencyTest() {
 System.out.print(" " + Thread.currentThread().getId());
}
```

```
Result:
  – 13 12 13 11 12 13 11 12 13 12 11 13 12 11 11 13 12 11 12 13
```

## Ignored Test Cases

Enable or disable test cases
- @Test(enabled=false)
- Or use @Ignore
- Add to group that is excluded
- Very useful when you have a test case that is broken

## Running Failed Tests

TestNG creates a testng-failed.xml in output directory
- Contains failed methods
- Allows to re-run the failed tests
- Can reproduce the failures and verify fixes quickly

---

# Testing and Object-Oriented Software

## Introduction

Testing is a search/hunt of bugs

Identifying bug hazards is essential for effective testing

Must examine the ways in which OOP languages can go wrong

## Object-Oriented Programming Languages

OOPL would solve all problems, including bugs
-> No more Testing!

However, programers make errors independently of the language

Some errors are language specific
- Create a subclass that is inconsistent with its superclass

## Fault model for object-oriented programming

OO programming reduces some kinf od errors
- Methods often consist of a few lines
- Encapsulation prevents bugs that result from global data scoping

However, it increases (or creates) the chance of others
- Encapsulation, polymorphism and method sequence pose new bug hazards

## Encapsulation

Access control mechanism

Can be an obstacle to testing

Real example of C++ library

```Cpp
lass IntSet {
 public:
IntSet();
~IntSet();
IntSet& add(int); // add a member
IntSet& remove(int); // remove a member
IntSet& clear(); // remove all members
int is_member(int); // is arg a member?
int extent(); // number of elements
int is_empty(); // empty or not?
…
}
```

The problem was when adding the same number twice
- add() should throw an exception in this case

Test Case?
```cpp
try {
 set.add(1);
 set.add(1);
 fail(“Error. Same number added twice”);
} catch (DuplicateException de) {
}
```

What is missing?
- Check the contentof the set inside catch
- But encapsulation prevents that

BUT

```cpp
try {
 set.add(1);
 set.add(1);
 fail(“Error. Same number added twice”);
} catch (DuplicateException de) {
 set.remove(1);
 assertTrue(set.is_member(1) == 0);
}
```

## Message Sequence

The packing of methods and states into classes is fundamental to the OO paradigm. As a result, messages are sent in some sequence

Account object:
- Must have sufficient funds (be in an open state) before withdrawal message can occur
- If withdrawal causes the balance to become negative then we transition from open to overdrawn state

State may be corrupted under certain message sequence patterns
- add, withdrawal (balance negative), withdrawal (refused), withdrawal (accepted)

Testing Goal:
- Select a set of sequences to test (including correct and incorrected)

We can use a state-based test model to model this.
- State based testing derives test cases by modeling a class as a state machine

## Inheritance

Crucial OO paradigm
- Supports reusability
- Allows efficient extensibility (type & subtype)

Unfortunately, it can be abused in many ways

Can make difficult to understand source code

How to test Generic Types and Abstract Classes

## Inheritance: What can go wrong?

Incorrect initialization
- Can easily go wrong
- Superclass initialization code not executed

Forgotten methods
- Proper use of upper-level features may become obscure when we have many levels of inheritance

Multiple inheritance
- a class inherits directly from 2 or more classes which may contain features with the same name
- presents many bug hazards

## Inheritance and Testing

Given a well-tested superclass and a new subclass:
- Should you retest inherited methods?
- Should you retest overriden methods?
- Can you reuse superclass tests for inherited and overriden methods?
- To what extent should you exercise interaction among methods of all superclasses and of the subclass under test?

How to test abstract classes?

## Inheritance: Can I reuse Testing?

Given a well-tested superclass and a new subclass

Inherited methods
- Do I need to retest unchanged inherited methods?
    - Maybe. At least when:
    1. The inherited method invokes other methods that are specified in the subclass (Is the superclass test suite enough?)
    2. The subclass modifies attrivutes that the inherited method assumes certain values

Overriding methods
- Can I just use the test suite made for the super class method version?
- No, overriding method can be implemented by a different algorithm or functionality

## Polymorphism

Is the ability to bind a reference to more than one class of objects

Dynamic binding: the specific method is determined in runtime

Produces compact, elegant and extensible code

Each possible binding of a polymorphic method is a distinct computation

It may be difficult to identify and exercise all such bindings

## Polymorphism: What can go wrong?

Polymorphic methods can result in hard-to-undestand error-prone code; yo-yo problem

Class hierarchy must be carefully designed, otherwise it can produce strange results for some messages

- Overriding a method that is incompatible with the original one - client code will not work in some cases

Messages can be bound to the wrong class
- Only for untyped languages
- Many classes may use the same method names

The yo-yo problem

As classes grow deeper the likelihood of misusung polymorphic methods increases

Combination of
- Template method design pattern
- Invocation of super version in a subclass method

Make it very difficult to understand the behaviour of lower level classes

## The yo-yo problem

```java
abstract class One {
 public void A() { print( "A, 1" ); B(); C(); }
 public void C() { print( "C, 1" ); }
 abstract public void B();
 abstract public void D();
}
class Two extends One {
 public void B() { print( "B, 2" ); D();}
 public void D() { print( "D, 2" ); }
}
class Three extends Two {
 public void A() { print( "A, 3" ); super.A(); }
 public void B() { print( "B, 3" ); super.B(); }
}
class Four extends Three {
 public void A() { print( "A, 4" ); super.A(); }
 public void C() { print( "C, 4" ); super.C(); }
}
class Five extends Four {
 public void D() { print( "D, 5" ); super.D(); }
}
```

What is the result of:

```java
public static void main( String args[] ){
 Five yoyo = new Five();
 yoyo.A();
} 
```

Invocation of a single method on class Five triggered the invocation of 9 methods on the same object
- One of these interactions maybe be wrong

--- 

# Domain Testing Model

Domain analysis is a straightforward and effective way to select test values

There are several domain testing models:
- Meyer's equivalence class
- ...
- Used in book: Based on White and Cohen's paper in 1978

## Domain Analysis

A domain is the set of all inputs accepted by the IUT

Domain is defined by set of boundary conditions
- Boolean expressions on the IUT input variables
    - Method parameters and instance variables
- Example
    - Collection class that holds objects
    - Boundary condition: maximum number of items: 1000

Fault model for domain testing?
- IUT has incorrectly implemented a boundary
- Example:
    - The IUT allows 999 items but reject 1000


## Development of a domain test suite

A domain test suite is developed by domain analysis:
1. Identify constraints for all input variables
2. Select test values for each variable in each boundary
3. Select test values for variables not given in the boundary
4. Determine expected results for these input

The results are represented in the domain matrix

Example:
- ``void aFunction(int x, float y, Stack aStack)`` with the following constraints:

```java
assert  ( (y >= 1.0 ) && // condition 1
        (x <= 10 ) && // condition 2
        (y <= 10.0) && // condition 3
        (x > 0 ) && // condition 4
        (y <= 14.0 –x) && // condition 5
        (! aStack.isFull)) // condition 6
```

## On, Off, In, Out points

All domain testing selection criteria use On and Off points

With respect to a particular boundary
- On points lie on the boundary
- Off points lie off the boundary
    - But as near as possible

With respect to all boundaries
- In points satisfy all boundary conditions & are not on a boundary
    - Normally used as typical values
- Out points satisfy no boundary conditions & are not on a boundary

## In points

In points satisfy all boudary conditions & are not on a boundary
- Meaning In points shouldnot be On or off points

Consider the example x>=5 && x<=10

Is 5 an In point?   No, it is on the boundary of for x>=5

Is 12 an In point?  No, it does not satisfy x<=10

Set of In points:   ]5,10[

## On and Off points - Open and Closed boundaries

Open Boundary - Strict inequality (e.g. x>0)

- On point:
     - x = 0, makes a boundary condition false
- Off point
    - Two possible choices: -1 and 1
    - Which one?
    - Apply the Rule: Off point must make the boundary condition true if On makes it false and vice-versa
    - In this case it is 1

Closed boundary - strict equality (e.g. y <= 10.0)
- On point:
    - y = 10.0 makes the boundary condition true
- Off point: 
    - Consider a 6 digit precision
    - Two possible choices: 9.999999 and 10.000001
    - Apply same rule
    - Correct is 10.000001

## What about OO systems?

For primitive data types, applying domain analysis is straightforward

Can we apply it to classes?

Yes, if the boundary condition involves a single instance variable
- e.g. aStack.size() <= 10

Sometimes, boundary condition involves an abstract state of an object

Abstract state
- Represent a given behaviour 
- Can involve several fields of the object
- Can be represented by several boundary conditions
- It may lead to a large number of test cases

Solution: Define abstract On, Off and In points

Consider the following Class

```java
Class Account {
 AccountNumber number;
 Money balance;
 Date lastUpdate;
 …
}
```

Account objects can be in one of three abstract state
- Open:      balance>=0 and lastUpdate <1825
- Overdrawn: balance<0 and lastUpdate<1825
- Inactive:  lastUpdate >= 1825

## Abstract state - State invariant

Abstract state: A set of attribute value combinations that share some property of interest

A valid state can be expressed with a state invariant
- Boolean expression that can be checked

Domain testing model to objects:
- Treat each state invariant as a domain boundary

## OO domain definitions
For each abstract state, define abstract state on, off and in points

An abstract state on point is a state such that the smallest possible change in some attribute will produce a state change

An abstract state off point is a valid state that is not the focus state and differs from the focus state by the smallest possible change in some attribute

An abstract state in point is neither an on or an off point (if possible)

## One by one Selection Criteria

Each test case exercises a single boundary condition

1x1 domain testing strategy calls for one on point and one off, or more, point for each domain boundary
- Number of off points depends on type of condition

Using the abstract state model, 1 x 1 is applicable to the full range of data types used in object oriented programing

For relational conditions, e.g. x<=10
- One on point and one off point

For strict equality conditions, e.g. x==10
- One on point and two off points

For nonscalar types: one on point and one off point

For abstract state invariants: one on point and at least one off point

## Domain Matrix Design

How to design the domain test suite?
1. Determine the domain restrictions of the IUT
2. Define on and off points for each boundary condition
3. Add expected results in points for other values
    - Each test case only has one off or on point
    - Select in points for all other values in the test case
    - Avoid to repeat in points. Why?

Result
- Minimal set test cases
- Input variables to exercise boundary conditions
- For any type of variable types
    - Including abstract complex types (objects)

## What does this approacch achieve

This is a systematic sampling approach to test case design

Using boundary values for the tests offers a few benefits:
- They will expose errors that mis-specify a boundary.
    - These can be coding errors (off-by-one errors such as saying "less than" instead of "less than or equal") or typing mistakes (such as entering 57 instead of 75 as the constant that defines the boundary).
    - Mis-specification can also result from ambiguity or confusion about the decision rule that defines the boundary
- Non-boundary values are less likely to expose these erros

It assumes that there is a single error