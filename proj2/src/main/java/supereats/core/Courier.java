package supereats.core;

import java.util.ArrayList;
import java.util.List;

public class Courier {

    private static final int MAX_ASSIGNED_DELIVERIES = 5;

    private final List<Delivery> assignedDeliveries = new ArrayList<>();

    boolean canAcceptDelivery() {
        return assignedDeliveries.size() < MAX_ASSIGNED_DELIVERIES;
    }

    void assign(Delivery delivery) {
        if (!canAcceptDelivery()) {
            throw new InvalidInvocationException("Courier cannot have more than 5 assigned deliveries.");
        }
        assignedDeliveries.add(delivery);
    }

    int assignedDeliveryCount() {
        return assignedDeliveries.size();
    }
}
