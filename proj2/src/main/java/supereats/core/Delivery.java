package supereats.core;

import supereats.core.Item;

/**
 * This class represents a deliver.
 **/
enum DeliverMode {
    IN_PREPARATION, READY_TO_DELIVER, IN_TRANSIT, DELIVERED, NOT_DELIVERED, CANCELLED;
}

public class Delivery {
    public Delivery(Order order) {
        /* ... */ }

    public void changeAddress(String newAddress) {
        /* ... */ }

    public void assign(Courier courier) {
        /* ... */ }

    public void setReady() {
        /* ... */ }

    public void delivered() {
        /* ... */ }

    public void cancel() {
        /* ... */ }

    public boolean updateItem(Item item, int quantity) {
        /* ... */ }

    List<Pair<Item, Integer>> content() {
        /* ... */ }

    DeliverMode mode() {
        /* ... */ }
}