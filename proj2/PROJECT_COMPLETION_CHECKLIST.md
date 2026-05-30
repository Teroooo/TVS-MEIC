# Project Completion Checklist

This checklist is based on `P2-Eng.pdf` and the current repository state.

## 1. Define the Test Strategy and Test Harness

Status: complete. The working decisions are recorded in `TEST_PLAN.md`; the final report remains deferred until the test suite is in place.

- [x] Confirm the current project focus.
  - The professor clarified that the immediate focus is writing tests.
  - The final formal report will be prepared later from the test-plan and test-design artifacts.

- [x] Choose the test strategy for each required target.
  - `Order` class scope: non-modal class testing plus invariant boundaries.
  - `Delivery` class scope: modal/FSM state-transition testing.
  - `Order.computeDeliveryCost()`: combinational function testing plus domain boundaries.
  - `Delivery.updateItem()`: category-partition plus delivery state constraints.

- [x] Establish the TestNG implementation conventions.
  - Keep tests in `src/test/java/supereats/core`.
  - Use Arrange, Act, Assert.
  - Use `Assert.expectThrows` or `Assert.assertThrows` when invalid operations require unchanged-state assertions.
  - Use `@DataProvider` for repeated decision-table or boundary cases.

- [x] Keep the test harness on Gradle/TestNG.
  - `build.gradle` already uses TestNG.
  - Added a Gradle project name in `settings.gradle`.
  - Added test logging for passed, skipped, and failed tests.

- [x] Track the `Client` uncertainty separately.
  - The PDF requires 8 TestNG tests for `Client`, but the visible PDF does not describe `Client` behavior.
  - This was resolved in Step 8 by documenting an explicit minimal `Client` assumption and implementing the required 8 tests.

## 2. Add the Missing Test-Design Draft

Status: complete. The working test-design artifact is `TEST_DESIGN_DRAFT.md`; final report formatting remains deferred until the end.

For each required target, write:

- [x] The test design strategy used.
- [x] The intermediate steps of the strategy, using the format taught in lectures.
- [x] The final list of designed test cases.
- [x] The expected result for each test case.
- [x] Any assumptions made because the PDF is incomplete or ambiguous.

Required targets:

- [x] Class-scope test cases for `Order`.
- [x] Class-scope test cases for `Delivery`.
- [x] Method-scope test cases for `Order.computeDeliveryCost()`.
- [x] Method-scope test cases for `Delivery.updateItem()`.

Recommended strategy choices:

- [x] Use Category Partition or another class-scope strategy for `Order`.
- [x] Use State Transition Testing for `Delivery`.
- [x] Use Decision Table / Classification Tree / Category Partition for `computeDeliveryCost()`.
- [x] Use Category Partition plus state constraints for `updateItem()`.

## 3. Complete `Order` Test Design Coverage

Status: complete. `TEST_DESIGN_DRAFT.md` contains the `Order` class-scope design, `OrderTest.java` is aligned with it, and the manual TestNG run passes.

Cover these `Order` class-scope rules:

- [x] Constructor accepts distance up to 20,000 metres.
- [x] Constructor rejects distance greater than 20,000 metres.
- [x] `setAddress()` accepts distance up to 20,000 metres.
- [x] `setAddress()` rejects distance greater than 20,000 metres and leaves state unchanged.
- [x] `addItem()` accepts item quantities from 1 to 10.
- [x] `addItem()` rejects quantities below 1.
- [x] `addItem()` rejects quantities above 10.
- [x] Re-adding an existing item must not make that item quantity exceed 10.
- [x] All items in an order must have the same supplier.
- [x] Total order cost must not exceed 1000 euros.
- [x] Total quantity must not exceed `20 + floor(orderCost / 50)`.
- [x] Invalid operations must throw `InvalidOperationException`.
- [x] Invalid operations must leave the order state unchanged.
- [x] `contains()`, `quantity()`, `totalQuantity()`, `cost()`, and `itens()` return values consistent with the current order content.

Fix or review these current tests:

- [x] Fix `testAddItemAndOverRemove`.
- [x] Fix `testRemoveNonExistingItem`.
- [x] Decide whether `removeItem()` should throw when removing too much or removing a missing item.
  - The PDF says any invalid operation must throw and preserve state.
  - Decision: `removeItem()` now throws and preserves state when removing too much, removing a missing item, or removing a non-positive quantity.
- [x] Do not put assertions after the operation that is expected to throw, unless using `try/catch` or `Assert.expectThrows`.

## 4. Complete `computeDeliveryCost()` Method-Scope Design

Status: complete. `TEST_DESIGN_DRAFT.md` contains the method-scope design, `OrderTest.java` now has a TestNG `@DataProvider` decision-table test for the required variants and boundaries, and the manual TestNG run passes.

Cover these decision branches and boundaries:

- [x] Distance below 5 km.
- [x] Distance exactly 5 km.
- [x] Distance between 5 km and 15 km.
- [x] Distance exactly 15 km.
- [x] Distance above 15 km up to 20 km.
- [x] Distance exactly 20 km.
- [x] Cost below 75.
- [x] Cost exactly 75.
- [x] Cost exactly 150.
- [x] Cost above 150.
- [x] Cost below 300.
- [x] Cost exactly 300.
- [x] Cost exactly 500.
- [x] Cost above 500.
- [x] Quantity exactly 5 and above 5.
- [x] Quantity exactly 8 and above/below 8.
- [x] Quantity exactly 10 and above 10.
- [x] Weight below 3 kg.
- [x] Weight exactly 3 kg.
- [x] Weight below 5 kg.
- [x] Weight exactly 5 kg.

Expected delivery costs to cover:

- [x] `0`
- [x] `1`
- [x] `3`
- [x] `4`
- [x] `5`
- [x] `6`
- [x] `7`
- [x] `8`
- [x] `10`

## 5. Complete `Delivery` Implementation or Test Stubs

Status: complete. `Delivery.java` now implements the required class-scope state behavior, `InvalidInvocationException` has been added, and `DeliveryTest.java` covers the state transitions and invalid invocations.

Required behavior from the PDF:

- [x] Constructor stores the `Order`.
- [x] Constructor initializes mode as `IN_PREPARATION`.
- [x] `mode()` returns the current mode at any time.
- [x] `content()` returns the current delivery content at any time.
- [x] `changeAddress()` works only in `IN_PREPARATION` and `READY_TO_DELIVER`.
- [x] Invalid invocations must throw the required exception and have no effect.
- [x] `setReady()` transitions from `IN_PREPARATION` to `READY_TO_DELIVER`.
- [x] `setReady()` transitions from `NOT_DELIVERED` to `READY_TO_DELIVER`.
- [x] `cancel()` from `IN_PREPARATION` or `READY_TO_DELIVER` transitions to `CANCELLED`.
- [x] `assign()` works only from `READY_TO_DELIVER`.
- [x] `assign()` transitions to `IN_TRANSIT` only if the courier has fewer than 5 assigned deliveries.
- [x] `delivered()` works only from `IN_TRANSIT` and transitions to `DELIVERED`.
- [x] `cancel()` from `IN_TRANSIT` transitions to `NOT_DELIVERED` for fewer than 3 attempts.
- [x] `cancel()` from `IN_TRANSIT` transitions to `CANCELLED` on the third failed attempt.
- [x] Terminal modes `DELIVERED` and `CANCELLED` reject further state-changing operations.

Important ambiguity:

- [x] The PDF says invalid `Delivery` invocations throw `InvalidInvocationException`.
- [x] Add `InvalidInvocationException` to the project.
- [x] Use `InvalidInvocationException` consistently for invalid `Delivery` invocations.

## 6. Complete `Delivery.updateItem()` Design and Implementation

Status: complete. `Delivery.updateItem()` now follows the method-scope rules from the PDF, including the total-units boundary, successful-update limit, ready-mode behavior, and unchanged content on unsuccessful valid calls. `DeliveryTest.java` now includes focused method-scope tests for these cases.

Required behavior:

- [x] Valid only in `IN_PREPARATION` and `READY_TO_DELIVER`.
- [x] If invoked in any other mode, throw the invalid-invocation exception.
- [x] Positive quantity means item addition/increase.
- [x] Negative quantity means item removal/decrease.
- [x] The final quantity for each item must not exceed 10.
- [x] The delivery must always contain at least one total unit after the update.
- [x] If the update is unsuccessful, return `false` and leave content unchanged.
- [x] At most 3 successful updates are allowed.
- [x] After 3 successful updates, valid calls return `false` without changing content.
- [x] If a ready delivery is successfully updated with a positive quantity, mode returns to `IN_PREPARATION`.
- [x] If a ready delivery has an unsuccessful update, mode remains `READY_TO_DELIVER`.
- [x] If a ready delivery is successfully updated with a negative quantity, mode remains `READY_TO_DELIVER`.
- [x] If a ready delivery receives a zero-quantity update, the update is unsuccessful and mode remains `READY_TO_DELIVER`.

Design tests for:

- [x] Successful item increase.
- [x] Successful new item addition from the same supplier.
- [x] Successful item decrease.
- [x] Successful full item removal when other units remain.
- [x] Failed removal that would make total units zero.
- [x] Failed update above quantity 10.
- [x] Failed update after 3 successful updates.
- [x] Unsuccessful updates do not consume the successful-update limit.
- [x] Invalid call in `IN_TRANSIT`.
- [x] Invalid call in `DELIVERED`.
- [x] Invalid call in `NOT_DELIVERED`.
- [x] Invalid call in `CANCELLED`.
- [x] Ready delivery returning to preparation after successful positive update.
- [x] Ready delivery remaining ready after unsuccessful update.
- [x] Ready delivery remaining ready after successful negative update.

## 7. Complete `Courier`

Status: complete for the behavior required by `Delivery.assign()`.

Needed for `Delivery.assign()`:

- [x] Track assigned deliveries.
- [x] Expose or support checking whether the courier has fewer than 5 assigned deliveries.
- [x] Add a delivery to the courier when assignment succeeds.
- [x] Decide whether completed/cancelled deliveries still count as assigned deliveries, and document the assumption if the PDF does not clarify.
  - Decision: assigned deliveries remain counted; the PDF does not define unassignment.

## 8. Complete `Client` Tests

Status: complete under an explicit project assumption. `P2-Eng.pdf` requires 8 `Client` tests but does not define `Client` behavior, so the project now documents and implements a minimal customer identity/contact model for `Client`.

Assumed `Client` behavior:

- [x] A client has `name`, `email`, `phone`, and `address`.
- [x] `name` and `address` must be non-null and non-blank.
- [x] `email` must be non-null, contain exactly one `@`, and have text before and after it.
- [x] `phone` must be exactly 9 digits.
- [x] `changeAddress()` accepts only non-blank addresses and preserves the previous address on failure.
- [x] A no-argument constructor remains available for the existing `Order` and `Delivery` tests.

Required by the PDF:

- [x] Add exactly or at least 8 implemented TestNG tests for `Client` class scope, depending on submission rules.
- [x] Include 4 successful test cases.
- [x] Include 4 unsuccessful test cases.
- [x] Use TestNG annotations.
- [x] Make tests syntactically valid and consistent with the implemented `Client` interface.

Implemented successful tests:

- [x] Valid constructor stores identity and contact data.
- [x] Constructor trims text fields.
- [x] Valid address update changes only the address.
- [x] Boundary-valid 9-digit phone is accepted.

Implemented unsuccessful tests:

- [x] Blank name is rejected.
- [x] Invalid email is rejected.
- [x] Phone with fewer than 9 digits is rejected.
- [x] Blank address update is rejected and preserves previous address.

## 9. Clean Up Test Execution

Status: complete. Gradle is now executable through the project wrapper, the full test suite runs from a clean build, and stale manual TestNG output has been removed.

- [x] Add a Gradle wrapper with `gradle wrapper`, or ensure the submission environment has Gradle installed.
  - Added wrapper files for Gradle `9.5.1`.
- [x] Re-run all tests with `./gradlew test`.
  - Ran `./gradlew clean test --warning-mode all`.
- [x] Ensure generated reports show all tests, not only stale earlier results.
  - Gradle XML report shows `ClientTest`: 8 tests, `DeliveryTest`: 34 tests, `OrderTest`: 64 tests.
- [x] Remove stale build artifacts from the final submission if the course does not want them.
  - Removed the old manual TestNG `test-output/` directory.
  - Added `.gitignore` entries for `.gradle/`, `build/`, `test-output/`, and `.DS_Store`.
- [x] Keep source files and tests only if required by the submission protocol.
  - Final archive should include the report and required Java files, not local Gradle caches or generated build output.

Current local test status:

- [x] Gradle is available locally and `./gradlew` is available for repeatable execution.
- [x] Manual TestNG execution compiled and ran `OrderTest` and `DeliveryTest`.
- [x] Manual result after Step 5: 83 TestNG invocations, 83 passes, 0 failures.
- [x] Manual result after Step 6: 98 TestNG invocations, 98 passes, 0 failures.
- [x] Manual result after Step 8: 106 TestNG invocations, 106 passes, 0 failures.
- [x] Gradle result after Step 9: 106 TestNG invocations, 106 passes, 0 failures.

## 10. Final Review Before Submission

- [ ] Confirm every required PDF bullet has a matching section in the report.
- [ ] Confirm every designed test has a clear expected result.
- [ ] Confirm implemented TestNG tests are part of the required `Client` test subset.
- [ ] Confirm invalid-operation tests check both exception and unchanged state.
- [ ] Confirm boundary values are explicit, especially distances, costs, weights, and quantities.
- [ ] Confirm the final submission does not rely on behavior that contradicts the PDF.
