package supereats.core;

import java.util.List;

/**
 * This class represents a deliver.
 **/
enum DeliverMode {
    IN_PREPARATION, READY_TO_DELIVER, IN_TRANSIT, DELIVERED, NOT_DELIVERED, CANCELLED;
}

public class Delivery {

    private DeliverMode mode;
    private Order order;
    private int attempts;

    public Delivery(Order order) {
        this.mode = DeliverMode.IN_PREPARATION;
        this.attempts = 0;
        /* ... */ }

    public void changeAddress(String newAddress) {
        if (mode == DeliverMode.IN_PREPARATION || mode == DeliverMode.READY_TO_DELIVER) {
            this.order.setAddress(newAddress, 0); // Distance?
        }
    }

    public void assign(Courier courier) {
        /* ... */ }

    public void setReady() {
        this.mode = DeliverMode.READY_TO_DELIVER;
    }

    public void delivered() {
        this.mode = DeliverMode.DELIVERED;
    }

    public void cancel() {
        if (mode == DeliverMode.IN_PREPARATION || mode == DeliverMode.READY_TO_DELIVER) {
            this.mode = DeliverMode.CANCELLED;
        }
        this.attempts += 1;
        if (this.attempts < 3) {
            this.mode = DeliverMode.NOT_DELIVERED;
        } else {
            this.mode = DeliverMode.CANCELLED;
        }
    }

    public boolean updateItem(Item item, int quantity) {
        /* ... */ 
        return false;
    }

    List<Pair<Item, Integer>> content() {
        /* ... */ 
        return null;
    }

    DeliverMode mode() {
        /* ... */ 
        return null;
    }
}