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
    private final Order order;
    private int attempts;
    private int successfulUpdates;
    private Courier courier;

    public Delivery(Order order) {
        this.order = order;
        this.mode = DeliverMode.IN_PREPARATION;
        this.attempts = 0;
        this.successfulUpdates = 0;
    }

    public void changeAddress(String newAddress) {
        if (mode == DeliverMode.IN_PREPARATION || mode == DeliverMode.READY_TO_DELIVER) {
            this.order.setAddress(newAddress, order.distance);
            return;
        }
        throw new InvalidInvocationException("Address can only be changed before assignment.");
    }

    public void assign(Courier courier) {
        if (mode != DeliverMode.READY_TO_DELIVER) {
            throw new InvalidInvocationException("Delivery can only be assigned when ready.");
        }
        if (!courier.canAcceptDelivery()) {
            throw new InvalidInvocationException("Courier cannot have more than 5 assigned deliveries.");
        }
        courier.assign(this);
        this.courier = courier;
        this.mode = DeliverMode.IN_TRANSIT;
    }

    public void setReady() {
        if (mode != DeliverMode.IN_PREPARATION && mode != DeliverMode.NOT_DELIVERED) {
            throw new InvalidInvocationException("Delivery can only be set ready from preparation or not delivered.");
        }
        this.mode = DeliverMode.READY_TO_DELIVER;
    }

    public void delivered() {
        if (mode != DeliverMode.IN_TRANSIT) {
            throw new InvalidInvocationException("Delivery can only be completed in transit.");
        }
        this.mode = DeliverMode.DELIVERED;
    }

    public void cancel() {
        if (mode == DeliverMode.IN_PREPARATION || mode == DeliverMode.READY_TO_DELIVER) {
            this.mode = DeliverMode.CANCELLED;
            return;
        }
        if (mode != DeliverMode.IN_TRANSIT) {
            throw new InvalidInvocationException("Delivery cannot be cancelled from the current mode.");
        }
        this.attempts += 1;
        if (this.attempts < 3) {
            this.mode = DeliverMode.NOT_DELIVERED;
        } else {
            this.mode = DeliverMode.CANCELLED;
        }
    }

    public boolean updateItem(Item item, int quantity) {
        if (mode != DeliverMode.IN_PREPARATION && mode != DeliverMode.READY_TO_DELIVER) {
            throw new InvalidInvocationException("Delivery items can only be updated before assignment.");
        }
        if (successfulUpdates >= 3 || quantity == 0) {
            return false;
        }

        boolean positiveUpdate = quantity > 0;
        boolean successful;
        if (order.contains(item)) {
            successful = updateExistingItem(item, quantity);
        } else {
            successful = addAbsentItem(item, quantity);
        }

        if (successful) {
            successfulUpdates++;
            if (mode == DeliverMode.READY_TO_DELIVER && positiveUpdate) {
                mode = DeliverMode.IN_PREPARATION;
            }
        }

        return successful;
    }

    List<Pair<Item, Integer>> content() {
        return order.itens();
    }

    DeliverMode mode() {
        return mode;
    }

    Courier courier() {
        return courier;
    }

    private boolean updateExistingItem(Item item, int quantity) {
        int currentQuantity = order.quantity(item);
        int newQuantity = currentQuantity + quantity;
        if (newQuantity < 0 || newQuantity > 10) {
            return false;
        }
        if (newQuantity == 0 && order.totalQuantity() == currentQuantity) {
            return false;
        }

        try {
            if (quantity > 0) {
                order.addItem(item, quantity);
            } else {
                order.removeItem(item, -quantity);
            }
            return true;
        } catch (InvalidOperationException exception) {
            return false;
        }
    }

    private boolean addAbsentItem(Item item, int quantity) {
        if (quantity < 1 || quantity > 10) {
            return false;
        }

        try {
            order.addItem(item, quantity);
            return true;
        } catch (InvalidOperationException exception) {
            return false;
        }
    }
}
