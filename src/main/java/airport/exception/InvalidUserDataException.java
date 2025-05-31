package airport.exception;

import java.util.NoSuchElementException;

public class InvalidUserDataException extends NoSuchElementException {
    public InvalidUserDataException(String message) {
        super(message);
    }
}
