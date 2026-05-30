# SuperEats Project 2 Test Plan

Status: Step 1 complete.

This file is the working test-plan backbone for Project 2. It is not the final report. The final report can later reuse the strategy choices, matrices, and test cases written here.

## Step 1 Decisions

### Focus

The project focus is writing tests from the specification in `P2-Eng.pdf`. Production implementation is only needed when it helps the tests compile or run locally.

### Test Framework

Use TestNG, already configured in `build.gradle` with:

- `org.testng:testng:7.10.2`
- `test { useTestNG() }`

All tests should stay under:

```text
src/test/java/supereats/core
```

This keeps test classes in the same package as the implementation classes, matching the class-slide guidance.

### Test Style

Use Arrange, Act, Assert in every test.

For exception tests, prefer `Assert.expectThrows` or `Assert.assertThrows` instead of only using `@Test(expectedExceptions = ...)`, because the project specification often requires checking that invalid operations leave state unchanged.

Example:

```java
InvalidOperationException exception = Assert.expectThrows(
    InvalidOperationException.class,
    () -> order.addItem(item, 11)
);

Assert.assertEquals(order.totalQuantity(), 0);
Assert.assertEquals(order.cost(), 0.0);
```

Use `@DataProvider` for repeated decision-table or boundary cases, especially `Order.computeDeliveryCost()`.

### Test Doubles

Default choice: use real objects unless setup becomes awkward.

- Use real `Supplier`.
- Use real `Item`.
- Use real/simple `Client` objects; Step 8 defines the minimal assumed `Client` behavior used by the implemented tests.
- Do not introduce Mockito unless a collaborator becomes difficult to construct or interaction verification is needed.

## Strategy Mapping

| Required Target | Chosen Strategy | Why |
| --- | --- | --- |
| `Order` class scope | Non-modal class testing + invariant boundaries | `Order` has no explicit modes, but has strong invariants around supplier, cost, quantity, distance, and content. |
| `Delivery` class scope | Modal/FSM state-transition testing | `Delivery` behavior depends on mode and previous method calls. |
| `Order.computeDeliveryCost()` method scope | Combinational Function Test + domain boundaries | The method selects a delivery cost from combinations of distance, order cost, quantity, and weight. |
| `Delivery.updateItem()` method scope | Category-Partition + delivery state constraints | The method behavior depends on mode, item presence, quantity sign, quantity limits, and number of successful updates. |
| `Client` class scope | Class-scope validation testing under explicit assumption | The PDF requires 8 Client tests but does not describe Client behavior, so the project documents a minimal identity/contact model. |

## Order Class-Scope Plan

Strategy: Non-modal class testing with invariant boundaries.

Class invariants and boundaries:

| Requirement | Boundary/Condition | Valid Point | Invalid Point |
| --- | --- | ---: | ---: |
| Distance must not exceed 20 km | `distance <= 20000` | `20000` | `20001` |
| Item quantity lower bound | `quantity >= 1` | `1` | `0` |
| Item quantity upper bound | `quantity <= 10` | `10` | `11` |
| Order cost upper bound | `cost <= 1000` | `1000` | `1001` |
| Total units formula | `totalQuantity <= 20 + floor(cost / 50)` | exactly formula limit | formula limit + 1 |
| Supplier consistency | all items from same supplier | same supplier | different supplier |

Core tests to keep or add:

- Constructor accepts distance `20000`.
- Constructor rejects distance `20001`.
- `setAddress()` accepts distance `20000`.
- `setAddress()` rejects distance `20001` and preserves existing order state.
- `addItem()` accepts quantities `1` and `10`.
- `addItem()` rejects quantities `0` and `11`.
- Re-adding an existing item rejects a final quantity above `10`.
- Adding an item from a different supplier is rejected.
- Adding an item that makes cost exceed `1000` is rejected.
- Adding an item that violates the total-units formula is rejected.
- `contains()`, `quantity()`, `totalQuantity()`, `cost()`, and `itens()` agree after valid changes.
- Invalid operations preserve state.

Current cleanup needed:

- `testAddItemAndOverRemove` must be aligned with the specification and current intended `removeItem()` behavior.
- `testRemoveNonExistingItem` must be aligned with the specification and current intended `removeItem()` behavior.
- Invalid-operation tests should move post-exception assertions after `expectThrows`.

## computeDeliveryCost Method-Scope Plan

Strategy: Combinational Function Test with domain boundary analysis.

Decision variables:

- distance range;
- order cost range;
- total quantity;
- total weight.

Decision table:

| Variant | Distance | Cost | Quantity | Weight | Expected Delivery Cost |
| --- | --- | --- | --- | --- | ---: |
| C1 | `< 5000` | `< 75` | `<= 10` | any | `3` |
| C2 | `< 5000` | `< 75` | `> 10` | any | `5` |
| C3 | `< 5000` | `>= 75` | any | any | `0` |
| C4 | `5000..15000` | `> 150` | any | any | `1` |
| C5 | `5000..15000` | `75..150` | any | any | `3` |
| C6 | `5000..15000` | `< 75` | `<= 5` | any | `4` |
| C7 | `5000..15000` | `< 75` | `> 5` | any | `6` |
| C8 | `15001..20000` | `> 500` | any | any | `1` |
| C9 | `15001..20000` | `300..500` | any | `< 5000g` | `3` |
| C10 | `15001..20000` | `300..500` | any | `>= 5000g` | `5` |
| C11 | `15001..20000` | `< 300` | any | `< 3000g` | `7` |
| C12 | `15001..20000` | `< 300` | `< 8` | `>= 3000g` | `8` |
| C13 | `15001..20000` | `< 300` | `>= 8` | `>= 3000g` | `10` |

Boundary values to include:

- distance: `4999`, `5000`, `14999`, `15000`, `15001`, `20000`;
- cost: `74`, `75`, `150`, `151`, `299`, `300`, `500`, `501`;
- quantity: `5`, `6`, `7`, `8`, `10`, `11`;
- weight: `2999`, `3000`, `4999`, `5000`.

Implementation direction:

- Replace repetitive individual tests with a `@DataProvider` if it stays readable.
- Keep at least one case per decision-table variant.
- Add extra boundary cases where a variant boundary is especially likely to fail.

## Delivery Class-Scope Plan

Strategy: Modal/FSM state-transition testing.

States:

- `IN_PREPARATION`
- `READY_TO_DELIVER`
- `IN_TRANSIT`
- `DELIVERED`
- `NOT_DELIVERED`
- `CANCELLED`

Valid transition table:

| Initial State | Event | Guard/Condition | Expected State |
| --- | --- | --- | --- |
| construction | `new Delivery(order)` | valid order | `IN_PREPARATION` |
| `IN_PREPARATION` | `setReady()` | none | `READY_TO_DELIVER` |
| `IN_PREPARATION` | `cancel()` | none | `CANCELLED` |
| `READY_TO_DELIVER` | `cancel()` | none | `CANCELLED` |
| `READY_TO_DELIVER` | `assign(courier)` | courier has fewer than 5 assigned deliveries | `IN_TRANSIT` |
| `IN_TRANSIT` | `delivered()` | none | `DELIVERED` |
| `IN_TRANSIT` | `cancel()` | failed attempts fewer than 3 | `NOT_DELIVERED` |
| `NOT_DELIVERED` | `setReady()` | ready for retry | `READY_TO_DELIVER` |
| `IN_TRANSIT` | `cancel()` | third failed attempt | `CANCELLED` |

Sneak-path/invalid transition tests:

- `assign()` in `IN_PREPARATION`.
- `delivered()` before assignment.
- `changeAddress()` in `IN_TRANSIT`.
- `updateItem()` in `IN_TRANSIT`.
- state-changing operation in `DELIVERED`.
- state-changing operation in `CANCELLED`.
- `assign()` with a courier that already has 5 assigned deliveries.

For every invalid transition:

- assert the expected exception;
- assert mode did not change;
- assert content did not change where relevant.

## updateItem Method-Scope Plan

Strategy: Category-Partition with modal state constraints.

Categories and choices:

| Category | Choices |
| --- | --- |
| Delivery mode | `IN_PREPARATION`, `READY_TO_DELIVER`, invalid modes |
| Item presence | present, absent |
| Quantity argument | positive, zero, negative |
| Resulting item quantity | `1..10`, `0`, `< 0`, `> 10` |
| Resulting total quantity | positive, zero |
| Successful update count before call | `0`, `2`, `3` |
| Supplier | same supplier, different supplier if adding absent item |

Expected behaviors:

- Valid successful update returns `true`.
- Valid unsuccessful update returns `false`.
- Invalid mode throws the invalid-invocation exception.
- Unsuccessful update preserves content.
- Fourth successful-update attempt returns `false` and preserves content.
- Failed updates do not consume the successful-update limit.
- Removing all units of one item is successful when other delivery units remain.
- Positive successful update from `READY_TO_DELIVER` returns mode to `IN_PREPARATION`.
- Unsuccessful update from `READY_TO_DELIVER` keeps mode `READY_TO_DELIVER`.
- Negative successful update from `READY_TO_DELIVER` keeps mode `READY_TO_DELIVER`.

Resolved exception decision:

- The PDF mentions `InvalidInvocationException`; this exception has been added and is used for invalid `Delivery` invocations.

## Client Class-Scope Plan

Status: complete under an explicit project assumption.

The PDF requires:

- 8 implemented TestNG tests for `Client`;
- 4 successful cases;
- 4 unsuccessful cases.

Specification gap:

- `P2-Eng.pdf` does not define `Client` behavior.
- The initial `Client.java` file was empty.

Decision:

- Define a minimal delivery-system client identity/contact model and document it as an assumption.
- Keep a no-argument constructor so existing `Order` and `Delivery` tests remain valid.
- Use `InvalidOperationException` for invalid client data, matching the existing domain validation style.

Assumed behavior:

- A client has `name`, `email`, `phone`, and `address`.
- `name` and `address` must be non-null and non-blank.
- `email` must contain exactly one `@` with text before and after it.
- `phone` must contain exactly 9 digits.
- `changeAddress()` updates the address only when the new address is valid.

Implemented successful tests:

- Valid client construction stores all fields.
- Constructor trims text fields.
- Valid address update changes only the address.
- Boundary-valid 9-digit phone is accepted.

Implemented unsuccessful tests:

- Blank name is rejected.
- Invalid email is rejected.
- Phone with fewer than 9 digits is rejected.
- Blank address update is rejected and preserves previous address.

## Immediate Next Work

1. Build the final PDF report from the completed design notes.
2. Package the required report and Java test files in a single archive.
3. Exclude local build output, Gradle caches, and stale generated reports from the final archive unless explicitly requested.
