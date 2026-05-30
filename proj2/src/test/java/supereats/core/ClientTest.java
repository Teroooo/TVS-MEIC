package supereats.core;

import org.testng.Assert;
import org.testng.annotations.Test;

public class ClientTest {

    @Test
    public void testConstructsClientWithValidIdentityAndContact() {
        // Arrange && Act
        Client client = new Client("Maria Silva", "maria@example.com", "912345678", "Avenida Central");

        // Assert
        Assert.assertEquals(client.name(), "Maria Silva");
        Assert.assertEquals(client.email(), "maria@example.com");
        Assert.assertEquals(client.phone(), "912345678");
        Assert.assertEquals(client.address(), "Avenida Central");
    }

    @Test
    public void testConstructorTrimsTextFields() {
        // Arrange && Act
        Client client = new Client("  Maria Silva  ", "  maria@example.com  ", " 912345678 ", "  Avenida Central  ");

        // Assert
        Assert.assertEquals(client.name(), "Maria Silva");
        Assert.assertEquals(client.email(), "maria@example.com");
        Assert.assertEquals(client.phone(), "912345678");
        Assert.assertEquals(client.address(), "Avenida Central");
    }

    @Test
    public void testChangeAddressWithValidAddressUpdatesOnlyAddress() {
        // Arrange
        Client client = new Client("Maria Silva", "maria@example.com", "912345678", "Avenida Central");

        // Act
        client.changeAddress("Rua Nova");

        // Assert
        Assert.assertEquals(client.name(), "Maria Silva");
        Assert.assertEquals(client.email(), "maria@example.com");
        Assert.assertEquals(client.phone(), "912345678");
        Assert.assertEquals(client.address(), "Rua Nova");
    }

    @Test
    public void testConstructorAcceptsBoundaryNineDigitPhone() {
        // Arrange && Act
        Client client = new Client("Maria Silva", "maria@example.com", "000000000", "Avenida Central");

        // Assert
        Assert.assertEquals(client.phone(), "000000000");
    }

    @Test
    public void testConstructorRejectsBlankName() {
        // Act && Assert
        Assert.expectThrows(
                InvalidOperationException.class,
                () -> new Client(" ", "maria@example.com", "912345678", "Avenida Central"));
    }

    @Test
    public void testConstructorRejectsInvalidEmail() {
        // Act && Assert
        Assert.expectThrows(
                InvalidOperationException.class,
                () -> new Client("Maria Silva", "maria.example.com", "912345678", "Avenida Central"));
    }

    @Test
    public void testConstructorRejectsPhoneThatIsNotNineDigits() {
        // Act && Assert
        Assert.expectThrows(
                InvalidOperationException.class,
                () -> new Client("Maria Silva", "maria@example.com", "91234567", "Avenida Central"));
    }

    @Test
    public void testChangeAddressRejectsBlankAddressAndPreservesPreviousAddress() {
        // Arrange
        Client client = new Client("Maria Silva", "maria@example.com", "912345678", "Avenida Central");

        // Act
        Assert.expectThrows(InvalidOperationException.class, () -> client.changeAddress(" "));

        // Assert
        Assert.assertEquals(client.address(), "Avenida Central");
    }
}
