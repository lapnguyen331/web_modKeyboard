package org.modKeyboard.exception;

public class KeyGenerationException extends RuntimeException {
    public KeyGenerationException(String message, Throwable cause) {
        super(message, cause);
    }
    public KeyGenerationException(String message) {
        super(message);
    }
}
