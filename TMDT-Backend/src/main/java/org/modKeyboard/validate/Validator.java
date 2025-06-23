package org.modKeyboard.validate;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.modKeyboard.dto.enums.OrderStatus;

public class Validator {

  public static boolean isValidEmail(String email) {
    if (isEmpty(email))
      return false;
    String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
    Pattern pattern = Pattern.compile(emailRegex);
    Matcher matcher = pattern.matcher(email);
    return matcher.matches();
  }

  public static boolean isValidPhoneNumber(String phoneNumber) {
    if (isEmpty(phoneNumber))
      return false;
    String phoneRegex = "^0\\d{9}$";

    Pattern pattern = Pattern.compile(phoneRegex);
    Matcher matcher = pattern.matcher(phoneNumber);
    return matcher.matches();
  }

  public static boolean isValidMinLength(String input, int minLength) {
    if (isEmpty(input))
      return false;
    return input.length() >= minLength;
  }

  public static boolean between(double value, double minValue, double maxValue) {
    return value >= minValue && value <= maxValue;
  }

  public static boolean containsWhitespace(String input) {
    if (isEmpty(input))
      return false;
    return input.contains(" ");
  }

  public static boolean isEmpty(String input) {
    if (input == null)
      return true;
    return input.trim().isEmpty();
  }

  public static boolean validateOrderUpdateStatus(OrderStatus currentStatus, OrderStatus newStatus) {
    if (currentStatus == null || newStatus == null)
      return false;
    return switch (currentStatus) {
      case PENDING -> newStatus == OrderStatus.PROCESSING || newStatus == OrderStatus.CANCELLED;
      case PROCESSING -> newStatus == OrderStatus.DELIVERED || newStatus == OrderStatus.CANCELLED;
      case DELIVERED -> newStatus == OrderStatus.RETURNED;
      case CANCELLED, RETURNED -> false;
    };
  }

}
