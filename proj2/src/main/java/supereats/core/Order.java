package supereats.core;

import supereats.core.Item;

/**
 * This class represents a order.
 **/
public class Order {
    public Order(Client client, String deliveryAddress, int distance) {
        /* ... */ }

    public void addItem(Item item, int quantity) {
        /* ... */ }

    public void removeItem(Item item, int quantity) {
        /* ... */ }

    public void setAddress(String newDeliveryAddress, int distance) {
        /* ... */ }

    public int quantity(Item item) {
        /* ... */ }

    public boolean contains(Item item) {
        /* ... */ }

    // returns the total number of unities of all itens in this order
    public int totalQuantity() {
        /* ... */ }

    // The cost of an order does not include the delivery cost, it just reflect the
    // cost of
    // the selected itens and corresponding quantities
    public double cost() {
        /* ... */ }

    // the content of this order
    public List<Pair<Item, Integer>> itens() {
        /* ... */ }

    public double computeDeliveryCost() {
        /* ... */ }
}
