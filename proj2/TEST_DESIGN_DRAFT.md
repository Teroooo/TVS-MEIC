# SuperEats Project 2 Test Design Draft

Status: Step 2 complete.

This document is the working test-design artifact for the project. It is not the final formatted report, but it contains the strategy choices, intermediate design steps, assumptions, and candidate test cases needed to implement the tests.

Source specification: `P2-Eng.pdf`.

Supporting class guidance:

- `02 - TestNG.pdf`: Arrange, Act, Assert; exception testing; `@DataProvider`.
- `03 - Domain Testing.pdf`: on/off/in points, domain matrix, boundary analysis.
- `04 - Method Scope Test Patterns.pdf`: Category-Partition and Combinational Function Test.
- `05 - Class Scope Testing.pdf`: Invariant Boundaries, non-modal class tests, modal/FSM class tests.

## Global Assumptions

- Tests are written against the specification, not against the current partial implementation.
- Invalid `Order` operations are expected to throw `InvalidOperationException` and preserve state.
- The specification says invalid `Delivery` invocations throw `InvalidInvocationException`; this exception now exists in the repository and is used for invalid `Delivery` state transitions.
- `Order.removeItem(item, quantity)` is treated as invalid when the item is absent, the quantity is non-positive, or the requested removal is greater than the current item quantity. Removing exactly the current quantity is valid and removes the item from the order.
- `Delivery.updateItem(item, 0)` is treated as a valid call that is unsuccessful: it returns `false`, preserves content, does not count as a successful update, and preserves mode.
- Delivery content is expected to remain a valid order-like content set. At minimum, per-item quantity must not exceed 10 and total units must remain strictly positive after an `updateItem()` call.
- Tests should use real `Supplier` and `Item` objects. Mockito is not required for the current project shape.

## 1. Order Class Scope

### Strategy

Chosen strategy: Non-modal Class Test with Invariant Boundaries.

Reason:

- `Order` has no explicit mode.
- Most methods can be called after construction.
- Correctness is mainly defined by invariants over item quantities, suppliers, cost, total units, distance, and observable content.

### Step 1: Class Modality

`Order` is non-modal.

There is no state enum or message sequence such as "ready" or "in transit". However, object validity depends on class invariants.

### Step 2: Class Invariants

The relevant class invariants are:

| ID | Invariant |
| --- | --- |
| OI1 | Delivery distance must be `<= 20000` metres. |
| OI2 | Each stored item quantity must be between `1` and `10`. |
| OI3 | All items in an order must belong to the same supplier. |
| OI4 | Total item cost must be `<= 1000`. |
| OI5 | Total units must be `<= 20 + floor(orderCost / 50)`. |
| OI6 | Stored weight must equal the sum of all item weights times quantities. |
| OI7 | Accessors must agree: `contains`, `quantity`, `totalQuantity`, `cost`, and `itens`. |
| OI8 | Invalid operations must preserve the previous state. |

### Step 3: Invariant Boundary Matrix

| Test Vector | Focus Invariant | Boundary Type | Distance | Item Qty | Cost | Total Qty | Supplier | Expected |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- |
| O-M01 | OI1 | On valid | 20000 | in | in | in | same | valid |
| O-M02 | OI1 | Off invalid | 20001 | in | in | in | same | exception, unchanged |
| O-M03 | OI2 lower | On valid | in | 1 | in | in | same | valid |
| O-M04 | OI2 lower | Off invalid | in | 0 | in | in | same | exception, unchanged |
| O-M05 | OI2 upper | On valid | in | 10 | in | in | same | valid |
| O-M06 | OI2 upper | Off invalid | in | 11 | in | in | same | exception, unchanged |
| O-M07 | OI3 | On valid | in | in | in | in | same | valid |
| O-M08 | OI3 | Off invalid | in | in | in | in | different | exception, unchanged |
| O-M09 | OI4 | On valid | in | in | 1000 | in | same | valid |
| O-M10 | OI4 | Off invalid | in | in | 1001 | in | same | exception, unchanged |
| O-M11 | OI5 | On valid | in | in | selected | formula limit | same | valid |
| O-M12 | OI5 | Off invalid | in | in | selected | formula limit + 1 | same | exception, unchanged |
| O-M13 | OI8 | Invalid modifier | in | invalid | unchanged | unchanged | same | exception, unchanged |
| O-M14 | OI7 | Accessor consistency | in | in | in | in | same | all accessors agree |

Typical in values:

- distance: `2000`;
- quantity: `3`;
- cost: `100`;
- total quantity: `3`;
- supplier: same supplier.

### Step 4: Candidate Test Cases

| ID | Scenario | Arrange | Act | Expected Result |
| --- | --- | --- | --- | --- |
| O-CS-01 | Constructor accepts boundary distance | client, address, distance `20000` | `new Order(...)` | order created; cost `0`; total quantity `0` |
| O-CS-02 | Constructor rejects distance above limit | client, address, distance `20001` | `new Order(...)` | `InvalidOperationException` |
| O-CS-03 | `setAddress()` accepts boundary distance | existing valid order | `setAddress(addr, 20000)` | no exception; order content unchanged |
| O-CS-04 | `setAddress()` rejects distance above limit | existing order with item | `setAddress(addr, 20001)` | exception; item quantity and cost unchanged |
| O-CS-05 | `addItem()` accepts minimum quantity | empty order, one item | `addItem(item, 1)` | quantity `1`; total quantity `1` |
| O-CS-06 | `addItem()` rejects quantity below minimum | empty order, one item | `addItem(item, 0)` | exception; total quantity `0`; cost `0` |
| O-CS-07 | `addItem()` accepts maximum quantity | empty order, one item | `addItem(item, 10)` | quantity `10`; total quantity `10` |
| O-CS-08 | `addItem()` rejects quantity above maximum | empty order, one item | `addItem(item, 11)` | exception; total quantity `0`; cost `0` |
| O-CS-09 | Re-adding existing item within max is valid | item quantity `3` | `addItem(item, 2)` | item quantity `5` |
| O-CS-10 | Re-adding existing item above max is invalid | item quantity `8` | `addItem(item, 3)` | exception; item quantity remains `8` |
| O-CS-11 | Add multiple items from same supplier | two items, same supplier | add both | order contains both; cost and quantities correct |
| O-CS-12 | Add item from different supplier is invalid | order with supplier A item | add supplier B item | exception; original content unchanged |
| O-CS-13 | Cost exactly `1000` is valid | item price/quantity total `1000` | add item(s) | cost `1000` |
| O-CS-14 | Cost above `1000` is invalid | item price/quantity total `1001` | add item(s) | exception; cost unchanged |
| O-CS-15 | Total quantity exactly formula limit is valid | cost chosen so formula is known | add items to limit | total quantity equals limit |
| O-CS-16 | Total quantity above formula limit is invalid | order already at formula limit | add one more unit | exception; total quantity unchanged |
| O-CS-17 | Partial removal is valid | item quantity `5` | `removeItem(item, 2)` | item quantity `3`; total quantity reduced |
| O-CS-18 | Exact full removal is valid | item quantity `3` | `removeItem(item, 3)` | item absent; total quantity reduced |
| O-CS-19 | Over-removal is invalid | item quantity `3` | `removeItem(item, 4)` | exception; item quantity remains `3` |
| O-CS-20 | Removing absent item is invalid | order without item X | `removeItem(itemX, 1)` | exception; content unchanged |
| O-CS-21 | Accessors agree after valid operations | order with two items | call accessors | `contains`, `quantity`, `totalQuantity`, `cost`, `itens` agree |

## 2. Delivery Class Scope

### Strategy

Chosen strategy: Modal Class Test using finite-state-machine testing.

Reason:

- `Delivery` has explicit modes.
- Accepted methods depend on the current mode.
- The same method can be valid in one mode and invalid in another.
- The specification defines both valid transitions and invalid/sneak-path invocations.

### Step 1: State Model

States:

- `IN_PREPARATION`
- `READY_TO_DELIVER`
- `IN_TRANSIT`
- `DELIVERED`
- `NOT_DELIVERED`
- `CANCELLED`

Initial state:

- `IN_PREPARATION`, created by `new Delivery(order)`.

Terminal states:

- `DELIVERED`
- `CANCELLED`

Status query:

- `mode()` can be used to observe the current state.

Content query:

- `content()` can be used to observe delivery content at any time.

### Step 2: Valid Transition Table

| ID | Current State | Event | Guard | Output/Action | Next State |
| --- | --- | --- | --- | --- | --- |
| D-T01 | construction | `new Delivery(order)` | valid order | content initialized from order | `IN_PREPARATION` |
| D-T02 | `IN_PREPARATION` | `setReady()` | none | delivery marked ready | `READY_TO_DELIVER` |
| D-T03 | `IN_PREPARATION` | `cancel()` | none | delivery cancelled | `CANCELLED` |
| D-T04 | `IN_PREPARATION` | `changeAddress(addr)` | not assigned | address changed | `IN_PREPARATION` |
| D-T05 | `IN_PREPARATION` | successful `updateItem()` | valid update | content updated | `IN_PREPARATION` |
| D-T06 | `READY_TO_DELIVER` | `cancel()` | none | delivery cancelled | `CANCELLED` |
| D-T07 | `READY_TO_DELIVER` | `changeAddress(addr)` | not assigned | address changed | `READY_TO_DELIVER` |
| D-T08 | `READY_TO_DELIVER` | successful positive `updateItem()` | valid update | content updated | `IN_PREPARATION` |
| D-T09 | `READY_TO_DELIVER` | unsuccessful `updateItem()` | valid call, failed update | content unchanged | `READY_TO_DELIVER` |
| D-T10 | `READY_TO_DELIVER` | `assign(courier)` | courier has fewer than 5 assigned deliveries | courier assigned | `IN_TRANSIT` |
| D-T11 | `IN_TRANSIT` | `delivered()` | none | delivery completed | `DELIVERED` |
| D-T12 | `IN_TRANSIT` | `cancel()` | failed attempts after this call < 3 | failed attempt recorded | `NOT_DELIVERED` |
| D-T13 | `NOT_DELIVERED` | `setReady()` | retry ready | ready for retry | `READY_TO_DELIVER` |
| D-T14 | `IN_TRANSIT` | `cancel()` | third failed attempt | delivery cancelled | `CANCELLED` |

### Step 3: Invalid/Sneak-Path Transition Table

Expected exception: `InvalidInvocationException` by specification.

| ID | Current State | Invalid Event | Expected State After Exception |
| --- | --- | --- | --- |
| D-S01 | `IN_PREPARATION` | `assign(courier)` | `IN_PREPARATION` |
| D-S02 | `IN_PREPARATION` | `delivered()` | `IN_PREPARATION` |
| D-S03 | `READY_TO_DELIVER` | `delivered()` | `READY_TO_DELIVER` |
| D-S04 | `READY_TO_DELIVER` | `assign(courierWith5Deliveries)` | `READY_TO_DELIVER` |
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

### Step 4: Candidate Test Cases

| ID | Scenario | Arrange | Act | Expected Result |
| --- | --- | --- | --- | --- |
| D-CS-01 | New delivery starts in preparation | valid order | `new Delivery(order)` | `mode() == IN_PREPARATION`; content equals order items |
| D-CS-02 | Preparation can become ready | new delivery | `setReady()` | mode `READY_TO_DELIVER` |
| D-CS-03 | Preparation can be cancelled | new delivery | `cancel()` | mode `CANCELLED` |
| D-CS-04 | Ready can be cancelled | delivery ready | `cancel()` | mode `CANCELLED` |
| D-CS-05 | Ready can be assigned to available courier | ready delivery, courier with 4 or fewer deliveries | `assign(courier)` | mode `IN_TRANSIT`; courier assigned |
| D-CS-06 | Ready cannot be assigned to full courier | ready delivery, courier with 5 deliveries | `assign(courier)` | exception; mode remains `READY_TO_DELIVER` |
| D-CS-07 | In transit can be delivered | assigned delivery | `delivered()` | mode `DELIVERED` |
| D-CS-08 | First failed in-transit attempt becomes not delivered | assigned delivery | `cancel()` | mode `NOT_DELIVERED` |
| D-CS-09 | Not delivered can become ready again | delivery in `NOT_DELIVERED` | `setReady()` | mode `READY_TO_DELIVER` |
| D-CS-10 | Third failed attempt cancels delivery | two previous failed attempts, assigned again | `cancel()` | mode `CANCELLED` |
| D-CS-11 | Cannot assign while in preparation | new delivery | `assign(courier)` | exception; mode unchanged |
| D-CS-12 | Cannot deliver before assignment | new or ready delivery | `delivered()` | exception; mode unchanged |
| D-CS-13 | Cannot change address in transit | assigned delivery | `changeAddress(addr)` | exception; mode/content unchanged |
| D-CS-14 | Cannot update item in transit | assigned delivery | `updateItem(item, 1)` | exception; mode/content unchanged |
| D-CS-15 | Delivered is terminal | delivered delivery | call a state-changing method | exception; mode remains `DELIVERED` |
| D-CS-16 | Cancelled is terminal | cancelled delivery | call a state-changing method | exception; mode remains `CANCELLED` |
| D-CS-17 | `mode()` and `content()` are always observable | delivery in each mode | call `mode()` and `content()` | no exception; correct values |

## 3. Order.computeDeliveryCost() Method Scope

### Strategy

Chosen strategy: Combinational Function Test with domain boundary analysis.

Reason:

- The method chooses one of several delivery costs.
- The choice depends on combinations of distance, order cost, total quantity, and total weight.
- The method is a business rule naturally represented as a decision table.

### Step 1: Method Function

Primary function:

- Return delivery cost for the current order.

Inputs:

- `distance`, stored in the `Order`;
- `cost()`, derived from items;
- `totalQuantity()`, derived from items;
- `totalWeight`, derived from item weights and quantities.

Output:

- delivery cost as `double`.

### Step 2: Decision Variables

| Variable | Relevant Partitions |
| --- | --- |
| Distance | `< 5000`, `5000..15000`, `15001..20000` |
| Cost | `< 75`, `75..150`, `> 150`, `< 300`, `300..500`, `> 500` |
| Quantity | `<= 5`, `> 5`, `<= 10`, `> 10`, `< 8`, `>= 8` |
| Weight | `< 3000g`, `>= 3000g`, `< 5000g`, `>= 5000g` |

### Step 3: Decision Table

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

There are 13 variants. Since Combinational Function Test has more than 8 variants, the detailed domain-matrix examples below are capped at the first 8 variants.

### Step 4: Boundary Values

| Variable | Boundary Values |
| --- | --- |
| Distance | `4999`, `5000`, `14999`, `15000`, `15001`, `20000` |
| Cost | `74`, `75`, `150`, `151`, `299`, `300`, `500`, `501` |
| Quantity | `5`, `6`, `7`, `8`, `10`, `11` |
| Weight | `2999`, `3000`, `4999`, `5000` |

### Step 5: Domain Matrices For First 8 Variants

| Variant | Distance Point | Cost Point | Quantity Point | Weight Point | Expected Cost |
| --- | --- | --- | --- | --- | ---: |
| CDC-V01 | `4999` on/off near 5km branch | `74` off below 75 | `10` on quantity branch | in | `3` |
| CDC-V02 | `4999` on/off near 5km branch | `74` off below 75 | `11` off above 10 | in | `5` |
| CDC-V03 | `4999` on/off near 5km branch | `75` on cost boundary | in | in | `0` |
| CDC-V04 | `5000` on medium-distance boundary | `151` off above 150 | in | in | `1` |
| CDC-V05 | `5000` on medium-distance boundary | `75` and `150` on cost interval boundaries | in | in | `3` |
| CDC-V06 | `5000` on medium-distance boundary | `74` off below 75 | `5` on quantity boundary | in | `4` |
| CDC-V07 | `5000` on medium-distance boundary | `74` off below 75 | `6` off above 5 | in | `6` |
| CDC-V08 | `15001` off above 15km boundary | `501` off above 500 | in | in | `1` |

### Step 6: Candidate Test Cases

| ID | Variant | Distance | Cost Setup | Quantity | Weight | Expected Delivery Cost |
| --- | --- | ---: | --- | ---: | ---: | ---: |
| CDC-01 | V01 | `4999` | total cost `74` | `10` | any | `3` |
| CDC-02 | V02 | `4999` | total cost `74` | `11` | any | `5` |
| CDC-03 | V03 | `4999` | total cost `75` | any | any | `0` |
| CDC-04 | V04 | `5000` | total cost `151` | any | any | `1` |
| CDC-05 | V05 | `5000` | total cost `75` | any | any | `3` |
| CDC-06 | V05 | `14999` | total cost `150` | any | any | `3` |
| CDC-07 | V06 | `5000` | total cost `74` | `5` | any | `4` |
| CDC-08 | V07 | `14999` | total cost `74` | `6` | any | `6` |
| CDC-09 | V04 | `15000` | total cost `300` | any | any | `1` |
| CDC-10 | V08 | `20000` | total cost `501` | any | any | `1` |
| CDC-11 | V09 | `15001` | total cost `300` | any | `4999` | `3` |
| CDC-12 | V10 | `20000` | total cost `500` | any | `5000` | `5` |
| CDC-13 | V11 | `20000` | total cost `299` | any | `2999` | `7` |
| CDC-14 | V12 | `20000` | total cost `299` | `7` | `3000` | `8` |
| CDC-15 | V13 | `20000` | total cost `299` | `8` | `3000` | `10` |

## 4. Delivery.updateItem() Method Scope

### Strategy

Chosen strategy: Category-Partition with delivery-state constraints.

Reason:

- `updateItem()` has multiple input categories.
- It has both normal return values and invalid-invocation exceptions.
- Its behavior depends on delivery mode and previous successful updates.
- Some combinations are invalid, impossible, or duplicate in expected behavior.

### Step 1: Method Functions

Primary functions:

- Increase the quantity of an existing item.
- Add a new item.
- Decrease the quantity of an existing item.
- Reject updates that would violate quantity/content constraints.
- Track the maximum of 3 successful updates.
- Change mode from `READY_TO_DELIVER` to `IN_PREPARATION` after a successful positive update.

Outputs:

- returned boolean;
- updated content or unchanged content;
- possible mode change;
- possible exception.

### Step 2: Input And State Categories

| Category | Choices |
| --- | --- |
| Mode | M1 `IN_PREPARATION`; M2 `READY_TO_DELIVER`; M3 `IN_TRANSIT`; M4 `DELIVERED`; M5 `NOT_DELIVERED`; M6 `CANCELLED` |
| Item relation | I1 present with current quantity `5`; I2 present with current quantity `10`; I3 present as only item with quantity `1`; I4 absent same supplier; I5 absent different supplier |
| Quantity argument | Q1 `+1`; Q2 `+5`; Q3 `0`; Q4 `-1`; Q5 `-5`; Q6 `-10` |
| Successful updates before call | S0 `0`; S2 `2`; S3 `3` |

Raw cross-product size:

- `6 modes * 5 item relations * 6 quantity choices * 3 success-count choices = 540 combinations`.

The raw set is reduced with constraints because many combinations are invalid-mode duplicates or impossible data setups. The candidate test suite below selects representative combinations after applying constraints.

### Step 3: Constraints

| ID | Constraint |
| --- | --- |
| U-C01 | If mode is `IN_TRANSIT`, `DELIVERED`, `NOT_DELIVERED`, or `CANCELLED`, the call is invalid and throws the invalid-invocation exception. |
| U-C02 | If successful update count is already `3`, otherwise valid calls return `false` and content is unchanged. |
| U-C03 | If quantity is `0`, the call is valid but unsuccessful and content is unchanged. |
| U-C04 | If the item is absent and quantity is negative, the call is unsuccessful and content is unchanged. |
| U-C05 | If the item is absent and supplier is different, positive addition is unsuccessful or invalid, depending on implementation exception policy; the content must remain valid and unchanged. |
| U-C06 | If final item quantity would be greater than `10`, return `false` and preserve content. |
| U-C07 | If final total units would be `0`, return `false` and preserve content. |
| U-C08 | If a positive update succeeds in `READY_TO_DELIVER`, mode becomes `IN_PREPARATION`. |
| U-C09 | If an update is unsuccessful in `READY_TO_DELIVER`, mode remains `READY_TO_DELIVER`. |
| U-C10 | Only successful updates increment the successful-update counter. |

### Step 4: First 30 Raw Category Combinations

This table records the first 30 combinations from the category matrix before final pruning. They are useful for the final report if the Category-Partition strategy needs a capped combination listing.

| Combo | Mode | Item Relation | Quantity | Prior Successes | Expected Classification |
| --- | --- | --- | --- | --- | --- |
| U-R01 | M1 | I1 | Q1 | S0 | valid success |
| U-R02 | M1 | I1 | Q1 | S2 | valid success, reaches 3 successes |
| U-R03 | M1 | I1 | Q1 | S3 | valid call, unsuccessful due update limit |
| U-R04 | M1 | I1 | Q2 | S0 | valid success if final qty <= 10 |
| U-R05 | M1 | I1 | Q2 | S2 | valid success if final qty <= 10 |
| U-R06 | M1 | I1 | Q2 | S3 | valid call, unsuccessful due update limit |
| U-R07 | M1 | I1 | Q3 | S0 | unsuccessful no-op |
| U-R08 | M1 | I1 | Q3 | S2 | unsuccessful no-op |
| U-R09 | M1 | I1 | Q3 | S3 | unsuccessful no-op/update limit |
| U-R10 | M1 | I1 | Q4 | S0 | valid success if total remains positive |
| U-R11 | M1 | I1 | Q4 | S2 | valid success if total remains positive |
| U-R12 | M1 | I1 | Q4 | S3 | valid call, unsuccessful due update limit |
| U-R13 | M1 | I1 | Q5 | S0 | success or fail depending final qty |
| U-R14 | M1 | I1 | Q5 | S2 | success or fail depending final qty |
| U-R15 | M1 | I1 | Q5 | S3 | valid call, unsuccessful due update limit |
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
| U-R30 | M1 | I2 | Q4 | S3 | valid call, unsuccessful due update limit |

### Step 5: Candidate Test Cases

| ID | Scenario | Arrange | Act | Expected Result |
| --- | --- | --- | --- | --- |
| U-MS-01 | Increase existing item in preparation | mode `IN_PREPARATION`, item qty `5`, successes `0` | `updateItem(item, 1)` | returns `true`; qty `6`; mode remains `IN_PREPARATION` |
| U-MS-02 | Add absent same-supplier item in preparation | mode `IN_PREPARATION`, absent item, same supplier | `updateItem(item, 1)` | returns `true`; item present qty `1` |
| U-MS-03 | Decrease existing item in preparation | mode `IN_PREPARATION`, item qty `5` | `updateItem(item, -1)` | returns `true`; qty `4` |
| U-MS-04 | Zero quantity is unsuccessful | mode `IN_PREPARATION`, item qty `5` | `updateItem(item, 0)` | returns `false`; content unchanged |
| U-MS-05 | Increase above max quantity fails | mode `IN_PREPARATION`, item qty `10` | `updateItem(item, 1)` | returns `false`; qty remains `10` |
| U-MS-06 | Removal to zero total units fails | mode `IN_PREPARATION`, only item qty `1` | `updateItem(item, -1)` | returns `false`; content unchanged |
| U-MS-07 | Removing absent item fails | mode `IN_PREPARATION`, item absent | `updateItem(item, -1)` | returns `false`; content unchanged |
| U-MS-08 | Fourth successful update is rejected | mode `IN_PREPARATION`, 3 successful updates already made | otherwise valid `updateItem(item, 1)` | returns `false`; content unchanged |
| U-MS-09 | Third successful update is still allowed | mode `IN_PREPARATION`, 2 successful updates already made | valid `updateItem(item, 1)` | returns `true`; content updated |
| U-MS-10 | Ready positive successful update returns to preparation | mode `READY_TO_DELIVER`, item qty `5` | `updateItem(item, 1)` | returns `true`; mode `IN_PREPARATION`; content updated |
| U-MS-11 | Ready unsuccessful update remains ready | mode `READY_TO_DELIVER`, item qty `10` | `updateItem(item, 1)` | returns `false`; mode `READY_TO_DELIVER`; content unchanged |
| U-MS-12 | Ready negative successful update remains ready | mode `READY_TO_DELIVER`, item qty `5` | `updateItem(item, -1)` | returns `true`; mode remains `READY_TO_DELIVER`; content updated |
| U-MS-13 | In-transit update is invalid | mode `IN_TRANSIT` | `updateItem(item, 1)` | invalid-invocation exception; mode/content unchanged |
| U-MS-14 | Delivered update is invalid | mode `DELIVERED` | `updateItem(item, 1)` | invalid-invocation exception; mode/content unchanged |
| U-MS-15 | Cancelled update is invalid | mode `CANCELLED` | `updateItem(item, 1)` | invalid-invocation exception; mode/content unchanged |
| U-MS-16 | Not-delivered update is invalid | mode `NOT_DELIVERED` | `updateItem(item, 1)` | invalid-invocation exception; mode/content unchanged |
| U-MS-17 | Different supplier item is rejected | valid mode, absent item from different supplier | `updateItem(item, 1)` | returns `false`; content unchanged |
| U-MS-18 | Full item removal succeeds when other units remain | mode `IN_PREPARATION`, first item qty `1`, second item qty `2` | `updateItem(firstItem, -1)` | returns `true`; first item removed; total units remain `2` |
| U-MS-19 | Unsuccessful updates do not consume limit | mode `IN_PREPARATION`, item qty `10` | three failed `updateItem(item, 1)` calls, then `updateItem(item, -1)` | failed calls return `false`; later valid update returns `true` |

## 5. Client Class-Scope Implemented Tests

The PDF requires 8 implemented TestNG tests for `Client`, split into 4 successful and 4 unsuccessful tests, but it does not define `Client` behavior. The project therefore uses the following explicit assumption for the implemented class-scope tests.

Assumed `Client` model:

- A client stores `name`, `email`, `phone`, and `address`.
- `name` and `address` must be non-null and non-blank.
- `email` must contain exactly one `@` with text before and after it.
- `phone` must contain exactly 9 digits.
- A valid address update changes only the address.

| ID | Classification | Scenario | Arrange | Act | Expected Result |
| --- | --- | --- | --- | --- | --- |
| C-CS-01 | Successful | Valid construction | valid name, email, 9-digit phone, address | `new Client(...)` | fields are stored |
| C-CS-02 | Successful | Text trimming | leading/trailing spaces around fields | `new Client(...)` | stored values are trimmed |
| C-CS-03 | Successful | Valid address update | valid existing client | `changeAddress("Rua Nova")` | address changes; identity/contact fields unchanged |
| C-CS-04 | Successful | Boundary-valid phone | phone `000000000` | `new Client(...)` | client is created; phone is stored |
| C-CS-05 | Unsuccessful | Blank name | blank name | `new Client(...)` | `InvalidOperationException` |
| C-CS-06 | Unsuccessful | Invalid email | email without `@` | `new Client(...)` | `InvalidOperationException` |
| C-CS-07 | Unsuccessful | Invalid phone | 8-digit phone | `new Client(...)` | `InvalidOperationException` |
| C-CS-08 | Unsuccessful | Blank address update | valid existing client | `changeAddress(" ")` | `InvalidOperationException`; previous address preserved |

## 6. Summary Of Completion

Step 2 required a test-design artifact for the four targets identified in the project statement.

Completed in this draft:

- `Order` class-scope strategy and candidate tests.
- `Delivery` class-scope strategy, state model, valid transition table, invalid transition table, and candidate tests.
- `Order.computeDeliveryCost()` method-scope strategy, decision table, boundary values, first 8 domain-matrix variants, and candidate tests.
- `Delivery.updateItem()` method-scope strategy, category partitions, constraints, first 30 raw combinations, and candidate tests.
- `Client` class-scope implemented tests under an explicit assumption, with 4 successful and 4 unsuccessful TestNG tests.

Still intentionally deferred:

- Final polished report formatting.
- Final packaging for submission.
