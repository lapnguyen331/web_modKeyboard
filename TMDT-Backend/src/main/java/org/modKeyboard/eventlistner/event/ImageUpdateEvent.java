package org.modKeyboard.eventlistner.event;

import java.util.List;
import java.util.UUID;

public record ImageUpdateEvent(
    UUID productId,
    List<String> imageIds) {
}
