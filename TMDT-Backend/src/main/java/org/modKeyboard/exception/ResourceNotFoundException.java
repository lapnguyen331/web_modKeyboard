package org.modKeyboard.exception;

import org.slf4j.helpers.MessageFormatter;

public class ResourceNotFoundException extends RuntimeException {
  public ResourceNotFoundException(String message) {
    super(message);
  }

  public static ResourceNotFoundException from(String message, Object... args) {
    String formattedMessage = MessageFormatter.arrayFormat(message, args).getMessage();
    return new ResourceNotFoundException(formattedMessage);
  }

  public ResourceNotFoundException(String message, Throwable cause) {
    super(message, cause);
  }

}
