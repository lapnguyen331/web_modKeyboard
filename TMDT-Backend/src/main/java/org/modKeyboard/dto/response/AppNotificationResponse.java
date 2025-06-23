package org.modKeyboard.dto.response;

import java.util.UUID;

public record AppNotificationResponse(
    UUID sender,
    String message) {
}
