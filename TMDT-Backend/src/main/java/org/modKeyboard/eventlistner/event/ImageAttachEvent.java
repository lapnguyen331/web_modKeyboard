package org.modKeyboard.eventlistner.event;

import java.util.List;
import java.util.UUID;

public record ImageAttachEvent(
    UUID productId,
    List<String> imageIds
) {
}
