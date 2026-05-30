package supereats.core;

import java.util.List;
import java.util.stream.Collectors;

/**
 * This class represents a order.
 **/
public class Order {
    Client client;
    String deliveryAddress;
    int distance; // distance in meters
    int totalWeight; // weight in grams!

    List<Pair<Item, Integer>> items;

    public Order(Client client, String deliveryAddress, int distance) {
        if (distance > 20000) {
            throw new InvalidOperationException("Distance cannot be greater than 20000 meters."); // Distance cannot be greater than 20 km
        }
        this.distance = distance;
        this.client = client;
        this.deliveryAddress = deliveryAddress;
        
        this.items = new java.util.ArrayList<>();
    }

    public void addItem(Item item, int quantity) {
        // Rule: quantity must be between 1 and 10
        if (quantity < 1 || quantity > 10) {
            throw new InvalidOperationException("Quantity for an item must be between 1 and 10.");
        }

        // Rule: All items must belong to the same supplier.
        if (!items.isEmpty() && !item.supplier().equals(items.get(0).first().supplier())) {
            throw new InvalidOperationException("All items in an order must belong to the same supplier.");
        }

        List<Item> itemsList = items.stream().map(Pair::first).collect(Collectors.toList());
        double currentCost = cost();
        int currentTotalQuantity = totalQuantity();
        double costOfNewItems = item.price() * quantity;

        // Rule: Total cost must not exceed 1000
        if (currentCost + costOfNewItems > 1000) {
            throw new InvalidOperationException("Adding this item would exceed the maximum cost of 1000.");
        }

        // Rule: Total quantity constraint
        if ((currentTotalQuantity + quantity) > 20 + Math.floor((currentCost + costOfNewItems) / 50)) {
            throw new InvalidOperationException("Adding this item would exceed the total quantity limit.");
        }

        if (itemsList.contains(item)) {
            int index = itemsList.indexOf(item);
            int existingQuantity = items.get(index).second();

            // Rule: Each item quantity must be between 1 and 10
            if (existingQuantity + quantity > 10) {
                throw new InvalidOperationException("Adding this item would exceed the maximum quantity of 10 per item.");
            }
            
            items.get(index).setSecond(existingQuantity + quantity);

        } else {
            // This is a new item for the order. The initial quantity check (1-10) is already done.
            items.add(new Pair<>(item, quantity));
        }
        
        this.totalWeight += item.weight() * quantity;
    }

    public void removeItem(Item item, int quantity) {
        if (quantity < 1) {
            throw new InvalidOperationException("Quantity to remove must be positive.");
        }

        List<Item> itemsList = items.stream().map(Pair::first).collect(Collectors.toList());
        if (!itemsList.contains(item)) {
            throw new InvalidOperationException("Item is not present in the order.");
        }

        int index = itemsList.indexOf(item);
        int currentQuantity = items.get(index).second();
        if (quantity > currentQuantity) {
            throw new InvalidOperationException("Removing this quantity would make the item quantity invalid.");
        }

        if (quantity == currentQuantity) {
            items.remove(index);
        } else {
            items.get(index).setSecond(currentQuantity - quantity);
        }
        this.totalWeight -= item.weight() * quantity;
    }

    public void setAddress(String newDeliveryAddress, int distance) {
        if (distance > 20000) {
            throw new InvalidOperationException("Distance cannot be greater than 20000 meters."); // Distance cannot be greater than 20 km
        }
        this.deliveryAddress = newDeliveryAddress;
        this.distance = distance;
    }

    public int quantity(Item item) {
        for (Pair<Item, Integer> pair : items) {
            if (pair.first().equals(item)) {
                return pair.second();
            }
        }
        return 0;
    }

    public boolean contains(Item item) {
        List<Item> itemsList = items.stream().map(Pair::first).collect(Collectors.toList());
        return itemsList.contains(item);
    }

    // returns the total number of unities of all itens in this order
    public int totalQuantity() {
        int total = items.stream().mapToInt(Pair::second).sum(); 
        return total;    
    }

    // The cost of an order does not include the delivery cost, it just reflect the
    // cost of
    // the selected itens and corresponding quantities
    public double cost() {
        double total = items.stream().mapToDouble(pair -> pair.first().price() * pair.second()).sum();
        return total;
    }

    // the content of this order
    public List<Pair<Item, Integer>> itens() {
        return items;
    }

    public double computeDeliveryCost() {
        double cost = cost();
        int quantity = totalQuantity();
        if (distance < 5000) {
            if (cost < 75) {
                if (quantity > 10) {
                    return 5.0;
                } else {
                    return 3.0;
                }
            } else {
                return 0.0;
            }
        } else if (distance >= 5000 && distance <= 15000) {
            if (cost > 150) {
                return 1.0;
            } else if (cost >= 75 && cost <= 150) {
                return 3.0;
            } else { // cost < 75
                if (quantity > 5) {
                    return 6.0;
                } else {
                    return 4.0;
                }
            }
        } else if (distance > 15000 && distance <= 20000) {
            if (cost > 500) {
                return 1.0;
            } else if (cost >= 300 && cost <= 500) {
                if (totalWeight < 5000) {
                    return 3.0;
                } else {
                    return 5.0;
                }
            } else { // cost < 300
                if (totalWeight < 3000) {
                    return 7.0;
                } else if (totalWeight >= 3000 && quantity < 8) {
                    return 8.0;
                } else { // totalWeight >= 3000 && quantity >= 8
                    return 10.0;
                }
            }
        }
        
        throw new InvalidOperationException("Delivery cost not defined for this Order state.");
    }
}
