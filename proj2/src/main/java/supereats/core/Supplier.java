package supereats.core;

/**
 * This class represents a Supplier. A supplier has a name.
 **/

public class Supplier {
    private final String name;

    public Supplier(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    // Returns true if other is a Supplier with the same name as this supplier
    @Override
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (other == null || getClass() != other.getClass()) {
            return false;
        }
        Supplier supplier = (Supplier) other;
        return name.equals(supplier.name);
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
