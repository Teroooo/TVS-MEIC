package supereats.core;

import org.testng.Assert;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

public class OrderTest {

    @Test
    public void testAddItemsFromDifferentSuppliers() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
        Supplier supplier2 = new Supplier("Amazon");

        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 30, supplier2, "Giant deck of cards");
        
        // Act
        order.addItem(item1, 3);
        Assert.expectThrows(InvalidOperationException.class, () -> order.addItem(item2, 2));

        // Assert
        Assert.assertEquals(order.totalQuantity(), 3);
        Assert.assertEquals(order.cost(), 135.0);
        Assert.assertFalse(order.contains(item2));
    }

    @Test
    public void testAddItem() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 30, supplier1, "Giant deck of cards");
        
        // Act
        order.addItem(item1, 3);
        order.addItem(item2, 2);

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 5);
        Assert.assertEquals(order.quantity(item1), 3);
        Assert.assertEquals(order.quantity(item2), 2);
        Assert.assertTrue(order.contains(item1));
        Assert.assertTrue(order.contains(item2));
        Assert.assertEquals(order.itens().size(), 2);
        Assert.assertEquals(order.cost(), 195.0);
    }

    @Test
    public void testAddItemTwoTimes() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        
        // Act
        order.addItem(item1, 3);
        order.addItem(item1, 2);

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 5);
        Assert.assertEquals(order.quantity(item1), 5);
    }

    @Test
    public void testAddItemTwoTimesAboveTenThrowsAndPreservesState() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");

        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 8);
        Assert.expectThrows(InvalidOperationException.class, () -> order.addItem(item1, 3));

        // Assert
        Assert.assertEquals(order.totalQuantity(), 8);
        Assert.assertEquals(order.quantity(item1), 8);
        Assert.assertEquals(order.cost(), 360.0);
    }

    @Test
    public void testAddItemAndRemoveAfter() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        
        // Act
        order.addItem(item1, 3);
        order.removeItem(item1, 2);

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 1);
        Assert.assertEquals(order.quantity(item1), 1);
    }

    @Test
    public void testAddItemAndRemoveAll() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        
        // Act
        order.addItem(item1, 3);
        order.removeItem(item1, 3);

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 0);
    }

    @Test
    public void testAddItemAndOverRemove() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        
        // Act
        order.addItem(item1, 3);
        Assert.expectThrows(InvalidOperationException.class, () -> order.removeItem(item1, 4));

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 3);
        Assert.assertEquals(order.quantity(item1), 3);
        Assert.assertTrue(order.contains(item1));
    }

    @Test
    public void testRemoveNonExistingItem() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 30, supplier1, "Giant deck of cards");


        // Act
        order.addItem(item1, 3);
        Assert.expectThrows(InvalidOperationException.class, () -> order.removeItem(item2, 4));

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 3);
        Assert.assertEquals(order.quantity(item1), 3);
        Assert.assertFalse(order.contains(item2));
    }

    @Test
    public void testRemoveZeroItemsThrowsAndPreservesState() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");

        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 3);
        Assert.expectThrows(InvalidOperationException.class, () -> order.removeItem(item1, 0));

        // Assert
        Assert.assertEquals(order.totalQuantity(), 3);
        Assert.assertEquals(order.quantity(item1), 3);
    }

    @Test
    public void testAddItemMoreThanTen() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        
        // Act
        Assert.expectThrows(InvalidOperationException.class, () -> order.addItem(item1, 11));

        // Assert
        Assert.assertEquals(order.totalQuantity(), 0);
        Assert.assertEquals(order.cost(), 0.0);
    }

    @Test
    public void testAddItemLessThanOne() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        
        // Act
        Assert.expectThrows(InvalidOperationException.class, () -> order.addItem(item1, 0));

        // Assert
        Assert.assertEquals(order.totalQuantity(), 0);
        Assert.assertEquals(order.cost(), 0.0);
    }

    @Test
    public void testAddItemTen() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        
        // Act
        order.addItem(item1, 10);

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 10);
        Assert.assertEquals(order.quantity(item1), 10);
    }
    
    @Test
    public void testAddItemOne() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        
        // Act
        order.addItem(item1, 1);

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 1);
        Assert.assertEquals(order.quantity(item1), 1);
    }

    @Test
    public void testCost() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 30, supplier1, "Giant deck of cards");
        
        // Act
        order.addItem(item1, 3);
        order.addItem(item2, 2);

        // Assert 
        Assert.assertEquals(order.cost(), 195.0);
    }

    @Test
    public void testCostExactlyOneThousand() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");

        Item item1 = new Item(200, 100, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 10);

        // Assert
        Assert.assertEquals(order.totalQuantity(), 10);
        Assert.assertEquals(order.cost(), 1000.0);
    }

    @Test
    public void testCostAboveOneThousand() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");

        Item item1 = new Item(200, 1001, supplier1, "Big toothbrush.");
        
        // Act
        Assert.expectThrows(InvalidOperationException.class, () -> order.addItem(item1, 1));

        // Assert
        Assert.assertEquals(order.totalQuantity(), 0);
        Assert.assertEquals(order.cost(), 0.0);
    }

    @Test
    public void testTotalQuantityAtGivenFormulaLimit() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");

        Item item1 = new Item(200, 1, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 1, supplier1, "Giant deck of cards");

        // Act
        order.addItem(item1, 10);
        order.addItem(item2, 10);

        // Assert
        Assert.assertEquals(order.totalQuantity(), 20);
        Assert.assertEquals(order.cost(), 20.0);
    }

    
    // Total number of units must not exceed 20 + ⌊orderCost/50⌋
    @Test
    public void testCostAboveGivenFormula() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");

        Item item1 = new Item(200, 1, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 1, supplier1, "Giant deck of cards");
        Item item3 = new Item(150, 1, supplier1, "Big pillow.");


        // Act
        order.addItem(item1, 10);
        order.addItem(item2, 10);
        Assert.expectThrows(InvalidOperationException.class, () -> order.addItem(item3, 1));

        // Assert
        Assert.assertEquals(order.totalQuantity(), 20);
        Assert.assertEquals(order.cost(), 20.0);
        Assert.assertFalse(order.contains(item3));
    }

    @Test
    public void testSetAddressAtTwentyKM() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);

        // Act
        order.setAddress("Av. Duque de Avila", 20000);

        // Assert
        Assert.assertEquals(order.deliveryAddress, "Av. Duque de Avila");
        Assert.assertEquals(order.distance, 20000);
    }

    @Test
    public void testSetAddressAboveTwentyKM() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        order.addItem(item1, 3);
        
        // Act
        Assert.expectThrows(InvalidOperationException.class, () -> order.setAddress("Av. Duque de Avila", 20001));

        // Assert
        Assert.assertEquals(order.deliveryAddress, "Sesame Street");
        Assert.assertEquals(order.distance, 2000);
        Assert.assertEquals(order.totalQuantity(), 3);
        Assert.assertEquals(order.cost(), 135.0);
    }

    @Test
    public void testAddressAtTwentyKM() {
        // Arrange && Act
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 20000);

        // Assert
        Assert.assertEquals(order.distance, 20000);
        Assert.assertEquals(order.totalQuantity(), 0);
        Assert.assertEquals(order.cost(), 0.0);
    }

    @Test
    public void testAddressAboveTwentyKM() {
        // Arrange && Act
        Client client = new Client();
        Assert.expectThrows(InvalidOperationException.class, () -> new Order(client, "Sesame Street", 20001));

        // Assert is the expected exception.
    }

    @DataProvider
    public Object[][] computeDeliveryCostDecisionTable() {
        return new Object[][] {
            {"below5_costBelow75_quantityExactly10", 4999, new int[][] {{100, 1, 10}}, 3.0},
            {"below5_costBelow75_quantityAbove10", 4999, new int[][] {{100, 1, 10}, {100, 1, 1}}, 5.0},
            {"below5_costExactly75", 4999, new int[][] {{100, 75, 1}}, 0.0},
            {"exactly5_costBelow75_quantityExactly5", 5000, new int[][] {{200, 70, 1}, {200, 1, 4}}, 4.0},
            {"exactly5_costBelow75_quantityAbove5", 5000, new int[][] {{200, 69, 1}, {200, 1, 5}}, 6.0},
            {"exactly5_costExactly150", 5000, new int[][] {{200, 150, 1}}, 3.0},
            {"exactly5_costAbove150", 5000, new int[][] {{200, 151, 1}}, 1.0},
            {"between5And15_costExactly75", 14999, new int[][] {{200, 75, 1}}, 3.0},
            {"exactly15_usesMiddleDistanceBranch", 15000, new int[][] {{4999, 300, 1}}, 1.0},
            {"above15_costExactly300_weightBelow5kg", 15001, new int[][] {{4999, 300, 1}}, 3.0},
            {"above15_costExactly500_weightExactly5kg", 15001, new int[][] {{5000, 500, 1}}, 5.0},
            {"exactly20_costAbove500", 20000, new int[][] {{200, 501, 1}}, 1.0},
            {"exactly20_costBelow300_weightBelow3kg", 20000, new int[][] {{2999, 299, 1}}, 7.0},
            {"exactly20_costBelow300_weightExactly3kg_quantityBelow8", 20000, new int[][] {{2994, 293, 1}, {1, 1, 6}}, 8.0},
            {"exactly20_costBelow300_weightExactly3kg_quantityExactly8", 20000, new int[][] {{2993, 292, 1}, {1, 1, 7}}, 10.0},
        };
    }

    @Test(dataProvider = "computeDeliveryCostDecisionTable")
    public void testComputeDeliveryCostDecisionTable(String caseName, int distance, int[][] itemSpecs, double expectedDeliveryCost) {
        // Arrange
        Order order = orderWithItems(distance, itemSpecs);

        // Act
        double deliveryCost = order.computeDeliveryCost();

        // Assert
        Assert.assertEquals(deliveryCost, expectedDeliveryCost, caseName);
    }

    private Order orderWithItems(int distance, int[][] itemSpecs) {
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", distance);
        Supplier supplier = new Supplier("Alibaba");

        for (int i = 0; i < itemSpecs.length; i++) {
            int weight = itemSpecs[i][0];
            int price = itemSpecs[i][1];
            int quantity = itemSpecs[i][2];
            order.addItem(new Item(weight, price, supplier, "Item " + i), quantity);
        }

        return order;
    }

    @Test
    public void testComputeDeliveryCostDistanceBelowFiveKmAndCostLessSeventyFive() {
       // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 4999);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 66, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 1, supplier1, "Giant deck of cards");

        // Act
        order.addItem(item1, 1);
        order.addItem(item2, 8);

        double deliveryCost = order.computeDeliveryCost();

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 9);
        Assert.assertEquals(deliveryCost, 3.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBelowFiveKmAndCostLessSeventyFiveAndMoreThanTenItems() {
       // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 4999);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 1, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 64, supplier1, "Giant deck of cards");

        // Act
        order.addItem(item2, 1);
        order.addItem(item1, 10);


        double deliveryCost = order.computeDeliveryCost();

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 11);
        Assert.assertEquals(deliveryCost, 5.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBelowFiveKmAndCostAtLeastSeventyFive() {
       // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 4999);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 75, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);


        double deliveryCost = order.computeDeliveryCost();

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 1);
        Assert.assertEquals(deliveryCost, 0.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBelowFiveKmAndCostAtLeastSeventyFive2() {
       // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 4999);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 76, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);


        double deliveryCost = order.computeDeliveryCost();

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 1);
        Assert.assertEquals(deliveryCost, 0.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBelowFiveKmAndCostAtLeastSeventyFive3() {
       // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 4999);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 1, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 65, supplier1, "Giant deck of cards");

        // Act
        order.addItem(item2, 1);
        order.addItem(item1, 10);


        double deliveryCost = order.computeDeliveryCost();

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 11);
        Assert.assertEquals(deliveryCost, 0.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBetweenFiveAndFifteenAndCostExceedOneFifty() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 5000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 151, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);

        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(order.totalQuantity(), 1);
        Assert.assertEquals(deliveryCost, 1.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBetweenFiveAndFifteenAndCostBetweenSeventyFiveAndOneHundred() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 5000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 150, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);

        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(order.totalQuantity(), 1);
        Assert.assertEquals(deliveryCost, 3.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBetweenFiveAndFifteenAndCostBetweenSeventyFiveAndOneHundred2() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 5000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 75, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);

        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(order.totalQuantity(), 1);
        Assert.assertEquals(deliveryCost, 3.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBetweenFiveAndFifteenAndCostBelowSeventyFiveAndQuantityExceedsFive() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 5000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 69, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 1, supplier1, "Giant deck of cards");

        // Act
        order.addItem(item1, 1);
        order.addItem(item2, 5);


        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(order.totalQuantity(), 6);
        Assert.assertEquals(deliveryCost, 6.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBetweenFiveAndFifteenAndCostBelowSeventyFiveAndQuantityBelowFive() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 5000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 70, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 1, supplier1, "Giant deck of cards");

        // Act
        order.addItem(item1, 1);
        order.addItem(item2, 4);


        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(order.totalQuantity(), 5);
        Assert.assertEquals(deliveryCost, 4.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBetweenFiveAndFifteenAndCostExceedOneFifty2() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 14999);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 151, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);

        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(order.totalQuantity(), 1);
        Assert.assertEquals(deliveryCost, 1.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBetweenFiveAndFifteenAndCostBetweenSeventyFiveAndOneHundred3() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 14999);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 150, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);

        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(order.totalQuantity(), 1);
        Assert.assertEquals(deliveryCost, 3.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBetweenFiveAndFifteenAndCostBetweenSeventyFiveAndOneHundred4() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 14999);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 75, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);

        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(order.totalQuantity(), 1);
        Assert.assertEquals(deliveryCost, 3.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBetweenFiveAndFifteenAndCostBelowSeventyFiveAndQuantityExceedsFive2() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 14999);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 69, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 1, supplier1, "Giant deck of cards");

        // Act
        order.addItem(item1, 1);
        order.addItem(item2, 5);


        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(order.totalQuantity(), 6);
        Assert.assertEquals(deliveryCost, 6.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceBetweenFiveAndFifteenAndCostBelowSeventyFiveAndQuantityBelowFive2() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 14999);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 70, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 1, supplier1, "Giant deck of cards");

        // Act
        order.addItem(item1, 1);
        order.addItem(item2, 4);


        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(order.totalQuantity(), 5);
        Assert.assertEquals(deliveryCost, 4.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceAboveFifteenAndUpToTwentyAndCostExceedsFiveHundred() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 15001);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 501, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);


        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(deliveryCost, 1.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceAboveFifteenAndUpToTwentyAndCostBetweenThreeHundredAndFiveHundredWithWeightLessThanFiveKg() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 15001);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(4999, 300, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);


        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(deliveryCost, 3.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceAboveFifteenAndUpToTwentyAndCostBetweenThreeHundredAndFiveHundredWithWeightAtLeastFiveKg() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 15001);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(5000, 300, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);


        double deliveryCost = order.computeDeliveryCost();

        // Assert
        Assert.assertEquals(deliveryCost, 5.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceAboveFifteenAndUpToTwentyAndCostLessThanThreeHundredWithWeightLessThanThreeKg() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 15001);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(2999, 299, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);


        double deliveryCost = order.computeDeliveryCost();

        // Assert
        Assert.assertEquals(deliveryCost, 7.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceAboveFifteenAndUpToTwentyAndCostLessThanThreeHundredWithWeightAtLeastThreeKgAndLessThanEightUnits() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 15001);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(2994, 293, supplier1, "Big toothbrush.");
        Item item2 = new Item(1, 1, supplier1, "Giant deck of cards");

        // Act
        order.addItem(item1, 1);
        order.addItem(item2, 6);


        double deliveryCost = order.computeDeliveryCost();

        // Assert
        Assert.assertEquals(deliveryCost, 8.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceAboveFifteenAndUpToTwentyAndCostLessThanThreeHundredWithWeightAtLeastThreeKgAndAtLeastEightUnits() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 15001);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(2993, 292, supplier1, "Big toothbrush.");
        Item item2 = new Item(1, 1, supplier1, "Giant deck of cards");

        // Act
        order.addItem(item1, 1);
        order.addItem(item2, 7);


        double deliveryCost = order.computeDeliveryCost();

        // Assert
        Assert.assertEquals(deliveryCost, 10.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceAboveFifteenAndUpToTwentyAndCostExceedsFiveHundred2() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 20000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 501, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);


        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(deliveryCost, 1.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceAboveFifteenAndUpToTwentyAndCostBetweenThreeHundredAndFiveHundredWithWeightLessThanFiveKg2() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 20000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(4999, 300, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);


        double deliveryCost = order.computeDeliveryCost();


        // Assert
        Assert.assertEquals(deliveryCost, 3.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceAboveFifteenAndUpToTwentyAndCostBetweenThreeHundredAndFiveHundredWithWeightAtLeastFiveKg2() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 20000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(5000, 300, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);


        double deliveryCost = order.computeDeliveryCost();

        // Assert
        Assert.assertEquals(deliveryCost, 5.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceAboveFifteenAndUpToTwentyAndCostLessThanThreeHundredWithWeightLessThanThreeKg2() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 20000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(2999, 299, supplier1, "Big toothbrush.");

        // Act
        order.addItem(item1, 1);


        double deliveryCost = order.computeDeliveryCost();

        // Assert
        Assert.assertEquals(deliveryCost, 7.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceAboveFifteenAndUpToTwentyAndCostLessThanThreeHundredWithWeightAtLeastThreeKgAndLessThanEightUnits2() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 20000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(2994, 293, supplier1, "Big toothbrush.");
        Item item2 = new Item(1, 1, supplier1, "Giant deck of cards");

        // Act
        order.addItem(item1, 1);
        order.addItem(item2, 6);


        double deliveryCost = order.computeDeliveryCost();

        // Assert
        Assert.assertEquals(deliveryCost, 8.0);
    }

    @Test
    public void testComputeDeliveryCostDistanceAboveFifteenAndUpToTwentyAndCostLessThanThreeHundredWithWeightAtLeastThreeKgAndAtLeastEightUnits2() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 20000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(2993, 292, supplier1, "Big toothbrush.");
        Item item2 = new Item(1, 1, supplier1, "Giant deck of cards");

        // Act
        order.addItem(item1, 1);
        order.addItem(item2, 7);


        double deliveryCost = order.computeDeliveryCost();

        // Assert
        Assert.assertEquals(deliveryCost, 10.0);
    }
}
