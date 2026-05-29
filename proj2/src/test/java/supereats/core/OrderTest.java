package supereats.core;

import org.testng.Assert;
import org.testng.annotations.Test;

public class OrderTest {

    @Test(expectedExceptions = InvalidOperationException.class)
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
        order.addItem(item2, 2);

        // Assert
        Assert.assertEquals(3, order.totalQuantity());
        Assert.assertEquals(order.cost(), 195);
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

    @Test(expectedExceptions = InvalidOperationException.class)
    public void testAddItemAndOverRemove() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        
        // Act
        order.addItem(item1, 3);
        order.removeItem(item1, 4);

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 3);
        Assert.assertEquals(order.quantity(item1), 3);
    }

    @Test(expectedExceptions = InvalidOperationException.class)
    public void testRemoveNonExistingItem() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        Item item2 = new Item(240, 30, supplier1, "Giant deck of cards");


        // Act
        order.addItem(item1, 3);
        order.removeItem(item2, 4);

        // Assert 
        Assert.assertEquals(order.totalQuantity(), 3);
        Assert.assertEquals(order.quantity(item1), 3);
    }

    @Test(expectedExceptions = InvalidOperationException.class)
    public void testAddItemMoreThanTen() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        
        // Act
        order.addItem(item1, 11);

        // Assert is the expectedException
        Assert.assertEquals(order.totalQuantity(), 11);
        Assert.assertEquals(order.cost(), 495);
    }

    @Test(expectedExceptions = InvalidOperationException.class)
    public void testAddItemLessThanOne() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");
     
        Item item1 = new Item(200, 45, supplier1, "Big toothbrush.");
        
        // Act
        order.addItem(item1, 0);

        // Assert is the expectedException
        Assert.assertEquals(order.totalQuantity(), 0);
        Assert.assertEquals(order.cost(), 0);
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

    @Test(expectedExceptions = InvalidOperationException.class)
    public void testCostAboveOneThousand() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        Supplier supplier1 = new Supplier("Alibaba");

        Item item1 = new Item(200, 1001, supplier1, "Big toothbrush.");
        
        // Act
        order.addItem(item1, 1);

        // Assert is the expectedException
        Assert.assertEquals(order.totalQuantity(), 1);
        Assert.assertEquals(order.cost(), 1001);
    }

    
    // Total number of units must not exceed 20 + ⌊orderCost/50⌋
    @Test(expectedExceptions = InvalidOperationException.class)
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
        order.addItem(item3, 1);

        // Assert is the expectedException
        Assert.assertEquals(order.totalQuantity(), 21);
        Assert.assertEquals(order.cost(), 21);
    }

    @Test(expectedExceptions = InvalidOperationException.class)
    public void testSetAddressAboveTwentyKM() {
        // Arrange
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 2000);
        
        // Act
        order.setAddress("Av. Duque de Ávila", 20001);

        // Assert is the expectedException
        Assert.assertEquals(order.totalQuantity(), 0);
        Assert.assertEquals(order.cost(), 0);
    }

    @Test(expectedExceptions = InvalidOperationException.class)
    public void testAddressAboveTwentyKM() {
        // Arrange && Act
        Client client = new Client();
        Order order = new Order(client, "Sesame Street", 20001);

        // Assert is the expectedException
        Assert.assertEquals(order.totalQuantity(), 0);
        Assert.assertEquals(order.cost(), 0);
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
