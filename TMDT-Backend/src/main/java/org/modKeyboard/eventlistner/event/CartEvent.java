package org.modKeyboard.eventlistner.event;

import java.util.UUID;

public record CartEvent(
    String cartOwner,
    UUID userId) {
}
