package supereats.core;

public class Client {

    private final String name;
    private final String email;
    private final String phone;
    private String address;

    public Client() {
        this("Anonymous Client", "anonymous@example.com", "900000000", "Unknown address");
    }

    public Client(String name, String email, String phone, String address) {
        this.name = requireText(name, "Name");
        this.email = validateEmail(email);
        this.phone = validatePhone(phone);
        this.address = requireText(address, "Address");
    }

    public String name() {
        return name;
    }

    public String email() {
        return email;
    }

    public String phone() {
        return phone;
    }

    public String address() {
        return address;
    }

    public void changeAddress(String newAddress) {
        this.address = requireText(newAddress, "Address");
    }

    private static String requireText(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new InvalidOperationException(fieldName + " must not be blank.");
        }
        return value.trim();
    }

    private static String validateEmail(String email) {
        String normalized = requireText(email, "Email");
        int at = normalized.indexOf('@');
        if (at <= 0 || at != normalized.lastIndexOf('@') || at == normalized.length() - 1 || hasWhitespace(normalized)) {
            throw new InvalidOperationException("Email must contain one @ with text before and after it.");
        }
        return normalized;
    }

    private static String validatePhone(String phone) {
        String normalized = requireText(phone, "Phone");
        if (!normalized.matches("\\d{9}")) {
            throw new InvalidOperationException("Phone must contain exactly 9 digits.");
        }
        return normalized;
    }

    private static boolean hasWhitespace(String value) {
        for (int i = 0; i < value.length(); i++) {
            if (Character.isWhitespace(value.charAt(i))) {
                return true;
            }
        }
        return false;
    }
}
