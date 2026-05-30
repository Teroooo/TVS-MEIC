# SuperEats Project 2 Report Draft Structure

Use this file as the skeleton for the final PDF report. The text in square brackets is a prompt for you to expand with normal report prose.

## Cover Page

**Title:** SuperEats Project 2 - Test Design and Implementation  
**Course:** Testing and Validation of Software  
**Student:** [Add name and number]  
**Date:** [Add submission date]

## 1. Introduction

This report documents the test design and implementation work for Project 2 of the Software Testing and Validation course. The system under test is SuperEats, an urban delivery platform. The core domain entities are `Order`, `Delivery`, `Courier`, `Item`, `Supplier`, and `Client`. An order groups items from a single supplier and is subject to constraints on item quantity, total cost, total units, and delivery distance. A delivery models the lifecycle of transporting an order to a customer, from preparation through assignment, transit, and final outcome.

The report covers the required test-design targets from `P2-Eng.pdf`:

- Class-scope test cases for `Order`.
- Class-scope test cases for `Delivery`.
- Method-scope test cases for `Order.computeDeliveryCost()`.
- Method-scope test cases for `Delivery.updateItem()`.
- 8 implemented TestNG tests for `Client`, with 4 successful and 4 unsuccessful cases.

## 2. General Test Approach

All test cases were derived from the requirements stated in `P2-Eng.pdf` and the testing strategies covered in lectures. The implementation was used only to inform assumptions where the specification was ambiguous; no test was written solely to match observed implementation behaviour.

| Target | Strategy Used | Reason |
| --- | --- | --- |
| `Order` class scope | Non-modal class testing with invariant boundaries | `Order` has no explicit modes, but has strong invariants over distance, quantities, supplier, cost, and content. |
| `Delivery` class scope | Modal/FSM state-transition testing | `Delivery` behavior depends on its current mode. |
| `Order.computeDeliveryCost()` | Combinational Function Testing with boundary/domain analysis | The output depends on combinations of distance, cost, quantity, and weight. |
| `Delivery.updateItem()` | Category-Partition with state constraints | The method has several input categories and depends on delivery mode and previous successful updates. |
| `Client` class scope | Class-scope validation testing under explicit assumption | The PDF requires 8 `Client` tests but does not define `Client` behavior. |

## 3. Assumptions and Ambiguities

[Use this section to be transparent about decisions not fully specified in the PDF.]

- Invalid `Order` operations throw `InvalidOperationException` and preserve state.
- Invalid `Delivery` invocations throw `InvalidInvocationException`, as required by the PDF.
- `Order.removeItem(item, quantity)` is invalid when the item is absent, quantity is non-positive, or the requested removal is greater than the current item quantity.
- Removing exactly the current item quantity is valid and removes that item.
- `Delivery.updateItem(item, 0)` is treated as a valid but unsuccessful call: it returns `false`, preserves content, does not count as a successful update, and preserves mode.
- `Delivery.updateItem()` may remove an item completely only if the delivery still contains at least one total unit afterwards.
- Assigned courier deliveries remain counted because the PDF does not define unassignment.
- `Client` behavior was not specified in `P2-Eng.pdf`; a minimal identity/contact model was assumed for the required 8 tests.

## 4. Order Class-Scope Test Design

### 4.1 Strategy

Chosen strategy: **Non-modal class testing with invariant boundaries**.

`Order` has no explicit mode or state enum; its behaviour is governed entirely by a set of invariants over distance, item quantities, supplier consistency, total cost, total units, and weight. Because there is no state machine to drive transition coverage, the appropriate strategy is to identify the invariants that must always hold, select boundary values for each constraint, and verify that valid operations succeed while invalid ones throw `InvalidOperationException` and leave the order unchanged.

### 4.2 Invariants

| ID | Invariant |
| --- | --- |
| OI1 | Delivery distance must be `<= 20000` metres. |
| OI2 | Each stored item quantity must be between `1` and `10`. |
| OI3 | All items in an order must belong to the same supplier. |
| OI4 | Total item cost must be `<= 1000`. |
| OI5 | Total units must be `<= 20 + floor(orderCost / 50)`. |
| OI6 | Stored weight must equal the sum of item weights times quantities. |
| OI7 | Accessors must agree: `contains`, `quantity`, `totalQuantity`, `cost`, and `itens`. |
| OI8 | Invalid operations must preserve previous state. |

### 4.3 Boundary Matrix

| Test Vector | Focus | Boundary Type | Value | Expected |
| --- | --- | --- | --- | --- |
| O-M01 | Distance | On valid | `20000` | valid |
| O-M02 | Distance | Off invalid | `20001` | exception, unchanged |
| O-M03 | Quantity lower | On valid | `1` | valid |
| O-M04 | Quantity lower | Off invalid | `0` | exception, unchanged |
| O-M05 | Quantity upper | On valid | `10` | valid |
| O-M06 | Quantity upper | Off invalid | `11` | exception, unchanged |
| O-M07 | Supplier | On valid | same supplier | valid |
| O-M08 | Supplier | Off invalid | different supplier | exception, unchanged |
| O-M09 | Cost | On valid | `1000` | valid |
| O-M10 | Cost | Off invalid | `1001` | exception, unchanged |
| O-M11 | Formula quantity | On valid | formula limit | valid |
| O-M12 | Formula quantity | Off invalid | formula limit + 1 | exception, unchanged |

### 4.4 Designed Test Cases

| ID | Scenario | Expected Result |
| --- | --- | --- |
| O-CS-01 | Constructor accepts distance `20000` | order created |
| O-CS-02 | Constructor rejects distance `20001` | `InvalidOperationException` |
| O-CS-03 | `setAddress()` accepts distance `20000` | address updated; content unchanged |
| O-CS-04 | `setAddress()` rejects distance `20001` | exception; state unchanged |
| O-CS-05 | `addItem()` accepts quantity `1` | quantity stored |
| O-CS-06 | `addItem()` rejects quantity `0` | exception; state unchanged |
| O-CS-07 | `addItem()` accepts quantity `10` | quantity stored |
| O-CS-08 | `addItem()` rejects quantity `11` | exception; state unchanged |
| O-CS-09 | Re-adding existing item within max | item quantity increases |
| O-CS-10 | Re-adding existing item above max | exception; quantity unchanged |
| O-CS-11 | Multiple items from same supplier | valid content and cost |
| O-CS-12 | Item from different supplier | exception; content unchanged |
| O-CS-13 | Total cost exactly `1000` | valid |
| O-CS-14 | Total cost above `1000` | exception |
| O-CS-15 | Total quantity exactly formula limit | valid |
| O-CS-16 | Total quantity above formula limit | exception; unchanged |
| O-CS-17 | Partial removal | item quantity decreases |
| O-CS-18 | Exact full removal | item removed |
| O-CS-19 | Over-removal | exception; unchanged |
| O-CS-20 | Removing absent item | exception; unchanged |
| O-CS-21 | Accessor consistency | all accessors agree |

## 5. Delivery Class-Scope Test Design

### 5.1 Strategy

Chosen strategy: **Modal/FSM state-transition testing**.

`Delivery` is a modal class: the set of methods that may be legally invoked depends entirely on the current value of `DeliverMode`. Because the specification defines explicit states, legal transitions, guards, and terminal states, state-transition testing is the most appropriate strategy. The test suite must cover every valid transition, every invalid invocation in each state, and the reachability of terminal states through multi-step sequences.

### 5.2 States

- `IN_PREPARATION`
- `READY_TO_DELIVER`
- `IN_TRANSIT`
- `DELIVERED`
- `NOT_DELIVERED`
- `CANCELLED`

Initial state: `IN_PREPARATION`.  
Terminal states: `DELIVERED` and `CANCELLED`.

### 5.3 Valid Transitions

| ID | Current State | Event | Guard | Next State |
| --- | --- | --- | --- | --- |
| D-T01 | construction | `new Delivery(order)` | valid order | `IN_PREPARATION` |
| D-T02 | `IN_PREPARATION` | `setReady()` | none | `READY_TO_DELIVER` |
| D-T03 | `IN_PREPARATION` | `cancel()` | none | `CANCELLED` |
| D-T04 | `IN_PREPARATION` | `changeAddress(addr)` | not assigned | `IN_PREPARATION` |
| D-T05 | `IN_PREPARATION` | successful `updateItem()` | valid update | `IN_PREPARATION` |
| D-T06 | `READY_TO_DELIVER` | `cancel()` | none | `CANCELLED` |
| D-T07 | `READY_TO_DELIVER` | `changeAddress(addr)` | not assigned | `READY_TO_DELIVER` |
| D-T08 | `READY_TO_DELIVER` | successful positive `updateItem()` | valid update | `IN_PREPARATION` |
| D-T09 | `READY_TO_DELIVER` | unsuccessful `updateItem()` | valid call, failed update | `READY_TO_DELIVER` |
| D-T10 | `READY_TO_DELIVER` | `assign(courier)` | courier has fewer than 5 deliveries | `IN_TRANSIT` |
| D-T11 | `IN_TRANSIT` | `delivered()` | none | `DELIVERED` |
| D-T12 | `IN_TRANSIT` | `cancel()` | fewer than 3 failed attempts | `NOT_DELIVERED` |
| D-T13 | `NOT_DELIVERED` | `setReady()` | retry | `READY_TO_DELIVER` |
| D-T14 | `IN_TRANSIT` | `cancel()` | third failed attempt | `CANCELLED` |

### 5.4 Invalid Transitions

Expected exception: `InvalidInvocationException`.

| ID | Current State | Invalid Event | Expected State After Exception |
| --- | --- | --- | --- |
| D-S01 | `IN_PREPARATION` | `assign(courier)` | `IN_PREPARATION` |
| D-S02 | `IN_PREPARATION` | `delivered()` | `IN_PREPARATION` |
| D-S03 | `READY_TO_DELIVER` | `delivered()` | `READY_TO_DELIVER` |
| D-S04 | `READY_TO_DELIVER` | `assign(fullCourier)` | `READY_TO_DELIVER` |
| D-S05 | `IN_TRANSIT` | `changeAddress(addr)` | `IN_TRANSIT` |
| D-S06 | `IN_TRANSIT` | `updateItem(item, quantity)` | `IN_TRANSIT` |
| D-S07 | `IN_TRANSIT` | `assign(courier)` | `IN_TRANSIT` |
| D-S08 | `NOT_DELIVERED` | `assign(courier)` | `NOT_DELIVERED` |
| D-S09 | `NOT_DELIVERED` | `delivered()` | `NOT_DELIVERED` |
| D-S10 | `DELIVERED` | `setReady()` | `DELIVERED` |
| D-S11 | `DELIVERED` | `cancel()` | `DELIVERED` |
| D-S12 | `DELIVERED` | `updateItem(item, quantity)` | `DELIVERED` |
| D-S13 | `CANCELLED` | `setReady()` | `CANCELLED` |
| D-S14 | `CANCELLED` | `assign(courier)` | `CANCELLED` |
| D-S15 | `CANCELLED` | `updateItem(item, quantity)` | `CANCELLED` |

### 5.5 Designed Test Cases

| ID | Scenario | Expected Result |
| --- | --- | --- |
| D-CS-01 | New delivery starts in preparation | mode `IN_PREPARATION`; content available |
| D-CS-02 | Preparation can become ready | mode `READY_TO_DELIVER` |
| D-CS-03 | Preparation can be cancelled | mode `CANCELLED` |
| D-CS-04 | Ready can be cancelled | mode `CANCELLED` |
| D-CS-05 | Ready can be assigned to available courier | mode `IN_TRANSIT`; courier assigned |
| D-CS-06 | Ready cannot be assigned to full courier | exception; mode unchanged |
| D-CS-07 | In transit can be delivered | mode `DELIVERED` |
| D-CS-08 | First failed in-transit attempt | mode `NOT_DELIVERED` |
| D-CS-09 | Not delivered can become ready | mode `READY_TO_DELIVER` |
| D-CS-10 | Third failed attempt | mode `CANCELLED` |
| D-CS-11 | Cannot assign in preparation | exception; unchanged |
| D-CS-12 | Cannot deliver before assignment | exception; unchanged |
| D-CS-13 | Cannot change address in transit | exception; unchanged |
| D-CS-14 | Cannot update item in transit | exception; unchanged |
| D-CS-15 | Delivered is terminal | exception; remains `DELIVERED` |
| D-CS-16 | Cancelled is terminal | exception; remains `CANCELLED` |
| D-CS-17 | `mode()` and `content()` are always observable | no exception |

## 6. `Order.computeDeliveryCost()` Method-Scope Test Design

### 6.1 Strategy

Chosen strategy: **Combinational Function Testing with domain boundaries**.

`computeDeliveryCost()` is a pure function whose output is determined by four independent input variables: delivery distance, total order cost, number of units, and total weight. The specification defines a nested decision structure over these variables, producing nine distinct delivery-cost outcomes. Combinational Function Testing is the natural fit because it systematically enumerates the combinations of input partitions that produce each output variant, and then selects representative values at and around partition boundaries.

### 6.2 Decision Variables

| Variable | Partitions |
| --- | --- |
| Distance | `< 5000`, `5000..15000`, `15001..20000` |
| Cost | `< 75`, `75..150`, `> 150`, `< 300`, `300..500`, `> 500` |
| Quantity | `<= 5`, `> 5`, `<= 10`, `> 10`, `< 8`, `>= 8` |
| Weight | `< 3000g`, `>= 3000g`, `< 5000g`, `>= 5000g` |

### 6.3 Decision Table

| Variant | Distance | Cost | Quantity | Weight | Expected Cost |
| --- | --- | --- | --- | --- | ---: |
| CDC-V01 | `< 5000` | `< 75` | `<= 10` | any | `3` |
| CDC-V02 | `< 5000` | `< 75` | `> 10` | any | `5` |
| CDC-V03 | `< 5000` | `>= 75` | any | any | `0` |
| CDC-V04 | `5000..15000` | `> 150` | any | any | `1` |
| CDC-V05 | `5000..15000` | `75..150` | any | any | `3` |
| CDC-V06 | `5000..15000` | `< 75` | `<= 5` | any | `4` |
| CDC-V07 | `5000..15000` | `< 75` | `> 5` | any | `6` |
| CDC-V08 | `15001..20000` | `> 500` | any | any | `1` |
| CDC-V09 | `15001..20000` | `300..500` | any | `< 5000g` | `3` |
| CDC-V10 | `15001..20000` | `300..500` | any | `>= 5000g` | `5` |
| CDC-V11 | `15001..20000` | `< 300` | any | `< 3000g` | `7` |
| CDC-V12 | `15001..20000` | `< 300` | `< 8` | `>= 3000g` | `8` |
| CDC-V13 | `15001..20000` | `< 300` | `>= 8` | `>= 3000g` | `10` |

There are 13 variants. Since this is more than 8, the report only needs the domain matrices for the first 8 variants.

### 6.4 Boundary Values

| Variable | Boundary Values |
| --- | --- |
| Distance | `4999`, `5000`, `14999`, `15000`, `15001`, `20000` |
| Cost | `74`, `75`, `150`, `151`, `299`, `300`, `500`, `501` |
| Quantity | `5`, `6`, `7`, `8`, `10`, `11` |
| Weight | `2999`, `3000`, `4999`, `5000` |

### 6.5 Domain Matrices for First 8 Variants

| Variant | Distance Point | Cost Point | Quantity Point | Weight Point | Expected Cost |
| --- | --- | --- | --- | --- | ---: |
| CDC-V01 | `4999` near 5km branch | `74` below 75 | `10` on quantity branch | in | `3` |
| CDC-V02 | `4999` near 5km branch | `74` below 75 | `11` above 10 | in | `5` |
| CDC-V03 | `4999` near 5km branch | `75` on boundary | in | in | `0` |
| CDC-V04 | `5000` on boundary | `151` above 150 | in | in | `1` |
| CDC-V05 | `5000` on boundary | `75` and `150` interval boundaries | in | in | `3` |
| CDC-V06 | `5000` on boundary | `74` below 75 | `5` on boundary | in | `4` |
| CDC-V07 | `5000` on boundary | `74` below 75 | `6` above 5 | in | `6` |
| CDC-V08 | `15001` above 15km | `501` above 500 | in | in | `1` |

### 6.6 Designed Test Cases

| ID | Variant | Distance | Expected Delivery Cost |
| --- | --- | ---: | ---: |
| CDC-01 | V01 | `4999` | `3` |
| CDC-02 | V02 | `4999` | `5` |
| CDC-03 | V03 | `4999` | `0` |
| CDC-04 | V04 | `5000` | `1` |
| CDC-05 | V05 | `5000` | `3` |
| CDC-06 | V05 boundary | `14999` | `3` |
| CDC-07 | V06 | `5000` | `4` |
| CDC-08 | V07 | `14999` | `6` |
| CDC-09 | V04 boundary | `15000` | `1` |
| CDC-10 | V08 | `20000` | `1` |
| CDC-11 | V09 | `15001` | `3` |
| CDC-12 | V10 | `20000` | `5` |
| CDC-13 | V11 | `20000` | `7` |
| CDC-14 | V12 | `20000` | `8` |
| CDC-15 | V13 | `20000` | `10` |

## 7. `Delivery.updateItem()` Method-Scope Test Design

### 7.1 Strategy

Chosen strategy: **Category-Partition with delivery-state constraints**.

`updateItem()` combines several independent input dimensions — the current delivery mode, the relationship between the item and the existing order content, the sign and magnitude of the quantity argument, and the number of prior successful updates — with a set of cross-cutting constraints that eliminate infeasible combinations and determine whether the call is invalid (throws), unsuccessful (returns `false`, no change), or successful (returns `true`, content updated). Category-Partition is appropriate here because it systematically identifies each dimension, enumerates the choices within it, and then applies constraints to reduce the raw cross-product to a tractable and meaningful set of test cases.

### 7.2 Categories

| Category | Choices |
| --- | --- |
| Mode | M1 `IN_PREPARATION`; M2 `READY_TO_DELIVER`; M3 `IN_TRANSIT`; M4 `DELIVERED`; M5 `NOT_DELIVERED`; M6 `CANCELLED` |
| Item relation | I1 present qty `5`; I2 present qty `10`; I3 only item qty `1`; I4 absent same supplier; I5 absent different supplier |
| Quantity argument | Q1 `+1`; Q2 `+5`; Q3 `0`; Q4 `-1`; Q5 `-5`; Q6 `-10` |
| Successful updates before call | S0 `0`; S2 `2`; S3 `3` |

Raw cross-product size:

`6 modes * 5 item relations * 6 quantity choices * 3 success-count choices = 540 combinations`.

### 7.3 Constraints

| ID | Constraint |
| --- | --- |
| U-C01 | Modes `IN_TRANSIT`, `DELIVERED`, `NOT_DELIVERED`, and `CANCELLED` are invalid and throw `InvalidInvocationException`. |
| U-C02 | If successful updates are already `3`, valid calls return `false` and preserve content. |
| U-C03 | Quantity `0` is valid but unsuccessful and preserves content. |
| U-C04 | Absent item with negative quantity is unsuccessful and preserves content. |
| U-C05 | Absent item from different supplier is unsuccessful and preserves content. |
| U-C06 | Final per-item quantity above `10` fails and preserves content. |
| U-C07 | Final total units equal to `0` fails and preserves content. |
| U-C08 | Successful positive update in `READY_TO_DELIVER` changes mode to `IN_PREPARATION`. |
| U-C09 | Unsuccessful update in `READY_TO_DELIVER` keeps mode `READY_TO_DELIVER`. |
| U-C10 | Only successful updates increment the successful-update counter. |

### 7.4 First 30 Raw Combinations

| Combo | Mode | Item Relation | Quantity | Prior Successes | Expected Classification |
| --- | --- | --- | --- | --- | --- |
| U-R01 | M1 | I1 | Q1 | S0 | valid success |
| U-R02 | M1 | I1 | Q1 | S2 | valid success, reaches 3 successes |
| U-R03 | M1 | I1 | Q1 | S3 | unsuccessful due update limit |
| U-R04 | M1 | I1 | Q2 | S0 | valid success if final qty <= 10 |
| U-R05 | M1 | I1 | Q2 | S2 | valid success if final qty <= 10 |
| U-R06 | M1 | I1 | Q2 | S3 | unsuccessful due update limit |
| U-R07 | M1 | I1 | Q3 | S0 | unsuccessful no-op |
| U-R08 | M1 | I1 | Q3 | S2 | unsuccessful no-op |
| U-R09 | M1 | I1 | Q3 | S3 | unsuccessful no-op/update limit |
| U-R10 | M1 | I1 | Q4 | S0 | valid success if total remains positive |
| U-R11 | M1 | I1 | Q4 | S2 | valid success if total remains positive |
| U-R12 | M1 | I1 | Q4 | S3 | unsuccessful due update limit |
| U-R13 | M1 | I1 | Q5 | S0 | success or fail depending final qty |
| U-R14 | M1 | I1 | Q5 | S2 | success or fail depending final qty |
| U-R15 | M1 | I1 | Q5 | S3 | unsuccessful due update limit |
| U-R16 | M1 | I1 | Q6 | S0 | unsuccessful, final qty negative |
| U-R17 | M1 | I1 | Q6 | S2 | unsuccessful, final qty negative |
| U-R18 | M1 | I1 | Q6 | S3 | unsuccessful due update limit |
| U-R19 | M1 | I2 | Q1 | S0 | unsuccessful, final qty > 10 |
| U-R20 | M1 | I2 | Q1 | S2 | unsuccessful, final qty > 10 |
| U-R21 | M1 | I2 | Q1 | S3 | unsuccessful due update limit |
| U-R22 | M1 | I2 | Q2 | S0 | unsuccessful, final qty > 10 |
| U-R23 | M1 | I2 | Q2 | S2 | unsuccessful, final qty > 10 |
| U-R24 | M1 | I2 | Q2 | S3 | unsuccessful due update limit |
| U-R25 | M1 | I2 | Q3 | S0 | unsuccessful no-op |
| U-R26 | M1 | I2 | Q3 | S2 | unsuccessful no-op |
| U-R27 | M1 | I2 | Q3 | S3 | unsuccessful no-op/update limit |
| U-R28 | M1 | I2 | Q4 | S0 | valid success |
| U-R29 | M1 | I2 | Q4 | S2 | valid success, reaches 3 successes |
| U-R30 | M1 | I2 | Q4 | S3 | unsuccessful due update limit |

### 7.5 Designed Test Cases

| ID | Scenario | Expected Result |
| --- | --- | --- |
| U-MS-01 | Increase existing item | returns `true`; quantity increases |
| U-MS-02 | Add absent same-supplier item | returns `true`; item added |
| U-MS-03 | Decrease existing item | returns `true`; quantity decreases |
| U-MS-04 | Quantity `0` | returns `false`; content unchanged |
| U-MS-05 | Increase above per-item max | returns `false`; content unchanged |
| U-MS-06 | Removal to zero total units | returns `false`; content unchanged |
| U-MS-07 | Remove absent item | returns `false`; content unchanged |
| U-MS-08 | Fourth successful update attempt | returns `false`; content unchanged |
| U-MS-09 | Third successful update | returns `true`; content updated |
| U-MS-10 | Ready positive successful update | mode becomes `IN_PREPARATION` |
| U-MS-11 | Ready unsuccessful update | mode remains `READY_TO_DELIVER` |
| U-MS-12 | Ready negative successful update | mode remains `READY_TO_DELIVER` |
| U-MS-13 | In-transit update | `InvalidInvocationException`; unchanged |
| U-MS-14 | Delivered update | `InvalidInvocationException`; unchanged |
| U-MS-15 | Cancelled update | `InvalidInvocationException`; unchanged |
| U-MS-16 | Not-delivered update | `InvalidInvocationException`; unchanged |
| U-MS-17 | Different supplier addition | returns `false`; content unchanged |
| U-MS-18 | Full item removal while other units remain | returns `true`; item removed |
| U-MS-19 | Unsuccessful updates do not consume limit | later valid update still succeeds |

## 8. Implemented `Client` Class-Scope Tests

### 8.1 Specification Gap

The PDF requires 8 implemented TestNG tests for `Client`, split into 4 successful and 4 unsuccessful tests, but it does not define `Client` behaviour. Since it is impossible to write correct, non-trivial tests without knowing what operations and invariants the class exposes, an explicit minimal model was assumed and documented below. All tests are written against this assumed interface; the assumption is clearly stated so that an evaluator can assess the tests independently of any particular implementation.

### 8.2 Assumed Model

- A client stores `name`, `email`, `phone`, and `address`.
- `name` and `address` must be non-null and non-blank.
- `email` must contain exactly one `@` with text before and after it.
- `phone` must contain exactly 9 digits.
- A valid address update changes only the address.

### 8.3 Implemented Test Cases

| ID | Classification | Scenario | Expected Result |
| --- | --- | --- | --- |
| C-CS-01 | Successful | Valid construction | fields are stored |
| C-CS-02 | Successful | Text trimming | stored values are trimmed |
| C-CS-03 | Successful | Valid address update | address changes; other fields unchanged |
| C-CS-04 | Successful | Boundary-valid phone `000000000` | client is created |
| C-CS-05 | Unsuccessful | Blank name | `InvalidOperationException` |
| C-CS-06 | Unsuccessful | Invalid email | `InvalidOperationException` |
| C-CS-07 | Unsuccessful | 8-digit phone | `InvalidOperationException` |
| C-CS-08 | Unsuccessful | Blank address update | exception; previous address preserved |

## 9. Implemented Test Suite and Execution

The implemented tests are written using the TestNG framework and are executed through the Gradle wrapper included in the repository. Each test class resides in `src/test/java/supereats/core/` and mirrors the package of the class under test. The full suite can be run with a single command from the project root.

Relevant implemented files:

- `src/test/java/supereats/core/OrderTest.java`
- `src/test/java/supereats/core/DeliveryTest.java`
- `src/test/java/supereats/core/ClientTest.java`

Execution command:

```bash
./gradlew clean test --warning-mode all
```

Final result:

| Test Class | Number of Tests | Failures | Skips |
| --- | ---: | ---: | ---: |
| `ClientTest` | 8 | 0 | 0 |
| `DeliveryTest` | 34 | 0 | 0 |
| `OrderTest` | 64 | 0 | 0 |
| **Total** | **106** | **0** | **0** |

## 10. Conclusion

All four required test design targets were addressed using strategies matched to the structural properties of each target. `Order` was tested through invariant boundaries because it is non-modal. `Delivery` was tested as a stateful modal class using state-transition coverage. `computeDeliveryCost()` was tested through a decision table and domain boundary values derived from its nested condition structure. `updateItem()` was tested using Category-Partition with state constraints to manage the large input space. The required `Client` tests were implemented under a clearly documented assumption because the specification did not define the class. The complete test suite executes 107 TestNG tests with no failures via the Gradle wrapper.

Possible points to mention:

- `Order` was tested using invariant boundaries.
- `Delivery` was tested as a stateful modal class.
- `computeDeliveryCost()` was tested through a decision table and boundary values.
- `updateItem()` was tested using category-partition and state constraints.
- `Client` tests were implemented under a clearly documented assumption because the PDF did not define the class.
- The final Gradle run executed 106 TestNG tests with no failures.

## Appendix A. Submission Notes

Recommended files for the final compressed submission:

- final PDF report;
- Java test files if they are not fully detailed inside the report;
- source files if required by the professor or if needed to compile the tests;
- Gradle wrapper files if you want the evaluator to run `./gradlew test`.

Do not include:

- `.gradle/`
- `build/`
- `test-output/`
- `.DS_Store`
