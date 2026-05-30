package supereats.core;

import java.util.HashMap;
import java.util.Map;

import org.testng.Assert;
import org.testng.annotations.Test;

public class DeliveryTest {

    @Test
    public void testNewDeliveryStartsInPreparationAndExposesContent() {
        // Arrange
        Order order = sampleOrder();

        // Act
        Delivery delivery = new Delivery(order);

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_PREPARATION);
        Assert.assertEquals(delivery.content().size(), 1);
        Assert.assertEquals(totalQuantity(delivery), 2);
    }

    @Test
    public void testChangeAddressInPreparation() {
        // Arrange
        Order order = sampleOrder();
        Delivery delivery = new Delivery(order);

        // Act
        delivery.changeAddress("New Street");

        // Assert
        Assert.assertEquals(order.deliveryAddress, "New Street");
        Assert.assertEquals(order.distance, 2000);
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_PREPARATION);
    }

    @Test
    public void testChangeAddressWhenReady() {
        // Arrange
        Order order = sampleOrder();
        Delivery delivery = new Delivery(order);
        delivery.setReady();

        // Act
        delivery.changeAddress("Ready Street");

        // Assert
        Assert.assertEquals(order.deliveryAddress, "Ready Street");
        Assert.assertEquals(delivery.mode(), DeliverMode.READY_TO_DELIVER);
    }

    @Test
    public void testSetReadyFromPreparation() {
        // Arrange
        Delivery delivery = sampleDelivery();

        // Act
        delivery.setReady();

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.READY_TO_DELIVER);
    }

    @Test
    public void testCancelFromPreparation() {
        // Arrange
        Delivery delivery = sampleDelivery();

        // Act
        delivery.cancel();

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.CANCELLED);
    }

    @Test
    public void testCancelFromReady() {
        // Arrange
        Delivery delivery = sampleDelivery();
        delivery.setReady();

        // Act
        delivery.cancel();

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.CANCELLED);
    }

    @Test
    public void testAssignReadyDeliveryToAvailableCourier() {
        // Arrange
        Delivery delivery = sampleDelivery();
        Courier courier = new Courier();
        delivery.setReady();

        // Act
        delivery.assign(courier);

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_TRANSIT);
        Assert.assertEquals(delivery.courier(), courier);
        Assert.assertEquals(courier.assignedDeliveryCount(), 1);
    }

    @Test
    public void testAssignReadyDeliveryToFullCourierThrowsAndPreservesState() {
        // Arrange
        Courier courier = fullCourier();
        Delivery delivery = sampleDelivery();
        delivery.setReady();
        int quantityBefore = totalQuantity(delivery);

        // Act
        Assert.expectThrows(InvalidInvocationException.class, () -> delivery.assign(courier));

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.READY_TO_DELIVER);
        Assert.assertEquals(totalQuantity(delivery), quantityBefore);
        Assert.assertEquals(courier.assignedDeliveryCount(), 5);
    }

    @Test
    public void testDeliveredFromInTransit() {
        // Arrange
        Delivery delivery = assignedDelivery();

        // Act
        delivery.delivered();

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.DELIVERED);
    }

    @Test
    public void testCancelFromInTransitBeforeThirdAttemptBecomesNotDelivered() {
        // Arrange
        Delivery delivery = assignedDelivery();

        // Act
        delivery.cancel();

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.NOT_DELIVERED);
    }

    @Test
    public void testNotDeliveredCanBecomeReadyAgain() {
        // Arrange
        Delivery delivery = assignedDelivery();
        delivery.cancel();

        // Act
        delivery.setReady();

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.READY_TO_DELIVER);
    }

    @Test
    public void testThirdFailedTransitAttemptCancelsDelivery() {
        // Arrange
        Delivery delivery = assignedDelivery();

        // Act
        delivery.cancel();
        delivery.setReady();
        delivery.assign(new Courier());
        delivery.cancel();
        delivery.setReady();
        delivery.assign(new Courier());
        delivery.cancel();

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.CANCELLED);
    }

    @Test
    public void testCannotAssignInPreparation() {
        // Arrange
        Delivery delivery = sampleDelivery();
        int quantityBefore = totalQuantity(delivery);

        // Act
        Assert.expectThrows(InvalidInvocationException.class, () -> delivery.assign(new Courier()));

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_PREPARATION);
        Assert.assertEquals(totalQuantity(delivery), quantityBefore);
    }

    @Test
    public void testCannotDeliverBeforeAssignment() {
        // Arrange
        Delivery delivery = sampleDelivery();
        delivery.setReady();

        // Act
        Assert.expectThrows(InvalidInvocationException.class, delivery::delivered);

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.READY_TO_DELIVER);
    }

    @Test
    public void testCannotChangeAddressInTransit() {
        // Arrange
        Order order = sampleOrder();
        Delivery delivery = new Delivery(order);
        delivery.setReady();
        delivery.assign(new Courier());

        // Act
        Assert.expectThrows(InvalidInvocationException.class, () -> delivery.changeAddress("Blocked Street"));

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_TRANSIT);
        Assert.assertEquals(order.deliveryAddress, "Sesame Street");
    }

    @Test
    public void testCannotUpdateItemInTransit() {
        // Arrange
        Delivery delivery = assignedDelivery();
        Item item = delivery.content().get(0).first();
        int quantityBefore = totalQuantity(delivery);

        // Act
        Assert.expectThrows(InvalidInvocationException.class, () -> delivery.updateItem(item, 1));

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_TRANSIT);
        Assert.assertEquals(totalQuantity(delivery), quantityBefore);
    }

    @Test
    public void testDeliveredModeRejectsFurtherStateChangingOperations() {
        // Arrange
        Delivery delivery = assignedDelivery();
        Item item = delivery.content().get(0).first();
        delivery.delivered();

        // Act
        Assert.expectThrows(InvalidInvocationException.class, delivery::setReady);
        Assert.expectThrows(InvalidInvocationException.class, delivery::cancel);
        Assert.expectThrows(InvalidInvocationException.class, () -> delivery.updateItem(item, 1));

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.DELIVERED);
    }

    @Test
    public void testCancelledModeRejectsFurtherStateChangingOperations() {
        // Arrange
        Delivery delivery = sampleDelivery();
        Item item = delivery.content().get(0).first();
        delivery.cancel();

        // Act
        Assert.expectThrows(InvalidInvocationException.class, delivery::setReady);
        Assert.expectThrows(InvalidInvocationException.class, () -> delivery.assign(new Courier()));
        Assert.expectThrows(InvalidInvocationException.class, () -> delivery.updateItem(item, 1));

        // Assert
        Assert.assertEquals(delivery.mode(), DeliverMode.CANCELLED);
    }

    @Test
    public void testModeAndContentCanBeReadInEveryMode() {
        // Arrange
        Delivery preparation = sampleDelivery();
        Delivery ready = sampleDelivery();
        ready.setReady();
        Delivery inTransit = assignedDelivery();
        Delivery delivered = assignedDelivery();
        delivered.delivered();
        Delivery notDelivered = assignedDelivery();
        notDelivered.cancel();
        Delivery cancelled = sampleDelivery();
        cancelled.cancel();

        // Act && Assert
        assertObservable(preparation, DeliverMode.IN_PREPARATION);
        assertObservable(ready, DeliverMode.READY_TO_DELIVER);
        assertObservable(inTransit, DeliverMode.IN_TRANSIT);
        assertObservable(delivered, DeliverMode.DELIVERED);
        assertObservable(notDelivered, DeliverMode.NOT_DELIVERED);
        assertObservable(cancelled, DeliverMode.CANCELLED);
    }

    @Test
    public void testUpdateItemIncreasesExistingItemInPreparation() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(5);
        Item item = delivery.content().get(0).first();

        // Act
        boolean updated = delivery.updateItem(item, 1);

        // Assert
        Assert.assertTrue(updated);
        Assert.assertEquals(itemQuantity(delivery, item), 6);
        Assert.assertEquals(totalQuantity(delivery), 6);
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_PREPARATION);
    }

    @Test
    public void testUpdateItemAddsAbsentSameSupplierItemInPreparation() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(5);
        Supplier supplier = delivery.content().get(0).first().supplier();
        Item newItem = new Item(150, 12, supplier, "Travel soap");

        // Act
        boolean updated = delivery.updateItem(newItem, 1);

        // Assert
        Assert.assertTrue(updated);
        Assert.assertEquals(itemQuantity(delivery, newItem), 1);
        Assert.assertEquals(totalQuantity(delivery), 6);
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_PREPARATION);
    }

    @Test
    public void testUpdateItemDecreasesExistingItemInPreparation() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(5);
        Item item = delivery.content().get(0).first();

        // Act
        boolean updated = delivery.updateItem(item, -1);

        // Assert
        Assert.assertTrue(updated);
        Assert.assertEquals(itemQuantity(delivery, item), 4);
        Assert.assertEquals(totalQuantity(delivery), 4);
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_PREPARATION);
    }

    @Test
    public void testUpdateItemWithZeroQuantityFailsAndPreservesContent() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(5);
        Item item = delivery.content().get(0).first();
        Map<Item, Integer> contentBefore = contentSnapshot(delivery);

        // Act
        boolean updated = delivery.updateItem(item, 0);

        // Assert
        Assert.assertFalse(updated);
        Assert.assertEquals(contentSnapshot(delivery), contentBefore);
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_PREPARATION);
    }

    @Test
    public void testUpdateItemRejectsIncreaseAbovePerItemLimit() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(10);
        Item item = delivery.content().get(0).first();
        Map<Item, Integer> contentBefore = contentSnapshot(delivery);

        // Act
        boolean updated = delivery.updateItem(item, 1);

        // Assert
        Assert.assertFalse(updated);
        Assert.assertEquals(contentSnapshot(delivery), contentBefore);
        Assert.assertEquals(itemQuantity(delivery, item), 10);
    }

    @Test
    public void testUpdateItemRejectsRemovalThatWouldEmptyDelivery() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(1);
        Item item = delivery.content().get(0).first();
        Map<Item, Integer> contentBefore = contentSnapshot(delivery);

        // Act
        boolean updated = delivery.updateItem(item, -1);

        // Assert
        Assert.assertFalse(updated);
        Assert.assertEquals(contentSnapshot(delivery), contentBefore);
        Assert.assertEquals(totalQuantity(delivery), 1);
    }

    @Test
    public void testUpdateItemRemovesWholeItemWhenOtherUnitsRemain() {
        // Arrange
        Supplier supplier = new Supplier("Alibaba");
        Item firstItem = new Item(200, 10, supplier, "Big toothbrush.");
        Item secondItem = new Item(100, 15, supplier, "Toothpaste.");
        Order order = new Order(new Client(), "Sesame Street", 2000);
        order.addItem(firstItem, 1);
        order.addItem(secondItem, 2);
        Delivery delivery = new Delivery(order);

        // Act
        boolean updated = delivery.updateItem(firstItem, -1);

        // Assert
        Assert.assertTrue(updated);
        Assert.assertFalse(contentSnapshot(delivery).containsKey(firstItem));
        Assert.assertEquals(itemQuantity(delivery, secondItem), 2);
        Assert.assertEquals(totalQuantity(delivery), 2);
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_PREPARATION);
    }

    @Test
    public void testUpdateItemRejectsAbsentNegativeQuantity() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(5);
        Supplier supplier = delivery.content().get(0).first().supplier();
        Item absentItem = new Item(150, 12, supplier, "Travel soap");
        Map<Item, Integer> contentBefore = contentSnapshot(delivery);

        // Act
        boolean updated = delivery.updateItem(absentItem, -1);

        // Assert
        Assert.assertFalse(updated);
        Assert.assertEquals(contentSnapshot(delivery), contentBefore);
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_PREPARATION);
    }

    @Test
    public void testUpdateItemRejectsDifferentSupplierAdditionAndPreservesContent() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(5);
        Item otherSupplierItem = new Item(150, 12, new Supplier("Corner Shop"), "Travel soap");
        Map<Item, Integer> contentBefore = contentSnapshot(delivery);

        // Act
        boolean updated = delivery.updateItem(otherSupplierItem, 1);

        // Assert
        Assert.assertFalse(updated);
        Assert.assertEquals(contentSnapshot(delivery), contentBefore);
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_PREPARATION);
    }

    @Test
    public void testUpdateItemAllowsThirdSuccessfulUpdateButRejectsFourth() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(5);
        Item item = delivery.content().get(0).first();

        // Act
        boolean firstUpdate = delivery.updateItem(item, 1);
        boolean secondUpdate = delivery.updateItem(item, 1);
        boolean thirdUpdate = delivery.updateItem(item, 1);
        Map<Item, Integer> contentAfterThirdUpdate = contentSnapshot(delivery);
        boolean fourthUpdate = delivery.updateItem(item, 1);

        // Assert
        Assert.assertTrue(firstUpdate);
        Assert.assertTrue(secondUpdate);
        Assert.assertTrue(thirdUpdate);
        Assert.assertFalse(fourthUpdate);
        Assert.assertEquals(itemQuantity(delivery, item), 8);
        Assert.assertEquals(contentSnapshot(delivery), contentAfterThirdUpdate);
    }

    @Test
    public void testUnsuccessfulUpdateItemCallsDoNotConsumeUpdateLimit() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(10);
        Item item = delivery.content().get(0).first();

        // Act
        boolean firstFailedUpdate = delivery.updateItem(item, 1);
        boolean secondFailedUpdate = delivery.updateItem(item, 1);
        boolean thirdFailedUpdate = delivery.updateItem(item, 1);
        boolean successfulUpdate = delivery.updateItem(item, -1);

        // Assert
        Assert.assertFalse(firstFailedUpdate);
        Assert.assertFalse(secondFailedUpdate);
        Assert.assertFalse(thirdFailedUpdate);
        Assert.assertTrue(successfulUpdate);
        Assert.assertEquals(itemQuantity(delivery, item), 9);
    }

    @Test
    public void testReadyPositiveSuccessfulUpdateReturnsToPreparation() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(5);
        Item item = delivery.content().get(0).first();
        delivery.setReady();

        // Act
        boolean updated = delivery.updateItem(item, 1);

        // Assert
        Assert.assertTrue(updated);
        Assert.assertEquals(itemQuantity(delivery, item), 6);
        Assert.assertEquals(delivery.mode(), DeliverMode.IN_PREPARATION);
    }

    @Test
    public void testReadyUnsuccessfulUpdateRemainsReady() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(10);
        Item item = delivery.content().get(0).first();
        Map<Item, Integer> contentBefore = contentSnapshot(delivery);
        delivery.setReady();

        // Act
        boolean updated = delivery.updateItem(item, 1);

        // Assert
        Assert.assertFalse(updated);
        Assert.assertEquals(contentSnapshot(delivery), contentBefore);
        Assert.assertEquals(delivery.mode(), DeliverMode.READY_TO_DELIVER);
    }

    @Test
    public void testReadyZeroQuantityUpdateFailsAndRemainsReady() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(5);
        Item item = delivery.content().get(0).first();
        Map<Item, Integer> contentBefore = contentSnapshot(delivery);
        delivery.setReady();

        // Act
        boolean updated = delivery.updateItem(item, 0);

        // Assert
        Assert.assertFalse(updated);
        Assert.assertEquals(contentSnapshot(delivery), contentBefore);
        Assert.assertEquals(delivery.mode(), DeliverMode.READY_TO_DELIVER);
    }

    @Test
    public void testReadyNegativeSuccessfulUpdateRemainsReady() {
        // Arrange
        Delivery delivery = deliveryWithSingleItemQuantity(5);
        Item item = delivery.content().get(0).first();
        delivery.setReady();

        // Act
        boolean updated = delivery.updateItem(item, -1);

        // Assert
        Assert.assertTrue(updated);
        Assert.assertEquals(itemQuantity(delivery, item), 4);
        Assert.assertEquals(delivery.mode(), DeliverMode.READY_TO_DELIVER);
    }

    @Test
    public void testUpdateItemThrowsInNotDeliveredAndPreservesContent() {
        // Arrange
        Delivery delivery = assignedDelivery();
        delivery.cancel();
        Item item = delivery.content().get(0).first();
        Map<Item, Integer> contentBefore = contentSnapshot(delivery);

        // Act
        Assert.expectThrows(InvalidInvocationException.class, () -> delivery.updateItem(item, 1));

        // Assert
        Assert.assertEquals(contentSnapshot(delivery), contentBefore);
        Assert.assertEquals(delivery.mode(), DeliverMode.NOT_DELIVERED);
    }

    private Delivery sampleDelivery() {
        return new Delivery(sampleOrder());
    }

    private Order sampleOrder() {
        Client client = new Client();
        Supplier supplier = new Supplier("Alibaba");
        Item item = new Item(200, 10, supplier, "Big toothbrush.");
        Order order = new Order(client, "Sesame Street", 2000);
        order.addItem(item, 2);
        return order;
    }

    private Delivery assignedDelivery() {
        Delivery delivery = sampleDelivery();
        delivery.setReady();
        delivery.assign(new Courier());
        return delivery;
    }

    private Delivery deliveryWithSingleItemQuantity(int quantity) {
        Supplier supplier = new Supplier("Alibaba");
        Item item = new Item(200, 10, supplier, "Big toothbrush.");
        Order order = new Order(new Client(), "Sesame Street", 2000);
        order.addItem(item, quantity);
        return new Delivery(order);
    }

    private Courier fullCourier() {
        Courier courier = new Courier();
        for (int i = 0; i < 5; i++) {
            Delivery delivery = sampleDelivery();
            delivery.setReady();
            delivery.assign(courier);
        }
        return courier;
    }

    private int totalQuantity(Delivery delivery) {
        int total = 0;
        for (Pair<Item, Integer> pair : delivery.content()) {
            total += pair.second();
        }
        return total;
    }

    private int itemQuantity(Delivery delivery, Item item) {
        for (Pair<Item, Integer> pair : delivery.content()) {
            if (pair.first().equals(item)) {
                return pair.second();
            }
        }
        return 0;
    }

    private Map<Item, Integer> contentSnapshot(Delivery delivery) {
        Map<Item, Integer> snapshot = new HashMap<>();
        for (Pair<Item, Integer> pair : delivery.content()) {
            snapshot.put(pair.first(), pair.second());
        }
        return snapshot;
    }

    private void assertObservable(Delivery delivery, DeliverMode expectedMode) {
        Assert.assertEquals(delivery.mode(), expectedMode);
        Assert.assertNotNull(delivery.content());
        Assert.assertTrue(totalQuantity(delivery) > 0);
    }
}
