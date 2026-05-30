# Class Slides Project Report

This report extracts the parts of the provided class slides that matter for completing Project 2. The project focus, according to the professor, is writing tests. The final formal report can be prepared later from the test-design artifacts.

The local slide files reviewed were:

- `02 - TestNG.pdf`
- `03 - Domain Testing.pdf`
- `04 - Method Scope Test Patterns.pdf`
- `05 - Class Scope Testing.pdf`
- `08 - Test Doubles and Mockito.pdf`
- `09 - Test Driven Delevopment.pdf`

## Overall Project Implications

The most important guidance from the slides is:

- Write tests against the specification, not against the current partial implementation.
- Each implemented TestNG test should have clear Arrange, Act, and Assert sections.
- Invalid-operation tests should verify both the exception and unchanged state.
- Boundary values are essential because the project specification is full of numeric limits.
- `Order` is mostly a non-modal class with invariants.
- `Delivery` is a modal/state-based class and should be tested with state-transition tests.
- `computeDeliveryCost()` is a combinational method and should be tested with a decision table plus boundary values.
- `updateItem()` combines method-scope categories with delivery state constraints.
- Test doubles are optional and should only be used if collaborators make tests hard to set up.
- The required `Client` tests use a documented minimal identity/contact assumption because the PDF does not define `Client` behavior.

## 02 - TestNG

### Most Relevant Slides

- Slides 7-12: implemented test-case structure and quality.
- Slides 18-21: testing expected exceptions.
- Slides 22-24: parameterized tests with `@DataProvider`.
- Slides 25-30: groups and dependencies.
- Slides 31-34: repeated runs, ignored tests, failed-test reports.

### What Matters For This Project

The slides define an implemented test case as a test of one specified behavior with known input, method under test, and expected output. For this project, each test should state:

- initial object state;
- method call;
- return value, exception, and final object state.

The AAA pattern is central:

- Arrange: create `Client`, `Supplier`, `Item`, `Order`, `Delivery`, and any required state.
- Act: call exactly the method or operation sequence being tested.
- Assert: check return value, exception, mode, quantity, cost, content, or unchanged state.

The current `OrderTest` already uses comments for Arrange, Act, and Assert, which matches the slides. The problem is that some exception tests use `@Test(expectedExceptions = ...)` and then put assertions after the throwing operation. Those assertions will not run if the exception happens.

For invalid operations in this project, prefer:

```java
InvalidOperationException ex = Assert.expectThrows(
    InvalidOperationException.class,
    () -> order.addItem(item, 11)
);

Assert.assertEquals(order.totalQuantity(), 0);
Assert.assertEquals(order.cost(), 0.0);
```

This matches the slides better because it lets the test verify state after the exception.

`@DataProvider` is very useful for repetitive boundary tests. The best target is `computeDeliveryCost()`, where many tests have the same shape:

- distance;
- item prices/quantities/weights;
- expected delivery cost.

Use `@DataProvider` to reduce duplicated tests, but keep test-case names or data labels clear enough for debugging.

### Less Relevant For This Project

Test groups, dependency testing, concurrency, and ignored tests are not central here. The slides mention dependencies, but this project should keep tests independent whenever possible.

### Concrete Actions

- [ ] Rewrite invalid-operation tests using `Assert.expectThrows` or `Assert.assertThrows`.
- [ ] Keep one behavior per test.
- [ ] Use `@DataProvider` for `computeDeliveryCost()` and possibly `updateItem()`.
- [ ] Avoid dependencies between tests.
- [ ] Use descriptive TestNG method names.

## 03 - Domain Testing

### Most Relevant Slides

- Slides 3-5: domain analysis and domain-test-suite steps.
- Slides 7-9: on, off, in, and out points; open and closed boundaries.
- Slides 13-18: object-oriented domains, abstract states, and 1x1 selection.
- Slides 21-23: domain matrix and why boundary tests matter.

### What Matters For This Project

Domain testing is one of the most useful slide sets for this project. The SuperEats specification contains many explicit boundaries:

- distance must be `<= 20000`;
- distance branches use `< 5000`, `>= 5000`, `< 15000`, `>= 15000`, `<= 20000`;
- item quantity must be from `1` to `10`;
- order cost must be `<= 1000`;
- total units must be `<= 20 + floor(orderCost / 50)`;
- delivery cost uses cost thresholds `75`, `150`, `300`, `500`;
- delivery cost uses quantity thresholds `5`, `8`, and `10`;
- delivery cost uses weight thresholds `3000g` and `5000g`;
- `Delivery.updateItem()` allows at most 3 successful updates.

The slides say to choose on, off, and in points for each boundary. For this project:

- On point: exactly on the boundary.
- Off point: nearest value on the other side of the boundary.
- In point: valid typical value not near a boundary.

Examples:

| Boundary | On Point | Off Point | Useful In Point |
| --- | ---: | ---: | ---: |
| distance `<= 20000` | `20000` | `20001` | `10000` |
| distance `< 5000` | `5000` | `4999` | `2500` |
| quantity `>= 1` | `1` | `0` | `5` |
| quantity `<= 10` | `10` | `11` | `5` |
| cost `>= 75` | `75` | `74` | `100` |
| cost `> 150` | `150` | `151` | `200` |
| weight `< 3000` | `3000` | `2999` | `1000` |
| successful updates `<= 3` | third success | fourth valid call | first success |

For object state, the slides say to use abstract states. Relevant abstract states include:

- `Order` empty;
- `Order` with one item;
- `Order` with multiple items from the same supplier;
- `Order` at max item quantity;
- `Order` at max cost;
- `Order` at max total quantity;
- `Delivery` in each mode.

### Concrete Actions

- [ ] Build a boundary matrix for `Order` invariants.
- [ ] Build a boundary matrix for `computeDeliveryCost()`.
- [ ] Include on/off/in values for every numeric threshold.
- [ ] For invalid tests, check exception plus unchanged state.
- [ ] Use one boundary focus per test where practical.

## 04 - Method Scope Test Patterns

### Most Relevant Slides

- Slide 14: basic method-scope test procedure.
- Slides 15-31: Category-Partition.
- Slides 33-40: Combinational Function Test.
- Slides 41-57: recursive and polymorphic method tests.

### What Matters For This Project

The basic method-scope procedure maps directly to the tests:

- Arrange the object state and method parameters.
- Send the method call.
- Check return value, object state, collaborator state, and exceptions.

Category-Partition is relevant for `Delivery.updateItem()` because that method has several categories:

- delivery mode;
- item already present or absent;
- quantity sign: positive, zero, negative;
- resulting item quantity;
- resulting total quantity;
- number of prior successful updates;
- expected boolean result;
- expected mode change.

The slides define Category-Partition steps:

1. Identify all functions of the method under test.
2. Identify input and output parameters.
3. Identify categories for each input.
4. Partition categories into choices.
5. Identify constraints on choices.
6. Generate test cases from combinations.
7. Develop expected results.

For `updateItem()`, the functions are:

- increase/add an item;
- decrease/remove an item;
- reject invalid state/mode;
- reject updates that violate item quantity or total quantity rules;
- count successful updates;
- possibly move `READY_TO_DELIVER` back to `IN_PREPARATION`.

Combinational Function Test is the best fit for `Order.computeDeliveryCost()` because it selects one of many delivery-cost actions based on combinations of:

- distance range;
- order cost range;
- total quantity;
- total weight.

The slides recommend a decision table and at least one test for each variant, with domain analysis for boundaries. That is exactly how `computeDeliveryCost()` should be handled.

### Less Relevant For This Project

Recursive Function Test and Polymorphic Message Test do not appear relevant. The project classes do not have recursive behavior or polymorphic server binding in the provided interface.

### Concrete Actions

- [ ] Use Combinational Function Test for `computeDeliveryCost()`.
- [ ] Create a decision table with one row per delivery-cost outcome.
- [ ] Add boundary-focused data for each row.
- [ ] Use Category-Partition for `updateItem()`.
- [ ] Mark impossible or duplicate combinations as constraints.
- [ ] Mark invalid combinations as error choices and test one error at a time.

## 05 - Class Scope Testing

### Most Relevant Slides

- Slides 8-16: Invariant Boundaries.
- Slides 17-29: Non-modal Class Test.
- Slides 30-46: finite-state-machine testing.
- Slides 47-70: Modal Class Test.
- Slides 71-89: Quasi-modal Class Test.

### What Matters For `Order`

`Order` is best treated as a non-modal class with invariants. It has no explicit modes, and most operations are legal if they preserve the class constraints.

Important `Order` invariants:

- distance is at most 20 km;
- all items belong to the same supplier;
- per-item quantity is between 1 and 10;
- total cost is at most 1000;
- total quantity respects `20 + floor(orderCost / 50)`;
- content, quantity, total quantity, cost, and contains agree with each other.

The slides say non-modal class testing should:

- find the class invariant;
- develop test values using Invariant Boundaries;
- use modifier methods to define state;
- use accessor methods to verify state;
- verify invalid modifiers throw and leave the object unchanged.

For `Order`, modifier methods are:

- constructor;
- `addItem()`;
- `removeItem()`;
- `setAddress()`.

Accessor/use methods are:

- `quantity()`;
- `contains()`;
- `totalQuantity()`;
- `cost()`;
- `itens()`;
- `computeDeliveryCost()`.

### What Matters For `Delivery`

`Delivery` is clearly a modal class because method validity depends on mode:

- `IN_PREPARATION`;
- `READY_TO_DELIVER`;
- `IN_TRANSIT`;
- `DELIVERED`;
- `NOT_DELIVERED`;
- `CANCELLED`.

The slides say modal class tests should:

- build a state model;
- expand conditional transitions;
- generate transition paths;
- test valid transitions;
- test forbidden transitions, also called sneak paths;
- verify exceptions and unchanged state for invalid transitions.

For `Delivery`, valid transitions include:

| Initial Mode | Method/Event | Condition | Expected Mode |
| --- | --- | --- | --- |
| new delivery | constructor | valid order | `IN_PREPARATION` |
| `IN_PREPARATION` | `setReady()` | items ready | `READY_TO_DELIVER` |
| `IN_PREPARATION` | `cancel()` | none | `CANCELLED` |
| `READY_TO_DELIVER` | `cancel()` | none | `CANCELLED` |
| `READY_TO_DELIVER` | `assign(courier)` | courier has fewer than 5 deliveries | `IN_TRANSIT` |
| `IN_TRANSIT` | `delivered()` | none | `DELIVERED` |
| `IN_TRANSIT` | `cancel()` | attempts fewer than 3 | `NOT_DELIVERED` |
| `IN_TRANSIT` | `cancel()` | third failed attempt | `CANCELLED` |
| `NOT_DELIVERED` | `setReady()` | new attempt | `READY_TO_DELIVER` |
| `READY_TO_DELIVER` | successful positive `updateItem()` | valid update | `IN_PREPARATION` |

Sneak-path tests should try invalid methods in each state, for example:

- `assign()` before `setReady()`;
- `delivered()` before `assign()`;
- `changeAddress()` after assignment;
- `updateItem()` in `IN_TRANSIT`;
- any modifier in `DELIVERED`;
- any modifier in `CANCELLED`.

### Concrete Actions

- [ ] Treat `Order` with Non-modal Class Test plus Invariant Boundaries.
- [ ] Treat `Delivery` with Modal Class Test / FSM testing.
- [ ] Add one test per valid `Delivery` transition.
- [ ] Add one test per important invalid transition.
- [ ] For every invalid transition, verify exception and unchanged mode/content.
- [ ] Use `mode()` as the status query required by FSM testing.

## 08 - Test Doubles and Mockito

### Most Relevant Slides

- Slides 2-4: Given-When-Then and readable tests.
- Slides 8-15: collaborators and test doubles.
- Slides 20-31: creating and programming Mockito doubles.
- Slides 36-43: verifying interactions.
- Slides 52-56: testing exceptions plus interactions.
- Slides 57-67: reducing mock boilerplate.

### What Matters For This Project

Mockito is not required by the project specification, but the slides are useful if missing collaborators block test writing.

In this project, many collaborators are simple:

- `Supplier` is simple and can be real.
- `Item` is a record and should be real.
- `Client` is simple and should be real; the Step 8 tests use the documented identity/contact assumption.

Do not mock these unless there is a reason. The slides distinguish classical style and mockist style; for this project, classical style is simpler: use real value objects and only use mocks when a collaborator is hard to construct or has behavior you must isolate.

Potential use cases for test doubles:

- The `Courier` implementation can now simulate a courier with 4 assigned deliveries versus 5 assigned deliveries.
- If `Client` later depends on repositories/services, Mockito can isolate it.
- If testing that an invalid operation does not call a collaborator, Mockito `verify(..., never())` can be useful.

The exception-testing guidance repeats the TestNG slides: `expectedExceptions` is concise but weak when you need to inspect object state or interactions. Use `assertThrows` and then assert state or verify no interaction.

### Concrete Actions

- [ ] Prefer real `Supplier`, `Item`, and simple `Client` objects.
- [ ] Use test doubles only if collaborator setup becomes awkward.
- [x] If `Courier` gets behavior, consider helper factory methods before Mockito.
- [ ] If using Mockito, verify no unwanted interaction after invalid operations.
- [ ] Do not make tests depend on private implementation details.

## 09 - Test Driven Development

### Most Relevant Slides

- Slides 3-8: test-last risks and Red-Green-Refactor.
- Slides 39-40: interface matters and test doubles are optional.
- Slides 41-46: best practices, naming, independence, minimal assertions.
- Slides 47-51: tools, coverage, and maintenance overhead.

### What Matters For This Project

The main lesson is to write tests from the required behavior, not from the current implementation. This matters because the current repository has incomplete classes. The tests should still express the specification.

Use a practical test-first order:

1. Write the simplest valid test for a behavior.
2. Add one boundary or invalid case.
3. Run the test.
4. Implement only enough code to pass if implementation is needed.
5. Refactor duplicated setup after tests pass.

The slides recommend:

- test classes in the same package as implementation;
- test class names matching the class under test;
- descriptive test method names;
- no dependencies between tests;
- fast tests;
- setup/tear-down methods where useful;
- minimal assertions per test.

For this project, minimal assertions means checking the behavior under test and the required state consistency. Invalid-operation tests may need several assertions because the specification explicitly says state must remain unchanged.

### Concrete Actions

- [ ] Keep tests in `src/test/java/supereats/core`.
- [ ] Use names like `givenReadyDeliveryWhenAssignCourierThenModeIsInTransit`.
- [ ] Add `@BeforeMethod` helpers if setup becomes repetitive.
- [ ] Write tests from the PDF requirements, not from the current stubs.
- [ ] Run all tests after every implementation change.
- [ ] Do not over-compress many cases into one test unless using a clear `@DataProvider`.

## Project-Specific Test Strategy From The Slides

### `Order` Class Scope

Recommended slide strategy:

- Non-modal Class Test from `05 - Class Scope Testing`.
- Invariant Boundaries from `05 - Class Scope Testing`.
- Domain Testing from `03 - Domain Testing`.

Test focus:

- constructor distance boundary;
- `setAddress()` distance boundary and unchanged state on failure;
- `addItem()` quantity boundaries;
- same-supplier invariant;
- total cost boundary;
- total quantity formula boundary;
- accessor consistency after valid operations;
- unchanged state after invalid operations.

### `Delivery` Class Scope

Recommended slide strategy:

- Modal Class Test / FSM testing from `05 - Class Scope Testing`.
- Sneak-path testing for invalid transitions.

Test focus:

- all valid mode transitions;
- conditional transition for courier capacity;
- failed-delivery attempts;
- terminal states;
- invalid method calls in each mode;
- unchanged mode/content after invalid method calls.

### `Order.computeDeliveryCost()` Method Scope

Recommended slide strategy:

- Combinational Function Test from `04 - Method Scope Test Patterns`.
- Domain Testing from `03 - Domain Testing`.
- TestNG `@DataProvider` from `02 - TestNG`.

Test focus:

- one decision-table row per delivery-cost result;
- boundary values for distance, cost, quantity, and weight;
- all expected outputs: `0`, `1`, `3`, `4`, `5`, `6`, `7`, `8`, `10`.

### `Delivery.updateItem()` Method Scope

Recommended slide strategy:

- Category-Partition from `04 - Method Scope Test Patterns`.
- Modal state constraints from `05 - Class Scope Testing`.
- Domain Testing for quantity/update-count boundaries.

Test focus:

- valid modes versus invalid modes;
- positive, zero, and negative quantities;
- item present versus item absent;
- final quantity within or outside `1..10`;
- final total units strictly positive;
- successful update counter from 0 to 3 and fourth valid call;
- ready delivery returning to preparation after successful positive update;
- unsuccessful update preserving content and mode.

### `Client` Class Scope

Recommended slide strategy:

- Use class-scope test patterns over the assumed `Client` lifecycle and validation behavior.
- Use TestNG from `02 - TestNG`.
- Use TDD naming and independence guidance from `09 - Test Driven Delevopment`.

Specification gap:

- The PDF requires 8 implemented TestNG tests for `Client`, but the visible PDF does not define `Client` behavior.

Documented assumption:

- `Client` is treated as a customer identity/contact object with `name`, `email`, `phone`, and `address`.
- Valid clients require non-blank name/address, one email `@` with text on both sides, and a 9-digit phone.
- Invalid client data throws `InvalidOperationException`, consistent with the rest of the domain validation.

Implemented tests:

- [x] 4 successful TestNG tests for valid construction, trimming, address update, and boundary-valid phone.
- [x] 4 unsuccessful TestNG tests for blank name, invalid email, invalid phone, and invalid address update.

## Topics That Are Mostly Not Needed

- Recursive Function Test.
- Polymorphic Message Test.
- TestNG groups and dependency testing.
- TestNG concurrency.
- Full Mockito annotation/injection machinery unless collaborators become complex.
- TDD as a strict process for the whole project, because the course deliverable is test design and selected implemented tests.

## Recommended Immediate Work Order

1. Fix the current failing `OrderTest` invalid-removal tests or align them with the intended spec.
2. Rewrite invalid-operation tests using `expectThrows` plus unchanged-state assertions.
3. Convert `computeDeliveryCost()` tests into a decision-table-backed `@DataProvider`.
4. Add `DeliveryTest` state-transition tests.
5. Add `Delivery.updateItem()` category-partition tests.
6. Clarify the `Client` specification.
7. Add the required 4 successful and 4 unsuccessful `Client` TestNG tests.
8. Only then prepare the final written report from the strategy artifacts.
